/*

Responsible for diagnosing and administering directives from failure information

*/

import { Thruster, ThrusterState } from "../Thruster";
import { FlightManagementSystem } from "./FlightManagementSystem";
import { ReactionControlSystem } from "./ReactionControlSystem";
import { SystemState } from "../SystemState";
import { lstd } from "../../lua/bridge/lstd";
import { Failure, FailureMode } from "../Failure";


export enum SystemName
{
    ReactionControlSystem,
    StabilityAugmentationSystem,
    TerrianAndDestructionAvoidanceSystem
}

export enum CrisisCode
{
    SAS_LOOPS_FAILED,
    RCS_UPDATE_ERRORED
}

export class CrisisManagementSystem
{
    public fms : FlightManagementSystem;
    public rcs : ReactionControlSystem;

    // CRISIS CODES
    private CrisisCode_SAS_LOOP_FAILED()
    {
        /*
            SAS has had its primary loops fail! It has fallen back to its manual systems but its important we find the cause 
        */
    }
    private CrisisCode_RCS_UPDATE_ERRORED()
    {
        /*
            RCS has had its update error out!
        */
    }

    public Distress(this : CrisisManagementSystem, signal : CrisisCode)
    {
        /*
            Entry point to every signal error.
            A system has sent a distress signal because of a malfunction, and it is our job
            to pinpoint the error.
        */
       switch (signal) 
       {
            case CrisisCode.SAS_LOOPS_FAILED:
            {
                this.CrisisCode_SAS_LOOP_FAILED();
                break;
            }
            case CrisisCode.RCS_UPDATE_ERRORED:
            {
                this.CrisisCode_RCS_UPDATE_ERRORED();
                break;
            }
            default:
            {
                lstd.Log("[CMS] Recieved unhandled distress signal! " + signal);
                break;
            }
       }
    }
    public SystemIsAlive(system : SystemName)
    {

    }

    public Update()
    {

    }

    constructor(fms : FlightManagementSystem)
    {
        this.fms = fms;
        this.rcs = fms.RCS;
    }

}