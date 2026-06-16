declare namespace PidBridge {
    function PID_Continuous_Vector(
        P : number,
        I : number,
        D : number,
        Min : number,
        Max : number
    ) : (x : number, y : number, z : number) => number[];
}
export = PidBridge;