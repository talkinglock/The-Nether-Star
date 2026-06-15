---@class ReactionControlSystem The RCS System allows for full rotational and translational control
---@field Thrusters table
---@field New fun(Thrusters:table<Thruster>, fixedRotation:Quaternion):ReactionControlSystem
---@field fixedRotation Quaternion
---@field DotThrustersToVector fun(vec:Vector3):nil
---@field Update fun():nil Nothing happens without updating, do this in a loop


local Mathc = require("classes.Mathc");
---@type Vector3
local Vector3 = require("classes.MathClasses.Vector3");
local Quaternion = require("classes.MathClasses.Quaternion");
local Standard   = require("classes.Standard");
local RCS = {
    Thrusters = {},
    fixedRotation = nil,
    pidLoop = nil;
}
RCS.__index = RCS;


function RCS.New(Thrusters, fixedRotation)
    local instance = {};
    instance.Thrusters = Thrusters;
    instance.fixedRotation = fixedRotation;
    setmetatable(instance, RCS); 
    return instance;
end

--- Will dot all thrusters to this vector, speed is magnitude
---@param vec Vector3
function RCS:DotThrustersToVector(vec)
    ---@type table<string, number>
    local returnTable = {}
    local shipRot = Quaternion.fromAdvancedLib(ship.getQuaternion());
    for _, thruster in pairs (self.Thrusters) do
        ---@cast thruster Thruster
        ---@type Vector3
        local worldSpace = shipRot  * thruster.direction
        local dot = worldSpace:Dot(vec:Normalized());

        local pos = thruster.position;

        

        thruster.dot_multiplier = -(dot * vec:Magnitude());
    end
end

---@param targetQuat Quaternion
---@param loop any
function RCS:DoRotationBiasing(targetQuat, loop)
    ---@type Quaternion
    local currentQuaternion = Quaternion.fromAdvancedLib(ship.getQuaternion());

    local worldError = currentQuaternion:Inverse() * targetQuat; 
    
    if (worldError.w < 0) then
        worldError = Quaternion.New(-worldError.x, -worldError.y, -worldError.z, -worldError.w);
    end
    local angle = 2 * math.acos(worldError.w);

    local devisor = math.sin(angle/2);

    local axis;

    axis = Vector3.New(worldError.x/devisor, worldError.y/devisor, worldError.z/devisor);
    local worldAngularVelocity = Vector3.fromCCVS(ship.getAngularVelocity());
    local localAngularVelocity = currentQuaternion:ConvertVectorToLocalSpace(worldAngularVelocity);

    local PIDFeed = ((axis * angle) - localAngularVelocity):toAdvancedLib();
    local PIDResult = Vector3.fromCCVS(loop:run(PIDFeed));

    for _, thruster in pairs(self.Thrusters) do
        ---@cast thruster Thruster
        --local worldSpaceTorque = currentQuaternion:ConvertVectorToWorldSpace(thruster.torque);
        local alignment = thruster.torque:Dot(PIDResult);
        local score = alignment;
        print(score);
        thruster.rotation_multiplier = score;
    end
end

function RCS:Update()
    -- The only function that actually administers thrust to the ship
    for name, thruster in pairs (self.Thrusters) do
        ---@cast thruster Thruster
        local thrust = (thruster.dot_multiplier + thruster.rotation_multiplier) * 15
        thruster:ApplyThrust(Mathc.clamp(thrust, 0, 15))
        thruster.dot_multiplier = 0;
        thruster.rotation_multiplier = 0;
    end
end

return RCS;