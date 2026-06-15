---@class Emergency;
---@field Failure fun(id:EmergencyMode, message:string)
local Emergency = {};
require("classes.EmergencyMode");
---@param id EmergencyMode
---@param message string
function Emergency.Failure(id, message)
    if (id == EmergencyMode.CATOSTROPHIC) then
        print("CATASTROPHIC ERROR! " .. message);
    elseif (id == EmergencyMode.MAJOR) then
        print("MAJOR ERROR! " .. message);
    elseif (id == EmergencyMode.MINOR) then
        print("CATASTROPHIC MINOR! " .. message);
    end
end

return Emergency;