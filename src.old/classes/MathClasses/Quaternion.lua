---@class Quaternion 
---@field x number
---@field y number
---@field z number
---@field w number
---@field fromAdvancedLib fun(original:any):Quaternion
---@field multiply fun(self:self, vec:Vector3):Vector3
---@field fromAxisAngle fun(vector:Vector3, angle:number):Quaternion
---@field ConvertVectorToWorldSpace fun(self:self, vec:Vector3):Vector3
---@field ConvertVectorToLocalSpace fun(self:self, vec:Vector3):Vector3
---@field Inverse fun():Quaternion
---@field new fun(x:number, y:number, z:number, w:number):Quaternion

local std = require("classes.Standard");
---@type Vector3
local Vector3 = require("classes.MathClasses.Vector3");


local Quaternion = {
    _type = "Quaternion"
}
Quaternion.__index = Quaternion;

---@param quat Quaternion
---@param vec Vector3
Quaternion.__mul = function(quat, other)
    return quat:multiply(quat, other);
end

---@param vector Vector3
---@param angle number
function Quaternion.fromAxisAngle(vector, angle)
    local len = math.sqrt(vector.x^2 + vector.y^2 + vector.z^2)

    if len < 1e-8 then
        return Quaternion.New(0, 0, 0, 1)
    end

    local x = vector.x / len
    local y = vector.y / len
    local z = vector.z / len

    local half = angle * 0.5
    local s = math.sin(half)
    local c = math.cos(half)

    return Quaternion.New(
        x * s,
        y * s,
        z * s,
        c
    )
end

---@return Quaternion
function Quaternion:Inverse()
   local squaredNorm = self.x^2 + self.y^2 + self.z^2 + self.w^2;
   local inverted = Quaternion.New(-self.x/squaredNorm, -self.y/squaredNorm, -self.z/squaredNorm, self.w/squaredNorm);
   return inverted;
end

---@param v Vector3|Quaternion;
function Quaternion:multiply(this, v)
    -- Generated this function with the big GPT going to be so for real I have a love hate relationship with quaternions
    if std.typeof(v) == "Vector3" then
        local x, y, z = self.x, self.y, self.z;
        local w = self.w;

        -- t = 2 * cross(q.xyz, v)
        local tx = 2 * (y * v.z - z * v.y);
        local ty = 2 * (z * v.x - x * v.z);
        local tz = 2 * (x * v.y - y * v.x);

        -- v + w * t
        local vx = v.x + w * tx;
        local vy = v.y + w * ty;
        local vz = v.z + w * tz;

        -- + cross(q.xyz, t)
        vx = vx + (y * tz - z * ty);
        vy = vy + (z * tx - x * tz);
        vz = vz + (x * ty - y * tx);

        local endVector = Vector3.New(vx, vy, vz);
        return endVector;
    elseif std.typeof(v) == "Quaternion" then
        local x = self.w*v.x + self.x*v.w + self.y*v.z - self.z*v.y;
        local y = self.w*v.y - self.x*v.z + self.y*v.w + self.z*v.x;
        local z = self.w*v.z + self.x*v.y - self.y*v.x + self.z*v.w;
        local w = self.w*v.w - self.x*v.x - self.y*v.y - self.z*v.z;
        return Quaternion.New(x,y,z,w);
    end
    
end

---@param vec Vector3 
--- Converts a vector to world space, assuming that the rotation of the vector can be expressed by this quaternion
function Quaternion:ConvertVectorToWorldSpace(vec)
    local vecQuat = Quaternion.New(vec.x, vec.y, vec.z, 0);
    local intermediate = self * vecQuat;
    local finalQuat = intermediate * self:Inverse();
    local final = Vector3.New(finalQuat.x, finalQuat.y, finalQuat.z);
    return final;
end
---@param vec Vector3 
--- Converts a vector to local space
function Quaternion:ConvertVectorToLocalSpace(vec)
    local vecQuat = Quaternion.New(vec.x, vec.y, vec.z, 0);
    local intermediate = self:Inverse() * vecQuat;
    local finalQuat = intermediate * self;
    local final = Vector3.New(finalQuat.x, finalQuat.y, finalQuat.z);
    return final;
end
function Quaternion.New(x, y, z, w)
    local instance = {};
    instance.x = x;
    instance.y = y;
    instance.z = z;
    instance.w = w;
    setmetatable(instance, Quaternion);
    return instance;
end
function Quaternion.fromAdvancedLib(original)
    local instance = {};
    setmetatable(instance, Quaternion);
    instance.x = original.v.x;
    instance.y = original.v.y;
    instance.z = original.v.z;
    instance.w = original.a;
    return instance
end

return Quaternion;