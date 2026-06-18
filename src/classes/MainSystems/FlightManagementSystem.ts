/*
The heart of any flying machine.
Controls everything
*/

import { lstd } from "../../lua/bridge/lstd";
import { ShipBridge } from "../../lua/bridge/shipBridge";
import { Configuration } from "../Configuration";
import { Failure } from "../Failure";
import { Quaternion } from "../Math/Quaternion";
import { Vector3 } from "../Math/Vector3";
import { Thruster } from "../Thruster";
import { Time } from "../Time";
import { CrisisCode, CrisisManagementSystem } from "./CrisisManagementSystem";
import { ReactionControlSystem } from "./ReactionControlSystem";
import { StabilityAugmentationSystem } from "./StabilityAugmentationSystem";

enum FMSState {
	Offline,
	Online,
	Degraded,
	Emergency,
	Failed,
}

export class FlightManagementSystem {
	private state: FMSState = FMSState.Offline;

	public config: Configuration;
	// Priority systems
	public cms: CrisisManagementSystem;
	// Flight systems
	public RCS: ReactionControlSystem;
	public SAS: StabilityAugmentationSystem;

	public Time: Time;

	private rcsDesiredVelocity: Vector3 = new Vector3(0, 0, 0);
	private rcsErrorRotation: Vector3 = new Vector3(0, 0, 0);
	private rcsInputTimesCalled: number = 0;
	public SetRCSInput(
		this: FlightManagementSystem,
		desiredVelocity: Vector3,
		errorRotation: Vector3,
	) {
		this.rcsInputTimesCalled++;
		if (this.rcsInputTimesCalled > 1) {
			// RCS got called twice. Ignore this and log an immediate error!
			lstd.Log("[FMS] More then one RCS call this tick!");
			return;
		}
		this.rcsDesiredVelocity = desiredVelocity;
		this.rcsErrorRotation = errorRotation;
	}

	private PowerOnSelfTest(this: FlightManagementSystem): boolean {
		// Consequence of failure just means we aren't taking off, so no big deal.
		if (this.RCS === null || this.SAS === null) {
			lstd.Log("FMS POST failed! One or more systems not instantiated.");
			return false;
		}

		const rcsPostResult: boolean = this.RCS.PowerOnSelfTest();
		const sasPostResult: boolean = this.SAS.PowerOnSelfTest();
		if (rcsPostResult === false || sasPostResult === false) {
			lstd.Log("FMS POST failed! One or more system POSTs failed.");
			return false;
		}

		return true;
	}

	constructor(config: Configuration) {
		this.config = config;
		this.cms = new CrisisManagementSystem(this);
		this.RCS = new ReactionControlSystem(config.Thrusters, this);
		this.SAS = new StabilityAugmentationSystem(this);
		this.Time = new Time(config.tickRate);
	}

	public StartEmergency(this: FlightManagementSystem) {
		// mostly just set the flag, individual systems handle it further
		this.state = FMSState.Emergency;
	}

	private Update() {
		// handle systems!
		this.SAS.Update(
			new Vector3(-39, 42, -52).Subtract(ShipBridge.GetWorldSpacePosition()),
			Quaternion.fromAxisAngles(new Vector3(0, 1, 0), 3.14),
		);
		if (this.rcsInputTimesCalled === 1) {
			try {
				this.RCS.Update(this.rcsDesiredVelocity, this.rcsErrorRotation);
			} catch (error) {
				lstd.Log("[FMS] RCS Failed to update!");
				this.cms.Distress(CrisisCode.RCS_UPDATE_ERRORED);
			}
		} else {
			lstd.Log("[FMS] RCS not called this loop!");
		}

		this.rcsInputTimesCalled = 0;
		this.Time.Tick();
		lstd.Sleep(this.config.tickRate);
	}
	private Loop(this: FlightManagementSystem) {
		while (true) {
			this.Update();
		}
	}
	// Effectively starts the show
	public Bootstrap(this: FlightManagementSystem) {
		const POSTResult: boolean = this.PowerOnSelfTest();
		if (POSTResult === false) {
			throw new Error("[FMS] POST failed!");
		}
		this.Loop();
	}
}
