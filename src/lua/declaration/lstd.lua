-- standard library for functions ts scripts need to reference

---@type table
local std = {};


---@param message string
---@return nil
function std.LUA__log(self, message)
    print(message);
    return nil;
end
function std.LUA__SLEEP(self, time)
    sleep(time)
end

return std;