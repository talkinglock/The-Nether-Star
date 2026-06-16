--os.loadAPI("lib/utilities.lua")

local utilities       = require "utilities"
local roundTo_vector3 = utilities.roundTo_vector3
local round_vector3   = utilities.round_vector3
local clamp_vector3   = utilities.clamp_vector3
local sign_vector3    = utilities.sign_vector3
local abs_vector3     = utilities.abs_vector3
local roundTo         = utilities.roundTo
local sign            = utilities.sign
local clamp           = utilities.clamp
local pidcontrollers  = {}
--[[

Modified by talkinglock for the nether star.

thanks to: Jyota_malcolm
https://www.reddit.com/r/Stormworks/comments/kei6pg/lua_code_for_a_basic_pid/


function pid(p,i,d)
return{p=p,i=i,d=d,error=0,derivative=0,integral=0,run=function(self,setpoint,process_variable)
		local error,derivative
		local integral = 0
		error = setpoint-process_variable
		derivative = error-self.error
		if math.abs(integral*self.i) < 1 then
			integral = self.integral+error
		else
			integral = integral*0.5
		end
		
		self.error = error
		self.derivative = derivative
		self.integral = integral
		
		return error*self.p + integral*self.i +derivative*self.d
	end
}
end
]] --

function pidcontrollers.PID_Continuous_Vector(p, i, d, clamp_parameter_min, clamp_parameter_max)
	local this = {}
	this.error = vector.new(0, 0, 0)
	this.derivative = vector.new(0, 0, 0)
	this.integral = vector.new(0, 0, 0)
	this.continue_integral_compounding = vector.new(1, 1, 1)
	this.is_same_sign = vector.new(0, 0, 0)

	function run(error_vector)
		local error, derivative
		local integral = vector.new(0, 0, 0)

		error = error_vector

		local error_sign = sign_vector3(error)

		--derivative = (input:sub(self.last_input)):div(0.05)-- anti derivative kick
		derivative = (error:sub(this.error)):div(0.05) -- had to go back to default derivative :(

		-- need to clamp integral to account for pwm thruster saturation --
		--https://youtu.be/NVLXCwc8HzM--
		this.error = error

		local err_x_cont = vector.new(error.x, error.y, error.z)
		err_x_cont.x = err_x_cont.x * this.continue_integral_compounding.x
		err_x_cont.y = err_x_cont.y * this.continue_integral_compounding.y
		err_x_cont.z = err_x_cont.z * this.continue_integral_compounding.z

		integral = this.integral:add(err_x_cont:mul(0.05))

		this.derivative = derivative
		this.integral = integral

		local output = error:mul(this.p)
		output = output:add(derivative:mul(this.d))
		output = output:add(integral:mul(this.i))
		local output_sign = sign_vector3(output)

		local clamped_output = clamp_vector3(output, clamp_parameter_min, clamp_parameter_max)

		local thruster_is_saturated = vector.new(0, 0, 0)

		thruster_is_saturated.x = clamped_output.x == output.x and 0 or 1
		thruster_is_saturated.y = clamped_output.y == output.y and 0 or 1
		thruster_is_saturated.z = clamped_output.z == output.z and 0 or 1

		this.is_same_sign.x = error_sign.x == output_sign.x and 1 or 0
		this.is_same_sign.y = error_sign.y == output_sign.y and 1 or 0
		this.is_same_sign.z = error_sign.z == output_sign.z and 1 or 0

		this.continue_integral_compounding.x = 1 - (thruster_is_saturated.x * this.is_same_sign.x)
		this.continue_integral_compounding.y = 1 - (thruster_is_saturated.y * this.is_same_sign.y)
		this.continue_integral_compounding.z = 1 - (thruster_is_saturated.z * this.is_same_sign.z)

		return {clamped_output.x, clamped_output.y, clamped_output.z};
		-- need to clamp integral to account for thruster saturation --
	end
end

function pidcontrollers.PID_Continuous_Quaternion(p, i, d, iMax, clamp_parameter_min, clamp_parameter_max)
	local table = {}
	local integral = { x = 0, y = 0, z = 0 }
	local last_error = { x = 0, y = 0, z = 0 }
	local dt = 0.02;
	function table:runPer(axis, error)
		-- Proportional
		local P = p * error

		-- Integral
		integral[axis] = integral[axis] + (error * 0.05)
		integral[axis] = Mathc.clamp(integral[axis], -iMax, iMax);
		local I = i * integral[axis]

		-- Derivative
		local derivative = (error - last_error[axis]) / 0.05
		local D = d * derivative

		last_error[axis] = error
		local totalOutput = (P + I + D);
		return Mathc.clamp(totalOutput, clamp_parameter_min, clamp_parameter_max);
	end

	function table:run(errorQuat)
		if errorQuat.w < 0 then
			errorQuat = Quaternion.New(-errorQuat.x, -errorQuat.y, -errorQuat.z, -errorQuat.w);
		end
		local angle = 2 * math.acos(math.max(-1, math.min(1, q_err.w)))
		local s = math.sin(angle / 2)
		if s == 0 then s = 1 end

		local errX = (errorQuat.x / s) * angle
		local errY = (errorQuat.y / s) * angle
		local errZ = (errorQuat.z / s) * angle

		-- D. Run independent PID loops for Pitch, Yaw, Roll
		local outX = self:runPer("x", errX)
		local outY = self:runPer("y", errY)
		local outZ = self:runPer("z", errZ)

		-- The final output type should be a Vector3 (Torque Vector), NOT a Quaternion.
		-- Assuming your engine has a standard Vector3 object:
		return Vector3.new(outX, outY, outZ)
	end

	return table
end

function pidcontrollers.PID_Continuous_Scalar(p, i, d, clamp_parameter_min, clamp_parameter_max)
	return {
		p = p,
		i = i,
		d = d,
		error = 0,
		derivative = 0,
		integral = 0,
		continue_integral_compounding = 1,
		is_same_sign = 0,

		run = function(self, err)
			local error, derivative
			local integral = 0
			error = err
			error_sign = sign(error)

			--derivative = (input-self.last_input)/0.05-- anti derivative kick
			derivative = (error - self.error) / 0.05 -- anti derivative kick

			-- need to clamp integral to account for pwm thruster saturation --
			--https://youtu.be/NVLXCwc8HzM--
			self.error = error
			err_x_cont = error * self.continue_integral_compounding

			integral = self.integral + (err_x_cont * 0.05)

			self.derivative = derivative
			self.integral = integral

			output = (error * self.p) + (derivative * self.d) + (integral * self.i)

			output_sign = sign(output)

			clamped_output = clamp(output, clamp_parameter_min, clamp_parameter_max)

			thruster_is_saturated = 0

			thruster_is_saturated = clamped_output == output and 0 or 1

			self.is_same_sign = error_sign == output_sign and 1 or 0

			self.continue_integral_compounding = 1 - (thruster_is_saturated * self.is_same_sign)

			return clamped_output

			-- need to clamp integral to account for thruster saturation --
		end
	}
end

function pidcontrollers.PID_Discrete_Vector(p, i, d, clamp_parameter_min, clamp_parameter_max, sample_interval)
	return {
		p = p,
		i = i,
		d = d,
		error = vector.new(0, 0, 0),
		prev_error = vector.new(0, 0, 0),
		derivative = vector.new(0, 0, 0),
		integral = vector.new(0, 0, 0),
		continue_integral_compounding = vector.new(1, 1, 1),
		is_same_sign = vector.new(0, 0, 0),

		run = function(self, error_vector)
			local error, prev_error, derivative
			local integral = vector.new(0, 0, 0)

			error = error_vector

			error_sign = sign_vector3(error)

			--derivative = (input:sub(self.last_input)):div(0.05)-- anti derivative kick
			derivative = (error:sub(self.error)):div(sample_interval) -- had to go back to default derivative :(

			-- need to clamp integral to account for pwm thruster saturation --
			--https://youtu.be/NVLXCwc8HzM--
			self.error = error

			err_x_cont = vector.new(error.x, error.y, error.z)
			err_x_cont.x = err_x_cont.x * self.continue_integral_compounding.x
			err_x_cont.y = err_x_cont.y * self.continue_integral_compounding.y
			err_x_cont.z = err_x_cont.z * self.continue_integral_compounding.z

			local disc_integ_err = self.prev_error:add(err_x_cont:add(self.error:mul(2)))

			integral = self.integral:add(disc_integ_err:mul(sample_interval * 0.5))

			self.derivative = derivative
			self.integral = integral

			output = error:mul(self.p)
			output = output:add(derivative:mul(self.d))
			output = output:add(integral:mul(self.i))
			output_sign = sign_vector3(output)

			clamped_output = clamp_vector3(output, clamp_parameter_min, clamp_parameter_max)

			thruster_is_saturated = vector.new(0, 0, 0)

			thruster_is_saturated.x = clamped_output.x == output.x and 0 or 1
			thruster_is_saturated.y = clamped_output.y == output.y and 0 or 1
			thruster_is_saturated.z = clamped_output.z == output.z and 0 or 1

			self.is_same_sign.x = error_sign.x == output_sign.x and 1 or 0
			self.is_same_sign.y = error_sign.y == output_sign.y and 1 or 0
			self.is_same_sign.z = error_sign.z == output_sign.z and 1 or 0

			self.continue_integral_compounding.x = 1 - (thruster_is_saturated.x * self.is_same_sign.x)
			self.continue_integral_compounding.y = 1 - (thruster_is_saturated.y * self.is_same_sign.y)
			self.continue_integral_compounding.z = 1 - (thruster_is_saturated.z * self.is_same_sign.z)

			return clamped_output

			-- need to clamp integral to account for thruster saturation --
		end
	}
end

function pidcontrollers.PID_Discrete_Scalar(p, i, d, clamp_parameter_min, clamp_parameter_max, sample_interval)
	return {
		p = p,
		i = i,
		d = d,
		error = 0,
		prev_error = 0,
		derivative = 0,
		integral = 0,
		continue_integral_compounding = 1,
		is_same_sign = 0,

		run = function(self, err)
			local error, prev_error, derivative
			local integral = 0
			error = err
			error_sign = sign(error)

			--derivative = (input-self.last_input)/0.05-- anti derivative kick
			derivative = (error - self.error) / sample_interval -- anti derivative kick

			-- need to clamp integral to account for pwm thruster saturation --
			--https://youtu.be/NVLXCwc8HzM--

			err_x_cont = error * self.continue_integral_compounding

			integral = self.integral + (sample_interval * 0.5) * (err_x_cont + 2 * self.error + self.prev_error)

			self.prev_error = self.error
			self.error = error
			self.derivative = derivative
			self.integral = integral

			output = (error * self.p) + (derivative * self.d) + (integral * self.i)

			output_sign = sign(output)

			clamped_output = clamp(output, clamp_parameter_min, clamp_parameter_max)

			thruster_is_saturated = 0

			thruster_is_saturated = clamped_output == output and 0 or 1

			self.is_same_sign = error_sign == output_sign and 1 or 0

			self.continue_integral_compounding = 1 - (thruster_is_saturated * self.is_same_sign)

			return clamped_output

			-- need to clamp integral to account for thruster saturation --
		end
	}
end

return pidcontrollers
