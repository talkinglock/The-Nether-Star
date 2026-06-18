// Holds data for specifics of a craft, like the PID tuning and thruster locations.

import PidBridge from "../../thirdparty/lua/pidcontrollers";
import { PIDControllerVector } from "../../thirdparty/tswrappers/pidcontroller";
import { Quaternion } from "./Math/Quaternion";
import { Thruster } from "./Thruster";

export interface Configuration {
	SASRotationLoop: {
		P: number;
		I: number;
		D: number;
		Min: number;
		Max: number;
	};
	SASTranslationLoop: {
		P: number;
		I: number;
		D: number;
		Min: number;
		Max: number;
	};

	SASManualTranslationMultiplier: number;
	SASManualRotationMultiplier: number;
	SASPIDTotalRetrustsBeforeStoppingPIDAttempts: number;
	SASPIDRestrustsBeforeReattemptingPID: number;
	SASBackupQuaternion: Quaternion;

	MaximumForwardSpeed: number;

	MinimumThrusterRotationAuthority: number; // minimum amount of thrusters required to safely decelerate
	RCSFailMajorityMultiplier: number;
	RCSFailMinorityMultiplier: number;
	tickRate: number;

	Thrusters: Thruster[];
}
