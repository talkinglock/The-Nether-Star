/*
    The Stability Augmentation System (SAS) is responsible for stabilizing the craft in ways
    that don't require individual thruster action.

    It sits in the aviation stack above the Reaction Control System, and feeds commands into it.
    
    For example:
    A failure of a thruster causing a rapid spin is *not* the responsibility of the SAS as it required individual thruster action.

    A rapid spin caused by a navigation computer sending faulty data *is* the responsibility of the SAS as it can be remedied without individual thruster action.
*/

import PidBridge from "../../../thirdparty/lua/pidcontrollers";
import { PIDControllerVector } from "../../../thirdparty/tswrappers/pidcontroller";
import { lstd } from "../../lua/bridge/lstd";
import { ShipBridge } from "../../lua/bridge/shipBridge";
import { Configuration } from "../Configuration";
import { AxisAngle, Quaternion } from "../Math/Quaternion";
import { Vector3 } from "../Math/Vector3";
import { FlightManagementSystem } from "./FlightManagementSystem";
import { ReactionControlSystem } from "./ReactionControlSystem";
import { SystemState } from "../SystemState";
import { Failure, FailureMode } from "../Failure";
import { SystemName } from "./CrisisManagementSystem";

enum VectorSanityStatus {
	Sane,
	Recoverable,
	Insane,
}
enum SASActivityStatus {
	Normal,
	HoldingPosition,
}

export class StabilityAugmentationSystem {
	private fms: FlightManagementSystem;
	private config: Configuration;

	private state: SystemState = SystemState.Offline;
	private activityState: SASActivityStatus = SASActivityStatus.Normal;

	private TranslationLoop: PIDControllerVector;
	private RotationLoop: PIDControllerVector;

	private rcs: ReactionControlSystem;

	private CanPidRetrust: boolean = true;
	private PIDTrustedCount: number = 0;
	private PIDTotalRetrusts: number = 0;

	/*
	TODO:
	Stress test
	Track Telemetry (for Crisis Management System)
	Implement into Crisis Management System
	Report to Crisis Management System
	*/

	public PowerOnSelfTest(this: StabilityAugmentationSystem): boolean {
		let currentQuat: Quaternion;
		let currentAngularVelocity: Vector3;
		let currentVelocity: Vector3;
		try {
			// are we able to get the nessecary information
			currentQuat = ShipBridge.GetQuaternion();
			currentAngularVelocity = ShipBridge.GetAngularVelocity();
			currentVelocity = ShipBridge.GetVelocity();
		} catch (err) {
			lstd.Log(
				"[SAS] POST failed, one or more ShipBridge functions returned jargon. Specific error: " + err
			);
			return false;
		}
		try {
			this.TranslationLoop.Run(currentVelocity);
			this.RotationLoop.Run(currentAngularVelocity);
		} catch (err) {
			lstd.Log("[SAS] POST failed, one or more PID loops returned jargon. Specific error: " + err);
			return false;
		}

		if (this.rcs.GetState() !== SystemState.Active) {
			lstd.Log("[SAS] POST failed, RCS is not active. Did it post?");
			return false;
		}
		this.state = SystemState.Active;
		return true;
	}

	// ##########################
	//    EMERGENCY FUNCTIONS
	// ##########################

	public SwitchLoopsToManual() {
		lstd.Log("[SAS] Entering degraded state!!");
		this.state = SystemState.Degraded;
	}

	public SwitchLoopsToPID() {
		if (this.state !== SystemState.Degraded) {
			lstd.Log("[SAS] Attempt to enter normal state while not in degraded mode!");
			return;
		}
		lstd.Log("[SAS] Exiting degraded state!");
		this.state = SystemState.Active;
	}

	public HoldPosition() {
		/*
            Slow down and negate velocity immediately!
        */
		lstd.Log("[SAS] Entered holding mode!");
		this.activityState = SASActivityStatus.HoldingPosition;
	}
	public UnholdPosition() {
		lstd.Log("[SAS] Exited holding mode!");
		this.activityState = SASActivityStatus.Normal;
	}

