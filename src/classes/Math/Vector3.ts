import { Failure, FailureMode } from "../Failure";
export class Vector3 {
    x: number = -1;
    y: number = -1;
    z: number = -1;
    constructor(conX: number, conY: number, conZ: number) {
        this.x = conX;
        this.y = conY;
        this.z = conZ;
    }

    static Zero(): Vector3 {
        const vector: Vector3 = new Vector3(0, 0, 0);
        return vector;
    }

    Dot(this: Vector3, otherVector: Vector3): number {
        const xComp: number = this.x * otherVector.x;
        const yComp: number = this.y * otherVector.y;
        const zComp: number = this.z * otherVector.z;
        const final: number = xComp + yComp + zComp;
        return final;
    }
    Cross(this: Vector3, otherVector: Vector3): Vector3 {
        const finalVector: Vector3 = new Vector3(
            this.y * otherVector.z - this.z * otherVector.y,
            this.z * otherVector.x - this.x * otherVector.z,
            this.x * otherVector.y - this.y * otherVector.x
        );
        return finalVector;

    }

    IsEqualTo(this : Vector3, otherVector : Vector3): boolean
    {
        if (this.x == otherVector.x && this.y == otherVector.y && this.z == otherVector.z)
        {
            return true;
        }
        return false;
    }

    Magnitude(this: Vector3): number {
        const final: number = Math.sqrt(this.x ** 2 + this.y ** 2 + this.z ** 2);
        return final;
    }
    Normalized(this: Vector3): Vector3 {
        const magnitude: number = this.Magnitude();
        if (magnitude === 0) {
            throw new Error("Cannot normalize a zero vector");
        }
        const normalized: Vector3 = new Vector3(
            this.x / magnitude,
            this.y / magnitude,
            this.z / magnitude
        );
        return normalized;

    }
    Add(this: Vector3, otherVector: Vector3): Vector3 {
        const product: Vector3 = new Vector3(
            this.x + otherVector.x,
            this.y + otherVector.y,
            this.z + otherVector.z
        );
        return product;
    }
    Subtract(this: Vector3, otherVector: Vector3): Vector3 {
        const difference: Vector3 = new Vector3(
            this.x - otherVector.x,
            this.y - otherVector.y,
            this.z - otherVector.z
        );
        return difference;
    }
    ComponentMultiply(this: Vector3, otherVector: Vector3): Vector3 {
        const product: Vector3 = new Vector3(
            this.x * otherVector.x,
            this.y * otherVector.y,
            this.z * otherVector.z
        );
        return product;
    }
    Multiply(this: Vector3, number: number): Vector3 {
        const product: Vector3 = new Vector3(
            this.x * number,
            this.y * number,
            this.z * number
        );
        return product;
    }
    Inverse(this: Vector3): Vector3 {

        const inverted: Vector3 = this.Multiply(-1);
        return inverted;
    }
}