import { Vector3 } from "./Vector3";

export class Quaternion {
    x : number = 0;
    y : number = 0;
    z : number = 0;
    w : number = 0;

    constructor(wPassthrough : number, xPassthrough : number, yPassthrough : number, zPassthrough : number)
    {
        this.x = xPassthrough;
        this.y = yPassthrough;
        this.z = zPassthrough;
        this.w = wPassthrough;
    }

    static fromAxisAngles(axis : Vector3, angle : number): Quaternion
    {
        const mag : number = axis.Magnitude();

        if (mag < 1e-8) {
            let quat : Quaternion = new Quaternion(1,0,0,0);
            return quat;
        }

        const normalized : Vector3 = axis.Normalized();
        const halfAngle : number = angle * 0.5;

        const sinAngle : number = Math.sin(halfAngle);
        const cosAngle : number = Math.cos(halfAngle);

        let finalQuat : Quaternion = new Quaternion(cosAngle, normalized.x * sinAngle, normalized.y * cosAngle, normalized.z * cosAngle);
        return finalQuat;
    }

    Inverse(this : Quaternion): Quaternion
    {
       const squaredNorm : number = this.x ** 2 + this.y ** 2 + this.z ** 2 + this.w ** 2;
       const inverted : Quaternion = new Quaternion(-this.w/squaredNorm, -this.x/squaredNorm, -this.y/squaredNorm, -this.z/squaredNorm);
       return inverted;
    }

    MultiplyByVector(this:Quaternion, vector:Vector3) : Vector3
    {
        const tx : number = 2 * (this.y * vector.z - this.z * vector.y);
        const ty : number = 2 * (this.z * vector.x - this.x * vector.z);
        const tz : number = 2 * (this.x * vector.y - this.y * vector.x);

        const vx : number = vector.x + this.w * tx;
        const vy : number = vector.y + this.w * ty;
        const vz : number = vector.z + this.w * tz;
        /*
            vx = vx + (y * tz - z * ty);
            vy = vy + (z * tx - x * tz);
            vz = vz + (x * ty - y * tx);
        */
        const endVector : Vector3 = new Vector3(
            vx + (this.y * tz - this.z * ty),
            vy + (this.z * tx - this.x * tz),
            vz + (this.x * ty - this.y * tx)
        )
        return endVector;
    }

    MultiplyByQuaternion(this : Quaternion, other : Quaternion) : Quaternion
    {
        const x : number = this.w * other.x + this.x * other.w + this.y * other.z - this.z * other.y;
        const y : number = this.w * other.y - this.x * other.z + this.y * other.w + this.z * other.x;
        const z : number = this.w * other.z + this.x * other.y - this.y * other.x + this.z * other.w;
        const w : number = this.w * other.w - this.x * other.x - this.y * other.y - this.z * other.z;
        const endQuaternion : Quaternion = new Quaternion(w,x,y,z);
        return endQuaternion;
    }
   ConvertVectorToWorldSpace(this : Quaternion, vector : Vector3) : Vector3
   {
        const quatedVector : Quaternion = new Quaternion(0, vector.x, vector.y, vector.z);
        const intermediate : Quaternion = this.MultiplyByQuaternion(quatedVector);
        const finalQuat : Quaternion = intermediate.MultiplyByQuaternion(this.Inverse());
        const final : Vector3 = new Vector3(finalQuat.x, finalQuat.y, finalQuat.z);
        return final;
   }

   ConvertVectorToLocalSpace(this : Quaternion, vector : Vector3) : Vector3
   {
        const quatedVector : Quaternion = new Quaternion(0, vector.x, vector.y, vector.z);
        const intermediate : Quaternion = this.Inverse().MultiplyByQuaternion(quatedVector);
        const finalQuat : Quaternion = intermediate.MultiplyByQuaternion(this);
        const final : Vector3 = new Vector3(finalQuat.x, finalQuat.y, finalQuat.z);
        return final;
   }
}