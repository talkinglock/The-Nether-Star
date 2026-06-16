// Holds data for specifics of a craft, like the PID tuning and thruster locations.

import PidBridge, { PID_Continuous_Vector } from "../../thirdparty/lua/pidcontrollers";
import { PIDControllerVector } from "../../thirdparty/tswrappers/pidcontroller";
import { Thruster } from "./Thruster";

export interface Configuration {

    SARCASRotationLoop: {
        P : number,
        I : number,
        D : number
        Min : number,
        Max : number;
    }
    
    MinimumThrusterRotationAuthority : number; // minimum amount of thrusters required to safely decelerate
    RCSFailMajorityMultiplier : number;
    RCSFailMinorityMultiplier : number;
    tickRate : number;

    Thrusters : Thruster[];
}