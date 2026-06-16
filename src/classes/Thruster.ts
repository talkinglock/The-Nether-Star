import { lstd } from "../lua/bridge/lstd";
import { ShipBridge } from "../lua/bridge/shipBridge";
import { Failure, FailureMode } from "./Failure";
import { Vector3 } from "./Math/Vector3";

export enum ThrusterState
{
    Active,
    Offline,
    Emergency,
    DisabledUnderEmergency,
    Failed
}
export enum ThrusterAuthority
{
    OrientationAndTranslation,
    Orientation,
    Translation
}

export class Thruster
{
    Relay : string = "";
    Face : string = "";
    

    State : ThrusterState = ThrusterState.Offline;
    Authority : ThrusterAuthority = ThrusterAuthority.OrientationAndTranslation;
    Position : Vector3 = new Vector3(0, 0, 0);
    ThrustVector : Vector3 = new Vector3(0, 0, 0);
    Torque : Vector3 = new Vector3(0, 0, 0);

    //Basic thruster self test
    NoThrustSelfTest(this : Thruster) : boolean
    {
        
        if (ShipBridge.IsRelayActive(this.Relay) === false) {
            lstd.Log("[THRUSTER] No thrust self test failed, relay inactive");
            return false;
        }
        return true;
    }
    ApplyThrust(this: Thruster, power : number)
    {
        ShipBridge.SetRelayOutput(this.Relay, this.Face, power);
    }
    //Applies minimal thrust to verify thruster is 100% active.
    ThrustSelfTest(this : Thruster) : boolean
    {
        try {
            if (this.NoThrustSelfTest() === false) {return false;}
            this.ApplyThrust(1);
            if (ShipBridge.GetRelayOutput(this.Relay, this.Face) !== 1) {lstd.Log("[THRUSTER] No thrust self test failed, relay read failed"); return false;}
            
            this.ApplyThrust(0);
            if (ShipBridge.GetRelayOutput(this.Relay, this.Face) !== 0) {lstd.Log("[THRUSTER] No thrust self test failed, relay read failed"); return false;}
            return true;
        }
        catch(err) {
            lstd.Log("[THRUSTER] Self test failed, error caught: " + err);
            return false;
        }
    }

    constructor(relay : string, face : string, position : Vector3, thrustVector : Vector3) {
        this.Relay = relay;
        this.Face = face;
        this.Position = position;
        this.ThrustVector = thrustVector;

        const torque : Vector3 = position.Cross(thrustVector);
        this.Torque = torque;
    }
    
}