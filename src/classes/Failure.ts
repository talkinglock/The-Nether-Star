// failure modes are relative to their functions.
// a dot product might not be that important, but if it fails it will return a catostrophic failure mode because it cannot complete.

import { lstd } from "../lua/bridge/lstd";
export enum FailureMode {
    UNDEF,
    MISSUSE,
    THRUSTER_RELAY_DOESNT_EXIST,
    THRUSTER_POST_FAILURE,
    RCS_POST_FAILURE,
    RCS_ZERO_VECTOR
}
export class Failure extends Error {
    public readonly Mode : FailureMode = FailureMode.UNDEF; 
    
    constructor (message : string, failureMode : FailureMode)
    {
        super(message + " FAILURE MODE " + failureMode.toString());
        this.Mode = failureMode
    }
}