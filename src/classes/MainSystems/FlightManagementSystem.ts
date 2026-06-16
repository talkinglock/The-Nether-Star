/*
The heart of any flying machine.
Controls everything
*/

import { lstd } from "../../lua/bridge/lstd";
import { ShipBridge } from "../../lua/bridge/shipBridge";
import { Configuration } from "../Configuration";
import { Quaternion } from "../Math/Quaternion";
import { Vector3 } from "../Math/Vector3";
import { Thruster } from "../Thruster";
import { Time } from "../Time";
import { FailureManagementSystem } from "./FailureManagementSystem";
import { ReactionControlSystem } from "./ReactionControlSystem";

enum FMSState
{
    Offline,
    Online,
    Degraded,
    Emergency,
    Failed
}

export class FlightManagementSystem
{
    private state : FMSState = FMSState.Offline;

    public config : Configuration;
    // Priority systems
    public failms : FailureManagementSystem;
    // Flight systems
    public RCS : ReactionControlSystem;
    public Time : Time;


    private PowerOnSelfTest(this : FlightManagementSystem) : boolean
    {
        // Consequence of failure just means we aren't taking off, so no big deal.
        if (this.RCS === null)
        {
            lstd.Log("FMS POST failed! One or more systems not instantiated.");
            return false;
        }

        const rcsPostResult : boolean = this.RCS.PowerOnSelfTest();

        if (rcsPostResult === false)
        {
            lstd.Log("FMS POST failed! One or more system POSTs failed.");
            return false;
        }
        return true;
    }

    constructor(config : Configuration) {
        this.config = config;
        this.failms = new FailureManagementSystem(this);
        this.RCS = new ReactionControlSystem(config.Thrusters, this);
        this.Time = new Time(config.tickRate);
    }

    public StartEmergency(this : FlightManagementSystem)
    {
        // mostly just set the flag, individual systems handle it further
        this.state = FMSState.Emergency;
    }
    private Loop(this : FlightManagementSystem)
    {
        while (true) 
        {
            this.RCS.Update(
                new Vector3(-25,41,-52).Subtract(ShipBridge.GetWorldSpacePosition()),
                new Quaternion(1,0,0,0),
                1.0
            );
            this.Time.Tick();
            lstd.Sleep(this.config.tickRate);
        }
    }
    // Effectively starts the show
    public Bootstrap(this : FlightManagementSystem)
    {
        const POSTResult : boolean = this.PowerOnSelfTest();
        if (POSTResult === false)
        {
            throw new Error("FMS POST failed");
        }
       this.Loop();
    }
}