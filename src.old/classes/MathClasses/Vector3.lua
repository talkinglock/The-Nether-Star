local Standard = require("classes.MathClasses.classes.Standard")
---@class Vector3
---@field x number
---@field y number
---@field z number
---@field New fun(x:number, y:number, z:number):Vector3
---@field toAdvancedLib fun(self:self):vector
---@field fromCCVS fun(vector:any):Vector3
---@field Zero fun():Vector3
---@field Magnitude fun(self:self):number "Length" or "Distance" of the vector
---@field Normalized fun(self:self):Vector3 The vector normalized
---@field Dot fun(self:self, OtherVector:Vector3):number Dot product
---@field Cross fun(self:self, OtherVector:Vector3):Vector3

local Vector3 = {
    x = 0,
    y = 0,
    z = 0,
    _type = "Vector3";
};


Vector3.__index = Vector3;
Vector3.__mul = function (this, other)
    if Standard.typeof(other) == "Vector3" and Standard.typeof(this) == "Vector3" then
        return Vector3.New(this.x * other.x, this.y * other.y, this.z * other.z);
    end
    if Standard.typeof(other) == "number" and Standard.typeof(this) == "Vector3" then
        return Vector3.New(this.x * other, this.y * other, this.z * other);
    end
    if Standard.typeof(this) == "Quaternion" and Standard.typeof(other) == "Vector3" then
        local qVec = Vector3.New(other.x, other.y, other.z)
    
    -- Calculate the two cross products
        local cross1 = qVec:Cross(this)
        local cross2 = qVec:Cross(cross1)
        
        -- Final combined formula: v + 2w*(q x v) + 2*(q x (q x v))
        return this + (cross1 * (2 * other.w)) + (cross2 * 2)
    end
end

Vector3.__unm = function (vec)
    return vec * -1;
end 

Vector3.__sub = function(vector, otherVector)
    if Standard.typeof(vector) == "Vector3" and Standard.typeof(otherVector) == "Vector3" then
        return Vector3.New(vector.x - otherVector.x, vector.y - otherVector.y, vector.z - otherVector.z);
    end
    if Standard.typeof(vector) == "Vector3" and Standard.typeof(otherVector) == "number" then
        return Vector3.New(vector.x - otherVector, vector.y - otherVector, vector.z - otherVector);
    end
end
Vector3.__add = function (vector, otherVector)
    if Standard.typeof(vector) == "Vector3" and Standard.typeof(vector) == "Vector3" then
        return Vector3.New(vector.x + otherVector.x, vector.y + otherVector.y, vector.z + otherVector.z);
    end
end


function Vector3.New(x, y, z)
    local instance = {
        x = x,
        y = y,
        z = z
    };
    setmetatable(instance, Vector3);
    return instance;
end

function Vector3:toAdvancedLib()
    return vector.new(self.x, self.y, self.z)
end
function Vector3.fromCCVS(oldVector)
    local instance = {
        x = oldVector.x,
        y = oldVector.y,
        z = oldVector.z
    };
    setmetatable(instance, Vector3);
    return instance;
end

---@param OtherVector Vector3 
function Vector3:Dot(OtherVector)
    return (self.x * OtherVector.x + self.y * OtherVector.y + self.z * OtherVector.z);
end

---@param OtherVector Vector3
function Vector3:Cross(OtherVector)
    local a = self;
    local b = OtherVector;
    return Vector3.New(
        a.y * b.z - a.z * b.y,
        a.z * b.x - a.x * b.z,
        a.x * b.y - a.y * b.x
    )
end

function Vector3:Magnitude()
    return math.sqrt(self.x^2 + self.y^2 + self.z^2);
end

function Vector3:Normalized()

    local mag = self:Magnitude();
    ---@type Vector3
    local newVector = Vector3.New(self.x/mag, self.y/mag, self.z/mag);
    
    return newVector;
end

function Vector3.Zero()
    return Vector3.New(0,0,0);
end
return Vector3;