export function SHIPBRIDGE__POSITION(): number[];
export function SHIPBRIDGE__QUATERNION(): number[];
export function SHIPBRIDGE__DOESRELAYEXIST(relay : string): boolean;
export function SHIPBRIDGE__GETANGULARVELOCITY(): number[];
export function SHIPBRIDGE__SETRELAYOUTPUT(relay : string, face : string, power : number): boolean;
export function SHIPBRIDGE__GETRELAYOUTPUT(relay : string, face : string): number;
export function SHIPBRIDGE_GETVELOCITY(): number[];