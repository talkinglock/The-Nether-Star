import { Failure, FailureMode } from "../../src/classes/Failure";
import { Vector3 } from "../../src/classes/Math/Vector3";
import PidBridge from "../lua/pidcontrollers";

export class PIDControllerVector {
    private P : number = 0;
    private I : number = 0;
    private D : number = 0;
    private Min : number = 0;
    private Max : number = 0;
    private luaRunFunction : Function;
    constructor(P : number, I : number, D : number, Min : number, Max : number) {
        this.P = P;
        this.I = I;
        this.D = D;
        this.Min = Min;
        this.Max = Max;
        this.luaRunFunction = PidBridge.PID_Continuous_Vector(P, I, D, Min, Max);
    }

    Run(ErrorVector : Vector3)
    {
        const rawVectorArray : number[] = this.luaRunFunction(ErrorVector.x, ErrorVector.y, ErrorVector.z);
        if (rawVectorArray.length !== 3)
        {
            throw new Failure("Cannot Run VECTOR Pid because returned vector is invalid!", FailureMode.MISSUSE);
        }
        if (rawVectorArray[0] === undefined || rawVectorArray[1] === undefined || rawVectorArray[2] === undefined) 
        {
            throw new Failure("Cannot Run VECTOR Pid because returned vector is invalid!", FailureMode.MISSUSE);
        }

        return new Vector3(rawVectorArray[0], rawVectorArray[1], rawVectorArray[2]);
    }
}