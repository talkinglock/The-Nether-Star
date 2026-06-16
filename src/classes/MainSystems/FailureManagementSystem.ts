/*

Responsible for diagnosing and administering directives from failure information

*/

import { Thruster, ThrusterState } from "../Thruster";
import { FlightManagementSystem } from "./FlightManagementSystem";
import { RCSState, ReactionControlSystem } from "./ReactionControlSystem";


export class FailureManagementSystem
{
    public fms : FlightManagementSystem;
    public rcs : ReactionControlSystem;

    constructor(fms : FlightManagementSystem)
    {
        this.fms = fms;
        this.rcs = fms.RCS;
    }

}