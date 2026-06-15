local Vector3 = require("classes.MathClasses.Vector3")

---@class Mathc
local Mathc = {
    Vector3 = Vector3
}

---@param value number
---@param min number
---@param max number
function Mathc.clamp(value, min, max)
    return math.max(min, math.min(max, value));
end

return Mathc;