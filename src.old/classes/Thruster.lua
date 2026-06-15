---@type Vector3
local Vector3 = require("classes.MathClasses.Vector3");
local emerg = require("classes.Emergency");


local null = nil;

---@class Thruster
---@field relay string Name of connected relay
---@field face string Which face of the relay its on
---@field position Vector3 normalized position from com
---@field direction Vector3 normalized forward vector relative to thrusters position
---@field dot_multiplier number
---@field rotation_multiplier number
---@field torque Vector3
---@field ApplyThrust fun(self:self, value:number):nil
---@field New fun(relay:string, face:string, position:Vector3, direction:Vector3):Thruster
local Thruster = {
    ["relay"] = "",
    ["face"] = "",
    ["position"] = nil,
    ["facing_vector"] = nil,
    ["dot_multiplier"] = 1,
    ["rotation_multiplier"] = 1,
    ["torque"] = nil;
};

Thruster.__index = Thruster;

---Thrust from 0-15
---@param value number
function Thruster:ApplyThrust(value)
    local relay = peripheral.wrap(self.relay);
    if (not relay) then
        emerg.Failure(EmergencyMode.CATOSTROPHIC, "THRUSTER FAILURE! COULD NOT FIND " .. self.relay);
        return nil;
    end
     relay.setAnalogOutput(self.face, value);

end

function Thruster.New(relay, face, position, direction)
    local instance = {};
    setmetatable(instance, Thruster);
    
    instance.relay = relay;
    instance.face = face;
    instance.position = position;
    instance.direction = direction;
    instance.torque = position:Cross((-direction));
    return instance;
end

return Thruster;