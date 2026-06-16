// we need to be very careful as all of the ship functions are *untyped* and MUST be typed here

import { Failure, FailureMode } from "../../classes/Failure";
import { Quaternion } from "../../classes/Math/Quaternion";
import { Vector3 } from "../../classes/Math/Vector3";
import { SHIPBRIDGE__DOESRELAYEXIST, SHIPBRIDGE__GETANGULARVELOCITY, SHIPBRIDGE__GETRELAYOUTPUT, SHIPBRIDGE__POSITION, SHIPBRIDGE__QUATERNION, SHIPBRIDGE__SETRELAYOUTPUT, SHIPBRIDGE_GETVELOCITY } from "../declaration/shipBridge";
import { lstd } from "./lstd";

export class ShipBridge
{
    static GetWorldSpacePosition(): Vector3
    {
        const rawPos : readonly number[] = SHIPBRIDGE__POSITION();
        if (rawPos.length !== 3) {
            throw new Failure("Raw position does not have substantial data to get world space position!", FailureMode.MISSUSE);
        }
        if (rawPos[0] === undefined || rawPos[1] === undefined || rawPos[2] === undefined)
        {
            throw new Failure("Raw position data is undefined! Cannot get world space position", FailureMode.MISSUSE);
        }
        const vector : Vector3 = new Vector3(rawPos[0], rawPos[1], rawPos[2]);
        return vector;
    }
    static IsRelayActive(relay : string) : boolean
    {
        return SHIPBRIDGE__DOESRELAYEXIST(relay);
    }
    static SetRelayOutput(relay : string, face : string, power : number)
    {
        const output : boolean = SHIPBRIDGE__SETRELAYOUTPUT(relay, face, power);
        if (output === false) {
            throw new Failure("Attempt to set relay output when relay doesn't exist!", FailureMode.THRUSTER_RELAY_DOESNT_EXIST);
        }
        return ;
    }
    static GetRelayOutput(relay : string, face : string) : number
    {
        const power : number = SHIPBRIDGE__GETRELAYOUTPUT(relay, face);
        if (power !== -1) {
            return power;
        }
        else
        {
            throw new Failure("Attempt to get relay output when relay doesn't exist!", FailureMode.THRUSTER_RELAY_DOESNT_EXIST);
        }
    }
    static GetQuaternion(): Quaternion
    {
        const rawPos : readonly number[] = SHIPBRIDGE__QUATERNION();
        if (rawPos.length !== 4) {
            lstd.Log(rawPos.length.toString());
            throw new Failure("Raw quaternion does not have substantial data to get quaternion!", FailureMode.MISSUSE);
        }
        if (rawPos[0] === undefined || rawPos[1] === undefined || rawPos[2] === undefined || rawPos[3] === undefined)
        {
            throw new Failure("Raw quaternion data is undefined! Cannot get quaternion!", FailureMode.MISSUSE);
        }
        const quaternion : Quaternion = new Quaternion(rawPos[0], rawPos[1], rawPos[2], rawPos[3]);
        return quaternion;
    }
    static GetVelocity(): Vector3
    {
        const rawVel : readonly number[] = SHIPBRIDGE__POSITION();
        if (rawVel.length !== 3) {
            throw new Failure("Raw velocity data is undefined! Cannot get velocity", FailureMode.MISSUSE); 
        }
        if (rawVel[0] === undefined || rawVel[1] === undefined || rawVel[2] === undefined)
        {
            throw new Failure("Raw velocity data is undefined! Cannot get velocity", FailureMode.MISSUSE);
        }
        const vector : Vector3 = new Vector3(rawVel[0], rawVel[1], rawVel[2]);
        return vector;
    }
    static GetAngularVelocity(): Vector3
    {
        const rawVel : readonly number[] = SHIPBRIDGE__GETANGULARVELOCITY();
        if (rawVel.length !== 3) {
            throw new Failure("Raw angular velocity data is undefined! Cannot get angular velocity", FailureMode.MISSUSE); 
        }
        if (rawVel[0] === undefined || rawVel[1] === undefined || rawVel[2] === undefined)
        {
            throw new Failure("Raw angular velocity data is undefined! Cannot get angular velocity", FailureMode.MISSUSE);
        }
        const vector : Vector3 = new Vector3(rawVel[0], rawVel[1], rawVel[2]);
        return vector;
    }
}