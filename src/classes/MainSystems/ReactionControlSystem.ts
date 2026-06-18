/*
    The Reaction Control System is the lowest level of flight control in the stack.
    It is the only system to directly interface with the thrusters.

    It takes in a target Velocity and Orientation(Quaternion) and 
    manipulates thrusters to achieve those values.

    It is responsible for handling failure modes which can be tied to individual thrusters failing.

    Examples:
    A thruster failing causing a rapid spin is the responsibility of the Reaction Control System.

    A rapid spin, which is not tied to a thruster failure, is not the responsibility of the Reaction Control System, 
    that is the responsibility of the Stability Augmentation System (SAS)

    The DOMAIN of RCS Is individual thruster mechanics. 
*/
import { lstd } from "../../lua/bridge/lstd";
import { ShipBridge } from "../../lua/bridge/shipBridge";
import { Configuration } from "../Configuration";
import { Failure, FailureMode } from "../Failure";
import { Mathc } from "../Math/Mathc";
import { Quaternion } from "../Math/Quaternion";
import { Vector3 } from "../Math/Vector3";
import { SystemState } from "../SystemState";
import { Thruster, ThrusterAuthority, ThrusterState } from "../Thruster";
import { Timer } from "../Timer";
import { CrisisManagementSystem } from "./CrisisManagementSystem";
import { FlightManagementSystem } from "./FlightManagementSystem";

enum RCSPriority {
	TranslationAndRotation,
	Translation,
	Rotation,
}

export class ReactionControlSystem {
	private Thrusters: Thruster[] = [];
	private state: SystemState = SystemState.Offline;
	private priority: RCSPriority = RCSPriority.TranslationAndRotation;

	private fms: FlightManagementSystem;
	private cms: CrisisManagementSystem;

	private DesiredVelocity: Vector3 = new Vector3(0, 0, 0);
	private DesiredVelocityMagnitude: number = 0;
	private DesiredVelocityNormalized: Vector3 = new Vector3(0, 0, 0);
	private CurrentQuaternion: Quaternion = new Quaternion(1, 0, 0, 0);
	private ErrorQuaternion: Quaternion = new Quaternion(1, 0, 0, 0);

	public GetState(this: ReactionControlSystem): SystemState {
		return this.state;
	}
	// ###################
	// EMERGENCY PROTOCOLS
	// ###################

	public CatastrophicShutdown(this: ReactionControlSystem) {
		/*
            The ship has cut its losses and decided to kill the system
            could be the result of spinning out of control, or some other situation.
        */
		this.state = SystemState.Failed;
		this.Thrusters.forEach((thruster) => {
			try {
				thruster.ApplyThrust(0);
			} catch (error) {}
		});
	}

	private CanThrusterDecelerateSpin(
		this: ReactionControlSystem,
		thruster: Thruster,
		angularVelocity: Vector3,
	): boolean {
		if (
			thruster.State === ThrusterState.Failed ||
			thruster.State === ThrusterState.Emergency ||
			thruster.State === ThrusterState.DisabledUnderEmergency
		)
			return false;
		if (thruster.Torque.Dot(angularVelocity) > 0) {
			return true;
		}
		return false;
	}

	// Activated by Crisis Management System
	public EmergencySpinCondition(this: ReactionControlSystem): Recoverability {
		/*
            This is the worst possible failure mode of the Reaction Control System.
            One or more thruster failures has caused a spin condition, where the craft cannot slow itself down in an axis resulting in acceleration or the inability decelerate
            If it were possible to just "apply anti-torque" the default loop would have done that,
            this function needs to determine whether or not to perform the Aggressive Reorientation Maneuver.
        */
		this.state = SystemState.Emergency;

		const angularVelocity: Vector3 = ShipBridge.GetAngularVelocity();

		let PossibleDecelerationThrusters: Thruster[] = [];
		let NormalDecelerationThrusters: Thruster[] = [];
		this.Thrusters.forEach((thruster) => {
			// thruster is type Thruster
			if (this.CanThrusterDecelerateSpin(thruster, angularVelocity)) {
				PossibleDecelerationThrusters.push(thruster);
			}
		});
		this.fms.config.Thrusters.forEach((thruster) => {
			// thruster is type Thruster
			if (this.CanThrusterDecelerateSpin(thruster, angularVelocity)) {
				NormalDecelerationThrusters.push(thruster);
			}
		});
		if (
			PossibleDecelerationThrusters.length === 0 ||
			NormalDecelerationThrusters.length === 0
		) {
			// it is literally impossible to decelerate
			return Recoverability.Unrecoverable;
		}
		if (
			PossibleDecelerationThrusters.length /
				NormalDecelerationThrusters.length >
			this.fms.config.MinimumThrusterRotationAuthority
		) {
			// We have enough thrusters to stop the rotation safely. We must allocate more resources to rotation.
			this.priority = RCSPriority.Rotation;
			return Recoverability.Recoverable;
		}
		return Recoverability.Unrecoverable;
	}