	private TryRetrust() {
		if (this.PIDTotalRetrusts <= this.config.SASPIDTotalRetrustsBeforeStoppingPIDAttempts) {
			lstd.Log("[SAS] Loops retrusting! Attempt : " + this.PIDTotalRetrusts);
			this.PIDTotalRetrusts++;
			this.SwitchLoopsToPID();
		} else {
			if (this.CanPidRetrust === true) {
				this.CanPidRetrust = false;
				lstd.Log("[SAS] Too many failed PID retrust attempts. PID Loops now offline forever.");
			}
		}
	}
	// VELOCITY FUNCTIONS
	private StabilizeVelocity(this: StabilityAugmentationSystem, desiredVelocity: Vector3): Vector3 {
		// input desiredVelocity is sanity verified
		const currentVelocity: Vector3 = ShipBridge.GetVelocity();
		const velocityError: Vector3 = desiredVelocity.Subtract(currentVelocity);

		const PIDResult: Vector3 = this.TranslationLoop.Run(velocityError);
		const PIDSanityStatus: VectorSanityStatus = this.GetErrorVelocitySanity(
			PIDResult,
			currentVelocity,
			desiredVelocity
		);

		if (PIDSanityStatus === VectorSanityStatus.Sane && this.state === SystemState.Degraded) {
			// PID returns good results!
			this.PIDTrustedCount++;
		} else if (PIDSanityStatus === VectorSanityStatus.Insane) {
			// PID Loop is still insane
			this.PIDTrustedCount = 0;
		}

		if (this.state === SystemState.Active) {
			return this.VelocityPIDUpdate(PIDSanityStatus, velocityError, PIDResult);
		} else {
			return this.VelocityManualUpdate(velocityError);
		}
	}

	private GetErrorVelocitySanity(
		this: StabilityAugmentationSystem,
		errorVector: Vector3,
		fromVector: Vector3,
		toVector: Vector3
	): VectorSanityStatus {
		// extends the standard check to error vectors
		const normalSanity: VectorSanityStatus = this.GetVelocityVectorSanity(errorVector);
		if (normalSanity === VectorSanityStatus.Insane) {
			return VectorSanityStatus.Insane;
		}

		const dot: number = toVector.Dot(errorVector);
		if (dot > 0) {
			return VectorSanityStatus.Sane;
		}
		if (normalSanity === VectorSanityStatus.Recoverable) {
			return VectorSanityStatus.Recoverable;
		} else {
			return VectorSanityStatus.Insane;
		}
	}

	private SanitizeVelocityVector(this: StabilityAugmentationSystem, velocity: Vector3): Vector3 {
		const status: VectorSanityStatus = this.GetVelocityVectorSanity(velocity);
		const speed: number = velocity.Magnitude();
		if (status === VectorSanityStatus.Sane) {
			lstd.Log(
				"[SAS] [WARN] Sanity correction performed on already sane vector. Are you missing a sanity check?"
			);
			return velocity;
		}
		if (status === VectorSanityStatus.Insane) {
			throw new Failure("[SAS] Attempt to sanitize insane vector!", FailureMode.MISSUSE);
		}
		if (speed > this.config.MaximumForwardSpeed) {
			const normalized: Vector3 = velocity.Normalized();
			const finalVector: Vector3 = normalized.Multiply(speed);
			return finalVector;
		}
		lstd.Log("[SAS] Recoverable vector has not implemented issue! Is the function unfinished?");
		return velocity;
		//throw new Failure("[SAS] Recoverable vector has not implemented issue! Is the function unfinished?", FailureMode.NOT_YET_IMPLEMENTED);
	}

	private VelocityPIDUpdate(
		PIDSanityStatus: VectorSanityStatus,
		velocityError: Vector3,
		PIDResult: Vector3
	): Vector3 {
		if (PIDSanityStatus === VectorSanityStatus.Insane) {
			// PID Failed. Initiate manual recovery
			lstd.Log("[SAS] Translation degredation tripped!");
			this.SwitchLoopsToManual();
			return this.VelocityManualUpdate(velocityError);
		}
		if (PIDSanityStatus === VectorSanityStatus.Recoverable) {
			return this.SanitizeVelocityVector(PIDResult);
		}
		return PIDResult;
	}

	private GetVelocityVectorSanity(
		this: StabilityAugmentationSystem,
		velocity: Vector3
	): VectorSanityStatus {
		const speed: number = velocity.Magnitude();
		if (speed > this.config.MaximumForwardSpeed) {
			return VectorSanityStatus.Recoverable;
		}
		return VectorSanityStatus.Sane;
		// currently cannot return insane
	}

	private VelocityManualUpdate(velocityError: Vector3): Vector3 {
		return velocityError.Multiply(this.config.SASManualTranslationMultiplier);
	}

	// ORIENTATION FUNCTIONS

