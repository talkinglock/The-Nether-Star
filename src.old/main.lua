---@type Vector3
local Vector3 = require("classes.MathClasses.Vector3")
---@type Quaternion
local Quaternion = require("classes.MathClasses.Quaternion");
---@type ReactionControlSystem
local RCS = require("classes.ReactionControlSystem");

local pidControllers = require("pidcontrollers");

local posCorrection = Vector3.New(0, 3.79, 0);

local PidLoop = pidControllers.PID_Discrete_Vector(
    0.2,
    0.01,
    0,
    -1,
    1,
    0.05
);
local RotationPidLoop = pidControllers.PID_Continuous_Vector(
    0.2,
    0,
    0,
    -1,
    1
);

local rotation = 0

---@type Thruster
local Thruster = require("classes.Thruster");
local Thrusters = {
    ["TopForwardLeft"] = Thruster.New("redstone_relay_2", "top", Vector3.New(-1, 1, -1), Vector3.New(0, 1, 0)),
    ["TopForwardRight"] = Thruster.New("redstone_relay_5", "top", Vector3.New(1, 1, -1), Vector3.New(0, 1, 0)),
    ["TopBackLeft"] = Thruster.New("redstone_relay_12", "top", Vector3.New(-1, 1, 1), Vector3.New(0, 1, 0)),
    ["TopBackRight"] = Thruster.New("redstone_relay_3", "top", Vector3.New(1, 1, 1), Vector3.New(0, 1, 0)),

    ["BottomForwardLeft"] = Thruster.New("redstone_relay_6", "bottom", Vector3.New(-1, -1, -1), Vector3.New(0, -1, 0)),
    ["BottomForwardRight"] = Thruster.New("redstone_relay_7", "bottom", Vector3.New(1, -1, -1), Vector3.New(0, -1, 0)),
    ["BottomBackLeft"] = Thruster.New("redstone_relay_11", "bottom", Vector3.New(-1, -1, 1), Vector3.New(0, -1, 0)),
    ["BottomBackRight"] = Thruster.New("redstone_relay_10", "bottom", Vector3.New(1, -1, 1), Vector3.New(0, -1, 0)),

    ["ForwardTopLeft"] = Thruster.New("redstone_relay_2", "back", Vector3.New(-1, 1, -1), Vector3.New(0, 0, -1)),
    ["ForwardTopRight"] = Thruster.New("redstone_relay_5", "back", Vector3.New(1, 1, -1), Vector3.New(0, 0, -1)),
    ["ForwardBottomLeft"] = Thruster.New("redstone_relay_6", "back", Vector3.New(-1, -1, -1), Vector3.New(0, 0, -1)),
    ["ForwardBottomRight"] = Thruster.New("redstone_relay_7", "back", Vector3.New(1, -1, -1), Vector3.New(0, 0, -1)),

    ["BackTopLeft"] = Thruster.New("redstone_relay_12", "right", Vector3.New(-1, 1, 1), Vector3.New(0, 0, 1)),
    ["BackTopRight"] = Thruster.New("redstone_relay_3", "back", Vector3.New(1, 1, 1), Vector3.New(0, 0, 1)),
    ["BackBottomLeft"] = Thruster.New("redstone_relay_11", "right", Vector3.New(-1, -1, 1), Vector3.New(0, 0, 1)),
    ["BackBottomRight"] = Thruster.New("redstone_relay_10", "back", Vector3.New(1, -1, 1), Vector3.New(0, 0, 1)),
    
    ["RightTopLeft"] = Thruster.New("redstone_relay_5", "left", Vector3.New(1, 1, -1), Vector3.New(1, 0, 0)),
    ["RightTopRight"] = Thruster.New("redstone_relay_3", "right", Vector3.New(1, 1, 1), Vector3.New(1, 0, 0)),
    ["RightBottomLeft"] = Thruster.New("redstone_relay_7", "left", Vector3.New(1, -1, -1), Vector3.New(1, 0, 0)),
    ["RightBottomRight"] = Thruster.New("redstone_relay_10", "right", Vector3.New(1, -1, 1), Vector3.New(1, 0, 0)),

    ["LeftTopLeft"] = Thruster.New("redstone_relay_12", "back", Vector3.New(-1, 1, 1), Vector3.New(-1, 0, 0)),
    ["LeftTopRight"] = Thruster.New("redstone_relay_2", "right", Vector3.New(-1, 1, -1), Vector3.New(-1, 0, 0)),
    ["LeftBottomLeft"] = Thruster.New("redstone_relay_11", "back", Vector3.New(-1, -1, 1), Vector3.New(-1, 0, 0)),
    ["LeftBottomRight"] = Thruster.New("redstone_relay_6", "right", Vector3.New(-1, -1, -1), Vector3.New(-1, 0, 0))
}

local shipRot = Quaternion.fromAxisAngle(Vector3.New(0,1,0), 2 * math.pi);
local targetQuat = Quaternion.fromAxisAngle(Vector3.New(0,1,0),  math.rad(160));


local reactionControl = RCS.New(Thrusters, shipRot);
local x, y, z = ship.getQuaternion():toEuler()
local ticks = 0;
while true do
    rotation = rotation + 0.07;
    targetQuat = Quaternion.fromAxisAngle(Vector3.New(0,1,0), rotation);
    local position = ship.getWorldspacePosition();
    local velocity = Vector3.fromCCVS(ship.getVelocity());
    local targetVelocity = (Vector3.New(-35, 40, -51) + posCorrection) - Vector3.New(position.x, position.y, position.z)
    local velocityDifference = targetVelocity - velocity
    local PIDChange = Vector3.fromCCVS(PidLoop:run((velocityDifference:toAdvancedLib())));
    reactionControl:DotThrustersToVector(PIDChange);
        
    local q = Quaternion.fromAdvancedLib(ship.getQuaternion())
    local forward = q * Vector3.New(0,0,-1)

    local vel = Vector3.fromCCVS(ship.getVelocity())



        
    reactionControl:DoRotationBiasing(targetQuat, RotationPidLoop);

    reactionControl:Update();
    sleep(0.05);
end