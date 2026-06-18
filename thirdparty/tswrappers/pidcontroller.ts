import { Failure, FailureMode } from "../../src/classes/Failure";
import { Vector3 } from "../../src/classes/Math/Vector3";
import PidBridge from "../lua/pidcontrollers";

/*
Adaptation of PHOBOSS's PID controller into typescript.
Transcription by talkinglock.
*/
export class PIDControllerVector {
	private P: number;
	private I: number;
	private D: number;
	private Min: number;
	private Max: number;

	private Error: Vector3 = new Vector3(0, 0, 0);
	private Derivative: Vector3 = new Vector3(0, 0, 0);
	private Integral: Vector3 = new Vector3(0, 0, 0);
	private ContinueIntegralWinding: Vector3 = new Vector3(1, 1, 1);
	private IsSameSign: Vector3 = new Vector3(0, 0, 0);

	constructor(P: number, I: number, D: number, Min: number, Max: number) {
		this.P = P;
		this.I = I;
		this.D = D;
		this.Min = Min;
		this.Max = Max;
	}

	Run(this: PIDControllerVector, errorVector: Vector3): Vector3 {
		this.Derivative = errorVector.Subtract(this.Error).Divide(0.05);
		let errorSign: Vector3 = errorVector.Sign();
		let errorContinued: Vector3 = new Vector3(
			errorVector.x * this.ContinueIntegralWinding.x,
			errorVector.y * this.ContinueIntegralWinding.y,
			errorVector.z * this.ContinueIntegralWinding.z,
		);

		this.Integral = this.Integral.Add(errorContinued.Multiply(0.05));

		let output: Vector3 = errorVector.Multiply(this.P);
		output = output.Add(this.Derivative.Multiply(this.D));
		output = output.Add(this.Integral.Multiply(this.I));

		const outputSign: Vector3 = output.Sign();
		const outputClamped: Vector3 = output.Clamp(this.Min, this.Max);
		let thrusterSaturation: Vector3 = new Vector3(0, 0, 0);
		if (outputClamped.x === output.x) {
			thrusterSaturation.x = 0;
		} else {
			thrusterSaturation.x = 1;
		}

		if (outputClamped.y === output.y) {
			thrusterSaturation.y = 0;
		} else {
			thrusterSaturation.y = 1;
		}

		if (outputClamped.z === output.z) {
			thrusterSaturation.z = 0;
		} else {
			thrusterSaturation.z = 1;
		}

		if (errorSign.x === outputSign.x) {
			this.IsSameSign.x = 1;
		} else {
			this.IsSameSign.x = 0;
		}

		if (errorSign.y === outputSign.y) {
			this.IsSameSign.y = 1;
		} else {
			this.IsSameSign.y = 0;
		}

		if (errorSign.z === outputSign.z) {
			this.IsSameSign.z = 1;
		} else {
			this.IsSameSign.z = 0;
		}

		this.ContinueIntegralWinding.x =
			1 - thrusterSaturation.x * this.IsSameSign.x;
		this.ContinueIntegralWinding.y =
			1 - thrusterSaturation.y * this.IsSameSign.y;
		this.ContinueIntegralWinding.z =
			1 - thrusterSaturation.z * this.IsSameSign.z;

		this.Error = errorVector;
		return outputClamped;
	}
}
