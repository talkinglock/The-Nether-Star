local null = nil;

---@class Standard
local Standard = {}

function Standard.typeof(check)
    local mt = getmetatable(check);
    if mt and mt._type then
        return mt._type
    else
        return type(check)
    end
end

return Standard