	private StabilizeOrientation(this: StabilityAugmentationSystem, targetQuat: Quaternion): Vector3 {
		const currentQuat: Quaternion = ShipBridge.GetQuaternion();
		const invertedQuat: Quaternion = currentQuat.Inverse();

		let errorQuat: Quaternion = invertedQuat.MultiplyByQuaternion(targetQuat);

		if (errorQuat.w < 0) {
			errorQuat = new Quaternion(-errorQuat.w, -errorQuat.x, -errorQuat.y, -errorQuat.z);
		}

		const axisAngle: AxisAngle = errorQuat.ToAxisAngles();
		const axis: Vector3 = axisAngle.axis;
		const angle: number = axisAngle.angle;

		this.TrackOrientationLoopStability(axisAngle);

		const worldAngularVelocity: Vector3 = ShipBridge.GetAngularVelocity();
		const localAngularVelocity: Vector3 = currentQuat.ConvertVectorToLocalSpace(worldAngularVelocity);

		const PIDFeed: Vector3 = axis.Multiply(angle).Subtract(localAngularVelocity);
		const PIDResult: Vector3 = this.RotationLoop.Run(PIDFeed);

		if (this.state === SystemState.Active) {
			return PIDResult;
		} else {
			return this.OrientationManualLoop(axis, angle, localAngularVelocity);
		}
	}

	private TrackOrientationLoopStability(
		this: StabilityAugmentationSystem,
		errorAxisAngles: AxisAngle
	) {
		/*
			Determine based on available data whether the loop is unstable.
			Track the angular error.
			If it remains above what it should be for more then a predefined amount of updates, degrade.
			If it attempts to go above the maximum value, degrade. 
		*/
	}
	private OrientationManualLoop(
		axis: Vector3,
		angle: number,
		localAngularVelocity: Vector3
	): Vector3 {
		return axis
			.Multiply(angle)
			.Multiply(this.config.SASManualRotationMultiplier)
			.Subtract(localAngularVelocity);
	}
	public Update(
		this: StabilityAugmentationSystem,
		desiredVelocity: Vector3,
		desiredQuaternion: Quaternion
	) {
		if (this.state === SystemState.Offline) {
			throw new Failure("[SAS] Attempt to Update pre-POST!", FailureMode.UPDATE_BEFORE_POST);
		}
		if (this.rcs.GetState() === SystemState.Failed) {
			lstd.Log("[SAS] Attempt to Update while RCS is failed!");
			return;
		}
		if (this.state === SystemState.Failed) {
			lstd.Log("[SAS] Attempt to Update while failed, passing through translation data to RCS.");
			this.fms.SetRCSInput(desiredVelocity, new Vector3(0, 1, 0));
		}

		const vectorSanity: VectorSanityStatus = this.GetVelocityVectorSanity(desiredVelocity);
		if (
			this.activityState === SASActivityStatus.HoldingPosition &&
			vectorSanity === VectorSanityStatus.Insane
		) {
			desiredVelocity = ShipBridge.GetVelocity().Inverse();
			desiredQuaternion = this.config.SASBackupQuaternion;
		} else if (
			this.activityState === SASActivityStatus.HoldingPosition &&
			vectorSanity !== VectorSanityStatus.Insane
		) {
			this.UnholdPosition();
		}

		// If code reaches here, all required systems are running and operational.

		if (vectorSanity === VectorSanityStatus.Insane) {
			// velocity vector is literally unrecoverable, hold position
			this.HoldPosition();
		}
		if (
			this.state === SystemState.Degraded &&
			this.PIDTrustedCount >= this.config.SASPIDRestrustsBeforeReattemptingPID
		) {
			this.TryRetrust();
		}

		const stabilizedVelocity: Vector3 = this.StabilizeVelocity(desiredVelocity);
		const stabilizedErrorRotation: Vector3 = this.StabilizeOrientation(desiredQuaternion);
		try {
			this.fms.SetRCSInput(stabilizedVelocity, stabilizedErrorRotation);
		} catch (error) {
			lstd.Log("[SAS] FMS-RCS call failed! " + error);
		}
	}

	constructor(fms: FlightManagementSystem) {
		this.fms = fms;
		this.rcs = fms.RCS;
		this.config = fms.config;
		this.TranslationLoop = new PIDControllerVector(
			this.config.SASTranslationLoop.P,
			this.config.SASTranslationLoop.I,
			this.config.SASTranslationLoop.D,
			this.config.SASTranslationLoop.Min,
			this.config.SASTranslationLoop.Max
		);
		this.RotationLoop = new PIDControllerVector(
			this.config.SASRotationLoop.P,
			this.config.SASRotationLoop.I,
			this.config.SASRotationLoop.D,
			this.config.SASRotationLoop.Min,
			this.config.SASRotationLoop.Max
		);
	}
}
