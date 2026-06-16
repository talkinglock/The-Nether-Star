---@type table
local shipBridge = {}


function shipBridge.SHIPBRIDGE__POSITION(_)
    local position = ship.getWorldspacePosition();
    return {position.x, position.y, position.z};
end
function shipBridge.SHIPBRIDGE__QUATERNION(_)
    local quat = ship.getQuaternion();
    return {quat.a, quat.v.x, quat.v.y, quat.v.z};
end
---@param relay string
function shipBridge.SHIPBRIDGE__DOESRELAYEXIST(_, relay)
    local relay = peripheral.wrap(relay);
    if (relay == nil) then
        return false;
    end
    return true;
end
---@param relay string
---@param face string
---@param power number
---@return boolean
function shipBridge.SHIPBRIDGE__SETRELAYOUTPUT(_, relay, face, power)
    if (shipBridge.SHIPBRIDGE__DOESRELAYEXIST(_, relay)) then
        local relay = peripheral.wrap(relay);
        relay.setAnalogOutput(face, power);
        return true
    end
    return false
end
---@param relay string
---@param face string
---@param power number
---@return number
function shipBridge.SHIPBRIDGE__GETRELAYOUTPUT(_, relay, face)
    if (shipBridge.SHIPBRIDGE__DOESRELAYEXIST(_, relay)) then
        local relay = peripheral.wrap(relay);
        
        return relay.getAnalogOutput(face);
    end
    return -1;
end
---@return table
function shipBridge.SHIPBRIDGE__GETVELOCITY(_)
    local velocity = ship.getVelocity();
    return {velocity.x, velocity.y, velocity.z};
end
---@return table
function shipBridge.SHIPBRIDGE__GETANGULARVELOCITY(_)
    local angularVelocity = ship.getAngularVelocity();
    return {angularVelocity.x, angularVelocity.y, angularVelocity.z};
end
return shipBridge;