	private ThrusterLost(this: ReactionControlSystem, thruster: Thruster) {
		thruster.State = ThrusterState.Emergency; // this automatically decouples the thruster from the PID loops,
		if (this.state == SystemState.Active) {
			lstd.Log("[RCS] Thruster Failed!");
			this.state = SystemState.Degraded;
		}
	}

	// ##########################
	// END OF EMERGENCY PROTOCOLS
	// ##########################

	// rcs can only be active *after* the power on self test is completed
	// unless the primary computer is in emergency/recovery mode
	// Avoid activating RCS if there is an issue. You always have the choice to not take off but you never have the choice to not land
	// THIS WILL ACTIVATE THRUSTERS FOR A TICK TO TEST THRUST!
	public PowerOnSelfTest(this: ReactionControlSystem): boolean {
		if (this.Thrusters.length === 0) {
			lstd.Log("[RCS] Post failed, insufficient thruster count.");
			return false;
		}
		let success: boolean = true;
		this.Thrusters.forEach((thruster) => {
			// thruster is type Thruster
			const postResult: boolean = thruster.ThrustSelfTest();
			if (postResult === false) {
				//lstd.Log("[RCS] Post failed, thruster post failed.");
				success = false;
			} else {
				thruster.State = ThrusterState.Active;
			}
		});
		if (success === true) {
			this.state = SystemState.Active;
		}
		return success;
	}

	private CalculateThrusterTranslation(
		this: ReactionControlSystem,
		thruster: Thruster,
	): number {
		const LocalSpaceDesiredVelocity: Vector3 =
			this.CurrentQuaternion.ConvertVectorToLocalSpace(
				this.DesiredVelocityNormalized,
			);
		const dotToDesiredVector: number = thruster.ThrustVector.Dot(
			LocalSpaceDesiredVelocity,
		);

		return dotToDesiredVector * this.DesiredVelocityMagnitude;
	}

	private CalculateThrusterRotation(
		this: ReactionControlSystem,
		thruster: Thruster,
		rotationDotVector: Vector3,
	): number {
		//const LocalSpaceDesiredRotation: Vector3 =
		//	this.CurrentQuaternion.ConvertVectorToLocalSpace(rotationDotVector);
		const alignment: number =
			thruster.Torque.Normalized().Dot(rotationDotVector);
		return alignment;
	}

	private ThrusterUpdate(
		this: ReactionControlSystem,
		thruster: Thruster,
		rotationDotVector: Vector3,
	) {
		/*
            3 steps per tick
            safety check, position calculation, rotation calculation
            if a safety check fails this thruster is considered dead, and we must order emergency mode.
        */
		const safety: boolean = thruster.NoThrustSelfTest();
		if (!safety) {
			this.ThrusterLost(thruster);
			return;
		}

		const translationFactor: number =
			this.CalculateThrusterTranslation(thruster);
		const rotationFactor: number = this.CalculateThrusterRotation(
			thruster,
			rotationDotVector,
		);
		//lstd.Log("trans " + translationFactor.toString());
		//lstd.Log("rot " + rotationFactor.toString());
		let thrust: number = 0;
		if (this.priority === RCSPriority.TranslationAndRotation) {
			thrust = (translationFactor + rotationFactor) * 15;
		} else if (this.priority === RCSPriority.Translation) {
			thrust =
				(translationFactor * this.fms.config.RCSFailMajorityMultiplier +
					rotationFactor * this.fms.config.RCSFailMinorityMultiplier) *
				15;
		} else if (this.priority === RCSPriority.Rotation) {
			thrust =
				(translationFactor * this.fms.config.RCSFailMinorityMultiplier +
					rotationFactor * this.fms.config.RCSFailMajorityMultiplier) *
				15;
		}
		const thrustClamped: number = Mathc.Clamp(thrust, 0, 15);

		try {
			thruster.ApplyThrust(thrustClamped);
		} catch (error) {
			this.ThrusterLost(thruster);
		}
	}

	Update(
		this: ReactionControlSystem,
		desiredVelocity: Vector3,
		rotationDotVector: Vector3,
	) {
		if (this.state === SystemState.Offline) {
			throw new Failure(
				"Attempt to use R.C.S pre-POST",
				FailureMode.UPDATE_BEFORE_POST,
			);
		}
		if (desiredVelocity.Magnitude() === 0) {
			return;
		}
		if (this.state === SystemState.Failed) {
			return;
		}

		const currentQuaternion: Quaternion = ShipBridge.GetQuaternion();

		this.CurrentQuaternion = currentQuaternion;
		this.DesiredVelocity = desiredVelocity;
		this.DesiredVelocityMagnitude = desiredVelocity.Magnitude();
		this.DesiredVelocityNormalized = desiredVelocity.Normalized();

		this.Thrusters.forEach((thruster) => {
			// thruster is type Thruster
			this.ThrusterUpdate(thruster, rotationDotVector);
		});
	}

	constructor(thrusters: Thruster[], fms: FlightManagementSystem) {
		this.Thrusters = thrusters;
		this.fms = fms;
		this.cms = fms.cms;
	}
}
