--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]

local ____modules = {}
local ____moduleCache = {}
local ____originalRequire = require
local function require(file, ...)
    if ____moduleCache[file] then
        return ____moduleCache[file].value
    end
    if ____modules[file] then
        local module = ____modules[file]
        local value = nil
        if (select("#", ...) > 0) then value = module(...) else value = module(file) end
        ____moduleCache[file] = { value = value }
        return value
    else
        if ____originalRequire then
            return ____originalRequire(file)
        else
            error("module '" .. file .. "' not found")
        end
    end
end
____modules = {
["lualib_bundle"] = function(...) 
local function __TS__ArrayAt(self, relativeIndex)
    local absoluteIndex = relativeIndex < 0 and #self + relativeIndex or relativeIndex
    if absoluteIndex >= 0 and absoluteIndex < #self then
        return self[absoluteIndex + 1]
    end
    return nil
end

local function __TS__ArrayIsArray(value)
    return type(value) == "table" and (value[1] ~= nil or next(value) == nil)
end

local function __TS__ArrayConcat(self, ...)
    local items = {...}
    local result = {}
    local len = 0
    for i = 1, #self do
        len = len + 1
        result[len] = self[i]
    end
    for i = 1, #items do
        local item = items[i]
        if __TS__ArrayIsArray(item) then
            for j = 1, #item do
                len = len + 1
                result[len] = item[j]
            end
        else
            len = len + 1
            result[len] = item
        end
    end
    return result
end

local __TS__Symbol, Symbol
do
    local symbolMetatable = {__tostring = function(self)
        return ("Symbol(" .. (self.description or "")) .. ")"
    end}
    function __TS__Symbol(description)
        return setmetatable({description = description}, symbolMetatable)
    end
    Symbol = {
        asyncDispose = __TS__Symbol("Symbol.asyncDispose"),
        dispose = __TS__Symbol("Symbol.dispose"),
        iterator = __TS__Symbol("Symbol.iterator"),
        hasInstance = __TS__Symbol("Symbol.hasInstance"),
        species = __TS__Symbol("Symbol.species"),
        toStringTag = __TS__Symbol("Symbol.toStringTag")
    }
end

local function __TS__ArrayEntries(array)
    local key = 0
    return {
        [Symbol.iterator] = function(self)
            return self
        end,
        next = function(self)
            local result = {done = array[key + 1] == nil, value = {key, array[key + 1]}}
            key = key + 1
            return result
        end
    }
end

local function __TS__ArrayEvery(self, callbackfn, thisArg)
    for i = 1, #self do
        if not callbackfn(thisArg, self[i], i - 1, self) then
            return false
        end
    end
    return true
end

local function __TS__ArrayFill(self, value, start, ____end)
    local relativeStart = start or 0
    local relativeEnd = ____end or #self
    if relativeStart < 0 then
        relativeStart = relativeStart + #self
    end
    if relativeEnd < 0 then
        relativeEnd = relativeEnd + #self
    end
    do
        local i = relativeStart
        while i < relativeEnd do
            self[i + 1] = value
            i = i + 1
        end
    end
    return self
end

local function __TS__ArrayFilter(self, callbackfn, thisArg)
    local result = {}
    local len = 0
    for i = 1, #self do
        if callbackfn(thisArg, self[i], i - 1, self) then
            len = len + 1
            result[len] = self[i]
        end
    end
    return result
end

local function __TS__ArrayForEach(self, callbackFn, thisArg)
    for i = 1, #self do
        callbackFn(thisArg, self[i], i - 1, self)
    end
end

local function __TS__ArrayFind(self, predicate, thisArg)
    for i = 1, #self do
        local elem = self[i]
        if predicate(thisArg, elem, i - 1, self) then
            return elem
        end
    end
    return nil
end

local function __TS__ArrayFindIndex(self, callbackFn, thisArg)
    for i = 1, #self do
        if callbackFn(thisArg, self[i], i - 1, self) then
            return i - 1
        end
    end
    return -1
end

local __TS__Iterator
do
    local function iteratorGeneratorStep(self)
        local co = self.____coroutine
        local status, value = coroutine.resume(co)
        if not status then
            error(value, 0)
        end
        if coroutine.status(co) == "dead" then
            return
        end
        return true, value
    end
    local function iteratorIteratorStep(self)
        local result = self:next()
        if result.done then
            return
        end
        return true, result.value
    end
    local function iteratorStringStep(self, index)
        index = index + 1
        if index > #self then
            return
        end
        return index, string.sub(self, index, index)
    end
    function __TS__Iterator(iterable)
        if type(iterable) == "string" then
            return iteratorStringStep, iterable, 0
        elseif iterable.____coroutine ~= nil then
            return iteratorGeneratorStep, iterable
        elseif iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            return iteratorIteratorStep, iterator
        else
            return ipairs(iterable)
        end
    end
end

local __TS__ArrayFrom
do
    local function arrayLikeStep(self, index)
        index = index + 1
        if index > self.length then
            return
        end
        return index, self[index]
    end
    local function arrayLikeIterator(arr)
        if type(arr.length) == "number" then
            return arrayLikeStep, arr, 0
        end
        return __TS__Iterator(arr)
    end
    function __TS__ArrayFrom(arrayLike, mapFn, thisArg)
        local result = {}
        if mapFn == nil then
            for ____, v in arrayLikeIterator(arrayLike) do
                result[#result + 1] = v
            end
        else
            local i = 0
            for ____, v in arrayLikeIterator(arrayLike) do
                local ____mapFn_3 = mapFn
                local ____thisArg_1 = thisArg
                local ____v_2 = v
                local ____i_0 = i
                i = ____i_0 + 1
                result[#result + 1] = ____mapFn_3(____thisArg_1, ____v_2, ____i_0)
            end
        end
        return result
    end
end

local function __TS__ArrayIncludes(self, searchElement, fromIndex)
    if fromIndex == nil then
        fromIndex = 0
    end
    local len = #self
    local k = fromIndex
    if fromIndex < 0 then
        k = len + fromIndex
    end
    if k < 0 then
        k = 0
    end
    for i = k + 1, len do
        if self[i] == searchElement then
            return true
        end
    end
    return false
end

local function __TS__ArrayIndexOf(self, searchElement, fromIndex)
    if fromIndex == nil then
        fromIndex = 0
    end
    local len = #self
    if len == 0 then
        return -1
    end
    if fromIndex >= len then
        return -1
    end
    if fromIndex < 0 then
        fromIndex = len + fromIndex
        if fromIndex < 0 then
            fromIndex = 0
        end
    end
    for i = fromIndex + 1, len do
        if self[i] == searchElement then
            return i - 1
        end
    end
    return -1
end

local function __TS__ArrayJoin(self, separator)
    if separator == nil then
        separator = ","
    end
    local parts = {}
    for i = 1, #self do
        parts[i] = tostring(self[i])
    end
    return table.concat(parts, separator)
end

local function __TS__ArrayMap(self, callbackfn, thisArg)
    local result = {}
    for i = 1, #self do
        result[i] = callbackfn(thisArg, self[i], i - 1, self)
    end
    return result
end

local function __TS__ArrayPush(self, ...)
    local items = {...}
    local len = #self
    for i = 1, #items do
        len = len + 1
        self[len] = items[i]
    end
    return len
end

local function __TS__ArrayPushArray(self, items)
    local len = #self
    for i = 1, #items do
        len = len + 1
        self[len] = items[i]
    end
    return len
end

local function __TS__CountVarargs(...)
    return select("#", ...)
end

local function __TS__ArrayReduce(self, callbackFn, ...)
    local len = #self
    local k = 0
    local accumulator = nil
    if __TS__CountVarargs(...) ~= 0 then
        accumulator = ...
    elseif len > 0 then
        accumulator = self[1]
        k = 1
    else
        error("Reduce of empty array with no initial value", 0)
    end
    for i = k + 1, len do
        accumulator = callbackFn(
            nil,
            accumulator,
            self[i],
            i - 1,
            self
        )
    end
    return accumulator
end

local function __TS__ArrayReduceRight(self, callbackFn, ...)
    local len = #self
    local k = len - 1
    local accumulator = nil
    if __TS__CountVarargs(...) ~= 0 then
        accumulator = ...
    elseif len > 0 then
        accumulator = self[k + 1]
        k = k - 1
    else
        error("Reduce of empty array with no initial value", 0)
    end
    for i = k + 1, 1, -1 do
        accumulator = callbackFn(
            nil,
            accumulator,
            self[i],
            i - 1,
            self
        )
    end
    return accumulator
end

local function __TS__ArrayReverse(self)
    local i = 1
    local j = #self
    while i < j do
        local temp = self[j]
        self[j] = self[i]
        self[i] = temp
        i = i + 1
        j = j - 1
    end
    return self
end

local function __TS__ArrayUnshift(self, ...)
    local items = {...}
    local numItemsToInsert = #items
    if numItemsToInsert == 0 then
        return #self
    end
    for i = #self, 1, -1 do
        self[i + numItemsToInsert] = self[i]
    end
    for i = 1, numItemsToInsert do
        self[i] = items[i]
    end
    return #self
end

local function __TS__ArraySort(self, compareFn)
    if compareFn ~= nil then
        table.sort(
            self,
            function(a, b) return compareFn(nil, a, b) < 0 end
        )
    else
        table.sort(self)
    end
    return self
end

local function __TS__ArraySlice(self, first, last)
    local len = #self
    first = first or 0
    if first < 0 then
        first = len + first
        if first < 0 then
            first = 0
        end
    else
        if first > len then
            first = len
        end
    end
    last = last or len
    if last < 0 then
        last = len + last
        if last < 0 then
            last = 0
        end
    else
        if last > len then
            last = len
        end
    end
    local out = {}
    first = first + 1
    last = last + 1
    local n = 1
    while first < last do
        out[n] = self[first]
        first = first + 1
        n = n + 1
    end
    return out
end

local function __TS__ArraySome(self, callbackfn, thisArg)
    for i = 1, #self do
        if callbackfn(thisArg, self[i], i - 1, self) then
            return true
        end
    end
    return false
end

local function __TS__ArraySplice(self, ...)
    local args = {...}
    local len = #self
    local actualArgumentCount = __TS__CountVarargs(...)
    local start = args[1]
    local deleteCount = args[2]
    if start < 0 then
        start = len + start
        if start < 0 then
            start = 0
        end
    elseif start > len then
        start = len
    end
    local itemCount = actualArgumentCount - 2
    if itemCount < 0 then
        itemCount = 0
    end
    local actualDeleteCount
    if actualArgumentCount == 0 then
        actualDeleteCount = 0
    elseif actualArgumentCount == 1 then
        actualDeleteCount = len - start
    else
        actualDeleteCount = deleteCount or 0
        if actualDeleteCount < 0 then
            actualDeleteCount = 0
        end
        if actualDeleteCount > len - start then
            actualDeleteCount = len - start
        end
    end
    local out = {}
    for k = 1, actualDeleteCount do
        local from = start + k
        if self[from] ~= nil then
            out[k] = self[from]
        end
    end
    if itemCount < actualDeleteCount then
        for k = start + 1, len - actualDeleteCount do
            local from = k + actualDeleteCount
            local to = k + itemCount
            if self[from] then
                self[to] = self[from]
            else
                self[to] = nil
            end
        end
        for k = len - actualDeleteCount + itemCount + 1, len do
            self[k] = nil
        end
    elseif itemCount > actualDeleteCount then
        for k = len - actualDeleteCount, start + 1, -1 do
            local from = k + actualDeleteCount
            local to = k + itemCount
            if self[from] then
                self[to] = self[from]
            else
                self[to] = nil
            end
        end
    end
    local j = start + 1
    for i = 3, actualArgumentCount do
        self[j] = args[i]
        j = j + 1
    end
    for k = #self, len - actualDeleteCount + itemCount + 1, -1 do
        self[k] = nil
    end
    return out
end

local function __TS__ArrayToObject(self)
    local object = {}
    for i = 1, #self do
        object[i - 1] = self[i]
    end
    return object
end

local function __TS__ArrayFlat(self, depth)
    if depth == nil then
        depth = 1
    end
    local result = {}
    local len = 0
    for i = 1, #self do
        local value = self[i]
        if depth > 0 and __TS__ArrayIsArray(value) then
            local toAdd
            if depth == 1 then
                toAdd = value
            else
                toAdd = __TS__ArrayFlat(value, depth - 1)
            end
            for j = 1, #toAdd do
                local val = toAdd[j]
                len = len + 1
                result[len] = val
            end
        else
            len = len + 1
            result[len] = value
        end
    end
    return result
end

local function __TS__ArrayFlatMap(self, callback, thisArg)
    local result = {}
    local len = 0
    for i = 1, #self do
        local value = callback(thisArg, self[i], i - 1, self)
        if __TS__ArrayIsArray(value) then
            for j = 1, #value do
                len = len + 1
                result[len] = value[j]
            end
        else
            len = len + 1
            result[len] = value
        end
    end
    return result
end

local function __TS__ArraySetLength(self, length)
    if length < 0 or length ~= length or length == math.huge or math.floor(length) ~= length then
        error(
            "invalid array length: " .. tostring(length),
            0
        )
    end
    for i = length + 1, #self do
        self[i] = nil
    end
    return length
end

local __TS__Unpack = table.unpack or unpack

local function __TS__ArrayToReversed(self)
    local copy = {__TS__Unpack(self)}
    __TS__ArrayReverse(copy)
    return copy
end

local function __TS__ArrayToSorted(self, compareFn)
    local copy = {__TS__Unpack(self)}
    __TS__ArraySort(copy, compareFn)
    return copy
end

local function __TS__ArrayToSpliced(self, start, deleteCount, ...)
    local copy = {__TS__Unpack(self)}
    __TS__ArraySplice(copy, start, deleteCount, ...)
    return copy
end

local function __TS__ArrayWith(self, index, value)
    local copy = {__TS__Unpack(self)}
    copy[index + 1] = value
    return copy
end

local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end

local function __TS__InstanceOf(obj, classTbl)
    if type(classTbl) ~= "table" then
        error("Right-hand side of 'instanceof' is not an object", 0)
    end
    if classTbl[Symbol.hasInstance] ~= nil then
        return not not classTbl[Symbol.hasInstance](classTbl, obj)
    end
    if type(obj) == "table" then
        local luaClass = obj.constructor
        while luaClass ~= nil do
            if luaClass == classTbl then
                return true
            end
            luaClass = luaClass.____super
        end
    end
    return false
end

local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local __TS__Promise
do
    local function makeDeferredPromiseFactory()
        local resolve
        local reject
        local function executor(____, res, rej)
            resolve = res
            reject = rej
        end
        return function()
            local promise = __TS__New(__TS__Promise, executor)
            return promise, resolve, reject
        end
    end
    local makeDeferredPromise = makeDeferredPromiseFactory()
    local function isPromiseLike(value)
        return __TS__InstanceOf(value, __TS__Promise)
    end
    local function doNothing(self)
    end
    local ____pcall = _G.pcall
    __TS__Promise = __TS__Class()
    __TS__Promise.name = "__TS__Promise"
    function __TS__Promise.prototype.____constructor(self, executor)
        self.state = 0
        self.fulfilledCallbacks = {}
        self.rejectedCallbacks = {}
        local success, ____error = ____pcall(
            executor,
            nil,
            function(____, v) return self:resolve(v) end,
            function(____, err) return self:reject(err) end
        )
        if not success then
            self:reject(____error)
        end
    end
    function __TS__Promise.resolve(value)
        if __TS__InstanceOf(value, __TS__Promise) then
            return value
        end
        local promise = __TS__New(__TS__Promise, doNothing)
        promise.state = 1
        promise.value = value
        return promise
    end
    function __TS__Promise.reject(reason)
        local promise = __TS__New(__TS__Promise, doNothing)
        promise.state = 2
        promise.rejectionReason = reason
        return promise
    end
    __TS__Promise.prototype["then"] = function(self, onFulfilled, onRejected)
        local promise, resolve, reject = makeDeferredPromise()
        self:addCallbacks(
            onFulfilled and self:createPromiseResolvingCallback(onFulfilled, resolve, reject) or resolve,
            onRejected and self:createPromiseResolvingCallback(onRejected, resolve, reject) or reject
        )
        return promise
    end
    function __TS__Promise.prototype.addCallbacks(self, fulfilledCallback, rejectedCallback)
        if self.state == 1 then
            return fulfilledCallback(nil, self.value)
        end
        if self.state == 2 then
            return rejectedCallback(nil, self.rejectionReason)
        end
        local ____self_fulfilledCallbacks_0 = self.fulfilledCallbacks
        ____self_fulfilledCallbacks_0[#____self_fulfilledCallbacks_0 + 1] = fulfilledCallback
        local ____self_rejectedCallbacks_1 = self.rejectedCallbacks
        ____self_rejectedCallbacks_1[#____self_rejectedCallbacks_1 + 1] = rejectedCallback
    end
    function __TS__Promise.prototype.catch(self, onRejected)
        return self["then"](self, nil, onRejected)
    end
    function __TS__Promise.prototype.finally(self, onFinally)
        if type(onFinally) ~= "function" then
            return self["then"](self, onFinally, onFinally)
        end
        return self["then"](
            self,
            function(____, x)
                local ____self_2 = __TS__New(
                    __TS__Promise,
                    function(____, resolve) return resolve(
                        nil,
                        onFinally(nil)
                    ) end
                )
                return ____self_2["then"](
                    ____self_2,
                    function() return x end
                )
            end,
            function(____, e)
                local ____self_3 = __TS__New(
                    __TS__Promise,
                    function(____, resolve) return resolve(
                        nil,
                        onFinally(nil)
                    ) end
                )
                return ____self_3["then"](
                    ____self_3,
                    function()
                        error(e, 0)
                    end
                )
            end
        )
    end
    function __TS__Promise.prototype.resolve(self, value)
        if isPromiseLike(value) then
            return value:addCallbacks(
                function(____, v) return self:resolve(v) end,
                function(____, err) return self:reject(err) end
            )
        end
        if self.state == 0 then
            self.state = 1
            self.value = value
            return self:invokeCallbacks(self.fulfilledCallbacks, value)
        end
    end
    function __TS__Promise.prototype.reject(self, reason)
        if self.state == 0 then
            self.state = 2
            self.rejectionReason = reason
            return self:invokeCallbacks(self.rejectedCallbacks, reason)
        end
    end
    function __TS__Promise.prototype.invokeCallbacks(self, callbacks, value)
        local callbacksLength = #callbacks
        if callbacksLength ~= 0 then
            for i = 1, callbacksLength - 1 do
                callbacks[i](callbacks, value)
            end
            return callbacks[callbacksLength](callbacks, value)
        end
    end
    function __TS__Promise.prototype.createPromiseResolvingCallback(self, f, resolve, reject)
        return function(____, value)
            local success, resultOrError = ____pcall(f, nil, value)
            if not success then
                return reject(nil, resultOrError)
            end
            return self:handleCallbackValue(resultOrError, resolve, reject)
        end
    end
    function __TS__Promise.prototype.handleCallbackValue(self, value, resolve, reject)
        if isPromiseLike(value) then
            local nextpromise = value
            if nextpromise.state == 1 then
                return resolve(nil, nextpromise.value)
            elseif nextpromise.state == 2 then
                return reject(nil, nextpromise.rejectionReason)
            else
                return nextpromise:addCallbacks(resolve, reject)
            end
        else
            return resolve(nil, value)
        end
    end
end

local __TS__AsyncAwaiter, __TS__Await
do
    local ____coroutine = _G.coroutine or ({})
    local cocreate = ____coroutine.create
    local coresume = ____coroutine.resume
    local costatus = ____coroutine.status
    local coyield = ____coroutine.yield
    function __TS__AsyncAwaiter(generator)
        return __TS__New(
            __TS__Promise,
            function(____, resolve, reject)
                local fulfilled, step, resolved, asyncCoroutine
                function fulfilled(self, value)
                    local success, resultOrError = coresume(asyncCoroutine, value)
                    if success then
                        return step(resultOrError)
                    end
                    return reject(nil, resultOrError)
                end
                function step(result)
                    if resolved then
                        return
                    end
                    if costatus(asyncCoroutine) == "dead" then
                        return resolve(nil, result)
                    end
                    return __TS__Promise.resolve(result):addCallbacks(fulfilled, reject)
                end
                resolved = false
                asyncCoroutine = cocreate(generator)
                local success, resultOrError = coresume(
                    asyncCoroutine,
                    function(____, v)
                        resolved = true
                        return __TS__Promise.resolve(v):addCallbacks(resolve, reject)
                    end
                )
                if success then
                    return step(resultOrError)
                else
                    return reject(nil, resultOrError)
                end
            end
        )
    end
    function __TS__Await(thing)
        return coyield(thing)
    end
end

local function __TS__ClassExtends(target, base)
    target.____super = base
    local staticMetatable = setmetatable({__index = base}, base)
    setmetatable(target, staticMetatable)
    local baseMetatable = getmetatable(base)
    if baseMetatable then
        if type(baseMetatable.__index) == "function" then
            staticMetatable.__index = baseMetatable.__index
        end
        if type(baseMetatable.__newindex) == "function" then
            staticMetatable.__newindex = baseMetatable.__newindex
        end
    end
    setmetatable(target.prototype, base.prototype)
    if type(base.prototype.__index) == "function" then
        target.prototype.__index = base.prototype.__index
    end
    if type(base.prototype.__newindex) == "function" then
        target.prototype.__newindex = base.prototype.__newindex
    end
    if type(base.prototype.__tostring) == "function" then
        target.prototype.__tostring = base.prototype.__tostring
    end
end

local function __TS__CloneDescriptor(____bindingPattern0)
    local value
    local writable
    local set
    local get
    local configurable
    local enumerable
    enumerable = ____bindingPattern0.enumerable
    configurable = ____bindingPattern0.configurable
    get = ____bindingPattern0.get
    set = ____bindingPattern0.set
    writable = ____bindingPattern0.writable
    value = ____bindingPattern0.value
    local descriptor = {enumerable = enumerable == true, configurable = configurable == true}
    local hasGetterOrSetter = get ~= nil or set ~= nil
    local hasValueOrWritableAttribute = writable ~= nil or value ~= nil
    if hasGetterOrSetter and hasValueOrWritableAttribute then
        error("Invalid property descriptor. Cannot both specify accessors and a value or writable attribute.", 0)
    end
    if get or set then
        descriptor.get = get
        descriptor.set = set
    else
        descriptor.value = value
        descriptor.writable = writable == true
    end
    return descriptor
end

local function __TS__Decorate(self, originalValue, decorators, context)
    local result = originalValue
    do
        local i = #decorators
        while i >= 0 do
            local decorator = decorators[i + 1]
            if decorator ~= nil then
                local ____decorator_result_0 = decorator(self, result, context)
                if ____decorator_result_0 == nil then
                    ____decorator_result_0 = result
                end
                result = ____decorator_result_0
            end
            i = i - 1
        end
    end
    return result
end

local function __TS__ObjectAssign(target, ...)
    local sources = {...}
    for i = 1, #sources do
        local source = sources[i]
        if type(source) == "table" then
            for key in pairs(source) do
                target[key] = source[key]
            end
        end
    end
    return target
end

local function __TS__ObjectGetOwnPropertyDescriptor(object, key)
    local metatable = getmetatable(object)
    if not metatable then
        return
    end
    if not rawget(metatable, "_descriptors") then
        return
    end
    return rawget(metatable, "_descriptors")[key]
end

local __TS__DescriptorGet
do
    local getmetatable = _G.getmetatable
    local ____rawget = _G.rawget
    function __TS__DescriptorGet(self, metatable, key)
        while metatable do
            local rawResult = ____rawget(metatable, key)
            if rawResult ~= nil then
                return rawResult
            end
            local descriptors = ____rawget(metatable, "_descriptors")
            if descriptors then
                local descriptor = descriptors[key]
                if descriptor ~= nil then
                    if descriptor.get then
                        return descriptor.get(self)
                    end
                    return descriptor.value
                end
            end
            metatable = getmetatable(metatable)
        end
    end
end

local __TS__DescriptorSet
do
    local getmetatable = _G.getmetatable
    local ____rawget = _G.rawget
    local rawset = _G.rawset
    function __TS__DescriptorSet(self, metatable, key, value)
        while metatable do
            local descriptors = ____rawget(metatable, "_descriptors")
            if descriptors then
                local descriptor = descriptors[key]
                if descriptor ~= nil then
                    if descriptor.set then
                        descriptor.set(self, value)
                    else
                        if descriptor.writable == false then
                            error(
                                ((("Cannot assign to read only property '" .. key) .. "' of object '") .. tostring(self)) .. "'",
                                0
                            )
                        end
                        descriptor.value = value
                    end
                    return
                end
            end
            metatable = getmetatable(metatable)
        end
        rawset(self, key, value)
    end
end

local __TS__SetDescriptor
do
    local getmetatable = _G.getmetatable
    local function descriptorIndex(self, key)
        return __TS__DescriptorGet(
            self,
            getmetatable(self),
            key
        )
    end
    local function descriptorNewIndex(self, key, value)
        return __TS__DescriptorSet(
            self,
            getmetatable(self),
            key,
            value
        )
    end
    function __TS__SetDescriptor(target, key, desc, isPrototype)
        if isPrototype == nil then
            isPrototype = false
        end
        local ____isPrototype_0
        if isPrototype then
            ____isPrototype_0 = target
        else
            ____isPrototype_0 = getmetatable(target)
        end
        local metatable = ____isPrototype_0
        if not metatable then
            metatable = {}
            setmetatable(target, metatable)
        end
        if not isPrototype and not rawget(metatable, "_isOwnDescriptorMetatable") then
            local instanceMetatable = {}
            instanceMetatable._isOwnDescriptorMetatable = true
            setmetatable(instanceMetatable, metatable)
            setmetatable(target, instanceMetatable)
            metatable = instanceMetatable
        end
        local value = rawget(target, key)
        if value ~= nil then
            rawset(target, key, nil)
        end
        if not rawget(metatable, "_descriptors") then
            metatable._descriptors = {}
        end
        metatable._descriptors[key] = __TS__CloneDescriptor(desc)
        metatable.__index = descriptorIndex
        metatable.__newindex = descriptorNewIndex
    end
end

local function __TS__DecorateLegacy(decorators, target, key, desc)
    local result = target
    do
        local i = #decorators
        while i >= 0 do
            local decorator = decorators[i + 1]
            if decorator ~= nil then
                local oldResult = result
                if key == nil then
                    result = decorator(nil, result)
                elseif desc == true then
                    local value = rawget(target, key)
                    local descriptor = __TS__ObjectGetOwnPropertyDescriptor(target, key) or ({configurable = true, writable = true, value = value})
                    local desc = decorator(nil, target, key, descriptor) or descriptor
                    local isSimpleValue = desc.configurable == true and desc.writable == true and not desc.get and not desc.set
                    if isSimpleValue then
                        rawset(target, key, desc.value)
                    else
                        __TS__SetDescriptor(
                            target,
                            key,
                            __TS__ObjectAssign({}, descriptor, desc)
                        )
                    end
                elseif desc == false then
                    result = decorator(nil, target, key, desc)
                else
                    result = decorator(nil, target, key)
                end
                result = result or oldResult
            end
            i = i - 1
        end
    end
    return result
end

local function __TS__DecorateParam(paramIndex, decorator)
    return function(____, target, key) return decorator(nil, target, key, paramIndex) end
end

local function __TS__StringIncludes(self, searchString, position)
    if not position then
        position = 1
    else
        position = position + 1
    end
    local index = string.find(self, searchString, position, true)
    return index ~= nil
end

local Error, RangeError, ReferenceError, SyntaxError, TypeError, URIError
do
    local function getErrorStack(self, constructor)
        if debug == nil then
            return nil
        end
        local level = 1
        while true do
            local info = debug.getinfo(level, "f")
            level = level + 1
            if not info then
                level = 1
                break
            elseif info.func == constructor then
                break
            end
        end
        if __TS__StringIncludes(_VERSION, "Lua 5.0") then
            return debug.traceback(("[Level " .. tostring(level)) .. "]")
        elseif _VERSION == "Lua 5.1" then
            return string.sub(
                debug.traceback("", level),
                2
            )
        else
            return debug.traceback(nil, level)
        end
    end
    local function wrapErrorToString(self, getDescription)
        return function(self)
            local description = getDescription(self)
            local caller = debug.getinfo(3, "f")
            local isClassicLua = __TS__StringIncludes(_VERSION, "Lua 5.0")
            if isClassicLua or caller and caller.func ~= error then
                return description
            else
                return (description .. "\n") .. tostring(self.stack)
            end
        end
    end
    local function initErrorClass(self, Type, name)
        Type.name = name
        return setmetatable(
            Type,
            {__call = function(____, _self, message) return __TS__New(Type, message) end}
        )
    end
    local ____initErrorClass_1 = initErrorClass
    local ____class_0 = __TS__Class()
    ____class_0.name = ""
    function ____class_0.prototype.____constructor(self, message)
        if message == nil then
            message = ""
        end
        self.message = message
        self.name = "Error"
        self.stack = getErrorStack(nil, __TS__New)
        local metatable = getmetatable(self)
        if metatable and not metatable.__errorToStringPatched then
            metatable.__errorToStringPatched = true
            metatable.__tostring = wrapErrorToString(nil, metatable.__tostring)
        end
    end
    function ____class_0.prototype.__tostring(self)
        return self.message ~= "" and (self.name .. ": ") .. self.message or self.name
    end
    Error = ____initErrorClass_1(nil, ____class_0, "Error")
    local function createErrorClass(self, name)
        local ____initErrorClass_3 = initErrorClass
        local ____class_2 = __TS__Class()
        ____class_2.name = ____class_2.name
        __TS__ClassExtends(____class_2, Error)
        function ____class_2.prototype.____constructor(self, ...)
            ____class_2.____super.prototype.____constructor(self, ...)
            self.name = name
        end
        return ____initErrorClass_3(nil, ____class_2, name)
    end
    RangeError = createErrorClass(nil, "RangeError")
    ReferenceError = createErrorClass(nil, "ReferenceError")
    SyntaxError = createErrorClass(nil, "SyntaxError")
    TypeError = createErrorClass(nil, "TypeError")
    URIError = createErrorClass(nil, "URIError")
end

local function __TS__ObjectGetOwnPropertyDescriptors(object)
    local metatable = getmetatable(object)
    if not metatable then
        return {}
    end
    return rawget(metatable, "_descriptors") or ({})
end

local function __TS__Delete(target, key)
    local descriptors = __TS__ObjectGetOwnPropertyDescriptors(target)
    local descriptor = descriptors[key]
    if descriptor then
        if not descriptor.configurable then
            error(
                __TS__New(
                    TypeError,
                    ((("Cannot delete property " .. tostring(key)) .. " of ") .. tostring(target)) .. "."
                ),
                0
            )
        end
        descriptors[key] = nil
        return true
    end
    target[key] = nil
    return true
end

local function __TS__StringAccess(self, index)
    if index >= 0 and index < #self then
        return string.sub(self, index + 1, index + 1)
    end
end

local function __TS__DelegatedYield(iterable)
    if type(iterable) == "string" then
        for index = 0, #iterable - 1 do
            coroutine.yield(__TS__StringAccess(iterable, index))
        end
    elseif iterable.____coroutine ~= nil then
        local co = iterable.____coroutine
        while true do
            local status, value = coroutine.resume(co)
            if not status then
                error(value, 0)
            end
            if coroutine.status(co) == "dead" then
                return value
            else
                coroutine.yield(value)
            end
        end
    elseif iterable[Symbol.iterator] then
        local iterator = iterable[Symbol.iterator](iterable)
        while true do
            local result = iterator:next()
            if result.done then
                return result.value
            else
                coroutine.yield(result.value)
            end
        end
    else
        for ____, value in ipairs(iterable) do
            coroutine.yield(value)
        end
    end
end

local function __TS__FunctionBind(fn, ...)
    local boundArgs = {...}
    return function(____, ...)
        local args = {...}
        __TS__ArrayUnshift(
            args,
            __TS__Unpack(boundArgs)
        )
        return fn(__TS__Unpack(args))
    end
end

local __TS__Generator
do
    local function generatorIterator(self)
        return self
    end
    local function generatorNext(self, ...)
        local co = self.____coroutine
        if coroutine.status(co) == "dead" then
            return {done = true}
        end
        local status, value = coroutine.resume(co, ...)
        if not status then
            error(value, 0)
        end
        return {
            value = value,
            done = coroutine.status(co) == "dead"
        }
    end
    function __TS__Generator(fn)
        return function(...)
            local args = {...}
            local argsLength = __TS__CountVarargs(...)
            return {
                ____coroutine = coroutine.create(function() return fn(__TS__Unpack(args, 1, argsLength)) end),
                [Symbol.iterator] = generatorIterator,
                next = generatorNext
            }
        end
    end
end

local function __TS__InstanceOfObject(value)
    local valueType = type(value)
    return valueType == "table" or valueType == "function"
end

local function __TS__LuaIteratorSpread(self, state, firstKey)
    local results = {}
    local key, value = self(state, firstKey)
    while key do
        results[#results + 1] = {key, value}
        key, value = self(state, key)
    end
    return __TS__Unpack(results)
end

local Map
do
    Map = __TS__Class()
    Map.name = "Map"
    function Map.prototype.____constructor(self, entries)
        self[Symbol.toStringTag] = "Map"
        self.items = {}
        self.size = 0
        self.nextKey = {}
        self.previousKey = {}
        if entries == nil then
            return
        end
        local iterable = entries
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                local value = result.value
                self:set(value[1], value[2])
            end
        else
            local array = entries
            for ____, kvp in ipairs(array) do
                self:set(kvp[1], kvp[2])
            end
        end
    end
    function Map.prototype.clear(self)
        self.items = {}
        self.nextKey = {}
        self.previousKey = {}
        self.firstKey = nil
        self.lastKey = nil
        self.size = 0
    end
    function Map.prototype.delete(self, key)
        local contains = self:has(key)
        if contains then
            self.size = self.size - 1
            local next = self.nextKey[key]
            local previous = self.previousKey[key]
            if next ~= nil and previous ~= nil then
                self.nextKey[previous] = next
                self.previousKey[next] = previous
            elseif next ~= nil then
                self.firstKey = next
                self.previousKey[next] = nil
            elseif previous ~= nil then
                self.lastKey = previous
                self.nextKey[previous] = nil
            else
                self.firstKey = nil
                self.lastKey = nil
            end
            self.nextKey[key] = nil
            self.previousKey[key] = nil
        end
        self.items[key] = nil
        return contains
    end
    function Map.prototype.forEach(self, callback)
        for ____, key in __TS__Iterator(self:keys()) do
            callback(nil, self.items[key], key, self)
        end
    end
    function Map.prototype.get(self, key)
        return self.items[key]
    end
    function Map.prototype.has(self, key)
        return self.nextKey[key] ~= nil or self.lastKey == key
    end
    function Map.prototype.set(self, key, value)
        local isNewValue = not self:has(key)
        if isNewValue then
            self.size = self.size + 1
        end
        self.items[key] = value
        if self.firstKey == nil then
            self.firstKey = key
            self.lastKey = key
        elseif isNewValue then
            self.nextKey[self.lastKey] = key
            self.previousKey[key] = self.lastKey
            self.lastKey = key
        end
        return self
    end
    Map.prototype[Symbol.iterator] = function(self)
        return self:entries()
    end
    function Map.prototype.entries(self)
        local function getFirstKey()
            return self.firstKey
        end
        local items = self.items
        local nextKey = self.nextKey
        local key
        local started = false
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                if not started then
                    started = true
                    key = getFirstKey(nil)
                else
                    key = nextKey[key]
                end
                return {done = not key, value = {key, items[key]}}
            end
        }
    end
    function Map.prototype.keys(self)
        local function getFirstKey()
            return self.firstKey
        end
        local nextKey = self.nextKey
        local key
        local started = false
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                if not started then
                    started = true
                    key = getFirstKey(nil)
                else
                    key = nextKey[key]
                end
                return {done = not key, value = key}
            end
        }
    end
    function Map.prototype.values(self)
        local function getFirstKey()
            return self.firstKey
        end
        local items = self.items
        local nextKey = self.nextKey
        local key
        local started = false
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                if not started then
                    started = true
                    key = getFirstKey(nil)
                else
                    key = nextKey[key]
                end
                return {done = not key, value = items[key]}
            end
        }
    end
    Map[Symbol.species] = Map
end

local function __TS__MapGroupBy(items, keySelector)
    local result = __TS__New(Map)
    local i = 0
    for ____, item in __TS__Iterator(items) do
        local key = keySelector(nil, item, i)
        if result:has(key) then
            local ____temp_0 = result:get(key)
            ____temp_0[#____temp_0 + 1] = item
        else
            result:set(key, {item})
        end
        i = i + 1
    end
    return result
end

local __TS__Match = string.match

local __TS__MathAtan2 = math.atan2 or math.atan

local __TS__MathModf = math.modf

local function __TS__NumberIsNaN(value)
    return value ~= value
end

local function __TS__MathSign(val)
    if __TS__NumberIsNaN(val) or val == 0 then
        return val
    end
    if val < 0 then
        return -1
    end
    return 1
end

local function __TS__NumberIsFinite(value)
    return type(value) == "number" and value == value and value ~= math.huge and value ~= -math.huge
end

local function __TS__MathTrunc(val)
    if not __TS__NumberIsFinite(val) or val == 0 then
        return val
    end
    return val > 0 and math.floor(val) or math.ceil(val)
end

local function __TS__Number(value)
    local valueType = type(value)
    if valueType == "number" then
        return value
    elseif valueType == "string" then
        local numberValue = tonumber(value)
        if numberValue then
            return numberValue
        end
        if value == "Infinity" then
            return math.huge
        end
        if value == "-Infinity" then
            return -math.huge
        end
        local stringWithoutSpaces = string.gsub(value, "%s", "")
        if stringWithoutSpaces == "" then
            return 0
        end
        return 0 / 0
    elseif valueType == "boolean" then
        return value and 1 or 0
    else
        return 0 / 0
    end
end

local function __TS__NumberIsInteger(value)
    return __TS__NumberIsFinite(value) and math.floor(value) == value
end

local function __TS__StringSubstring(self, start, ____end)
    if ____end ~= ____end then
        ____end = 0
    end
    if ____end ~= nil and start > ____end then
        start, ____end = ____end, start
    end
    if start >= 0 then
        start = start + 1
    else
        start = 1
    end
    if ____end ~= nil and ____end < 0 then
        ____end = 0
    end
    return string.sub(self, start, ____end)
end

local __TS__ParseInt
do
    local parseIntBasePattern = "0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTvVwWxXyYzZ"
    function __TS__ParseInt(numberString, base)
        if base == nil then
            base = 10
            local hexMatch = __TS__Match(numberString, "^%s*-?0[xX]")
            if hexMatch ~= nil then
                base = 16
                numberString = (__TS__Match(hexMatch, "-")) and "-" .. __TS__StringSubstring(numberString, #hexMatch) or __TS__StringSubstring(numberString, #hexMatch)
            end
        end
        if base < 2 or base > 36 then
            return 0 / 0
        end
        local allowedDigits = base <= 10 and __TS__StringSubstring(parseIntBasePattern, 0, base) or __TS__StringSubstring(parseIntBasePattern, 0, 10 + 2 * (base - 10))
        local pattern = ("^%s*(-?[" .. allowedDigits) .. "]*)"
        local number = tonumber((__TS__Match(numberString, pattern)), base)
        if number == nil then
            return 0 / 0
        end
        if number >= 0 then
            return math.floor(number)
        else
            return math.ceil(number)
        end
    end
end

local function __TS__ParseFloat(numberString)
    local infinityMatch = __TS__Match(numberString, "^%s*(-?Infinity)")
    if infinityMatch ~= nil then
        return __TS__StringAccess(infinityMatch, 0) == "-" and -math.huge or math.huge
    end
    local number = tonumber((__TS__Match(numberString, "^%s*(-?%d+%.?%d*)")))
    return number or 0 / 0
end

local __TS__NumberToString
do
    local radixChars = "0123456789abcdefghijklmnopqrstuvwxyz"
    function __TS__NumberToString(self, radix)
        if radix == nil or radix == 10 or self == math.huge or self == -math.huge or self ~= self then
            return tostring(self)
        end
        radix = math.floor(radix)
        if radix < 2 or radix > 36 then
            error("toString() radix argument must be between 2 and 36", 0)
        end
        local integer, fraction = __TS__MathModf(math.abs(self))
        local result = ""
        if radix == 8 then
            result = string.format("%o", integer)
        elseif radix == 16 then
            result = string.format("%x", integer)
        else
            repeat
                do
                    result = __TS__StringAccess(radixChars, integer % radix) .. result
                    integer = math.floor(integer / radix)
                end
            until not (integer ~= 0)
        end
        if fraction ~= 0 then
            result = result .. "."
            local delta = 1e-16
            repeat
                do
                    fraction = fraction * radix
                    delta = delta * radix
                    local digit = math.floor(fraction)
                    result = result .. __TS__StringAccess(radixChars, digit)
                    fraction = fraction - digit
                end
            until not (fraction >= delta)
        end
        if self < 0 then
            result = "-" .. result
        end
        return result
    end
end

local function __TS__NumberToFixed(self, fractionDigits)
    if math.abs(self) >= 1e+21 or self ~= self then
        return tostring(self)
    end
    local f = math.floor(fractionDigits or 0)
    if f < 0 or f > 99 then
        error("toFixed() digits argument must be between 0 and 99", 0)
    end
    return string.format(
        ("%." .. tostring(f)) .. "f",
        self
    )
end

local function __TS__ObjectDefineProperty(target, key, desc)
    local luaKey = type(key) == "number" and key + 1 or key
    local value = rawget(target, luaKey)
    local hasGetterOrSetter = desc.get ~= nil or desc.set ~= nil
    local descriptor
    if hasGetterOrSetter then
        if value ~= nil then
            error(
                "Cannot redefine property: " .. tostring(key),
                0
            )
        end
        descriptor = desc
    else
        local valueExists = value ~= nil
        local ____desc_set_4 = desc.set
        local ____desc_get_5 = desc.get
        local ____desc_configurable_0 = desc.configurable
        if ____desc_configurable_0 == nil then
            ____desc_configurable_0 = valueExists
        end
        local ____desc_enumerable_1 = desc.enumerable
        if ____desc_enumerable_1 == nil then
            ____desc_enumerable_1 = valueExists
        end
        local ____desc_writable_2 = desc.writable
        if ____desc_writable_2 == nil then
            ____desc_writable_2 = valueExists
        end
        local ____temp_3
        if desc.value ~= nil then
            ____temp_3 = desc.value
        else
            ____temp_3 = value
        end
        descriptor = {
            set = ____desc_set_4,
            get = ____desc_get_5,
            configurable = ____desc_configurable_0,
            enumerable = ____desc_enumerable_1,
            writable = ____desc_writable_2,
            value = ____temp_3
        }
    end
    __TS__SetDescriptor(target, luaKey, descriptor)
    return target
end

local function __TS__ObjectEntries(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = {key, obj[key]}
    end
    return result
end

local function __TS__ObjectFromEntries(entries)
    local obj = {}
    local iterable = entries
    if iterable[Symbol.iterator] then
        local iterator = iterable[Symbol.iterator](iterable)
        while true do
            local result = iterator:next()
            if result.done then
                break
            end
            local value = result.value
            obj[value[1]] = value[2]
        end
    else
        for ____, entry in ipairs(entries) do
            obj[entry[1]] = entry[2]
        end
    end
    return obj
end

local function __TS__ObjectGroupBy(items, keySelector)
    local result = {}
    local i = 0
    for ____, item in __TS__Iterator(items) do
        local key = keySelector(nil, item, i)
        if result[key] ~= nil then
            local ____result_key_0 = result[key]
            ____result_key_0[#____result_key_0 + 1] = item
        else
            result[key] = {item}
        end
        i = i + 1
    end
    return result
end

local function __TS__ObjectKeys(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = key
    end
    return result
end

local function __TS__ObjectRest(target, usedProperties)
    local result = {}
    for property in pairs(target) do
        if not usedProperties[property] then
            result[property] = target[property]
        end
    end
    return result
end

local function __TS__ObjectValues(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = obj[key]
    end
    return result
end

local function __TS__PromiseAll(iterable)
    local results = {}
    local toResolve = {}
    local numToResolve = 0
    local i = 0
    for ____, item in __TS__Iterator(iterable) do
        if __TS__InstanceOf(item, __TS__Promise) then
            if item.state == 1 then
                results[i + 1] = item.value
            elseif item.state == 2 then
                return __TS__Promise.reject(item.rejectionReason)
            else
                numToResolve = numToResolve + 1
                toResolve[i] = item
            end
        else
            results[i + 1] = item
        end
        i = i + 1
    end
    if numToResolve == 0 then
        return __TS__Promise.resolve(results)
    end
    return __TS__New(
        __TS__Promise,
        function(____, resolve, reject)
            for index, promise in pairs(toResolve) do
                promise["then"](
                    promise,
                    function(____, data)
                        results[index + 1] = data
                        numToResolve = numToResolve - 1
                        if numToResolve == 0 then
                            resolve(nil, results)
                        end
                    end,
                    function(____, reason)
                        reject(nil, reason)
                    end
                )
            end
        end
    )
end

local function __TS__PromiseAllSettled(iterable)
    local results = {}
    local toResolve = {}
    local numToResolve = 0
    local i = 0
    for ____, item in __TS__Iterator(iterable) do
        if __TS__InstanceOf(item, __TS__Promise) then
            if item.state == 1 then
                results[i + 1] = {status = "fulfilled", value = item.value}
            elseif item.state == 2 then
                results[i + 1] = {status = "rejected", reason = item.rejectionReason}
            else
                numToResolve = numToResolve + 1
                toResolve[i] = item
            end
        else
            results[i + 1] = {status = "fulfilled", value = item}
        end
        i = i + 1
    end
    if numToResolve == 0 then
        return __TS__Promise.resolve(results)
    end
    return __TS__New(
        __TS__Promise,
        function(____, resolve)
            for index, promise in pairs(toResolve) do
                promise["then"](
                    promise,
                    function(____, data)
                        results[index + 1] = {status = "fulfilled", value = data}
                        numToResolve = numToResolve - 1
                        if numToResolve == 0 then
                            resolve(nil, results)
                        end
                    end,
                    function(____, reason)
                        results[index + 1] = {status = "rejected", reason = reason}
                        numToResolve = numToResolve - 1
                        if numToResolve == 0 then
                            resolve(nil, results)
                        end
                    end
                )
            end
        end
    )
end

local function __TS__PromiseAny(iterable)
    local rejections = {}
    local pending = {}
    for ____, item in __TS__Iterator(iterable) do
        if __TS__InstanceOf(item, __TS__Promise) then
            if item.state == 1 then
                return __TS__Promise.resolve(item.value)
            elseif item.state == 2 then
                rejections[#rejections + 1] = item.rejectionReason
            else
                pending[#pending + 1] = item
            end
        else
            return __TS__Promise.resolve(item)
        end
    end
    if #pending == 0 then
        return __TS__Promise.reject("No promises to resolve with .any()")
    end
    local numResolved = 0
    return __TS__New(
        __TS__Promise,
        function(____, resolve, reject)
            for ____, promise in ipairs(pending) do
                promise["then"](
                    promise,
                    function(____, data)
                        resolve(nil, data)
                    end,
                    function(____, reason)
                        rejections[#rejections + 1] = reason
                        numResolved = numResolved + 1
                        if numResolved == #pending then
                            reject(nil, {name = "AggregateError", message = "All Promises rejected", errors = rejections})
                        end
                    end
                )
            end
        end
    )
end

local function __TS__PromiseRace(iterable)
    local pending = {}
    for ____, item in __TS__Iterator(iterable) do
        if __TS__InstanceOf(item, __TS__Promise) then
            if item.state == 1 then
                return __TS__Promise.resolve(item.value)
            elseif item.state == 2 then
                return __TS__Promise.reject(item.rejectionReason)
            else
                pending[#pending + 1] = item
            end
        else
            return __TS__Promise.resolve(item)
        end
    end
    return __TS__New(
        __TS__Promise,
        function(____, resolve, reject)
            for ____, promise in ipairs(pending) do
                promise["then"](
                    promise,
                    function(____, value) return resolve(nil, value) end,
                    function(____, reason) return reject(nil, reason) end
                )
            end
        end
    )
end

local Set
do
    Set = __TS__Class()
    Set.name = "Set"
    function Set.prototype.____constructor(self, values)
        self[Symbol.toStringTag] = "Set"
        self.size = 0
        self.nextKey = {}
        self.previousKey = {}
        if values == nil then
            return
        end
        local iterable = values
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                self:add(result.value)
            end
        else
            local array = values
            for ____, value in ipairs(array) do
                self:add(value)
            end
        end
    end
    function Set.prototype.add(self, value)
        local isNewValue = not self:has(value)
        if isNewValue then
            self.size = self.size + 1
        end
        if self.firstKey == nil then
            self.firstKey = value
            self.lastKey = value
        elseif isNewValue then
            self.nextKey[self.lastKey] = value
            self.previousKey[value] = self.lastKey
            self.lastKey = value
        end
        return self
    end
    function Set.prototype.clear(self)
        self.nextKey = {}
        self.previousKey = {}
        self.firstKey = nil
        self.lastKey = nil
        self.size = 0
    end
    function Set.prototype.delete(self, value)
        local contains = self:has(value)
        if contains then
            self.size = self.size - 1
            local next = self.nextKey[value]
            local previous = self.previousKey[value]
            if next ~= nil and previous ~= nil then
                self.nextKey[previous] = next
                self.previousKey[next] = previous
            elseif next ~= nil then
                self.firstKey = next
                self.previousKey[next] = nil
            elseif previous ~= nil then
                self.lastKey = previous
                self.nextKey[previous] = nil
            else
                self.firstKey = nil
                self.lastKey = nil
            end
            self.nextKey[value] = nil
            self.previousKey[value] = nil
        end
        return contains
    end
    function Set.prototype.forEach(self, callback)
        for ____, key in __TS__Iterator(self:keys()) do
            callback(nil, key, key, self)
        end
    end
    function Set.prototype.has(self, value)
        return self.nextKey[value] ~= nil or self.lastKey == value
    end
    Set.prototype[Symbol.iterator] = function(self)
        return self:values()
    end
    function Set.prototype.entries(self)
        local function getFirstKey()
            return self.firstKey
        end
        local nextKey = self.nextKey
        local key
        local started = false
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                if not started then
                    started = true
                    key = getFirstKey(nil)
                else
                    key = nextKey[key]
                end
                return {done = not key, value = {key, key}}
            end
        }
    end
    function Set.prototype.keys(self)
        local function getFirstKey()
            return self.firstKey
        end
        local nextKey = self.nextKey
        local key
        local started = false
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                if not started then
                    started = true
                    key = getFirstKey(nil)
                else
                    key = nextKey[key]
                end
                return {done = not key, value = key}
            end
        }
    end
    function Set.prototype.values(self)
        local function getFirstKey()
            return self.firstKey
        end
        local nextKey = self.nextKey
        local key
        local started = false
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                if not started then
                    started = true
                    key = getFirstKey(nil)
                else
                    key = nextKey[key]
                end
                return {done = not key, value = key}
            end
        }
    end
    function Set.prototype.union(self, other)
        local result = __TS__New(Set, self)
        for ____, item in __TS__Iterator(other) do
            result:add(item)
        end
        return result
    end
    function Set.prototype.intersection(self, other)
        local result = __TS__New(Set)
        for ____, item in __TS__Iterator(self) do
            if other:has(item) then
                result:add(item)
            end
        end
        return result
    end
    function Set.prototype.difference(self, other)
        local result = __TS__New(Set, self)
        for ____, item in __TS__Iterator(other) do
            result:delete(item)
        end
        return result
    end
    function Set.prototype.symmetricDifference(self, other)
        local result = __TS__New(Set, self)
        for ____, item in __TS__Iterator(other) do
            if self:has(item) then
                result:delete(item)
            else
                result:add(item)
            end
        end
        return result
    end
    function Set.prototype.isSubsetOf(self, other)
        for ____, item in __TS__Iterator(self) do
            if not other:has(item) then
                return false
            end
        end
        return true
    end
    function Set.prototype.isSupersetOf(self, other)
        for ____, item in __TS__Iterator(other) do
            if not self:has(item) then
                return false
            end
        end
        return true
    end
    function Set.prototype.isDisjointFrom(self, other)
        for ____, item in __TS__Iterator(self) do
            if other:has(item) then
                return false
            end
        end
        return true
    end
    Set[Symbol.species] = Set
end

local function __TS__SparseArrayNew(...)
    local sparseArray = {...}
    sparseArray.sparseLength = __TS__CountVarargs(...)
    return sparseArray
end

local function __TS__SparseArrayPush(sparseArray, ...)
    local args = {...}
    local argsLen = __TS__CountVarargs(...)
    local listLen = sparseArray.sparseLength
    for i = 1, argsLen do
        sparseArray[listLen + i] = args[i]
    end
    sparseArray.sparseLength = listLen + argsLen
end

local function __TS__SparseArraySpread(sparseArray)
    local _unpack = unpack or table.unpack
    return _unpack(sparseArray, 1, sparseArray.sparseLength)
end

local WeakMap
do
    WeakMap = __TS__Class()
    WeakMap.name = "WeakMap"
    function WeakMap.prototype.____constructor(self, entries)
        self[Symbol.toStringTag] = "WeakMap"
        self.items = {}
        setmetatable(self.items, {__mode = "k"})
        if entries == nil then
            return
        end
        local iterable = entries
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                local value = result.value
                self.items[value[1]] = value[2]
            end
        else
            for ____, kvp in ipairs(entries) do
                self.items[kvp[1]] = kvp[2]
            end
        end
    end
    function WeakMap.prototype.delete(self, key)
        local contains = self:has(key)
        self.items[key] = nil
        return contains
    end
    function WeakMap.prototype.get(self, key)
        return self.items[key]
    end
    function WeakMap.prototype.has(self, key)
        return self.items[key] ~= nil
    end
    function WeakMap.prototype.set(self, key, value)
        self.items[key] = value
        return self
    end
    WeakMap[Symbol.species] = WeakMap
end

local WeakSet
do
    WeakSet = __TS__Class()
    WeakSet.name = "WeakSet"
    function WeakSet.prototype.____constructor(self, values)
        self[Symbol.toStringTag] = "WeakSet"
        self.items = {}
        setmetatable(self.items, {__mode = "k"})
        if values == nil then
            return
        end
        local iterable = values
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                self.items[result.value] = true
            end
        else
            for ____, value in ipairs(values) do
                self.items[value] = true
            end
        end
    end
    function WeakSet.prototype.add(self, value)
        self.items[value] = true
        return self
    end
    function WeakSet.prototype.delete(self, value)
        local contains = self:has(value)
        self.items[value] = nil
        return contains
    end
    function WeakSet.prototype.has(self, value)
        return self.items[value] == true
    end
    WeakSet[Symbol.species] = WeakSet
end

local function __TS__SourceMapTraceBack(fileName, sourceMap)
    _G.__TS__sourcemap = _G.__TS__sourcemap or ({})
    _G.__TS__sourcemap[fileName] = sourceMap
    if _G.__TS__originalTraceback == nil then
        local originalTraceback = debug.traceback
        _G.__TS__originalTraceback = originalTraceback
        debug.traceback = function(thread, message, level)
            local trace
            if thread == nil and message == nil and level == nil then
                trace = originalTraceback()
            elseif __TS__StringIncludes(_VERSION, "Lua 5.0") then
                trace = originalTraceback((("[Level " .. tostring(level)) .. "] ") .. tostring(message))
            else
                trace = originalTraceback(thread, message, level)
            end
            if type(trace) ~= "string" then
                return trace
            end
            local function replacer(____, file, srcFile, line)
                local fileSourceMap = _G.__TS__sourcemap[file]
                if fileSourceMap ~= nil and fileSourceMap[line] ~= nil then
                    local data = fileSourceMap[line]
                    if type(data) == "number" then
                        return (srcFile .. ":") .. tostring(data)
                    end
                    return (data.file .. ":") .. tostring(data.line)
                end
                return (file .. ":") .. line
            end
            local result = string.gsub(
                trace,
                "([^%s<]+)%.lua:(%d+)",
                function(file, line) return replacer(nil, file .. ".lua", file .. ".ts", line) end
            )
            local function stringReplacer(____, file, line)
                local fileSourceMap = _G.__TS__sourcemap[file]
                if fileSourceMap ~= nil and fileSourceMap[line] ~= nil then
                    local chunkName = (__TS__Match(file, "%[string \"([^\"]+)\"%]"))
                    local sourceName = string.gsub(chunkName, ".lua$", ".ts")
                    local data = fileSourceMap[line]
                    if type(data) == "number" then
                        return (sourceName .. ":") .. tostring(data)
                    end
                    return (data.file .. ":") .. tostring(data.line)
                end
                return (file .. ":") .. line
            end
            result = string.gsub(
                result,
                "(%[string \"[^\"]+\"%]):(%d+)",
                function(file, line) return stringReplacer(nil, file, line) end
            )
            return result
        end
    end
end

local function __TS__Spread(iterable)
    local arr = {}
    if type(iterable) == "string" then
        for i = 0, #iterable - 1 do
            arr[i + 1] = __TS__StringAccess(iterable, i)
        end
    else
        local len = 0
        for ____, item in __TS__Iterator(iterable) do
            len = len + 1
            arr[len] = item
        end
    end
    return __TS__Unpack(arr)
end

local function __TS__StringCharAt(self, pos)
    if pos ~= pos then
        pos = 0
    end
    if pos < 0 then
        return ""
    end
    return string.sub(self, pos + 1, pos + 1)
end

local function __TS__StringCharCodeAt(self, index)
    if index ~= index then
        index = 0
    end
    if index < 0 then
        return 0 / 0
    end
    return string.byte(self, index + 1) or 0 / 0
end

local function __TS__StringEndsWith(self, searchString, endPosition)
    if endPosition == nil or endPosition > #self then
        endPosition = #self
    end
    return string.sub(self, endPosition - #searchString + 1, endPosition) == searchString
end

local function __TS__StringPadEnd(self, maxLength, fillString)
    if fillString == nil then
        fillString = " "
    end
    if maxLength ~= maxLength then
        maxLength = 0
    end
    if maxLength == -math.huge or maxLength == math.huge then
        error("Invalid string length", 0)
    end
    if #self >= maxLength or #fillString == 0 then
        return self
    end
    maxLength = maxLength - #self
    if maxLength > #fillString then
        fillString = fillString .. string.rep(
            fillString,
            math.floor(maxLength / #fillString)
        )
    end
    return self .. string.sub(
        fillString,
        1,
        math.floor(maxLength)
    )
end

local function __TS__StringPadStart(self, maxLength, fillString)
    if fillString == nil then
        fillString = " "
    end
    if maxLength ~= maxLength then
        maxLength = 0
    end
    if maxLength == -math.huge or maxLength == math.huge then
        error("Invalid string length", 0)
    end
    if #self >= maxLength or #fillString == 0 then
        return self
    end
    maxLength = maxLength - #self
    if maxLength > #fillString then
        fillString = fillString .. string.rep(
            fillString,
            math.floor(maxLength / #fillString)
        )
    end
    return string.sub(
        fillString,
        1,
        math.floor(maxLength)
    ) .. self
end

local __TS__StringReplace
do
    local sub = string.sub
    function __TS__StringReplace(source, searchValue, replaceValue)
        local startPos, endPos = string.find(source, searchValue, nil, true)
        if not startPos then
            return source
        end
        local before = sub(source, 1, startPos - 1)
        local replacement = type(replaceValue) == "string" and replaceValue or replaceValue(nil, searchValue, startPos - 1, source)
        local after = sub(source, endPos + 1)
        return (before .. replacement) .. after
    end
end

local __TS__StringSplit
do
    local sub = string.sub
    local find = string.find
    function __TS__StringSplit(source, separator, limit)
        if limit == nil then
            limit = 4294967295
        end
        if limit == 0 then
            return {}
        end
        local result = {}
        local resultIndex = 1
        if separator == nil or separator == "" then
            for i = 1, #source do
                result[resultIndex] = sub(source, i, i)
                resultIndex = resultIndex + 1
            end
        else
            local currentPos = 1
            while resultIndex <= limit do
                local startPos, endPos = find(source, separator, currentPos, true)
                if not startPos then
                    break
                end
                result[resultIndex] = sub(source, currentPos, startPos - 1)
                resultIndex = resultIndex + 1
                currentPos = endPos + 1
            end
            if resultIndex <= limit then
                result[resultIndex] = sub(source, currentPos)
            end
        end
        return result
    end
end

local __TS__StringReplaceAll
do
    local sub = string.sub
    local find = string.find
    function __TS__StringReplaceAll(source, searchValue, replaceValue)
        if type(replaceValue) == "string" then
            local concat = table.concat(
                __TS__StringSplit(source, searchValue),
                replaceValue
            )
            if #searchValue == 0 then
                return (replaceValue .. concat) .. replaceValue
            end
            return concat
        end
        local parts = {}
        local partsIndex = 1
        if #searchValue == 0 then
            parts[1] = replaceValue(nil, "", 0, source)
            partsIndex = 2
            for i = 1, #source do
                parts[partsIndex] = sub(source, i, i)
                parts[partsIndex + 1] = replaceValue(nil, "", i, source)
                partsIndex = partsIndex + 2
            end
        else
            local currentPos = 1
            while true do
                local startPos, endPos = find(source, searchValue, currentPos, true)
                if not startPos then
                    break
                end
                parts[partsIndex] = sub(source, currentPos, startPos - 1)
                parts[partsIndex + 1] = replaceValue(nil, searchValue, startPos - 1, source)
                partsIndex = partsIndex + 2
                currentPos = endPos + 1
            end
            parts[partsIndex] = sub(source, currentPos)
        end
        return table.concat(parts)
    end
end

local function __TS__StringSlice(self, start, ____end)
    if start == nil or start ~= start then
        start = 0
    end
    if ____end ~= ____end then
        ____end = 0
    end
    if start >= 0 then
        start = start + 1
    end
    if ____end ~= nil and ____end < 0 then
        ____end = ____end - 1
    end
    return string.sub(self, start, ____end)
end

local function __TS__StringStartsWith(self, searchString, position)
    if position == nil or position < 0 then
        position = 0
    end
    return string.sub(self, position + 1, #searchString + position) == searchString
end

local function __TS__StringSubstr(self, from, length)
    if from ~= from then
        from = 0
    end
    if length ~= nil then
        if length ~= length or length <= 0 then
            return ""
        end
        length = length + from
    end
    if from >= 0 then
        from = from + 1
    end
    return string.sub(self, from, length)
end

local function __TS__StringTrim(self)
    local result = string.gsub(self, "^[%s ﻿]*(.-)[%s ﻿]*$", "%1")
    return result
end

local function __TS__StringTrimEnd(self)
    local result = string.gsub(self, "[%s ﻿]*$", "")
    return result
end

local function __TS__StringTrimStart(self)
    local result = string.gsub(self, "^[%s ﻿]*", "")
    return result
end

local __TS__SymbolRegistryFor, __TS__SymbolRegistryKeyFor
do
    local symbolRegistry = {}
    function __TS__SymbolRegistryFor(key)
        if not symbolRegistry[key] then
            symbolRegistry[key] = __TS__Symbol(key)
        end
        return symbolRegistry[key]
    end
    function __TS__SymbolRegistryKeyFor(sym)
        for key in pairs(symbolRegistry) do
            if symbolRegistry[key] == sym then
                return key
            end
        end
        return nil
    end
end

local function __TS__TypeOf(value)
    local luaType = type(value)
    if luaType == "table" then
        return "object"
    elseif luaType == "nil" then
        return "undefined"
    else
        return luaType
    end
end

local function __TS__Using(self, cb, ...)
    local args = {...}
    local thrownError
    local ok, result = xpcall(
        function() return cb(__TS__Unpack(args)) end,
        function(err)
            thrownError = err
            return thrownError
        end
    )
    local argArray = {__TS__Unpack(args)}
    do
        local i = #argArray - 1
        while i >= 0 do
            local ____self_0 = argArray[i + 1]
            ____self_0[Symbol.dispose](____self_0)
            i = i - 1
        end
    end
    if not ok then
        error(thrownError, 0)
    end
    return result
end

local function __TS__UsingAsync(self, cb, ...)
    local args = {...}
    return __TS__AsyncAwaiter(function(____awaiter_resolve)
        local thrownError
        local ok, result = xpcall(
            function() return cb(
                nil,
                __TS__Unpack(args)
            ) end,
            function(err)
                thrownError = err
                return thrownError
            end
        )
        local argArray = {__TS__Unpack(args)}
        do
            local i = #argArray - 1
            while i >= 0 do
                if argArray[i + 1][Symbol.dispose] ~= nil then
                    local ____self_0 = argArray[i + 1]
                    ____self_0[Symbol.dispose](____self_0)
                end
                if argArray[i + 1][Symbol.asyncDispose] ~= nil then
                    local ____self_1 = argArray[i + 1]
                    __TS__Await(____self_1[Symbol.asyncDispose](____self_1))
                end
                i = i - 1
            end
        end
        if not ok then
            error(thrownError, 0)
        end
        return ____awaiter_resolve(nil, result)
    end)
end

return {
  __TS__ArrayAt = __TS__ArrayAt,
  __TS__ArrayConcat = __TS__ArrayConcat,
  __TS__ArrayEntries = __TS__ArrayEntries,
  __TS__ArrayEvery = __TS__ArrayEvery,
  __TS__ArrayFill = __TS__ArrayFill,
  __TS__ArrayFilter = __TS__ArrayFilter,
  __TS__ArrayForEach = __TS__ArrayForEach,
  __TS__ArrayFind = __TS__ArrayFind,
  __TS__ArrayFindIndex = __TS__ArrayFindIndex,
  __TS__ArrayFrom = __TS__ArrayFrom,
  __TS__ArrayIncludes = __TS__ArrayIncludes,
  __TS__ArrayIndexOf = __TS__ArrayIndexOf,
  __TS__ArrayIsArray = __TS__ArrayIsArray,
  __TS__ArrayJoin = __TS__ArrayJoin,
  __TS__ArrayMap = __TS__ArrayMap,
  __TS__ArrayPush = __TS__ArrayPush,
  __TS__ArrayPushArray = __TS__ArrayPushArray,
  __TS__ArrayReduce = __TS__ArrayReduce,
  __TS__ArrayReduceRight = __TS__ArrayReduceRight,
  __TS__ArrayReverse = __TS__ArrayReverse,
  __TS__ArrayUnshift = __TS__ArrayUnshift,
  __TS__ArraySort = __TS__ArraySort,
  __TS__ArraySlice = __TS__ArraySlice,
  __TS__ArraySome = __TS__ArraySome,
  __TS__ArraySplice = __TS__ArraySplice,
  __TS__ArrayToObject = __TS__ArrayToObject,
  __TS__ArrayFlat = __TS__ArrayFlat,
  __TS__ArrayFlatMap = __TS__ArrayFlatMap,
  __TS__ArraySetLength = __TS__ArraySetLength,
  __TS__ArrayToReversed = __TS__ArrayToReversed,
  __TS__ArrayToSorted = __TS__ArrayToSorted,
  __TS__ArrayToSpliced = __TS__ArrayToSpliced,
  __TS__ArrayWith = __TS__ArrayWith,
  __TS__AsyncAwaiter = __TS__AsyncAwaiter,
  __TS__Await = __TS__Await,
  __TS__Class = __TS__Class,
  __TS__ClassExtends = __TS__ClassExtends,
  __TS__CloneDescriptor = __TS__CloneDescriptor,
  __TS__CountVarargs = __TS__CountVarargs,
  __TS__Decorate = __TS__Decorate,
  __TS__DecorateLegacy = __TS__DecorateLegacy,
  __TS__DecorateParam = __TS__DecorateParam,
  __TS__Delete = __TS__Delete,
  __TS__DelegatedYield = __TS__DelegatedYield,
  __TS__DescriptorGet = __TS__DescriptorGet,
  __TS__DescriptorSet = __TS__DescriptorSet,
  Error = Error,
  RangeError = RangeError,
  ReferenceError = ReferenceError,
  SyntaxError = SyntaxError,
  TypeError = TypeError,
  URIError = URIError,
  __TS__FunctionBind = __TS__FunctionBind,
  __TS__Generator = __TS__Generator,
  __TS__InstanceOf = __TS__InstanceOf,
  __TS__InstanceOfObject = __TS__InstanceOfObject,
  __TS__Iterator = __TS__Iterator,
  __TS__LuaIteratorSpread = __TS__LuaIteratorSpread,
  Map = Map,
  __TS__MapGroupBy = __TS__MapGroupBy,
  __TS__Match = __TS__Match,
  __TS__MathAtan2 = __TS__MathAtan2,
  __TS__MathModf = __TS__MathModf,
  __TS__MathSign = __TS__MathSign,
  __TS__MathTrunc = __TS__MathTrunc,
  __TS__New = __TS__New,
  __TS__Number = __TS__Number,
  __TS__NumberIsFinite = __TS__NumberIsFinite,
  __TS__NumberIsInteger = __TS__NumberIsInteger,
  __TS__NumberIsNaN = __TS__NumberIsNaN,
  __TS__ParseInt = __TS__ParseInt,
  __TS__ParseFloat = __TS__ParseFloat,
  __TS__NumberToString = __TS__NumberToString,
  __TS__NumberToFixed = __TS__NumberToFixed,
  __TS__ObjectAssign = __TS__ObjectAssign,
  __TS__ObjectDefineProperty = __TS__ObjectDefineProperty,
  __TS__ObjectEntries = __TS__ObjectEntries,
  __TS__ObjectFromEntries = __TS__ObjectFromEntries,
  __TS__ObjectGetOwnPropertyDescriptor = __TS__ObjectGetOwnPropertyDescriptor,
  __TS__ObjectGetOwnPropertyDescriptors = __TS__ObjectGetOwnPropertyDescriptors,
  __TS__ObjectGroupBy = __TS__ObjectGroupBy,
  __TS__ObjectKeys = __TS__ObjectKeys,
  __TS__ObjectRest = __TS__ObjectRest,
  __TS__ObjectValues = __TS__ObjectValues,
  __TS__ParseFloat = __TS__ParseFloat,
  __TS__ParseInt = __TS__ParseInt,
  __TS__Promise = __TS__Promise,
  __TS__PromiseAll = __TS__PromiseAll,
  __TS__PromiseAllSettled = __TS__PromiseAllSettled,
  __TS__PromiseAny = __TS__PromiseAny,
  __TS__PromiseRace = __TS__PromiseRace,
  Set = Set,
  __TS__SetDescriptor = __TS__SetDescriptor,
  __TS__SparseArrayNew = __TS__SparseArrayNew,
  __TS__SparseArrayPush = __TS__SparseArrayPush,
  __TS__SparseArraySpread = __TS__SparseArraySpread,
  WeakMap = WeakMap,
  WeakSet = WeakSet,
  __TS__SourceMapTraceBack = __TS__SourceMapTraceBack,
  __TS__Spread = __TS__Spread,
  __TS__StringAccess = __TS__StringAccess,
  __TS__StringCharAt = __TS__StringCharAt,
  __TS__StringCharCodeAt = __TS__StringCharCodeAt,
  __TS__StringEndsWith = __TS__StringEndsWith,
  __TS__StringIncludes = __TS__StringIncludes,
  __TS__StringPadEnd = __TS__StringPadEnd,
  __TS__StringPadStart = __TS__StringPadStart,
  __TS__StringReplace = __TS__StringReplace,
  __TS__StringReplaceAll = __TS__StringReplaceAll,
  __TS__StringSlice = __TS__StringSlice,
  __TS__StringSplit = __TS__StringSplit,
  __TS__StringStartsWith = __TS__StringStartsWith,
  __TS__StringSubstr = __TS__StringSubstr,
  __TS__StringSubstring = __TS__StringSubstring,
  __TS__StringTrim = __TS__StringTrim,
  __TS__StringTrimEnd = __TS__StringTrimEnd,
  __TS__StringTrimStart = __TS__StringTrimStart,
  __TS__Symbol = __TS__Symbol,
  Symbol = Symbol,
  __TS__SymbolRegistryFor = __TS__SymbolRegistryFor,
  __TS__SymbolRegistryKeyFor = __TS__SymbolRegistryKeyFor,
  __TS__TypeOf = __TS__TypeOf,
  __TS__Unpack = __TS__Unpack,
  __TS__Using = __TS__Using,
  __TS__UsingAsync = __TS__UsingAsync
}
 end,
["src.lua.bridge.lstd"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____lstd = require("src.lua.declaration.lstd")
local LUA__log = ____lstd.LUA__log
local LUA__SLEEP = ____lstd.LUA__SLEEP
____exports.lstd = __TS__Class()
local lstd = ____exports.lstd
lstd.name = "lstd"
function lstd.prototype.____constructor(self)
end
function lstd.Log(self, message)
    LUA__log(nil, message)
end
function lstd.Sleep(self, time)
    LUA__SLEEP(nil, time)
end
return ____exports
 end,
["src.lua.declaration.lstd"] = function(...) 
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

return std; end,
["src.classes.Failure"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
____exports.FailureMode = ____exports.FailureMode or ({})
____exports.FailureMode.UNDEF = 0
____exports.FailureMode[____exports.FailureMode.UNDEF] = "UNDEF"
____exports.FailureMode.MISSUSE = 1
____exports.FailureMode[____exports.FailureMode.MISSUSE] = "MISSUSE"
____exports.FailureMode.THRUSTER_RELAY_DOESNT_EXIST = 2
____exports.FailureMode[____exports.FailureMode.THRUSTER_RELAY_DOESNT_EXIST] = "THRUSTER_RELAY_DOESNT_EXIST"
____exports.FailureMode.THRUSTER_POST_FAILURE = 3
____exports.FailureMode[____exports.FailureMode.THRUSTER_POST_FAILURE] = "THRUSTER_POST_FAILURE"
____exports.FailureMode.UPDATE_BEFORE_POST = 4
____exports.FailureMode[____exports.FailureMode.UPDATE_BEFORE_POST] = "UPDATE_BEFORE_POST"
____exports.FailureMode.NOT_YET_IMPLEMENTED = 5
____exports.FailureMode[____exports.FailureMode.NOT_YET_IMPLEMENTED] = "NOT_YET_IMPLEMENTED"
____exports.FailureMode.RCS_ZERO_VECTOR = 6
____exports.FailureMode[____exports.FailureMode.RCS_ZERO_VECTOR] = "RCS_ZERO_VECTOR"
____exports.Failure = __TS__Class()
local Failure = ____exports.Failure
Failure.name = "Failure"
__TS__ClassExtends(Failure, Error)
function Failure.prototype.____constructor(self, message, failureMode)
    Error.prototype.____constructor(
        self,
        (message .. " FAILURE MODE ") .. tostring(failureMode)
    )
    self.Mode = ____exports.FailureMode.UNDEF
    self.Mode = failureMode
end
return ____exports
 end,
["src.classes.Math.Mathc"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
____exports.Mathc = __TS__Class()
local Mathc = ____exports.Mathc
Mathc.name = "Mathc"
function Mathc.prototype.____constructor(self)
end
function Mathc.Clamp(self, value, min, max)
    if value < min then
        return min
    end
    if value > max then
        return max
    end
    return value
end
function Mathc.Sign(self, value)
    if value < 0 then
        return -1
    else
        return 1
    end
end
return ____exports
 end,
["src.classes.Math.Vector3"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__MathSign = ____lualib.__TS__MathSign
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____Mathc = require("src.classes.Math.Mathc")
local Mathc = ____Mathc.Mathc
____exports.Vector3 = __TS__Class()
local Vector3 = ____exports.Vector3
Vector3.name = "Vector3"
function Vector3.prototype.____constructor(self, conX, conY, conZ)
    self.x = -1
    self.y = -1
    self.z = -1
    self.x = conX
    self.y = conY
    self.z = conZ
end
function Vector3.Zero(self)
    local vector = __TS__New(____exports.Vector3, 0, 0, 0)
    return vector
end
function Vector3.prototype.Sign(self)
    local x = __TS__MathSign(self.x)
    local y = __TS__MathSign(self.y)
    local z = __TS__MathSign(self.z)
    return __TS__New(____exports.Vector3, x, y, z)
end
function Vector3.prototype.Clamp(self, min, max)
    local x = Mathc:Clamp(self.x, min, max)
    local y = Mathc:Clamp(self.y, min, max)
    local z = Mathc:Clamp(self.z, min, max)
    return __TS__New(____exports.Vector3, x, y, z)
end
function Vector3.prototype.Dot(self, otherVector)
    local xComp = self.x * otherVector.x
    local yComp = self.y * otherVector.y
    local zComp = self.z * otherVector.z
    local final = xComp + yComp + zComp
    return final
end
function Vector3.prototype.Cross(self, otherVector)
    local finalVector = __TS__New(____exports.Vector3, self.y * otherVector.z - self.z * otherVector.y, self.z * otherVector.x - self.x * otherVector.z, self.x * otherVector.y - self.y * otherVector.x)
    return finalVector
end
function Vector3.prototype.IsEqualTo(self, otherVector)
    if self.x == otherVector.x and self.y == otherVector.y and self.z == otherVector.z then
        return true
    end
    return false
end
function Vector3.prototype.Magnitude(self)
    local final = math.sqrt(self.x ^ 2 + self.y ^ 2 + self.z ^ 2)
    return final
end
function Vector3.prototype.Normalized(self)
    local magnitude = self:Magnitude()
    if magnitude == 0 then
        error(
            __TS__New(Error, "Cannot normalize a zero vector"),
            0
        )
    end
    local normalized = __TS__New(____exports.Vector3, self.x / magnitude, self.y / magnitude, self.z / magnitude)
    return normalized
end
function Vector3.prototype.Add(self, otherVector)
    local product = __TS__New(____exports.Vector3, self.x + otherVector.x, self.y + otherVector.y, self.z + otherVector.z)
    return product
end
function Vector3.prototype.Subtract(self, otherVector)
    local difference = __TS__New(____exports.Vector3, self.x - otherVector.x, self.y - otherVector.y, self.z - otherVector.z)
    return difference
end
function Vector3.prototype.ComponentMultiply(self, otherVector)
    local product = __TS__New(____exports.Vector3, self.x * otherVector.x, self.y * otherVector.y, self.z * otherVector.z)
    return product
end
function Vector3.prototype.Multiply(self, number)
    local product = __TS__New(____exports.Vector3, self.x * number, self.y * number, self.z * number)
    return product
end
function Vector3.prototype.Divide(self, scalar)
    if scalar == 0 then
        error(
            __TS__New(Error, "[VECTOR] Attempt to divide by 0!"),
            0
        )
    end
    return __TS__New(____exports.Vector3, self.x / scalar, self.y / scalar, self.z / scalar)
end
function Vector3.prototype.Inverse(self)
    local inverted = self:Multiply(-1)
    return inverted
end
return ____exports
 end,
["thirdparty.tswrappers.pidcontroller"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____Vector3 = require("src.classes.Math.Vector3")
local Vector3 = ____Vector3.Vector3
____exports.PIDControllerVector = __TS__Class()
local PIDControllerVector = ____exports.PIDControllerVector
PIDControllerVector.name = "PIDControllerVector"
function PIDControllerVector.prototype.____constructor(self, P, I, D, Min, Max)
    self.Error = __TS__New(Vector3, 0, 0, 0)
    self.Derivative = __TS__New(Vector3, 0, 0, 0)
    self.Integral = __TS__New(Vector3, 0, 0, 0)
    self.ContinueIntegralWinding = __TS__New(Vector3, 1, 1, 1)
    self.IsSameSign = __TS__New(Vector3, 0, 0, 0)
    self.P = P
    self.I = I
    self.D = D
    self.Min = Min
    self.Max = Max
end
function PIDControllerVector.prototype.Run(self, errorVector)
    self.Derivative = errorVector:Subtract(self.Error):Divide(0.05)
    local errorSign = errorVector:Sign()
    local errorContinued = __TS__New(Vector3, errorVector.x * self.ContinueIntegralWinding.x, errorVector.y * self.ContinueIntegralWinding.y, errorVector.z * self.ContinueIntegralWinding.z)
    self.Integral = self.Integral:Add(errorContinued:Multiply(0.05))
    local output = errorVector:Multiply(self.P)
    output = output:Add(self.Derivative:Multiply(self.D))
    output = output:Add(self.Integral:Multiply(self.I))
    local outputSign = output:Sign()
    local outputClamped = output:Clamp(self.Min, self.Max)
    local thrusterSaturation = __TS__New(Vector3, 0, 0, 0)
    if outputClamped.x == output.x then
        thrusterSaturation.x = 0
    else
        thrusterSaturation.x = 1
    end
    if outputClamped.y == output.y then
        thrusterSaturation.y = 0
    else
        thrusterSaturation.y = 1
    end
    if outputClamped.z == output.z then
        thrusterSaturation.z = 0
    else
        thrusterSaturation.z = 1
    end
    if errorSign.x == outputSign.x then
        self.IsSameSign.x = 1
    else
        self.IsSameSign.x = 0
    end
    if errorSign.y == outputSign.y then
        self.IsSameSign.y = 1
    else
        self.IsSameSign.y = 0
    end
    if errorSign.z == outputSign.z then
        self.IsSameSign.z = 1
    else
        self.IsSameSign.z = 0
    end
    self.ContinueIntegralWinding.x = 1 - thrusterSaturation.x * self.IsSameSign.x
    self.ContinueIntegralWinding.y = 1 - thrusterSaturation.y * self.IsSameSign.y
    self.ContinueIntegralWinding.z = 1 - thrusterSaturation.z * self.IsSameSign.z
    self.Error = errorVector
    return outputClamped
end
return ____exports
 end,
["src.classes.Math.Quaternion"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____Vector3 = require("src.classes.Math.Vector3")
local Vector3 = ____Vector3.Vector3
____exports.Quaternion = __TS__Class()
local Quaternion = ____exports.Quaternion
Quaternion.name = "Quaternion"
function Quaternion.prototype.____constructor(self, wPassthrough, xPassthrough, yPassthrough, zPassthrough)
    self.x = 0
    self.y = 0
    self.z = 0
    self.w = 0
    self.x = xPassthrough
    self.y = yPassthrough
    self.z = zPassthrough
    self.w = wPassthrough
end
function Quaternion.fromAxisAngles(self, axis, angle)
    local mag = axis:Magnitude()
    if mag < 1e-8 then
        local quat = __TS__New(
            ____exports.Quaternion,
            1,
            0,
            0,
            0
        )
        return quat
    end
    local normalized = axis:Normalized()
    local halfAngle = angle * 0.5
    local sinAngle = math.sin(halfAngle)
    local cosAngle = math.cos(halfAngle)
    local finalQuat = __TS__New(
        ____exports.Quaternion,
        cosAngle,
        normalized.x * sinAngle,
        normalized.y * sinAngle,
        normalized.z * sinAngle
    )
    return finalQuat
end
function Quaternion.prototype.ToAxisAngles(self)
    local angle = 2 * math.acos(self.w)
    local devisor = math.sqrt(1 - self.w * self.w)
    if devisor < ____exports.Quaternion.ANGLE_EPSILON then
        return {
            axis = __TS__New(Vector3, 0, 1, 0),
            angle = angle
        }
    end
    local axis = __TS__New(Vector3, self.x / devisor, self.y / devisor, self.z / devisor)
    local axisAngles = {axis = axis, angle = angle}
    return axisAngles
end
function Quaternion.prototype.Inverse(self)
    local squaredNorm = self.x ^ 2 + self.y ^ 2 + self.z ^ 2 + self.w ^ 2
    local inverted = __TS__New(
        ____exports.Quaternion,
        self.w / squaredNorm,
        -self.x / squaredNorm,
        -self.y / squaredNorm,
        -self.z / squaredNorm
    )
    return inverted
end
function Quaternion.prototype.MultiplyByVector(self, vector)
    local tx = 2 * (self.y * vector.z - self.z * vector.y)
    local ty = 2 * (self.z * vector.x - self.x * vector.z)
    local tz = 2 * (self.x * vector.y - self.y * vector.x)
    local vx = vector.x + self.w * tx
    local vy = vector.y + self.w * ty
    local vz = vector.z + self.w * tz
    local endVector = __TS__New(Vector3, vx + (self.y * tz - self.z * ty), vy + (self.z * tx - self.x * tz), vz + (self.x * ty - self.y * tx))
    return endVector
end
function Quaternion.prototype.MultiplyByQuaternion(self, other)
    local x = self.w * other.x + self.x * other.w + self.y * other.z - self.z * other.y
    local y = self.w * other.y - self.x * other.z + self.y * other.w + self.z * other.x
    local z = self.w * other.z + self.x * other.y - self.y * other.x + self.z * other.w
    local w = self.w * other.w - self.x * other.x - self.y * other.y - self.z * other.z
    local endQuaternion = __TS__New(
        ____exports.Quaternion,
        w,
        x,
        y,
        z
    )
    return endQuaternion
end
function Quaternion.prototype.ConvertVectorToWorldSpace(self, vector)
    local quatedVector = __TS__New(
        ____exports.Quaternion,
        0,
        vector.x,
        vector.y,
        vector.z
    )
    local intermediate = self:MultiplyByQuaternion(quatedVector)
    local finalQuat = intermediate:MultiplyByQuaternion(self:Inverse())
    local final = __TS__New(Vector3, finalQuat.x, finalQuat.y, finalQuat.z)
    return final
end
function Quaternion.prototype.ConvertVectorToLocalSpace(self, vector)
    local quatedVector = __TS__New(
        ____exports.Quaternion,
        0,
        vector.x,
        vector.y,
        vector.z
    )
    local intermediate = self:Inverse():MultiplyByQuaternion(quatedVector)
    local finalQuat = intermediate:MultiplyByQuaternion(self)
    local final = __TS__New(Vector3, finalQuat.x, finalQuat.y, finalQuat.z)
    return final
end
Quaternion.ANGLE_EPSILON = 1e-8
return ____exports
 end,
["src.lua.bridge.shipBridge"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____Failure = require("src.classes.Failure")
local Failure = ____Failure.Failure
local FailureMode = ____Failure.FailureMode
local ____Quaternion = require("src.classes.Math.Quaternion")
local Quaternion = ____Quaternion.Quaternion
local ____Vector3 = require("src.classes.Math.Vector3")
local Vector3 = ____Vector3.Vector3
local ____shipBridge = require("src.lua.declaration.shipBridge")
local SHIPBRIDGE__DOESRELAYEXIST = ____shipBridge.SHIPBRIDGE__DOESRELAYEXIST
local SHIPBRIDGE__GETANGULARVELOCITY = ____shipBridge.SHIPBRIDGE__GETANGULARVELOCITY
local SHIPBRIDGE__GETRELAYOUTPUT = ____shipBridge.SHIPBRIDGE__GETRELAYOUTPUT
local SHIPBRIDGE__POSITION = ____shipBridge.SHIPBRIDGE__POSITION
local SHIPBRIDGE__QUATERNION = ____shipBridge.SHIPBRIDGE__QUATERNION
local SHIPBRIDGE__SETRELAYOUTPUT = ____shipBridge.SHIPBRIDGE__SETRELAYOUTPUT
local SHIPBRIDGE__GETVELOCITY = ____shipBridge.SHIPBRIDGE__GETVELOCITY
local ____lstd = require("src.lua.bridge.lstd")
local lstd = ____lstd.lstd
____exports.ShipBridge = __TS__Class()
local ShipBridge = ____exports.ShipBridge
ShipBridge.name = "ShipBridge"
function ShipBridge.prototype.____constructor(self)
end
function ShipBridge.GetWorldSpacePosition(self)
    local rawPos = SHIPBRIDGE__POSITION(nil)
    if #rawPos ~= 3 then
        error(
            __TS__New(Failure, "Raw position does not have substantial data to get world space position!", FailureMode.MISSUSE),
            0
        )
    end
    if rawPos[1] == nil or rawPos[2] == nil or rawPos[3] == nil then
        error(
            __TS__New(Failure, "Raw position data is undefined! Cannot get world space position", FailureMode.MISSUSE),
            0
        )
    end
    local vector = __TS__New(Vector3, rawPos[1], rawPos[2], rawPos[3])
    return vector
end
function ShipBridge.IsRelayActive(self, relay)
    return SHIPBRIDGE__DOESRELAYEXIST(nil, relay)
end
function ShipBridge.SetRelayOutput(self, relay, face, power)
    local output = SHIPBRIDGE__SETRELAYOUTPUT(nil, relay, face, power)
    if output == false then
        error(
            __TS__New(Failure, "Attempt to set relay output when relay doesn't exist!", FailureMode.THRUSTER_RELAY_DOESNT_EXIST),
            0
        )
    end
    return
end
function ShipBridge.GetRelayOutput(self, relay, face)
    local power = SHIPBRIDGE__GETRELAYOUTPUT(nil, relay, face)
    if power ~= -1 then
        return power
    else
        error(
            __TS__New(Failure, "Attempt to get relay output when relay doesn't exist!", FailureMode.THRUSTER_RELAY_DOESNT_EXIST),
            0
        )
    end
end
function ShipBridge.GetQuaternion(self)
    local rawPos = SHIPBRIDGE__QUATERNION(nil)
    if #rawPos ~= 4 then
        lstd:Log(tostring(#rawPos))
        error(
            __TS__New(Failure, "Raw quaternion does not have substantial data to get quaternion!", FailureMode.MISSUSE),
            0
        )
    end
    if rawPos[1] == nil or rawPos[2] == nil or rawPos[3] == nil or rawPos[4] == nil then
        error(
            __TS__New(Failure, "Raw quaternion data is undefined! Cannot get quaternion!", FailureMode.MISSUSE),
            0
        )
    end
    local quaternion = __TS__New(
        Quaternion,
        rawPos[1],
        rawPos[2],
        rawPos[3],
        rawPos[4]
    )
    return quaternion
end
function ShipBridge.GetVelocity(self)
    local rawVel = SHIPBRIDGE__GETVELOCITY(nil)
    if #rawVel ~= 3 then
        error(
            __TS__New(Failure, "Raw velocity data is undefined! Cannot get velocity", FailureMode.MISSUSE),
            0
        )
    end
    if rawVel[1] == nil or rawVel[2] == nil or rawVel[3] == nil then
        error(
            __TS__New(Failure, "Raw velocity data is undefined! Cannot get velocity", FailureMode.MISSUSE),
            0
        )
    end
    local vector = __TS__New(Vector3, rawVel[1], rawVel[2], rawVel[3])
    return vector
end
function ShipBridge.GetAngularVelocity(self)
    local rawVel = SHIPBRIDGE__GETANGULARVELOCITY(nil)
    if #rawVel ~= 3 then
        error(
            __TS__New(Failure, "Raw angular velocity data is undefined! Cannot get angular velocity", FailureMode.MISSUSE),
            0
        )
    end
    if rawVel[1] == nil or rawVel[2] == nil or rawVel[3] == nil then
        error(
            __TS__New(Failure, "Raw angular velocity data is undefined! Cannot get angular velocity", FailureMode.MISSUSE),
            0
        )
    end
    local vector = __TS__New(Vector3, rawVel[1], rawVel[2], rawVel[3])
    return vector
end
return ____exports
 end,
["src.lua.declaration.shipBridge"] = function(...) 
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
return shipBridge; end,
["src.classes.Thruster"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____lstd = require("src.lua.bridge.lstd")
local lstd = ____lstd.lstd
local ____shipBridge = require("src.lua.bridge.shipBridge")
local ShipBridge = ____shipBridge.ShipBridge
local ____Vector3 = require("src.classes.Math.Vector3")
local Vector3 = ____Vector3.Vector3
____exports.ThrusterState = ____exports.ThrusterState or ({})
____exports.ThrusterState.Active = 0
____exports.ThrusterState[____exports.ThrusterState.Active] = "Active"
____exports.ThrusterState.Offline = 1
____exports.ThrusterState[____exports.ThrusterState.Offline] = "Offline"
____exports.ThrusterState.Emergency = 2
____exports.ThrusterState[____exports.ThrusterState.Emergency] = "Emergency"
____exports.ThrusterState.DisabledUnderEmergency = 3
____exports.ThrusterState[____exports.ThrusterState.DisabledUnderEmergency] = "DisabledUnderEmergency"
____exports.ThrusterState.Failed = 4
____exports.ThrusterState[____exports.ThrusterState.Failed] = "Failed"
____exports.ThrusterAuthority = ____exports.ThrusterAuthority or ({})
____exports.ThrusterAuthority.OrientationAndTranslation = 0
____exports.ThrusterAuthority[____exports.ThrusterAuthority.OrientationAndTranslation] = "OrientationAndTranslation"
____exports.ThrusterAuthority.Orientation = 1
____exports.ThrusterAuthority[____exports.ThrusterAuthority.Orientation] = "Orientation"
____exports.ThrusterAuthority.Translation = 2
____exports.ThrusterAuthority[____exports.ThrusterAuthority.Translation] = "Translation"
____exports.Thruster = __TS__Class()
local Thruster = ____exports.Thruster
Thruster.name = "Thruster"
function Thruster.prototype.____constructor(self, relay, face, position, thrustVector)
    self.Relay = ""
    self.Face = ""
    self.State = ____exports.ThrusterState.Offline
    self.Authority = ____exports.ThrusterAuthority.OrientationAndTranslation
    self.Position = __TS__New(Vector3, 0, 0, 0)
    self.ThrustVector = __TS__New(Vector3, 0, 0, 0)
    self.Torque = __TS__New(Vector3, 0, 0, 0)
    self.Relay = relay
    self.Face = face
    self.Position = position
    self.ThrustVector = thrustVector
    local torque = position:Cross(thrustVector)
    self.Torque = torque
end
function Thruster.prototype.NoThrustSelfTest(self)
    if ShipBridge:IsRelayActive(self.Relay) == false then
        lstd:Log("[THRUSTER] No thrust self test failed, relay inactive")
        return false
    end
    return true
end
function Thruster.prototype.ApplyThrust(self, power)
    ShipBridge:SetRelayOutput(self.Relay, self.Face, power)
end
function Thruster.prototype.ThrustSelfTest(self)
    do
        local function ____catch(err)
            lstd:Log("[THRUSTER] Self test failed, error caught: " .. tostring(err))
            return true, false
        end
        local ____try, ____hasReturned, ____returnValue = pcall(function()
            if self:NoThrustSelfTest() == false then
                return true, false
            end
            self:ApplyThrust(1)
            if ShipBridge:GetRelayOutput(self.Relay, self.Face) ~= 1 then
                lstd:Log("[THRUSTER] No thrust self test failed, relay read failed")
                return true, false
            end
            self:ApplyThrust(0)
            if ShipBridge:GetRelayOutput(self.Relay, self.Face) ~= 0 then
                lstd:Log("[THRUSTER] No thrust self test failed, relay read failed")
                return true, false
            end
            return true, true
        end)
        if not ____try then
            ____hasReturned, ____returnValue = ____catch(____hasReturned)
        end
        if ____hasReturned then
            return ____returnValue
        end
    end
end
return ____exports
 end,
["src.classes.Configuration"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
return ____exports
 end,
["src.classes.Recoverability"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
Recoverability = Recoverability or ({})
Recoverability.Recoverable = 0
Recoverability[Recoverability.Recoverable] = "Recoverable"
Recoverability.Unknown = 1
Recoverability[Recoverability.Unknown] = "Unknown"
Recoverability.Unrecoverable = 2
Recoverability[Recoverability.Unrecoverable] = "Unrecoverable"
 end,
["src.classes.SystemState"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
____exports.SystemState = ____exports.SystemState or ({})
____exports.SystemState.Offline = 0
____exports.SystemState[____exports.SystemState.Offline] = "Offline"
____exports.SystemState.Active = 1
____exports.SystemState[____exports.SystemState.Active] = "Active"
____exports.SystemState.Degraded = 2
____exports.SystemState[____exports.SystemState.Degraded] = "Degraded"
____exports.SystemState.Emergency = 3
____exports.SystemState[____exports.SystemState.Emergency] = "Emergency"
____exports.SystemState.Failed = 4
____exports.SystemState[____exports.SystemState.Failed] = "Failed"
return ____exports
 end,
["src.classes.Time"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
____exports.Time = __TS__Class()
local Time = ____exports.Time
Time.name = "Time"
function Time.prototype.____constructor(self, tickRate)
    self.CurrentTick = 0
    self.TickRate = tickRate
end
function Time.prototype.GetTimeSeconds(self)
    local ticksPerSecond = 1 / self.TickRate
    return self.CurrentTick / ticksPerSecond
end
function Time.prototype.Tick(self)
    self.CurrentTick = self.CurrentTick + 1
end
return ____exports
 end,
["src.classes.Timer"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
____exports.Timer = __TS__Class()
local Timer = ____exports.Timer
Timer.name = "Timer"
function Timer.prototype.____constructor(self, TimeUntilEndSeconds, time)
    self.StartTime = time:GetTimeSeconds()
    self.EndTime = self.StartTime + TimeUntilEndSeconds
    self.time = time
end
function Timer.prototype.IsFinished(self)
    if self.time:GetTimeSeconds() > self.EndTime then
        return true
    end
    return false
end
return ____exports
 end,
["src.classes.MainSystems.ReactionControlSystem"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____lstd = require("src.lua.bridge.lstd")
local lstd = ____lstd.lstd
local ____shipBridge = require("src.lua.bridge.shipBridge")
local ShipBridge = ____shipBridge.ShipBridge
local ____Failure = require("src.classes.Failure")
local Failure = ____Failure.Failure
local FailureMode = ____Failure.FailureMode
local ____Mathc = require("src.classes.Math.Mathc")
local Mathc = ____Mathc.Mathc
local ____Quaternion = require("src.classes.Math.Quaternion")
local Quaternion = ____Quaternion.Quaternion
local ____Vector3 = require("src.classes.Math.Vector3")
local Vector3 = ____Vector3.Vector3
local ____SystemState = require("src.classes.SystemState")
local SystemState = ____SystemState.SystemState
local ____Thruster = require("src.classes.Thruster")
local ThrusterState = ____Thruster.ThrusterState
local RCSPriority = RCSPriority or ({})
RCSPriority.TranslationAndRotation = 0
RCSPriority[RCSPriority.TranslationAndRotation] = "TranslationAndRotation"
RCSPriority.Translation = 1
RCSPriority[RCSPriority.Translation] = "Translation"
RCSPriority.Rotation = 2
RCSPriority[RCSPriority.Rotation] = "Rotation"
____exports.ReactionControlSystem = __TS__Class()
local ReactionControlSystem = ____exports.ReactionControlSystem
ReactionControlSystem.name = "ReactionControlSystem"
function ReactionControlSystem.prototype.____constructor(self, thrusters, fms)
    self.Thrusters = {}
    self.state = SystemState.Offline
    self.priority = RCSPriority.TranslationAndRotation
    self.DesiredVelocity = __TS__New(Vector3, 0, 0, 0)
    self.DesiredVelocityMagnitude = 0
    self.DesiredVelocityNormalized = __TS__New(Vector3, 0, 0, 0)
    self.CurrentQuaternion = __TS__New(
        Quaternion,
        1,
        0,
        0,
        0
    )
    self.ErrorQuaternion = __TS__New(
        Quaternion,
        1,
        0,
        0,
        0
    )
    self.Thrusters = thrusters
    self.fms = fms
    self.cms = fms.cms
end
function ReactionControlSystem.prototype.GetState(self)
    return self.state
end
function ReactionControlSystem.prototype.CatastrophicShutdown(self)
    self.state = SystemState.Failed
    __TS__ArrayForEach(
        self.Thrusters,
        function(____, thruster)
            do
                pcall(function()
                    thruster:ApplyThrust(0)
                end)
            end
        end
    )
end
function ReactionControlSystem.prototype.CanThrusterDecelerateSpin(self, thruster, angularVelocity)
    if thruster.State == ThrusterState.Failed or thruster.State == ThrusterState.Emergency or thruster.State == ThrusterState.DisabledUnderEmergency then
        return false
    end
    if thruster.Torque:Dot(angularVelocity) > 0 then
        return true
    end
    return false
end
function ReactionControlSystem.prototype.EmergencySpinCondition(self)
    self.state = SystemState.Emergency
    local angularVelocity = ShipBridge:GetAngularVelocity()
    local PossibleDecelerationThrusters = {}
    local NormalDecelerationThrusters = {}
    __TS__ArrayForEach(
        self.Thrusters,
        function(____, thruster)
            if self:CanThrusterDecelerateSpin(thruster, angularVelocity) then
                PossibleDecelerationThrusters[#PossibleDecelerationThrusters + 1] = thruster
            end
        end
    )
    __TS__ArrayForEach(
        self.fms.config.Thrusters,
        function(____, thruster)
            if self:CanThrusterDecelerateSpin(thruster, angularVelocity) then
                NormalDecelerationThrusters[#NormalDecelerationThrusters + 1] = thruster
            end
        end
    )
    if #PossibleDecelerationThrusters == 0 or #NormalDecelerationThrusters == 0 then
        return Recoverability.Unrecoverable
    end
    if #PossibleDecelerationThrusters / #NormalDecelerationThrusters > self.fms.config.MinimumThrusterRotationAuthority then
        self.priority = RCSPriority.Rotation
        return Recoverability.Recoverable
    end
    return Recoverability.Unrecoverable
end
function ReactionControlSystem.prototype.ThrusterLost(self, thruster)
    thruster.State = ThrusterState.Emergency
    if self.state == SystemState.Active then
        lstd:Log("[RCS] Thruster Failed!")
        self.state = SystemState.Degraded
    end
end
function ReactionControlSystem.prototype.PowerOnSelfTest(self)
    if #self.Thrusters == 0 then
        lstd:Log("[RCS] Post failed, insufficient thruster count.")
        return false
    end
    local success = true
    __TS__ArrayForEach(
        self.Thrusters,
        function(____, thruster)
            local postResult = thruster:ThrustSelfTest()
            if postResult == false then
                success = false
            else
                thruster.State = ThrusterState.Active
            end
        end
    )
    if success == true then
        self.state = SystemState.Active
    end
    return success
end
function ReactionControlSystem.prototype.CalculateThrusterTranslation(self, thruster)
    local LocalSpaceDesiredVelocity = self.CurrentQuaternion:ConvertVectorToLocalSpace(self.DesiredVelocityNormalized)
    local dotToDesiredVector = thruster.ThrustVector:Dot(LocalSpaceDesiredVelocity)
    return dotToDesiredVector * self.DesiredVelocityMagnitude
end
function ReactionControlSystem.prototype.CalculateThrusterRotation(self, thruster, rotationDotVector)
    local alignment = thruster.Torque:Normalized():Dot(rotationDotVector)
    return alignment
end
function ReactionControlSystem.prototype.ThrusterUpdate(self, thruster, rotationDotVector)
    local safety = thruster:NoThrustSelfTest()
    if not safety then
        self:ThrusterLost(thruster)
        return
    end
    local translationFactor = self:CalculateThrusterTranslation(thruster)
    local rotationFactor = self:CalculateThrusterRotation(thruster, rotationDotVector)
    local thrust = 0
    if self.priority == RCSPriority.TranslationAndRotation then
        thrust = (translationFactor + rotationFactor) * 15
    elseif self.priority == RCSPriority.Translation then
        thrust = (translationFactor * self.fms.config.RCSFailMajorityMultiplier + rotationFactor * self.fms.config.RCSFailMinorityMultiplier) * 15
    elseif self.priority == RCSPriority.Rotation then
        thrust = (translationFactor * self.fms.config.RCSFailMinorityMultiplier + rotationFactor * self.fms.config.RCSFailMajorityMultiplier) * 15
    end
    local thrustClamped = Mathc:Clamp(thrust, 0, 15)
    do
        local function ____catch(____error)
            self:ThrusterLost(thruster)
        end
        local ____try, ____hasReturned = pcall(function()
            thruster:ApplyThrust(thrustClamped)
        end)
        if not ____try then
            ____catch(____hasReturned)
        end
    end
end
function ReactionControlSystem.prototype.Update(self, desiredVelocity, rotationDotVector)
    if self.state == SystemState.Offline then
        error(
            __TS__New(Failure, "Attempt to use R.C.S pre-POST", FailureMode.UPDATE_BEFORE_POST),
            0
        )
    end
    if desiredVelocity:Magnitude() == 0 then
        return
    end
    if self.state == SystemState.Failed then
        return
    end
    local currentQuaternion = ShipBridge:GetQuaternion()
    self.CurrentQuaternion = currentQuaternion
    self.DesiredVelocity = desiredVelocity
    self.DesiredVelocityMagnitude = desiredVelocity:Magnitude()
    self.DesiredVelocityNormalized = desiredVelocity:Normalized()
    __TS__ArrayForEach(
        self.Thrusters,
        function(____, thruster)
            self:ThrusterUpdate(thruster, rotationDotVector)
        end
    )
end
return ____exports
 end,
["src.classes.MainSystems.StabilityAugmentationSystem"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____pidcontroller = require("thirdparty.tswrappers.pidcontroller")
local PIDControllerVector = ____pidcontroller.PIDControllerVector
local ____lstd = require("src.lua.bridge.lstd")
local lstd = ____lstd.lstd
local ____shipBridge = require("src.lua.bridge.shipBridge")
local ShipBridge = ____shipBridge.ShipBridge
local ____Quaternion = require("src.classes.Math.Quaternion")
local Quaternion = ____Quaternion.Quaternion
local ____Vector3 = require("src.classes.Math.Vector3")
local Vector3 = ____Vector3.Vector3
local ____SystemState = require("src.classes.SystemState")
local SystemState = ____SystemState.SystemState
local ____Failure = require("src.classes.Failure")
local Failure = ____Failure.Failure
local FailureMode = ____Failure.FailureMode
local VectorSanityStatus = VectorSanityStatus or ({})
VectorSanityStatus.Sane = 0
VectorSanityStatus[VectorSanityStatus.Sane] = "Sane"
VectorSanityStatus.Recoverable = 1
VectorSanityStatus[VectorSanityStatus.Recoverable] = "Recoverable"
VectorSanityStatus.Insane = 2
VectorSanityStatus[VectorSanityStatus.Insane] = "Insane"
local SASActivityStatus = SASActivityStatus or ({})
SASActivityStatus.Normal = 0
SASActivityStatus[SASActivityStatus.Normal] = "Normal"
SASActivityStatus.HoldingPosition = 1
SASActivityStatus[SASActivityStatus.HoldingPosition] = "HoldingPosition"
____exports.StabilityAugmentationSystem = __TS__Class()
local StabilityAugmentationSystem = ____exports.StabilityAugmentationSystem
StabilityAugmentationSystem.name = "StabilityAugmentationSystem"
function StabilityAugmentationSystem.prototype.____constructor(self, fms)
    self.state = SystemState.Offline
    self.activityState = SASActivityStatus.Normal
    self.CanPidRetrust = true
    self.PIDTrustedCount = 0
    self.PIDTotalRetrusts = 0
    self.fms = fms
    self.rcs = fms.RCS
    self.config = fms.config
    self.TranslationLoop = __TS__New(
        PIDControllerVector,
        self.config.SASTranslationLoop.P,
        self.config.SASTranslationLoop.I,
        self.config.SASTranslationLoop.D,
        self.config.SASTranslationLoop.Min,
        self.config.SASTranslationLoop.Max
    )
    self.RotationLoop = __TS__New(
        PIDControllerVector,
        self.config.SASRotationLoop.P,
        self.config.SASRotationLoop.I,
        self.config.SASRotationLoop.D,
        self.config.SASRotationLoop.Min,
        self.config.SASRotationLoop.Max
    )
end
function StabilityAugmentationSystem.prototype.PowerOnSelfTest(self)
    local currentQuat
    local currentAngularVelocity
    local currentVelocity
    do
        local function ____catch(err)
            lstd:Log("[SAS] POST failed, one or more ShipBridge functions returned jargon. Specific error: " .. tostring(err))
            return true, false
        end
        local ____try, ____hasReturned, ____returnValue = pcall(function()
            currentQuat = ShipBridge:GetQuaternion()
            currentAngularVelocity = ShipBridge:GetAngularVelocity()
            currentVelocity = ShipBridge:GetVelocity()
        end)
        if not ____try then
            ____hasReturned, ____returnValue = ____catch(____hasReturned)
        end
        if ____hasReturned then
            return ____returnValue
        end
    end
    do
        local function ____catch(err)
            lstd:Log("[SAS] POST failed, one or more PID loops returned jargon. Specific error: " .. tostring(err))
            return true, false
        end
        local ____try, ____hasReturned, ____returnValue = pcall(function()
            self.TranslationLoop:Run(currentVelocity)
            self.RotationLoop:Run(currentAngularVelocity)
        end)
        if not ____try then
            ____hasReturned, ____returnValue = ____catch(____hasReturned)
        end
        if ____hasReturned then
            return ____returnValue
        end
    end
    if self.rcs:GetState() ~= SystemState.Active then
        lstd:Log("[SAS] POST failed, RCS is not active. Did it post?")
        return false
    end
    self.state = SystemState.Active
    return true
end
function StabilityAugmentationSystem.prototype.GetVelocityVectorSanity(self, velocity)
    local speed = velocity:Magnitude()
    if speed > self.config.MaximumForwardSpeed then
        return VectorSanityStatus.Recoverable
    end
    return VectorSanityStatus.Sane
end
function StabilityAugmentationSystem.prototype.GetErrorVelocitySanity(self, errorVector, fromVector, toVector)
    local normalSanity = self:GetVelocityVectorSanity(errorVector)
    if normalSanity == VectorSanityStatus.Insane then
        return VectorSanityStatus.Insane
    end
    local dot = toVector:Dot(errorVector)
    if dot > 0 then
        return VectorSanityStatus.Sane
    end
    if normalSanity == VectorSanityStatus.Recoverable then
        return VectorSanityStatus.Recoverable
    else
        return VectorSanityStatus.Insane
    end
end
function StabilityAugmentationSystem.prototype.SanitizeVelocityVector(self, velocity)
    local status = self:GetVelocityVectorSanity(velocity)
    local speed = velocity:Magnitude()
    if status == VectorSanityStatus.Sane then
        lstd:Log("[SAS] [WARN] Sanity correction performed on already sane vector. Are you missing a sanity check?")
        return velocity
    end
    if status == VectorSanityStatus.Insane then
        error(
            __TS__New(Failure, "[SAS] Attempt to sanitize insane vector!", FailureMode.MISSUSE),
            0
        )
    end
    if speed > self.config.MaximumForwardSpeed then
        local normalized = velocity:Normalized()
        local finalVector = normalized:Multiply(speed)
        return finalVector
    end
    lstd:Log("[SAS] Recoverable vector has not implemented issue! Is the function unfinished?")
    return velocity
end
function StabilityAugmentationSystem.prototype.VelocityPIDUpdate(self, PIDSanityStatus, velocityError, PIDResult)
    if PIDSanityStatus == VectorSanityStatus.Insane then
        lstd:Log("[SAS] Translation degredation tripped!")
        self:SwitchLoopsToManual()
        return self:VelocityManualUpdate(velocityError)
    end
    if PIDSanityStatus == VectorSanityStatus.Recoverable then
        return self:SanitizeVelocityVector(PIDResult)
    end
    return PIDResult
end
function StabilityAugmentationSystem.prototype.VelocityManualUpdate(self, velocityError)
    return velocityError:Multiply(self.config.SASManualTranslationMultiplier)
end
function StabilityAugmentationSystem.prototype.StabilizeVelocity(self, desiredVelocity)
    local currentVelocity = ShipBridge:GetVelocity()
    local velocityError = desiredVelocity:Subtract(currentVelocity)
    local PIDResult = self.TranslationLoop:Run(velocityError)
    local PIDSanityStatus = self:GetErrorVelocitySanity(PIDResult, currentVelocity, desiredVelocity)
    if PIDSanityStatus == VectorSanityStatus.Sane and self.state == SystemState.Degraded then
        self.PIDTrustedCount = self.PIDTrustedCount + 1
    elseif PIDSanityStatus == VectorSanityStatus.Insane then
        self.PIDTrustedCount = 0
    end
    if self.state == SystemState.Active then
        return self:VelocityPIDUpdate(PIDSanityStatus, velocityError, PIDResult)
    else
        return self:VelocityManualUpdate(velocityError)
    end
end
function StabilityAugmentationSystem.prototype.IsOrientationPIDSane(self, axis, PIDResult, targetQuat)
    local targetAxisAngle = targetQuat:ToAxisAngles()
    if targetAxisAngle.axis:Dot(PIDResult) > 0 then
        return VectorSanityStatus.Insane
    end
    return VectorSanityStatus.Sane
end
function StabilityAugmentationSystem.prototype.OrientationManualLoop(self, axis, angle, localAngularVelocity)
    return axis:Multiply(angle):Multiply(self.config.SASManualRotationMultiplier):Subtract(localAngularVelocity)
end
function StabilityAugmentationSystem.prototype.StabilizeOrientation(self, targetQuat)
    local currentQuat = ShipBridge:GetQuaternion()
    local invertedQuat = currentQuat:Inverse()
    local errorQuat = invertedQuat:MultiplyByQuaternion(targetQuat)
    if errorQuat.w < 0 then
        errorQuat = __TS__New(
            Quaternion,
            -errorQuat.w,
            -errorQuat.x,
            -errorQuat.y,
            -errorQuat.z
        )
    end
    local axisAngle = errorQuat:ToAxisAngles()
    local axis = axisAngle.axis
    local angle = axisAngle.angle
    local worldAngularVelocity = ShipBridge:GetAngularVelocity()
    local localAngularVelocity = currentQuat:ConvertVectorToLocalSpace(worldAngularVelocity)
    local PIDFeed = axis:Multiply(angle):Subtract(localAngularVelocity)
    local PIDResult = self.RotationLoop:Run(PIDFeed)
    local PIDSanity = self:IsOrientationPIDSane(axis, PIDResult, targetQuat)
    if PIDSanity == VectorSanityStatus.Insane and self.state == SystemState.Active then
        lstd:Log("[SAS] Orientation degredation tripped!")
        self:SwitchLoopsToManual()
    elseif PIDSanity == VectorSanityStatus.Insane and self.state ~= SystemState.Active then
        self.PIDTrustedCount = 0
    elseif PIDSanity == VectorSanityStatus.Sane and self.state == SystemState.Degraded then
        self.PIDTrustedCount = self.PIDTrustedCount + 1
    end
    if self.state == SystemState.Active then
        return PIDResult
    else
        return self:OrientationManualLoop(axis, angle, localAngularVelocity)
    end
end
function StabilityAugmentationSystem.prototype.SwitchLoopsToManual(self)
    lstd:Log("[SAS] Entering degraded state!!")
    self.state = SystemState.Degraded
end
function StabilityAugmentationSystem.prototype.SwitchLoopsToPID(self)
    if self.state ~= SystemState.Degraded then
        lstd:Log("[SAS] Attempt to enter normal state while not in degraded mode!")
        return
    end
    lstd:Log("[SAS] Exiting degraded state!")
    self.state = SystemState.Active
end
function StabilityAugmentationSystem.prototype.HoldPosition(self)
    lstd:Log("[SAS] Entered holding mode!")
    self.activityState = SASActivityStatus.HoldingPosition
end
function StabilityAugmentationSystem.prototype.UnholdPosition(self)
    lstd:Log("[SAS] Exited holding mode!")
    self.activityState = SASActivityStatus.Normal
end
function StabilityAugmentationSystem.prototype.TryRetrust(self)
    if self.PIDTotalRetrusts <= self.config.SASPIDTotalRetrustsBeforeStoppingPIDAttempts then
        lstd:Log("[SAS] Loops retrusting! Attempt : " .. tostring(self.PIDTotalRetrusts))
        self.PIDTotalRetrusts = self.PIDTotalRetrusts + 1
        self:SwitchLoopsToPID()
    else
        if self.CanPidRetrust == true then
            self.CanPidRetrust = false
            lstd:Log("[SAS] Too many failed PID retrust attempts. PID Loops now offline forever.")
        end
    end
end
function StabilityAugmentationSystem.prototype.Update(self, desiredVelocity, desiredQuaternion)
    if self.state == SystemState.Offline then
        error(
            __TS__New(Failure, "[SAS] Attempt to Update pre-POST!", FailureMode.UPDATE_BEFORE_POST),
            0
        )
    end
    if self.rcs:GetState() == SystemState.Failed then
        lstd:Log("[SAS] Attempt to Update while RCS is failed!")
        return
    end
    if self.state == SystemState.Failed then
        lstd:Log("[SAS] Attempt to Update while failed, passing through translation data to RCS.")
        self.fms:SetRCSInput(
            desiredVelocity,
            __TS__New(Vector3, 0, 1, 0)
        )
    end
    local vectorSanity = self:GetVelocityVectorSanity(desiredVelocity)
    if self.activityState == SASActivityStatus.HoldingPosition and vectorSanity == VectorSanityStatus.Insane then
        desiredVelocity = ShipBridge:GetVelocity():Inverse()
        desiredQuaternion = self.config.SASBackupQuaternion
    elseif self.activityState == SASActivityStatus.HoldingPosition and vectorSanity ~= VectorSanityStatus.Insane then
        self:UnholdPosition()
    end
    if vectorSanity == VectorSanityStatus.Insane then
        self:HoldPosition()
    end
    if self.state == SystemState.Degraded and self.PIDTrustedCount >= self.config.SASPIDRestrustsBeforeReattemptingPID then
        self:TryRetrust()
    end
    local stabilizedVelocity = self:StabilizeVelocity(desiredVelocity)
    local stabilizedErrorRotation = self:StabilizeOrientation(desiredQuaternion)
    do
        local function ____catch(____error)
            lstd:Log("[SAS] FMS-RCS call failed! " .. tostring(____error))
        end
        local ____try, ____hasReturned = pcall(function()
            self.fms:SetRCSInput(stabilizedVelocity, stabilizedErrorRotation)
        end)
        if not ____try then
            ____catch(____hasReturned)
        end
    end
end
return ____exports
 end,
["src.classes.MainSystems.FlightManagementSystem"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____lstd = require("src.lua.bridge.lstd")
local lstd = ____lstd.lstd
local ____shipBridge = require("src.lua.bridge.shipBridge")
local ShipBridge = ____shipBridge.ShipBridge
local ____Quaternion = require("src.classes.Math.Quaternion")
local Quaternion = ____Quaternion.Quaternion
local ____Vector3 = require("src.classes.Math.Vector3")
local Vector3 = ____Vector3.Vector3
local ____Time = require("src.classes.Time")
local Time = ____Time.Time
local ____CrisisManagementSystem = require("src.classes.MainSystems.CrisisManagementSystem")
local CrisisCode = ____CrisisManagementSystem.CrisisCode
local CrisisManagementSystem = ____CrisisManagementSystem.CrisisManagementSystem
local ____ReactionControlSystem = require("src.classes.MainSystems.ReactionControlSystem")
local ReactionControlSystem = ____ReactionControlSystem.ReactionControlSystem
local ____StabilityAugmentationSystem = require("src.classes.MainSystems.StabilityAugmentationSystem")
local StabilityAugmentationSystem = ____StabilityAugmentationSystem.StabilityAugmentationSystem
local FMSState = FMSState or ({})
FMSState.Offline = 0
FMSState[FMSState.Offline] = "Offline"
FMSState.Online = 1
FMSState[FMSState.Online] = "Online"
FMSState.Degraded = 2
FMSState[FMSState.Degraded] = "Degraded"
FMSState.Emergency = 3
FMSState[FMSState.Emergency] = "Emergency"
FMSState.Failed = 4
FMSState[FMSState.Failed] = "Failed"
____exports.FlightManagementSystem = __TS__Class()
local FlightManagementSystem = ____exports.FlightManagementSystem
FlightManagementSystem.name = "FlightManagementSystem"
function FlightManagementSystem.prototype.____constructor(self, config)
    self.state = FMSState.Offline
    self.rcsDesiredVelocity = __TS__New(Vector3, 0, 0, 0)
    self.rcsErrorRotation = __TS__New(Vector3, 0, 0, 0)
    self.rcsInputTimesCalled = 0
    self.config = config
    self.cms = __TS__New(CrisisManagementSystem, self)
    self.RCS = __TS__New(ReactionControlSystem, config.Thrusters, self)
    self.SAS = __TS__New(StabilityAugmentationSystem, self)
    self.Time = __TS__New(Time, config.tickRate)
end
function FlightManagementSystem.prototype.SetRCSInput(self, desiredVelocity, errorRotation)
    self.rcsInputTimesCalled = self.rcsInputTimesCalled + 1
    if self.rcsInputTimesCalled > 1 then
        lstd:Log("[FMS] More then one RCS call this tick!")
        return
    end
    self.rcsDesiredVelocity = desiredVelocity
    self.rcsErrorRotation = errorRotation
end
function FlightManagementSystem.prototype.PowerOnSelfTest(self)
    if self.RCS == nil or self.SAS == nil then
        lstd:Log("FMS POST failed! One or more systems not instantiated.")
        return false
    end
    local rcsPostResult = self.RCS:PowerOnSelfTest()
    local sasPostResult = self.SAS:PowerOnSelfTest()
    if rcsPostResult == false or sasPostResult == false then
        lstd:Log("FMS POST failed! One or more system POSTs failed.")
        return false
    end
    return true
end
function FlightManagementSystem.prototype.StartEmergency(self)
    self.state = FMSState.Emergency
end
function FlightManagementSystem.prototype.Update(self)
    self.SAS:Update(
        __TS__New(Vector3, -39, 42, -52):Subtract(ShipBridge:GetWorldSpacePosition()),
        Quaternion:fromAxisAngles(
            __TS__New(Vector3, 0, 1, 0),
            3.14
        )
    )
    if self.rcsInputTimesCalled == 1 then
        do
            local function ____catch(____error)
                lstd:Log("[FMS] RCS Failed to update!")
                self.cms:Distress(CrisisCode.RCS_UPDATE_ERRORED)
            end
            local ____try, ____hasReturned = pcall(function()
                self.RCS:Update(self.rcsDesiredVelocity, self.rcsErrorRotation)
            end)
            if not ____try then
                ____catch(____hasReturned)
            end
        end
    else
        lstd:Log("[FMS] RCS not called this loop!")
    end
    self.rcsInputTimesCalled = 0
    self.Time:Tick()
    lstd:Sleep(self.config.tickRate)
end
function FlightManagementSystem.prototype.Loop(self)
    while true do
        self:Update()
    end
end
function FlightManagementSystem.prototype.Bootstrap(self)
    local POSTResult = self:PowerOnSelfTest()
    if POSTResult == false then
        error(
            __TS__New(Error, "[FMS] POST failed!"),
            0
        )
    end
    self:Loop()
end
return ____exports
 end,
["src.classes.MainSystems.CrisisManagementSystem"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____lstd = require("src.lua.bridge.lstd")
local lstd = ____lstd.lstd
____exports.SystemName = ____exports.SystemName or ({})
____exports.SystemName.ReactionControlSystem = 0
____exports.SystemName[____exports.SystemName.ReactionControlSystem] = "ReactionControlSystem"
____exports.SystemName.StabilityAugmentationSystem = 1
____exports.SystemName[____exports.SystemName.StabilityAugmentationSystem] = "StabilityAugmentationSystem"
____exports.SystemName.TerrianAndDestructionAvoidanceSystem = 2
____exports.SystemName[____exports.SystemName.TerrianAndDestructionAvoidanceSystem] = "TerrianAndDestructionAvoidanceSystem"
____exports.CrisisCode = ____exports.CrisisCode or ({})
____exports.CrisisCode.SAS_LOOPS_FAILED = 0
____exports.CrisisCode[____exports.CrisisCode.SAS_LOOPS_FAILED] = "SAS_LOOPS_FAILED"
____exports.CrisisCode.RCS_UPDATE_ERRORED = 1
____exports.CrisisCode[____exports.CrisisCode.RCS_UPDATE_ERRORED] = "RCS_UPDATE_ERRORED"
____exports.CrisisManagementSystem = __TS__Class()
local CrisisManagementSystem = ____exports.CrisisManagementSystem
CrisisManagementSystem.name = "CrisisManagementSystem"
function CrisisManagementSystem.prototype.____constructor(self, fms)
    self.fms = fms
    self.rcs = fms.RCS
end
function CrisisManagementSystem.prototype.CrisisCode_SAS_LOOP_FAILED(self)
end
function CrisisManagementSystem.prototype.CrisisCode_RCS_UPDATE_ERRORED(self)
end
function CrisisManagementSystem.prototype.Distress(self, signal)
    repeat
        local ____switch6 = signal
        local ____cond6 = ____switch6 == ____exports.CrisisCode.SAS_LOOPS_FAILED
        if ____cond6 then
            do
                self:CrisisCode_SAS_LOOP_FAILED()
                break
            end
        end
        ____cond6 = ____cond6 or ____switch6 == ____exports.CrisisCode.RCS_UPDATE_ERRORED
        if ____cond6 then
            do
                self:CrisisCode_RCS_UPDATE_ERRORED()
                break
            end
        end
        do
            do
                lstd:Log("[CMS] Recieved unhandled distress signal! " .. tostring(signal))
                break
            end
        end
    until true
end
function CrisisManagementSystem.prototype.SystemIsAlive(self, system)
end
function CrisisManagementSystem.prototype.Update(self)
end
return ____exports
 end,
["src.classes.MainSystems.Kernel"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
 end,
["src.entry.drone"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__New = ____lualib.__TS__New
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
local ____exports = {}
local ____FlightManagementSystem = require("src.classes.MainSystems.FlightManagementSystem")
local FlightManagementSystem = ____FlightManagementSystem.FlightManagementSystem
local ____Quaternion = require("src.classes.Math.Quaternion")
local Quaternion = ____Quaternion.Quaternion
local ____Vector3 = require("src.classes.Math.Vector3")
local Vector3 = ____Vector3.Vector3
local ____Thruster = require("src.classes.Thruster")
local Thruster = ____Thruster.Thruster
local config = {
    SASRotationLoop = {
        P = 0.3,
        I = 0,
        D = 0,
        Min = -1,
        Max = 1
    },
    SASTranslationLoop = {
        P = 0.2,
        I = 0.01,
        D = 0,
        Min = -1,
        Max = 1
    },
    SASPIDRestrustsBeforeReattemptingPID = 10,
    SASPIDTotalRetrustsBeforeStoppingPIDAttempts = 5,
    SASBackupQuaternion = Quaternion:fromAxisAngles(
        __TS__New(Vector3, 0, 1, 0),
        math.pi
    ),
    SASManualRotationMultiplier = 0.5,
    SASManualTranslationMultiplier = 0.5,
    MaximumForwardSpeed = 30,
    MinimumThrusterRotationAuthority = 0.2,
    RCSFailMajorityMultiplier = 0.5,
    RCSFailMinorityMultiplier = 0.5,
    tickRate = 0.05,
    Thrusters = {
        __TS__New(
            Thruster,
            "redstone_relay_2",
            "top",
            __TS__New(Vector3, -1, 1, -1),
            __TS__New(Vector3, 0, -1, 0)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_5",
            "top",
            __TS__New(Vector3, 1, 1, -1),
            __TS__New(Vector3, 0, -1, 0)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_12",
            "top",
            __TS__New(Vector3, -1, 1, 1),
            __TS__New(Vector3, 0, -1, 0)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_3",
            "top",
            __TS__New(Vector3, 1, 1, 1),
            __TS__New(Vector3, 0, -1, 0)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_6",
            "bottom",
            __TS__New(Vector3, -1, -1, -1),
            __TS__New(Vector3, 0, 1, 0)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_7",
            "bottom",
            __TS__New(Vector3, 1, -1, -1),
            __TS__New(Vector3, 0, 1, 0)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_11",
            "bottom",
            __TS__New(Vector3, -1, -1, 1),
            __TS__New(Vector3, 0, 1, 0)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_10",
            "bottom",
            __TS__New(Vector3, 1, -1, 1),
            __TS__New(Vector3, 0, 1, 0)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_2",
            "back",
            __TS__New(Vector3, -1, 1, -1),
            __TS__New(Vector3, 0, 0, 1)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_5",
            "back",
            __TS__New(Vector3, 1, 1, -1),
            __TS__New(Vector3, 0, 0, 1)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_6",
            "back",
            __TS__New(Vector3, -1, -1, -1),
            __TS__New(Vector3, 0, 0, 1)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_7",
            "back",
            __TS__New(Vector3, 1, -1, -1),
            __TS__New(Vector3, 0, 0, 1)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_12",
            "right",
            __TS__New(Vector3, -1, 1, 1),
            __TS__New(Vector3, 0, 0, -1)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_3",
            "back",
            __TS__New(Vector3, 1, 1, 1),
            __TS__New(Vector3, 0, 0, -1)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_11",
            "right",
            __TS__New(Vector3, -1, -1, 1),
            __TS__New(Vector3, 0, 0, -1)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_10",
            "back",
            __TS__New(Vector3, 1, -1, 1),
            __TS__New(Vector3, 0, 0, -1)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_5",
            "left",
            __TS__New(Vector3, 1, 1, -1),
            __TS__New(Vector3, -1, 0, 0)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_3",
            "right",
            __TS__New(Vector3, 1, 1, 1),
            __TS__New(Vector3, -1, 0, 0)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_7",
            "left",
            __TS__New(Vector3, 1, -1, -1),
            __TS__New(Vector3, -1, 0, 0)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_10",
            "right",
            __TS__New(Vector3, 1, -1, 1),
            __TS__New(Vector3, -1, 0, 0)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_12",
            "back",
            __TS__New(Vector3, -1, 1, 1),
            __TS__New(Vector3, 1, 0, 0)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_2",
            "right",
            __TS__New(Vector3, -1, 1, -1),
            __TS__New(Vector3, 1, 0, 0)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_11",
            "back",
            __TS__New(Vector3, -1, -1, 1),
            __TS__New(Vector3, 1, 0, 0)
        ),
        __TS__New(
            Thruster,
            "redstone_relay_6",
            "right",
            __TS__New(Vector3, -1, -1, -1),
            __TS__New(Vector3, 1, 0, 0)
        )
    }
}
local fms = __TS__New(FlightManagementSystem, config)
fms:Bootstrap()
return ____exports
 end,
}
local __TS__SourceMapTraceBack = require("lualib_bundle").__TS__SourceMapTraceBack
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["2836"] = {line = 1, file = "lstd.ts"},["2837"] = {line = 1, file = "lstd.ts"},["2838"] = {line = 1, file = "lstd.ts"},["2839"] = {line = 3, file = "lstd.ts"},["2840"] = {line = 3, file = "lstd.ts"},["2841"] = {line = 3, file = "lstd.ts"},["2843"] = {line = 3, file = "lstd.ts"},["2844"] = {line = 4, file = "lstd.ts"},["2845"] = {line = 5, file = "lstd.ts"},["2846"] = {line = 4, file = "lstd.ts"},["2847"] = {line = 7, file = "lstd.ts"},["2848"] = {line = 8, file = "lstd.ts"},["2849"] = {line = 7, file = "lstd.ts"},["2882"] = {line = 5, file = "Failure.ts"},["2883"] = {line = 6, file = "Failure.ts"},["2884"] = {line = 6, file = "Failure.ts"},["2885"] = {line = 7, file = "Failure.ts"},["2886"] = {line = 7, file = "Failure.ts"},["2887"] = {line = 8, file = "Failure.ts"},["2888"] = {line = 8, file = "Failure.ts"},["2889"] = {line = 9, file = "Failure.ts"},["2890"] = {line = 9, file = "Failure.ts"},["2891"] = {line = 10, file = "Failure.ts"},["2892"] = {line = 10, file = "Failure.ts"},["2893"] = {line = 11, file = "Failure.ts"},["2894"] = {line = 11, file = "Failure.ts"},["2895"] = {line = 12, file = "Failure.ts"},["2896"] = {line = 12, file = "Failure.ts"},["2897"] = {line = 14, file = "Failure.ts"},["2898"] = {line = 14, file = "Failure.ts"},["2899"] = {line = 14, file = "Failure.ts"},["2900"] = {line = 14, file = "Failure.ts"},["2901"] = {line = 17, file = "Failure.ts"},["2902"] = {line = 14, file = "Failure.ts"},["2903"] = {line = 19, file = "Failure.ts"},["2904"] = {line = 19, file = "Failure.ts"},["2905"] = {line = 19, file = "Failure.ts"},["2906"] = {line = 15, file = "Failure.ts"},["2907"] = {line = 20, file = "Failure.ts"},["2908"] = {line = 17, file = "Failure.ts"},["2916"] = {line = 1, file = "Mathc.ts"},["2917"] = {line = 1, file = "Mathc.ts"},["2918"] = {line = 1, file = "Mathc.ts"},["2920"] = {line = 1, file = "Mathc.ts"},["2921"] = {line = 2, file = "Mathc.ts"},["2922"] = {line = 6, file = "Mathc.ts"},["2923"] = {line = 8, file = "Mathc.ts"},["2925"] = {line = 10, file = "Mathc.ts"},["2926"] = {line = 12, file = "Mathc.ts"},["2928"] = {line = 14, file = "Mathc.ts"},["2929"] = {line = 2, file = "Mathc.ts"},["2930"] = {line = 16, file = "Mathc.ts"},["2931"] = {line = 18, file = "Mathc.ts"},["2932"] = {line = 20, file = "Mathc.ts"},["2934"] = {line = 24, file = "Mathc.ts"},["2936"] = {line = 16, file = "Mathc.ts"},["2952"] = {line = 2, file = "Vector3.ts"},["2953"] = {line = 2, file = "Vector3.ts"},["2954"] = {line = 3, file = "Vector3.ts"},["2955"] = {line = 3, file = "Vector3.ts"},["2956"] = {line = 3, file = "Vector3.ts"},["2957"] = {line = 7, file = "Vector3.ts"},["2958"] = {line = 4, file = "Vector3.ts"},["2959"] = {line = 5, file = "Vector3.ts"},["2960"] = {line = 6, file = "Vector3.ts"},["2961"] = {line = 8, file = "Vector3.ts"},["2962"] = {line = 9, file = "Vector3.ts"},["2963"] = {line = 10, file = "Vector3.ts"},["2964"] = {line = 7, file = "Vector3.ts"},["2965"] = {line = 13, file = "Vector3.ts"},["2966"] = {line = 14, file = "Vector3.ts"},["2967"] = {line = 15, file = "Vector3.ts"},["2968"] = {line = 13, file = "Vector3.ts"},["2969"] = {line = 24, file = "Vector3.ts"},["2970"] = {line = 26, file = "Vector3.ts"},["2971"] = {line = 27, file = "Vector3.ts"},["2972"] = {line = 28, file = "Vector3.ts"},["2973"] = {line = 29, file = "Vector3.ts"},["2974"] = {line = 24, file = "Vector3.ts"},["2975"] = {line = 32, file = "Vector3.ts"},["2976"] = {line = 34, file = "Vector3.ts"},["2977"] = {line = 35, file = "Vector3.ts"},["2978"] = {line = 36, file = "Vector3.ts"},["2979"] = {line = 37, file = "Vector3.ts"},["2980"] = {line = 32, file = "Vector3.ts"},["2981"] = {line = 40, file = "Vector3.ts"},["2982"] = {line = 41, file = "Vector3.ts"},["2983"] = {line = 42, file = "Vector3.ts"},["2984"] = {line = 43, file = "Vector3.ts"},["2985"] = {line = 44, file = "Vector3.ts"},["2986"] = {line = 45, file = "Vector3.ts"},["2987"] = {line = 40, file = "Vector3.ts"},["2988"] = {line = 47, file = "Vector3.ts"},["2989"] = {line = 48, file = "Vector3.ts"},["2990"] = {line = 53, file = "Vector3.ts"},["2991"] = {line = 47, file = "Vector3.ts"},["2992"] = {line = 56, file = "Vector3.ts"},["2993"] = {line = 58, file = "Vector3.ts"},["2994"] = {line = 60, file = "Vector3.ts"},["2996"] = {line = 62, file = "Vector3.ts"},["2997"] = {line = 56, file = "Vector3.ts"},["2998"] = {line = 65, file = "Vector3.ts"},["2999"] = {line = 66, file = "Vector3.ts"},["3000"] = {line = 67, file = "Vector3.ts"},["3001"] = {line = 65, file = "Vector3.ts"},["3002"] = {line = 69, file = "Vector3.ts"},["3003"] = {line = 70, file = "Vector3.ts"},["3004"] = {line = 71, file = "Vector3.ts"},["3006"] = {line = 72, file = "Vector3.ts"},["3010"] = {line = 74, file = "Vector3.ts"},["3011"] = {line = 79, file = "Vector3.ts"},["3012"] = {line = 69, file = "Vector3.ts"},["3013"] = {line = 82, file = "Vector3.ts"},["3014"] = {line = 83, file = "Vector3.ts"},["3015"] = {line = 88, file = "Vector3.ts"},["3016"] = {line = 82, file = "Vector3.ts"},["3017"] = {line = 90, file = "Vector3.ts"},["3018"] = {line = 91, file = "Vector3.ts"},["3019"] = {line = 96, file = "Vector3.ts"},["3020"] = {line = 90, file = "Vector3.ts"},["3021"] = {line = 98, file = "Vector3.ts"},["3022"] = {line = 99, file = "Vector3.ts"},["3023"] = {line = 104, file = "Vector3.ts"},["3024"] = {line = 98, file = "Vector3.ts"},["3025"] = {line = 106, file = "Vector3.ts"},["3026"] = {line = 107, file = "Vector3.ts"},["3027"] = {line = 112, file = "Vector3.ts"},["3028"] = {line = 106, file = "Vector3.ts"},["3029"] = {line = 114, file = "Vector3.ts"},["3030"] = {line = 116, file = "Vector3.ts"},["3032"] = {line = 118, file = "Vector3.ts"},["3036"] = {line = 120, file = "Vector3.ts"},["3037"] = {line = 114, file = "Vector3.ts"},["3038"] = {line = 122, file = "Vector3.ts"},["3039"] = {line = 124, file = "Vector3.ts"},["3040"] = {line = 125, file = "Vector3.ts"},["3041"] = {line = 122, file = "Vector3.ts"},["3050"] = {line = 2, file = "pidcontroller.ts"},["3051"] = {line = 2, file = "pidcontroller.ts"},["3052"] = {line = 9, file = "pidcontroller.ts"},["3053"] = {line = 9, file = "pidcontroller.ts"},["3054"] = {line = 9, file = "pidcontroller.ts"},["3055"] = {line = 22, file = "pidcontroller.ts"},["3056"] = {line = 16, file = "pidcontroller.ts"},["3057"] = {line = 17, file = "pidcontroller.ts"},["3058"] = {line = 18, file = "pidcontroller.ts"},["3059"] = {line = 19, file = "pidcontroller.ts"},["3060"] = {line = 20, file = "pidcontroller.ts"},["3061"] = {line = 23, file = "pidcontroller.ts"},["3062"] = {line = 24, file = "pidcontroller.ts"},["3063"] = {line = 25, file = "pidcontroller.ts"},["3064"] = {line = 26, file = "pidcontroller.ts"},["3065"] = {line = 27, file = "pidcontroller.ts"},["3066"] = {line = 22, file = "pidcontroller.ts"},["3067"] = {line = 30, file = "pidcontroller.ts"},["3068"] = {line = 31, file = "pidcontroller.ts"},["3069"] = {line = 32, file = "pidcontroller.ts"},["3070"] = {line = 33, file = "pidcontroller.ts"},["3071"] = {line = 39, file = "pidcontroller.ts"},["3072"] = {line = 41, file = "pidcontroller.ts"},["3073"] = {line = 42, file = "pidcontroller.ts"},["3074"] = {line = 43, file = "pidcontroller.ts"},["3075"] = {line = 45, file = "pidcontroller.ts"},["3076"] = {line = 46, file = "pidcontroller.ts"},["3077"] = {line = 47, file = "pidcontroller.ts"},["3078"] = {line = 48, file = "pidcontroller.ts"},["3079"] = {line = 49, file = "pidcontroller.ts"},["3081"] = {line = 51, file = "pidcontroller.ts"},["3083"] = {line = 54, file = "pidcontroller.ts"},["3084"] = {line = 55, file = "pidcontroller.ts"},["3086"] = {line = 57, file = "pidcontroller.ts"},["3088"] = {line = 60, file = "pidcontroller.ts"},["3089"] = {line = 61, file = "pidcontroller.ts"},["3091"] = {line = 63, file = "pidcontroller.ts"},["3093"] = {line = 66, file = "pidcontroller.ts"},["3094"] = {line = 67, file = "pidcontroller.ts"},["3096"] = {line = 69, file = "pidcontroller.ts"},["3098"] = {line = 72, file = "pidcontroller.ts"},["3099"] = {line = 73, file = "pidcontroller.ts"},["3101"] = {line = 75, file = "pidcontroller.ts"},["3103"] = {line = 78, file = "pidcontroller.ts"},["3104"] = {line = 79, file = "pidcontroller.ts"},["3106"] = {line = 81, file = "pidcontroller.ts"},["3108"] = {line = 84, file = "pidcontroller.ts"},["3109"] = {line = 86, file = "pidcontroller.ts"},["3110"] = {line = 88, file = "pidcontroller.ts"},["3111"] = {line = 91, file = "pidcontroller.ts"},["3112"] = {line = 92, file = "pidcontroller.ts"},["3113"] = {line = 30, file = "pidcontroller.ts"},["3122"] = {line = 2, file = "Quaternion.ts"},["3123"] = {line = 2, file = "Quaternion.ts"},["3124"] = {line = 9, file = "Quaternion.ts"},["3125"] = {line = 9, file = "Quaternion.ts"},["3126"] = {line = 9, file = "Quaternion.ts"},["3127"] = {line = 18, file = "Quaternion.ts"},["3128"] = {line = 10, file = "Quaternion.ts"},["3129"] = {line = 11, file = "Quaternion.ts"},["3130"] = {line = 12, file = "Quaternion.ts"},["3131"] = {line = 13, file = "Quaternion.ts"},["3132"] = {line = 23, file = "Quaternion.ts"},["3133"] = {line = 24, file = "Quaternion.ts"},["3134"] = {line = 25, file = "Quaternion.ts"},["3135"] = {line = 26, file = "Quaternion.ts"},["3136"] = {line = 17, file = "Quaternion.ts"},["3137"] = {line = 29, file = "Quaternion.ts"},["3138"] = {line = 30, file = "Quaternion.ts"},["3139"] = {line = 32, file = "Quaternion.ts"},["3140"] = {line = 33, file = "Quaternion.ts"},["3141"] = {line = 33, file = "Quaternion.ts"},["3142"] = {line = 33, file = "Quaternion.ts"},["3143"] = {line = 33, file = "Quaternion.ts"},["3144"] = {line = 33, file = "Quaternion.ts"},["3145"] = {line = 33, file = "Quaternion.ts"},["3146"] = {line = 33, file = "Quaternion.ts"},["3147"] = {line = 34, file = "Quaternion.ts"},["3149"] = {line = 37, file = "Quaternion.ts"},["3150"] = {line = 38, file = "Quaternion.ts"},["3151"] = {line = 40, file = "Quaternion.ts"},["3152"] = {line = 41, file = "Quaternion.ts"},["3153"] = {line = 43, file = "Quaternion.ts"},["3154"] = {line = 43, file = "Quaternion.ts"},["3155"] = {line = 44, file = "Quaternion.ts"},["3156"] = {line = 45, file = "Quaternion.ts"},["3157"] = {line = 46, file = "Quaternion.ts"},["3158"] = {line = 47, file = "Quaternion.ts"},["3159"] = {line = 43, file = "Quaternion.ts"},["3160"] = {line = 49, file = "Quaternion.ts"},["3161"] = {line = 29, file = "Quaternion.ts"},["3162"] = {line = 52, file = "Quaternion.ts"},["3163"] = {line = 53, file = "Quaternion.ts"},["3164"] = {line = 54, file = "Quaternion.ts"},["3165"] = {line = 55, file = "Quaternion.ts"},["3166"] = {line = 56, file = "Quaternion.ts"},["3167"] = {line = 57, file = "Quaternion.ts"},["3168"] = {line = 58, file = "Quaternion.ts"},["3169"] = {line = 56, file = "Quaternion.ts"},["3171"] = {line = 62, file = "Quaternion.ts"},["3172"] = {line = 67, file = "Quaternion.ts"},["3173"] = {line = 71, file = "Quaternion.ts"},["3174"] = {line = 52, file = "Quaternion.ts"},["3175"] = {line = 74, file = "Quaternion.ts"},["3176"] = {line = 75, file = "Quaternion.ts"},["3177"] = {line = 77, file = "Quaternion.ts"},["3178"] = {line = 77, file = "Quaternion.ts"},["3179"] = {line = 78, file = "Quaternion.ts"},["3180"] = {line = 79, file = "Quaternion.ts"},["3181"] = {line = 80, file = "Quaternion.ts"},["3182"] = {line = 81, file = "Quaternion.ts"},["3183"] = {line = 77, file = "Quaternion.ts"},["3184"] = {line = 83, file = "Quaternion.ts"},["3185"] = {line = 74, file = "Quaternion.ts"},["3186"] = {line = 86, file = "Quaternion.ts"},["3187"] = {line = 87, file = "Quaternion.ts"},["3188"] = {line = 88, file = "Quaternion.ts"},["3189"] = {line = 89, file = "Quaternion.ts"},["3190"] = {line = 91, file = "Quaternion.ts"},["3191"] = {line = 92, file = "Quaternion.ts"},["3192"] = {line = 93, file = "Quaternion.ts"},["3193"] = {line = 99, file = "Quaternion.ts"},["3194"] = {line = 104, file = "Quaternion.ts"},["3195"] = {line = 86, file = "Quaternion.ts"},["3196"] = {line = 107, file = "Quaternion.ts"},["3197"] = {line = 108, file = "Quaternion.ts"},["3198"] = {line = 110, file = "Quaternion.ts"},["3199"] = {line = 112, file = "Quaternion.ts"},["3200"] = {line = 114, file = "Quaternion.ts"},["3201"] = {line = 116, file = "Quaternion.ts"},["3202"] = {line = 116, file = "Quaternion.ts"},["3203"] = {line = 116, file = "Quaternion.ts"},["3204"] = {line = 116, file = "Quaternion.ts"},["3205"] = {line = 116, file = "Quaternion.ts"},["3206"] = {line = 116, file = "Quaternion.ts"},["3207"] = {line = 116, file = "Quaternion.ts"},["3208"] = {line = 117, file = "Quaternion.ts"},["3209"] = {line = 107, file = "Quaternion.ts"},["3210"] = {line = 119, file = "Quaternion.ts"},["3211"] = {line = 120, file = "Quaternion.ts"},["3212"] = {line = 120, file = "Quaternion.ts"},["3213"] = {line = 121, file = "Quaternion.ts"},["3214"] = {line = 122, file = "Quaternion.ts"},["3215"] = {line = 123, file = "Quaternion.ts"},["3216"] = {line = 124, file = "Quaternion.ts"},["3217"] = {line = 120, file = "Quaternion.ts"},["3218"] = {line = 126, file = "Quaternion.ts"},["3219"] = {line = 127, file = "Quaternion.ts"},["3220"] = {line = 130, file = "Quaternion.ts"},["3221"] = {line = 131, file = "Quaternion.ts"},["3222"] = {line = 119, file = "Quaternion.ts"},["3223"] = {line = 133, file = "Quaternion.ts"},["3224"] = {line = 134, file = "Quaternion.ts"},["3225"] = {line = 134, file = "Quaternion.ts"},["3226"] = {line = 135, file = "Quaternion.ts"},["3227"] = {line = 136, file = "Quaternion.ts"},["3228"] = {line = 137, file = "Quaternion.ts"},["3229"] = {line = 138, file = "Quaternion.ts"},["3230"] = {line = 134, file = "Quaternion.ts"},["3231"] = {line = 140, file = "Quaternion.ts"},["3232"] = {line = 142, file = "Quaternion.ts"},["3233"] = {line = 143, file = "Quaternion.ts"},["3234"] = {line = 144, file = "Quaternion.ts"},["3235"] = {line = 133, file = "Quaternion.ts"},["3236"] = {line = 15, file = "Quaternion.ts"},["3245"] = {line = 3, file = "shipBridge.ts"},["3246"] = {line = 3, file = "shipBridge.ts"},["3247"] = {line = 3, file = "shipBridge.ts"},["3248"] = {line = 4, file = "shipBridge.ts"},["3249"] = {line = 4, file = "shipBridge.ts"},["3250"] = {line = 5, file = "shipBridge.ts"},["3251"] = {line = 5, file = "shipBridge.ts"},["3252"] = {line = 6, file = "shipBridge.ts"},["3253"] = {line = 6, file = "shipBridge.ts"},["3254"] = {line = 6, file = "shipBridge.ts"},["3255"] = {line = 6, file = "shipBridge.ts"},["3256"] = {line = 6, file = "shipBridge.ts"},["3257"] = {line = 6, file = "shipBridge.ts"},["3258"] = {line = 6, file = "shipBridge.ts"},["3259"] = {line = 6, file = "shipBridge.ts"},["3260"] = {line = 7, file = "shipBridge.ts"},["3261"] = {line = 7, file = "shipBridge.ts"},["3262"] = {line = 9, file = "shipBridge.ts"},["3263"] = {line = 9, file = "shipBridge.ts"},["3264"] = {line = 9, file = "shipBridge.ts"},["3266"] = {line = 9, file = "shipBridge.ts"},["3267"] = {line = 11, file = "shipBridge.ts"},["3268"] = {line = 13, file = "shipBridge.ts"},["3269"] = {line = 14, file = "shipBridge.ts"},["3271"] = {line = 15, file = "shipBridge.ts"},["3275"] = {line = 17, file = "shipBridge.ts"},["3277"] = {line = 19, file = "shipBridge.ts"},["3281"] = {line = 21, file = "shipBridge.ts"},["3282"] = {line = 22, file = "shipBridge.ts"},["3283"] = {line = 11, file = "shipBridge.ts"},["3284"] = {line = 24, file = "shipBridge.ts"},["3285"] = {line = 26, file = "shipBridge.ts"},["3286"] = {line = 24, file = "shipBridge.ts"},["3287"] = {line = 28, file = "shipBridge.ts"},["3288"] = {line = 30, file = "shipBridge.ts"},["3289"] = {line = 31, file = "shipBridge.ts"},["3291"] = {line = 32, file = "shipBridge.ts"},["3296"] = {line = 28, file = "shipBridge.ts"},["3297"] = {line = 36, file = "shipBridge.ts"},["3298"] = {line = 38, file = "shipBridge.ts"},["3299"] = {line = 39, file = "shipBridge.ts"},["3300"] = {line = 40, file = "shipBridge.ts"},["3303"] = {line = 44, file = "shipBridge.ts"},["3307"] = {line = 36, file = "shipBridge.ts"},["3308"] = {line = 47, file = "shipBridge.ts"},["3309"] = {line = 49, file = "shipBridge.ts"},["3310"] = {line = 50, file = "shipBridge.ts"},["3311"] = {line = 51, file = "shipBridge.ts"},["3313"] = {line = 52, file = "shipBridge.ts"},["3317"] = {line = 54, file = "shipBridge.ts"},["3319"] = {line = 56, file = "shipBridge.ts"},["3323"] = {line = 58, file = "shipBridge.ts"},["3324"] = {line = 58, file = "shipBridge.ts"},["3325"] = {line = 58, file = "shipBridge.ts"},["3326"] = {line = 58, file = "shipBridge.ts"},["3327"] = {line = 58, file = "shipBridge.ts"},["3328"] = {line = 58, file = "shipBridge.ts"},["3329"] = {line = 58, file = "shipBridge.ts"},["3330"] = {line = 59, file = "shipBridge.ts"},["3331"] = {line = 47, file = "shipBridge.ts"},["3332"] = {line = 61, file = "shipBridge.ts"},["3333"] = {line = 63, file = "shipBridge.ts"},["3334"] = {line = 64, file = "shipBridge.ts"},["3336"] = {line = 65, file = "shipBridge.ts"},["3340"] = {line = 67, file = "shipBridge.ts"},["3342"] = {line = 69, file = "shipBridge.ts"},["3346"] = {line = 71, file = "shipBridge.ts"},["3347"] = {line = 72, file = "shipBridge.ts"},["3348"] = {line = 61, file = "shipBridge.ts"},["3349"] = {line = 74, file = "shipBridge.ts"},["3350"] = {line = 76, file = "shipBridge.ts"},["3351"] = {line = 77, file = "shipBridge.ts"},["3353"] = {line = 78, file = "shipBridge.ts"},["3357"] = {line = 80, file = "shipBridge.ts"},["3359"] = {line = 82, file = "shipBridge.ts"},["3363"] = {line = 84, file = "shipBridge.ts"},["3364"] = {line = 85, file = "shipBridge.ts"},["3365"] = {line = 74, file = "shipBridge.ts"},["3430"] = {line = 1, file = "Thruster.ts"},["3431"] = {line = 1, file = "Thruster.ts"},["3432"] = {line = 2, file = "Thruster.ts"},["3433"] = {line = 2, file = "Thruster.ts"},["3434"] = {line = 4, file = "Thruster.ts"},["3435"] = {line = 4, file = "Thruster.ts"},["3436"] = {line = 6, file = "Thruster.ts"},["3437"] = {line = 8, file = "Thruster.ts"},["3438"] = {line = 8, file = "Thruster.ts"},["3439"] = {line = 9, file = "Thruster.ts"},["3440"] = {line = 9, file = "Thruster.ts"},["3441"] = {line = 10, file = "Thruster.ts"},["3442"] = {line = 10, file = "Thruster.ts"},["3443"] = {line = 11, file = "Thruster.ts"},["3444"] = {line = 11, file = "Thruster.ts"},["3445"] = {line = 12, file = "Thruster.ts"},["3446"] = {line = 12, file = "Thruster.ts"},["3447"] = {line = 14, file = "Thruster.ts"},["3448"] = {line = 16, file = "Thruster.ts"},["3449"] = {line = 16, file = "Thruster.ts"},["3450"] = {line = 17, file = "Thruster.ts"},["3451"] = {line = 17, file = "Thruster.ts"},["3452"] = {line = 18, file = "Thruster.ts"},["3453"] = {line = 18, file = "Thruster.ts"},["3454"] = {line = 21, file = "Thruster.ts"},["3455"] = {line = 21, file = "Thruster.ts"},["3456"] = {line = 21, file = "Thruster.ts"},["3457"] = {line = 65, file = "Thruster.ts"},["3458"] = {line = 23, file = "Thruster.ts"},["3459"] = {line = 24, file = "Thruster.ts"},["3460"] = {line = 27, file = "Thruster.ts"},["3461"] = {line = 28, file = "Thruster.ts"},["3462"] = {line = 29, file = "Thruster.ts"},["3463"] = {line = 30, file = "Thruster.ts"},["3464"] = {line = 31, file = "Thruster.ts"},["3465"] = {line = 66, file = "Thruster.ts"},["3466"] = {line = 67, file = "Thruster.ts"},["3467"] = {line = 68, file = "Thruster.ts"},["3468"] = {line = 69, file = "Thruster.ts"},["3469"] = {line = 71, file = "Thruster.ts"},["3470"] = {line = 72, file = "Thruster.ts"},["3471"] = {line = 65, file = "Thruster.ts"},["3472"] = {line = 34, file = "Thruster.ts"},["3473"] = {line = 37, file = "Thruster.ts"},["3474"] = {line = 38, file = "Thruster.ts"},["3475"] = {line = 39, file = "Thruster.ts"},["3477"] = {line = 41, file = "Thruster.ts"},["3478"] = {line = 34, file = "Thruster.ts"},["3479"] = {line = 43, file = "Thruster.ts"},["3480"] = {line = 45, file = "Thruster.ts"},["3481"] = {line = 43, file = "Thruster.ts"},["3482"] = {line = 48, file = "Thruster.ts"},["3485"] = {line = 60, file = "Thruster.ts"},["3486"] = {line = 61, file = "Thruster.ts"},["3489"] = {line = 51, file = "Thruster.ts"},["3490"] = {line = 51, file = "Thruster.ts"},["3492"] = {line = 52, file = "Thruster.ts"},["3493"] = {line = 53, file = "Thruster.ts"},["3494"] = {line = 53, file = "Thruster.ts"},["3495"] = {line = 53, file = "Thruster.ts"},["3497"] = {line = 55, file = "Thruster.ts"},["3498"] = {line = 56, file = "Thruster.ts"},["3499"] = {line = 56, file = "Thruster.ts"},["3500"] = {line = 56, file = "Thruster.ts"},["3502"] = {line = 57, file = "Thruster.ts"},["3508"] = {line = 50, file = "Thruster.ts"},["3511"] = {line = 48, file = "Thruster.ts"},["3523"] = {line = 1, file = "Recoverability.ts"},["3524"] = {line = 1, file = "Recoverability.ts"},["3525"] = {line = 1, file = "Recoverability.ts"},["3526"] = {line = 1, file = "Recoverability.ts"},["3527"] = {line = 1, file = "Recoverability.ts"},["3528"] = {line = 1, file = "Recoverability.ts"},["3529"] = {line = 1, file = "Recoverability.ts"},["3535"] = {line = 1, file = "SystemState.ts"},["3536"] = {line = 2, file = "SystemState.ts"},["3537"] = {line = 2, file = "SystemState.ts"},["3538"] = {line = 3, file = "SystemState.ts"},["3539"] = {line = 3, file = "SystemState.ts"},["3540"] = {line = 4, file = "SystemState.ts"},["3541"] = {line = 4, file = "SystemState.ts"},["3542"] = {line = 5, file = "SystemState.ts"},["3543"] = {line = 5, file = "SystemState.ts"},["3544"] = {line = 6, file = "SystemState.ts"},["3545"] = {line = 6, file = "SystemState.ts"},["3553"] = {line = 1, file = "Time.ts"},["3554"] = {line = 1, file = "Time.ts"},["3555"] = {line = 1, file = "Time.ts"},["3556"] = {line = 5, file = "Time.ts"},["3557"] = {line = 3, file = "Time.ts"},["3558"] = {line = 7, file = "Time.ts"},["3559"] = {line = 5, file = "Time.ts"},["3560"] = {line = 10, file = "Time.ts"},["3561"] = {line = 12, file = "Time.ts"},["3562"] = {line = 13, file = "Time.ts"},["3563"] = {line = 10, file = "Time.ts"},["3564"] = {line = 16, file = "Time.ts"},["3565"] = {line = 18, file = "Time.ts"},["3566"] = {line = 16, file = "Time.ts"},["3574"] = {line = 3, file = "Timer.ts"},["3575"] = {line = 3, file = "Timer.ts"},["3576"] = {line = 3, file = "Timer.ts"},["3577"] = {line = 8, file = "Timer.ts"},["3578"] = {line = 10, file = "Timer.ts"},["3579"] = {line = 11, file = "Timer.ts"},["3580"] = {line = 12, file = "Timer.ts"},["3581"] = {line = 8, file = "Timer.ts"},["3582"] = {line = 15, file = "Timer.ts"},["3583"] = {line = 17, file = "Timer.ts"},["3584"] = {line = 19, file = "Timer.ts"},["3586"] = {line = 21, file = "Timer.ts"},["3587"] = {line = 15, file = "Timer.ts"},["3597"] = {line = 18, file = "ReactionControlSystem.ts"},["3598"] = {line = 18, file = "ReactionControlSystem.ts"},["3599"] = {line = 19, file = "ReactionControlSystem.ts"},["3600"] = {line = 19, file = "ReactionControlSystem.ts"},["3601"] = {line = 21, file = "ReactionControlSystem.ts"},["3602"] = {line = 21, file = "ReactionControlSystem.ts"},["3603"] = {line = 21, file = "ReactionControlSystem.ts"},["3604"] = {line = 22, file = "ReactionControlSystem.ts"},["3605"] = {line = 22, file = "ReactionControlSystem.ts"},["3606"] = {line = 23, file = "ReactionControlSystem.ts"},["3607"] = {line = 23, file = "ReactionControlSystem.ts"},["3608"] = {line = 24, file = "ReactionControlSystem.ts"},["3609"] = {line = 24, file = "ReactionControlSystem.ts"},["3610"] = {line = 25, file = "ReactionControlSystem.ts"},["3611"] = {line = 25, file = "ReactionControlSystem.ts"},["3612"] = {line = 26, file = "ReactionControlSystem.ts"},["3613"] = {line = 26, file = "ReactionControlSystem.ts"},["3614"] = {line = 31, file = "ReactionControlSystem.ts"},["3615"] = {line = 31, file = "ReactionControlSystem.ts"},["3616"] = {line = 31, file = "ReactionControlSystem.ts"},["3617"] = {line = 31, file = "ReactionControlSystem.ts"},["3618"] = {line = 31, file = "ReactionControlSystem.ts"},["3619"] = {line = 31, file = "ReactionControlSystem.ts"},["3620"] = {line = 31, file = "ReactionControlSystem.ts"},["3621"] = {line = 37, file = "ReactionControlSystem.ts"},["3622"] = {line = 37, file = "ReactionControlSystem.ts"},["3623"] = {line = 37, file = "ReactionControlSystem.ts"},["3624"] = {line = 276, file = "ReactionControlSystem.ts"},["3625"] = {line = 38, file = "ReactionControlSystem.ts"},["3626"] = {line = 39, file = "ReactionControlSystem.ts"},["3627"] = {line = 40, file = "ReactionControlSystem.ts"},["3628"] = {line = 45, file = "ReactionControlSystem.ts"},["3629"] = {line = 46, file = "ReactionControlSystem.ts"},["3630"] = {line = 47, file = "ReactionControlSystem.ts"},["3631"] = {line = 48, file = "ReactionControlSystem.ts"},["3632"] = {line = 48, file = "ReactionControlSystem.ts"},["3633"] = {line = 48, file = "ReactionControlSystem.ts"},["3634"] = {line = 48, file = "ReactionControlSystem.ts"},["3635"] = {line = 48, file = "ReactionControlSystem.ts"},["3636"] = {line = 48, file = "ReactionControlSystem.ts"},["3637"] = {line = 48, file = "ReactionControlSystem.ts"},["3638"] = {line = 49, file = "ReactionControlSystem.ts"},["3639"] = {line = 49, file = "ReactionControlSystem.ts"},["3640"] = {line = 49, file = "ReactionControlSystem.ts"},["3641"] = {line = 49, file = "ReactionControlSystem.ts"},["3642"] = {line = 49, file = "ReactionControlSystem.ts"},["3643"] = {line = 49, file = "ReactionControlSystem.ts"},["3644"] = {line = 49, file = "ReactionControlSystem.ts"},["3645"] = {line = 277, file = "ReactionControlSystem.ts"},["3646"] = {line = 278, file = "ReactionControlSystem.ts"},["3647"] = {line = 279, file = "ReactionControlSystem.ts"},["3648"] = {line = 276, file = "ReactionControlSystem.ts"},["3649"] = {line = 51, file = "ReactionControlSystem.ts"},["3650"] = {line = 52, file = "ReactionControlSystem.ts"},["3651"] = {line = 51, file = "ReactionControlSystem.ts"},["3652"] = {line = 58, file = "ReactionControlSystem.ts"},["3653"] = {line = 63, file = "ReactionControlSystem.ts"},["3654"] = {line = 64, file = "ReactionControlSystem.ts"},["3655"] = {line = 64, file = "ReactionControlSystem.ts"},["3656"] = {line = 64, file = "ReactionControlSystem.ts"},["3659"] = {line = 66, file = "ReactionControlSystem.ts"},["3662"] = {line = 64, file = "ReactionControlSystem.ts"},["3663"] = {line = 64, file = "ReactionControlSystem.ts"},["3664"] = {line = 58, file = "ReactionControlSystem.ts"},["3665"] = {line = 71, file = "ReactionControlSystem.ts"},["3666"] = {line = 77, file = "ReactionControlSystem.ts"},["3667"] = {line = 81, file = "ReactionControlSystem.ts"},["3669"] = {line = 82, file = "ReactionControlSystem.ts"},["3670"] = {line = 83, file = "ReactionControlSystem.ts"},["3672"] = {line = 85, file = "ReactionControlSystem.ts"},["3673"] = {line = 71, file = "ReactionControlSystem.ts"},["3674"] = {line = 89, file = "ReactionControlSystem.ts"},["3675"] = {line = 96, file = "ReactionControlSystem.ts"},["3676"] = {line = 98, file = "ReactionControlSystem.ts"},["3677"] = {line = 100, file = "ReactionControlSystem.ts"},["3678"] = {line = 101, file = "ReactionControlSystem.ts"},["3679"] = {line = 102, file = "ReactionControlSystem.ts"},["3680"] = {line = 102, file = "ReactionControlSystem.ts"},["3681"] = {line = 102, file = "ReactionControlSystem.ts"},["3682"] = {line = 104, file = "ReactionControlSystem.ts"},["3683"] = {line = 105, file = "ReactionControlSystem.ts"},["3685"] = {line = 102, file = "ReactionControlSystem.ts"},["3686"] = {line = 102, file = "ReactionControlSystem.ts"},["3687"] = {line = 108, file = "ReactionControlSystem.ts"},["3688"] = {line = 108, file = "ReactionControlSystem.ts"},["3689"] = {line = 108, file = "ReactionControlSystem.ts"},["3690"] = {line = 110, file = "ReactionControlSystem.ts"},["3691"] = {line = 111, file = "ReactionControlSystem.ts"},["3693"] = {line = 108, file = "ReactionControlSystem.ts"},["3694"] = {line = 108, file = "ReactionControlSystem.ts"},["3695"] = {line = 115, file = "ReactionControlSystem.ts"},["3696"] = {line = 119, file = "ReactionControlSystem.ts"},["3698"] = {line = 122, file = "ReactionControlSystem.ts"},["3699"] = {line = 127, file = "ReactionControlSystem.ts"},["3700"] = {line = 128, file = "ReactionControlSystem.ts"},["3702"] = {line = 130, file = "ReactionControlSystem.ts"},["3703"] = {line = 89, file = "ReactionControlSystem.ts"},["3704"] = {line = 133, file = "ReactionControlSystem.ts"},["3705"] = {line = 134, file = "ReactionControlSystem.ts"},["3706"] = {line = 135, file = "ReactionControlSystem.ts"},["3707"] = {line = 136, file = "ReactionControlSystem.ts"},["3708"] = {line = 137, file = "ReactionControlSystem.ts"},["3710"] = {line = 133, file = "ReactionControlSystem.ts"},["3711"] = {line = 149, file = "ReactionControlSystem.ts"},["3712"] = {line = 150, file = "ReactionControlSystem.ts"},["3713"] = {line = 151, file = "ReactionControlSystem.ts"},["3714"] = {line = 152, file = "ReactionControlSystem.ts"},["3716"] = {line = 154, file = "ReactionControlSystem.ts"},["3717"] = {line = 155, file = "ReactionControlSystem.ts"},["3718"] = {line = 155, file = "ReactionControlSystem.ts"},["3719"] = {line = 155, file = "ReactionControlSystem.ts"},["3720"] = {line = 157, file = "ReactionControlSystem.ts"},["3721"] = {line = 158, file = "ReactionControlSystem.ts"},["3722"] = {line = 160, file = "ReactionControlSystem.ts"},["3724"] = {line = 162, file = "ReactionControlSystem.ts"},["3726"] = {line = 155, file = "ReactionControlSystem.ts"},["3727"] = {line = 155, file = "ReactionControlSystem.ts"},["3728"] = {line = 165, file = "ReactionControlSystem.ts"},["3729"] = {line = 166, file = "ReactionControlSystem.ts"},["3731"] = {line = 168, file = "ReactionControlSystem.ts"},["3732"] = {line = 149, file = "ReactionControlSystem.ts"},["3733"] = {line = 171, file = "ReactionControlSystem.ts"},["3734"] = {line = 175, file = "ReactionControlSystem.ts"},["3735"] = {line = 179, file = "ReactionControlSystem.ts"},["3736"] = {line = 183, file = "ReactionControlSystem.ts"},["3737"] = {line = 171, file = "ReactionControlSystem.ts"},["3738"] = {line = 186, file = "ReactionControlSystem.ts"},["3739"] = {line = 193, file = "ReactionControlSystem.ts"},["3740"] = {line = 195, file = "ReactionControlSystem.ts"},["3741"] = {line = 186, file = "ReactionControlSystem.ts"},["3742"] = {line = 198, file = "ReactionControlSystem.ts"},["3743"] = {line = 208, file = "ReactionControlSystem.ts"},["3744"] = {line = 209, file = "ReactionControlSystem.ts"},["3745"] = {line = 210, file = "ReactionControlSystem.ts"},["3748"] = {line = 214, file = "ReactionControlSystem.ts"},["3749"] = {line = 216, file = "ReactionControlSystem.ts"},["3750"] = {line = 222, file = "ReactionControlSystem.ts"},["3751"] = {line = 223, file = "ReactionControlSystem.ts"},["3752"] = {line = 224, file = "ReactionControlSystem.ts"},["3753"] = {line = 225, file = "ReactionControlSystem.ts"},["3754"] = {line = 226, file = "ReactionControlSystem.ts"},["3755"] = {line = 230, file = "ReactionControlSystem.ts"},["3756"] = {line = 231, file = "ReactionControlSystem.ts"},["3758"] = {line = 236, file = "ReactionControlSystem.ts"},["3761"] = {line = 241, file = "ReactionControlSystem.ts"},["3764"] = {line = 239, file = "ReactionControlSystem.ts"},["3770"] = {line = 198, file = "ReactionControlSystem.ts"},["3771"] = {line = 245, file = "ReactionControlSystem.ts"},["3772"] = {line = 250, file = "ReactionControlSystem.ts"},["3774"] = {line = 251, file = "ReactionControlSystem.ts"},["3778"] = {line = 256, file = "ReactionControlSystem.ts"},["3781"] = {line = 259, file = "ReactionControlSystem.ts"},["3784"] = {line = 263, file = "ReactionControlSystem.ts"},["3785"] = {line = 265, file = "ReactionControlSystem.ts"},["3786"] = {line = 266, file = "ReactionControlSystem.ts"},["3787"] = {line = 267, file = "ReactionControlSystem.ts"},["3788"] = {line = 268, file = "ReactionControlSystem.ts"},["3789"] = {line = 270, file = "ReactionControlSystem.ts"},["3790"] = {line = 270, file = "ReactionControlSystem.ts"},["3791"] = {line = 270, file = "ReactionControlSystem.ts"},["3792"] = {line = 272, file = "ReactionControlSystem.ts"},["3793"] = {line = 270, file = "ReactionControlSystem.ts"},["3794"] = {line = 270, file = "ReactionControlSystem.ts"},["3795"] = {line = 245, file = "ReactionControlSystem.ts"},["3804"] = {line = 14, file = "StabilityAugmentationSystem.ts"},["3805"] = {line = 14, file = "StabilityAugmentationSystem.ts"},["3806"] = {line = 15, file = "StabilityAugmentationSystem.ts"},["3807"] = {line = 15, file = "StabilityAugmentationSystem.ts"},["3808"] = {line = 16, file = "StabilityAugmentationSystem.ts"},["3809"] = {line = 16, file = "StabilityAugmentationSystem.ts"},["3810"] = {line = 18, file = "StabilityAugmentationSystem.ts"},["3811"] = {line = 18, file = "StabilityAugmentationSystem.ts"},["3812"] = {line = 19, file = "StabilityAugmentationSystem.ts"},["3813"] = {line = 19, file = "StabilityAugmentationSystem.ts"},["3814"] = {line = 22, file = "StabilityAugmentationSystem.ts"},["3815"] = {line = 22, file = "StabilityAugmentationSystem.ts"},["3816"] = {line = 23, file = "StabilityAugmentationSystem.ts"},["3817"] = {line = 23, file = "StabilityAugmentationSystem.ts"},["3818"] = {line = 23, file = "StabilityAugmentationSystem.ts"},["3819"] = {line = 26, file = "StabilityAugmentationSystem.ts"},["3820"] = {line = 26, file = "StabilityAugmentationSystem.ts"},["3821"] = {line = 26, file = "StabilityAugmentationSystem.ts"},["3822"] = {line = 26, file = "StabilityAugmentationSystem.ts"},["3823"] = {line = 26, file = "StabilityAugmentationSystem.ts"},["3824"] = {line = 26, file = "StabilityAugmentationSystem.ts"},["3825"] = {line = 26, file = "StabilityAugmentationSystem.ts"},["3826"] = {line = 31, file = "StabilityAugmentationSystem.ts"},["3827"] = {line = 31, file = "StabilityAugmentationSystem.ts"},["3828"] = {line = 31, file = "StabilityAugmentationSystem.ts"},["3829"] = {line = 31, file = "StabilityAugmentationSystem.ts"},["3830"] = {line = 31, file = "StabilityAugmentationSystem.ts"},["3831"] = {line = 36, file = "StabilityAugmentationSystem.ts"},["3832"] = {line = 36, file = "StabilityAugmentationSystem.ts"},["3833"] = {line = 36, file = "StabilityAugmentationSystem.ts"},["3834"] = {line = 351, file = "StabilityAugmentationSystem.ts"},["3835"] = {line = 40, file = "StabilityAugmentationSystem.ts"},["3836"] = {line = 41, file = "StabilityAugmentationSystem.ts"},["3837"] = {line = 48, file = "StabilityAugmentationSystem.ts"},["3838"] = {line = 49, file = "StabilityAugmentationSystem.ts"},["3839"] = {line = 50, file = "StabilityAugmentationSystem.ts"},["3840"] = {line = 352, file = "StabilityAugmentationSystem.ts"},["3841"] = {line = 353, file = "StabilityAugmentationSystem.ts"},["3842"] = {line = 354, file = "StabilityAugmentationSystem.ts"},["3843"] = {line = 355, file = "StabilityAugmentationSystem.ts"},["3844"] = {line = 355, file = "StabilityAugmentationSystem.ts"},["3845"] = {line = 356, file = "StabilityAugmentationSystem.ts"},["3846"] = {line = 357, file = "StabilityAugmentationSystem.ts"},["3847"] = {line = 358, file = "StabilityAugmentationSystem.ts"},["3848"] = {line = 359, file = "StabilityAugmentationSystem.ts"},["3849"] = {line = 360, file = "StabilityAugmentationSystem.ts"},["3850"] = {line = 355, file = "StabilityAugmentationSystem.ts"},["3851"] = {line = 362, file = "StabilityAugmentationSystem.ts"},["3852"] = {line = 362, file = "StabilityAugmentationSystem.ts"},["3853"] = {line = 363, file = "StabilityAugmentationSystem.ts"},["3854"] = {line = 364, file = "StabilityAugmentationSystem.ts"},["3855"] = {line = 365, file = "StabilityAugmentationSystem.ts"},["3856"] = {line = 366, file = "StabilityAugmentationSystem.ts"},["3857"] = {line = 367, file = "StabilityAugmentationSystem.ts"},["3858"] = {line = 362, file = "StabilityAugmentationSystem.ts"},["3859"] = {line = 351, file = "StabilityAugmentationSystem.ts"},["3860"] = {line = 54, file = "StabilityAugmentationSystem.ts"},["3861"] = {line = 55, file = "StabilityAugmentationSystem.ts"},["3862"] = {line = 56, file = "StabilityAugmentationSystem.ts"},["3863"] = {line = 57, file = "StabilityAugmentationSystem.ts"},["3866"] = {line = 64, file = "StabilityAugmentationSystem.ts"},["3867"] = {line = 68, file = "StabilityAugmentationSystem.ts"},["3870"] = {line = 60, file = "StabilityAugmentationSystem.ts"},["3871"] = {line = 61, file = "StabilityAugmentationSystem.ts"},["3872"] = {line = 62, file = "StabilityAugmentationSystem.ts"},["3878"] = {line = 58, file = "StabilityAugmentationSystem.ts"},["3883"] = {line = 74, file = "StabilityAugmentationSystem.ts"},["3884"] = {line = 75, file = "StabilityAugmentationSystem.ts"},["3887"] = {line = 71, file = "StabilityAugmentationSystem.ts"},["3888"] = {line = 72, file = "StabilityAugmentationSystem.ts"},["3894"] = {line = 70, file = "StabilityAugmentationSystem.ts"},["3897"] = {line = 78, file = "StabilityAugmentationSystem.ts"},["3898"] = {line = 79, file = "StabilityAugmentationSystem.ts"},["3899"] = {line = 80, file = "StabilityAugmentationSystem.ts"},["3901"] = {line = 82, file = "StabilityAugmentationSystem.ts"},["3902"] = {line = 83, file = "StabilityAugmentationSystem.ts"},["3903"] = {line = 54, file = "StabilityAugmentationSystem.ts"},["3904"] = {line = 86, file = "StabilityAugmentationSystem.ts"},["3905"] = {line = 90, file = "StabilityAugmentationSystem.ts"},["3906"] = {line = 91, file = "StabilityAugmentationSystem.ts"},["3907"] = {line = 92, file = "StabilityAugmentationSystem.ts"},["3909"] = {line = 94, file = "StabilityAugmentationSystem.ts"},["3910"] = {line = 86, file = "StabilityAugmentationSystem.ts"},["3911"] = {line = 97, file = "StabilityAugmentationSystem.ts"},["3912"] = {line = 104, file = "StabilityAugmentationSystem.ts"},["3913"] = {line = 105, file = "StabilityAugmentationSystem.ts"},["3914"] = {line = 106, file = "StabilityAugmentationSystem.ts"},["3916"] = {line = 109, file = "StabilityAugmentationSystem.ts"},["3917"] = {line = 110, file = "StabilityAugmentationSystem.ts"},["3918"] = {line = 111, file = "StabilityAugmentationSystem.ts"},["3920"] = {line = 113, file = "StabilityAugmentationSystem.ts"},["3921"] = {line = 114, file = "StabilityAugmentationSystem.ts"},["3923"] = {line = 116, file = "StabilityAugmentationSystem.ts"},["3925"] = {line = 97, file = "StabilityAugmentationSystem.ts"},["3926"] = {line = 119, file = "StabilityAugmentationSystem.ts"},["3927"] = {line = 120, file = "StabilityAugmentationSystem.ts"},["3928"] = {line = 121, file = "StabilityAugmentationSystem.ts"},["3929"] = {line = 122, file = "StabilityAugmentationSystem.ts"},["3930"] = {line = 123, file = "StabilityAugmentationSystem.ts"},["3931"] = {line = 126, file = "StabilityAugmentationSystem.ts"},["3933"] = {line = 128, file = "StabilityAugmentationSystem.ts"},["3935"] = {line = 129, file = "StabilityAugmentationSystem.ts"},["3939"] = {line = 131, file = "StabilityAugmentationSystem.ts"},["3940"] = {line = 132, file = "StabilityAugmentationSystem.ts"},["3941"] = {line = 133, file = "StabilityAugmentationSystem.ts"},["3942"] = {line = 134, file = "StabilityAugmentationSystem.ts"},["3944"] = {line = 136, file = "StabilityAugmentationSystem.ts"},["3945"] = {line = 137, file = "StabilityAugmentationSystem.ts"},["3946"] = {line = 119, file = "StabilityAugmentationSystem.ts"},["3947"] = {line = 141, file = "StabilityAugmentationSystem.ts"},["3948"] = {line = 146, file = "StabilityAugmentationSystem.ts"},["3949"] = {line = 148, file = "StabilityAugmentationSystem.ts"},["3950"] = {line = 149, file = "StabilityAugmentationSystem.ts"},["3951"] = {line = 150, file = "StabilityAugmentationSystem.ts"},["3953"] = {line = 152, file = "StabilityAugmentationSystem.ts"},["3954"] = {line = 153, file = "StabilityAugmentationSystem.ts"},["3956"] = {line = 155, file = "StabilityAugmentationSystem.ts"},["3957"] = {line = 141, file = "StabilityAugmentationSystem.ts"},["3958"] = {line = 158, file = "StabilityAugmentationSystem.ts"},["3959"] = {line = 159, file = "StabilityAugmentationSystem.ts"},["3960"] = {line = 158, file = "StabilityAugmentationSystem.ts"},["3961"] = {line = 162, file = "StabilityAugmentationSystem.ts"},["3962"] = {line = 164, file = "StabilityAugmentationSystem.ts"},["3963"] = {line = 165, file = "StabilityAugmentationSystem.ts"},["3964"] = {line = 167, file = "StabilityAugmentationSystem.ts"},["3965"] = {line = 168, file = "StabilityAugmentationSystem.ts"},["3966"] = {line = 174, file = "StabilityAugmentationSystem.ts"},["3967"] = {line = 176, file = "StabilityAugmentationSystem.ts"},["3968"] = {line = 177, file = "StabilityAugmentationSystem.ts"},["3969"] = {line = 179, file = "StabilityAugmentationSystem.ts"},["3971"] = {line = 182, file = "StabilityAugmentationSystem.ts"},["3972"] = {line = 183, file = "StabilityAugmentationSystem.ts"},["3974"] = {line = 185, file = "StabilityAugmentationSystem.ts"},["3976"] = {line = 162, file = "StabilityAugmentationSystem.ts"},["3977"] = {line = 189, file = "StabilityAugmentationSystem.ts"},["3978"] = {line = 194, file = "StabilityAugmentationSystem.ts"},["3979"] = {line = 195, file = "StabilityAugmentationSystem.ts"},["3980"] = {line = 197, file = "StabilityAugmentationSystem.ts"},["3982"] = {line = 199, file = "StabilityAugmentationSystem.ts"},["3983"] = {line = 189, file = "StabilityAugmentationSystem.ts"},["3984"] = {line = 202, file = "StabilityAugmentationSystem.ts"},["3985"] = {line = 207, file = "StabilityAugmentationSystem.ts"},["3986"] = {line = 202, file = "StabilityAugmentationSystem.ts"},["3987"] = {line = 213, file = "StabilityAugmentationSystem.ts"},["3988"] = {line = 214, file = "StabilityAugmentationSystem.ts"},["3989"] = {line = 215, file = "StabilityAugmentationSystem.ts"},["3990"] = {line = 217, file = "StabilityAugmentationSystem.ts"},["3991"] = {line = 219, file = "StabilityAugmentationSystem.ts"},["3992"] = {line = 220, file = "StabilityAugmentationSystem.ts"},["3993"] = {line = 220, file = "StabilityAugmentationSystem.ts"},["3994"] = {line = 220, file = "StabilityAugmentationSystem.ts"},["3995"] = {line = 220, file = "StabilityAugmentationSystem.ts"},["3996"] = {line = 220, file = "StabilityAugmentationSystem.ts"},["3997"] = {line = 220, file = "StabilityAugmentationSystem.ts"},["3998"] = {line = 220, file = "StabilityAugmentationSystem.ts"},["4000"] = {line = 223, file = "StabilityAugmentationSystem.ts"},["4001"] = {line = 224, file = "StabilityAugmentationSystem.ts"},["4002"] = {line = 225, file = "StabilityAugmentationSystem.ts"},["4003"] = {line = 227, file = "StabilityAugmentationSystem.ts"},["4004"] = {line = 228, file = "StabilityAugmentationSystem.ts"},["4005"] = {line = 231, file = "StabilityAugmentationSystem.ts"},["4006"] = {line = 232, file = "StabilityAugmentationSystem.ts"},["4007"] = {line = 233, file = "StabilityAugmentationSystem.ts"},["4008"] = {line = 235, file = "StabilityAugmentationSystem.ts"},["4009"] = {line = 236, file = "StabilityAugmentationSystem.ts"},["4010"] = {line = 237, file = "StabilityAugmentationSystem.ts"},["4011"] = {line = 238, file = "StabilityAugmentationSystem.ts"},["4012"] = {line = 240, file = "StabilityAugmentationSystem.ts"},["4013"] = {line = 241, file = "StabilityAugmentationSystem.ts"},["4014"] = {line = 243, file = "StabilityAugmentationSystem.ts"},["4016"] = {line = 246, file = "StabilityAugmentationSystem.ts"},["4017"] = {line = 247, file = "StabilityAugmentationSystem.ts"},["4019"] = {line = 249, file = "StabilityAugmentationSystem.ts"},["4021"] = {line = 213, file = "StabilityAugmentationSystem.ts"},["4022"] = {line = 257, file = "StabilityAugmentationSystem.ts"},["4023"] = {line = 258, file = "StabilityAugmentationSystem.ts"},["4024"] = {line = 259, file = "StabilityAugmentationSystem.ts"},["4025"] = {line = 257, file = "StabilityAugmentationSystem.ts"},["4026"] = {line = 262, file = "StabilityAugmentationSystem.ts"},["4027"] = {line = 263, file = "StabilityAugmentationSystem.ts"},["4028"] = {line = 264, file = "StabilityAugmentationSystem.ts"},["4031"] = {line = 267, file = "StabilityAugmentationSystem.ts"},["4032"] = {line = 268, file = "StabilityAugmentationSystem.ts"},["4033"] = {line = 262, file = "StabilityAugmentationSystem.ts"},["4034"] = {line = 271, file = "StabilityAugmentationSystem.ts"},["4035"] = {line = 275, file = "StabilityAugmentationSystem.ts"},["4036"] = {line = 276, file = "StabilityAugmentationSystem.ts"},["4037"] = {line = 271, file = "StabilityAugmentationSystem.ts"},["4038"] = {line = 278, file = "StabilityAugmentationSystem.ts"},["4039"] = {line = 279, file = "StabilityAugmentationSystem.ts"},["4040"] = {line = 280, file = "StabilityAugmentationSystem.ts"},["4041"] = {line = 278, file = "StabilityAugmentationSystem.ts"},["4042"] = {line = 287, file = "StabilityAugmentationSystem.ts"},["4043"] = {line = 288, file = "StabilityAugmentationSystem.ts"},["4044"] = {line = 289, file = "StabilityAugmentationSystem.ts"},["4045"] = {line = 290, file = "StabilityAugmentationSystem.ts"},["4046"] = {line = 291, file = "StabilityAugmentationSystem.ts"},["4048"] = {line = 293, file = "StabilityAugmentationSystem.ts"},["4049"] = {line = 294, file = "StabilityAugmentationSystem.ts"},["4050"] = {line = 295, file = "StabilityAugmentationSystem.ts"},["4053"] = {line = 287, file = "StabilityAugmentationSystem.ts"},["4054"] = {line = 300, file = "StabilityAugmentationSystem.ts"},["4055"] = {line = 305, file = "StabilityAugmentationSystem.ts"},["4057"] = {line = 306, file = "StabilityAugmentationSystem.ts"},["4061"] = {line = 308, file = "StabilityAugmentationSystem.ts"},["4062"] = {line = 309, file = "StabilityAugmentationSystem.ts"},["4065"] = {line = 312, file = "StabilityAugmentationSystem.ts"},["4066"] = {line = 313, file = "StabilityAugmentationSystem.ts"},["4067"] = {line = 314, file = "StabilityAugmentationSystem.ts"},["4068"] = {line = 314, file = "StabilityAugmentationSystem.ts"},["4069"] = {line = 314, file = "StabilityAugmentationSystem.ts"},["4070"] = {line = 314, file = "StabilityAugmentationSystem.ts"},["4072"] = {line = 317, file = "StabilityAugmentationSystem.ts"},["4073"] = {line = 319, file = "StabilityAugmentationSystem.ts"},["4074"] = {line = 322, file = "StabilityAugmentationSystem.ts"},["4075"] = {line = 323, file = "StabilityAugmentationSystem.ts"},["4076"] = {line = 325, file = "StabilityAugmentationSystem.ts"},["4077"] = {line = 328, file = "StabilityAugmentationSystem.ts"},["4079"] = {line = 332, file = "StabilityAugmentationSystem.ts"},["4080"] = {line = 334, file = "StabilityAugmentationSystem.ts"},["4082"] = {line = 337, file = "StabilityAugmentationSystem.ts"},["4083"] = {line = 340, file = "StabilityAugmentationSystem.ts"},["4085"] = {line = 342, file = "StabilityAugmentationSystem.ts"},["4086"] = {line = 343, file = "StabilityAugmentationSystem.ts"},["4089"] = {line = 347, file = "StabilityAugmentationSystem.ts"},["4092"] = {line = 345, file = "StabilityAugmentationSystem.ts"},["4098"] = {line = 300, file = "StabilityAugmentationSystem.ts"},["4113"] = {line = 6, file = "FlightManagementSystem.ts"},["4114"] = {line = 6, file = "FlightManagementSystem.ts"},["4115"] = {line = 7, file = "FlightManagementSystem.ts"},["4116"] = {line = 7, file = "FlightManagementSystem.ts"},["4117"] = {line = 10, file = "FlightManagementSystem.ts"},["4118"] = {line = 10, file = "FlightManagementSystem.ts"},["4119"] = {line = 11, file = "FlightManagementSystem.ts"},["4120"] = {line = 11, file = "FlightManagementSystem.ts"},["4121"] = {line = 13, file = "FlightManagementSystem.ts"},["4122"] = {line = 13, file = "FlightManagementSystem.ts"},["4123"] = {line = 14, file = "FlightManagementSystem.ts"},["4124"] = {line = 14, file = "FlightManagementSystem.ts"},["4125"] = {line = 14, file = "FlightManagementSystem.ts"},["4126"] = {line = 15, file = "FlightManagementSystem.ts"},["4127"] = {line = 15, file = "FlightManagementSystem.ts"},["4128"] = {line = 16, file = "FlightManagementSystem.ts"},["4129"] = {line = 16, file = "FlightManagementSystem.ts"},["4130"] = {line = 18, file = "FlightManagementSystem.ts"},["4131"] = {line = 18, file = "FlightManagementSystem.ts"},["4132"] = {line = 18, file = "FlightManagementSystem.ts"},["4133"] = {line = 18, file = "FlightManagementSystem.ts"},["4134"] = {line = 18, file = "FlightManagementSystem.ts"},["4135"] = {line = 18, file = "FlightManagementSystem.ts"},["4136"] = {line = 18, file = "FlightManagementSystem.ts"},["4137"] = {line = 18, file = "FlightManagementSystem.ts"},["4138"] = {line = 18, file = "FlightManagementSystem.ts"},["4139"] = {line = 18, file = "FlightManagementSystem.ts"},["4140"] = {line = 18, file = "FlightManagementSystem.ts"},["4141"] = {line = 26, file = "FlightManagementSystem.ts"},["4142"] = {line = 26, file = "FlightManagementSystem.ts"},["4143"] = {line = 26, file = "FlightManagementSystem.ts"},["4144"] = {line = 73, file = "FlightManagementSystem.ts"},["4145"] = {line = 27, file = "FlightManagementSystem.ts"},["4146"] = {line = 38, file = "FlightManagementSystem.ts"},["4147"] = {line = 39, file = "FlightManagementSystem.ts"},["4148"] = {line = 40, file = "FlightManagementSystem.ts"},["4149"] = {line = 74, file = "FlightManagementSystem.ts"},["4150"] = {line = 75, file = "FlightManagementSystem.ts"},["4151"] = {line = 76, file = "FlightManagementSystem.ts"},["4152"] = {line = 77, file = "FlightManagementSystem.ts"},["4153"] = {line = 78, file = "FlightManagementSystem.ts"},["4154"] = {line = 73, file = "FlightManagementSystem.ts"},["4155"] = {line = 41, file = "FlightManagementSystem.ts"},["4156"] = {line = 46, file = "FlightManagementSystem.ts"},["4157"] = {line = 47, file = "FlightManagementSystem.ts"},["4158"] = {line = 49, file = "FlightManagementSystem.ts"},["4161"] = {line = 52, file = "FlightManagementSystem.ts"},["4162"] = {line = 53, file = "FlightManagementSystem.ts"},["4163"] = {line = 41, file = "FlightManagementSystem.ts"},["4164"] = {line = 56, file = "FlightManagementSystem.ts"},["4165"] = {line = 58, file = "FlightManagementSystem.ts"},["4166"] = {line = 59, file = "FlightManagementSystem.ts"},["4167"] = {line = 60, file = "FlightManagementSystem.ts"},["4169"] = {line = 63, file = "FlightManagementSystem.ts"},["4170"] = {line = 64, file = "FlightManagementSystem.ts"},["4171"] = {line = 65, file = "FlightManagementSystem.ts"},["4172"] = {line = 66, file = "FlightManagementSystem.ts"},["4173"] = {line = 67, file = "FlightManagementSystem.ts"},["4175"] = {line = 70, file = "FlightManagementSystem.ts"},["4176"] = {line = 56, file = "FlightManagementSystem.ts"},["4177"] = {line = 81, file = "FlightManagementSystem.ts"},["4178"] = {line = 83, file = "FlightManagementSystem.ts"},["4179"] = {line = 81, file = "FlightManagementSystem.ts"},["4180"] = {line = 86, file = "FlightManagementSystem.ts"},["4181"] = {line = 88, file = "FlightManagementSystem.ts"},["4182"] = {line = 89, file = "FlightManagementSystem.ts"},["4183"] = {line = 90, file = "FlightManagementSystem.ts"},["4184"] = {line = 90, file = "FlightManagementSystem.ts"},["4185"] = {line = 90, file = "FlightManagementSystem.ts"},["4186"] = {line = 90, file = "FlightManagementSystem.ts"},["4187"] = {line = 88, file = "FlightManagementSystem.ts"},["4188"] = {line = 92, file = "FlightManagementSystem.ts"},["4191"] = {line = 96, file = "FlightManagementSystem.ts"},["4192"] = {line = 97, file = "FlightManagementSystem.ts"},["4195"] = {line = 94, file = "FlightManagementSystem.ts"},["4202"] = {line = 100, file = "FlightManagementSystem.ts"},["4204"] = {line = 103, file = "FlightManagementSystem.ts"},["4205"] = {line = 104, file = "FlightManagementSystem.ts"},["4206"] = {line = 105, file = "FlightManagementSystem.ts"},["4207"] = {line = 86, file = "FlightManagementSystem.ts"},["4208"] = {line = 107, file = "FlightManagementSystem.ts"},["4209"] = {line = 108, file = "FlightManagementSystem.ts"},["4210"] = {line = 109, file = "FlightManagementSystem.ts"},["4212"] = {line = 107, file = "FlightManagementSystem.ts"},["4213"] = {line = 113, file = "FlightManagementSystem.ts"},["4214"] = {line = 114, file = "FlightManagementSystem.ts"},["4215"] = {line = 115, file = "FlightManagementSystem.ts"},["4217"] = {line = 116, file = "FlightManagementSystem.ts"},["4221"] = {line = 118, file = "FlightManagementSystem.ts"},["4222"] = {line = 113, file = "FlightManagementSystem.ts"},["4230"] = {line = 11, file = "CrisisManagementSystem.ts"},["4231"] = {line = 11, file = "CrisisManagementSystem.ts"},["4232"] = {line = 15, file = "CrisisManagementSystem.ts"},["4233"] = {line = 17, file = "CrisisManagementSystem.ts"},["4234"] = {line = 17, file = "CrisisManagementSystem.ts"},["4235"] = {line = 18, file = "CrisisManagementSystem.ts"},["4236"] = {line = 18, file = "CrisisManagementSystem.ts"},["4237"] = {line = 19, file = "CrisisManagementSystem.ts"},["4238"] = {line = 19, file = "CrisisManagementSystem.ts"},["4239"] = {line = 22, file = "CrisisManagementSystem.ts"},["4240"] = {line = 24, file = "CrisisManagementSystem.ts"},["4241"] = {line = 24, file = "CrisisManagementSystem.ts"},["4242"] = {line = 25, file = "CrisisManagementSystem.ts"},["4243"] = {line = 25, file = "CrisisManagementSystem.ts"},["4244"] = {line = 28, file = "CrisisManagementSystem.ts"},["4245"] = {line = 28, file = "CrisisManagementSystem.ts"},["4246"] = {line = 28, file = "CrisisManagementSystem.ts"},["4247"] = {line = 83, file = "CrisisManagementSystem.ts"},["4248"] = {line = 85, file = "CrisisManagementSystem.ts"},["4249"] = {line = 86, file = "CrisisManagementSystem.ts"},["4250"] = {line = 83, file = "CrisisManagementSystem.ts"},["4251"] = {line = 34, file = "CrisisManagementSystem.ts"},["4252"] = {line = 34, file = "CrisisManagementSystem.ts"},["4253"] = {line = 40, file = "CrisisManagementSystem.ts"},["4254"] = {line = 40, file = "CrisisManagementSystem.ts"},["4255"] = {line = 47, file = "CrisisManagementSystem.ts"},["4257"] = {line = 54, file = "CrisisManagementSystem.ts"},["4258"] = {line = 56, file = "CrisisManagementSystem.ts"},["4261"] = {line = 58, file = "CrisisManagementSystem.ts"},["4265"] = {line = 61, file = "CrisisManagementSystem.ts"},["4268"] = {line = 63, file = "CrisisManagementSystem.ts"},["4274"] = {line = 68, file = "CrisisManagementSystem.ts"},["4279"] = {line = 47, file = "CrisisManagementSystem.ts"},["4280"] = {line = 73, file = "CrisisManagementSystem.ts"},["4281"] = {line = 73, file = "CrisisManagementSystem.ts"},["4282"] = {line = 78, file = "CrisisManagementSystem.ts"},["4283"] = {line = 78, file = "CrisisManagementSystem.ts"},["4295"] = {line = 5, file = "drone.ts"},["4296"] = {line = 5, file = "drone.ts"},["4297"] = {line = 6, file = "drone.ts"},["4298"] = {line = 6, file = "drone.ts"},["4299"] = {line = 7, file = "drone.ts"},["4300"] = {line = 7, file = "drone.ts"},["4301"] = {line = 8, file = "drone.ts"},["4302"] = {line = 8, file = "drone.ts"},["4303"] = {line = 10, file = "drone.ts"},["4304"] = {line = 11, file = "drone.ts"},["4305"] = {line = 11, file = "drone.ts"},["4306"] = {line = 11, file = "drone.ts"},["4307"] = {line = 11, file = "drone.ts"},["4308"] = {line = 11, file = "drone.ts"},["4309"] = {line = 11, file = "drone.ts"},["4310"] = {line = 11, file = "drone.ts"},["4311"] = {line = 12, file = "drone.ts"},["4312"] = {line = 12, file = "drone.ts"},["4313"] = {line = 12, file = "drone.ts"},["4314"] = {line = 12, file = "drone.ts"},["4315"] = {line = 12, file = "drone.ts"},["4316"] = {line = 12, file = "drone.ts"},["4317"] = {line = 12, file = "drone.ts"},["4318"] = {line = 13, file = "drone.ts"},["4319"] = {line = 14, file = "drone.ts"},["4320"] = {line = 15, file = "drone.ts"},["4321"] = {line = 15, file = "drone.ts"},["4322"] = {line = 15, file = "drone.ts"},["4323"] = {line = 15, file = "drone.ts"},["4324"] = {line = 16, file = "drone.ts"},["4325"] = {line = 17, file = "drone.ts"},["4326"] = {line = 19, file = "drone.ts"},["4327"] = {line = 20, file = "drone.ts"},["4328"] = {line = 21, file = "drone.ts"},["4329"] = {line = 22, file = "drone.ts"},["4330"] = {line = 23, file = "drone.ts"},["4331"] = {line = 24, file = "drone.ts"},["4332"] = {line = 25, file = "drone.ts"},["4333"] = {line = 25, file = "drone.ts"},["4334"] = {line = 26, file = "drone.ts"},["4335"] = {line = 27, file = "drone.ts"},["4336"] = {line = 28, file = "drone.ts"},["4337"] = {line = 29, file = "drone.ts"},["4338"] = {line = 25, file = "drone.ts"},["4339"] = {line = 31, file = "drone.ts"},["4340"] = {line = 31, file = "drone.ts"},["4341"] = {line = 32, file = "drone.ts"},["4342"] = {line = 33, file = "drone.ts"},["4343"] = {line = 34, file = "drone.ts"},["4344"] = {line = 35, file = "drone.ts"},["4345"] = {line = 31, file = "drone.ts"},["4346"] = {line = 37, file = "drone.ts"},["4347"] = {line = 37, file = "drone.ts"},["4348"] = {line = 38, file = "drone.ts"},["4349"] = {line = 39, file = "drone.ts"},["4350"] = {line = 40, file = "drone.ts"},["4351"] = {line = 41, file = "drone.ts"},["4352"] = {line = 37, file = "drone.ts"},["4353"] = {line = 43, file = "drone.ts"},["4354"] = {line = 43, file = "drone.ts"},["4355"] = {line = 44, file = "drone.ts"},["4356"] = {line = 45, file = "drone.ts"},["4357"] = {line = 46, file = "drone.ts"},["4358"] = {line = 47, file = "drone.ts"},["4359"] = {line = 43, file = "drone.ts"},["4360"] = {line = 50, file = "drone.ts"},["4361"] = {line = 50, file = "drone.ts"},["4362"] = {line = 51, file = "drone.ts"},["4363"] = {line = 52, file = "drone.ts"},["4364"] = {line = 53, file = "drone.ts"},["4365"] = {line = 54, file = "drone.ts"},["4366"] = {line = 50, file = "drone.ts"},["4367"] = {line = 56, file = "drone.ts"},["4368"] = {line = 56, file = "drone.ts"},["4369"] = {line = 57, file = "drone.ts"},["4370"] = {line = 58, file = "drone.ts"},["4371"] = {line = 59, file = "drone.ts"},["4372"] = {line = 60, file = "drone.ts"},["4373"] = {line = 56, file = "drone.ts"},["4374"] = {line = 62, file = "drone.ts"},["4375"] = {line = 62, file = "drone.ts"},["4376"] = {line = 63, file = "drone.ts"},["4377"] = {line = 64, file = "drone.ts"},["4378"] = {line = 65, file = "drone.ts"},["4379"] = {line = 66, file = "drone.ts"},["4380"] = {line = 62, file = "drone.ts"},["4381"] = {line = 68, file = "drone.ts"},["4382"] = {line = 68, file = "drone.ts"},["4383"] = {line = 69, file = "drone.ts"},["4384"] = {line = 70, file = "drone.ts"},["4385"] = {line = 71, file = "drone.ts"},["4386"] = {line = 72, file = "drone.ts"},["4387"] = {line = 68, file = "drone.ts"},["4388"] = {line = 75, file = "drone.ts"},["4389"] = {line = 75, file = "drone.ts"},["4390"] = {line = 76, file = "drone.ts"},["4391"] = {line = 77, file = "drone.ts"},["4392"] = {line = 78, file = "drone.ts"},["4393"] = {line = 79, file = "drone.ts"},["4394"] = {line = 75, file = "drone.ts"},["4395"] = {line = 81, file = "drone.ts"},["4396"] = {line = 81, file = "drone.ts"},["4397"] = {line = 82, file = "drone.ts"},["4398"] = {line = 83, file = "drone.ts"},["4399"] = {line = 84, file = "drone.ts"},["4400"] = {line = 85, file = "drone.ts"},["4401"] = {line = 81, file = "drone.ts"},["4402"] = {line = 87, file = "drone.ts"},["4403"] = {line = 87, file = "drone.ts"},["4404"] = {line = 88, file = "drone.ts"},["4405"] = {line = 89, file = "drone.ts"},["4406"] = {line = 90, file = "drone.ts"},["4407"] = {line = 91, file = "drone.ts"},["4408"] = {line = 87, file = "drone.ts"},["4409"] = {line = 93, file = "drone.ts"},["4410"] = {line = 93, file = "drone.ts"},["4411"] = {line = 94, file = "drone.ts"},["4412"] = {line = 95, file = "drone.ts"},["4413"] = {line = 96, file = "drone.ts"},["4414"] = {line = 97, file = "drone.ts"},["4415"] = {line = 93, file = "drone.ts"},["4416"] = {line = 100, file = "drone.ts"},["4417"] = {line = 100, file = "drone.ts"},["4418"] = {line = 101, file = "drone.ts"},["4419"] = {line = 102, file = "drone.ts"},["4420"] = {line = 103, file = "drone.ts"},["4421"] = {line = 104, file = "drone.ts"},["4422"] = {line = 100, file = "drone.ts"},["4423"] = {line = 106, file = "drone.ts"},["4424"] = {line = 106, file = "drone.ts"},["4425"] = {line = 107, file = "drone.ts"},["4426"] = {line = 108, file = "drone.ts"},["4427"] = {line = 109, file = "drone.ts"},["4428"] = {line = 110, file = "drone.ts"},["4429"] = {line = 106, file = "drone.ts"},["4430"] = {line = 112, file = "drone.ts"},["4431"] = {line = 112, file = "drone.ts"},["4432"] = {line = 113, file = "drone.ts"},["4433"] = {line = 114, file = "drone.ts"},["4434"] = {line = 115, file = "drone.ts"},["4435"] = {line = 116, file = "drone.ts"},["4436"] = {line = 112, file = "drone.ts"},["4437"] = {line = 118, file = "drone.ts"},["4438"] = {line = 118, file = "drone.ts"},["4439"] = {line = 119, file = "drone.ts"},["4440"] = {line = 120, file = "drone.ts"},["4441"] = {line = 121, file = "drone.ts"},["4442"] = {line = 122, file = "drone.ts"},["4443"] = {line = 118, file = "drone.ts"},["4444"] = {line = 125, file = "drone.ts"},["4445"] = {line = 125, file = "drone.ts"},["4446"] = {line = 126, file = "drone.ts"},["4447"] = {line = 127, file = "drone.ts"},["4448"] = {line = 128, file = "drone.ts"},["4449"] = {line = 129, file = "drone.ts"},["4450"] = {line = 125, file = "drone.ts"},["4451"] = {line = 131, file = "drone.ts"},["4452"] = {line = 131, file = "drone.ts"},["4453"] = {line = 132, file = "drone.ts"},["4454"] = {line = 133, file = "drone.ts"},["4455"] = {line = 134, file = "drone.ts"},["4456"] = {line = 135, file = "drone.ts"},["4457"] = {line = 131, file = "drone.ts"},["4458"] = {line = 137, file = "drone.ts"},["4459"] = {line = 137, file = "drone.ts"},["4460"] = {line = 138, file = "drone.ts"},["4461"] = {line = 139, file = "drone.ts"},["4462"] = {line = 140, file = "drone.ts"},["4463"] = {line = 141, file = "drone.ts"},["4464"] = {line = 137, file = "drone.ts"},["4465"] = {line = 143, file = "drone.ts"},["4466"] = {line = 143, file = "drone.ts"},["4467"] = {line = 144, file = "drone.ts"},["4468"] = {line = 145, file = "drone.ts"},["4469"] = {line = 146, file = "drone.ts"},["4470"] = {line = 147, file = "drone.ts"},["4471"] = {line = 143, file = "drone.ts"},["4472"] = {line = 150, file = "drone.ts"},["4473"] = {line = 150, file = "drone.ts"},["4474"] = {line = 151, file = "drone.ts"},["4475"] = {line = 152, file = "drone.ts"},["4476"] = {line = 153, file = "drone.ts"},["4477"] = {line = 154, file = "drone.ts"},["4478"] = {line = 150, file = "drone.ts"},["4479"] = {line = 156, file = "drone.ts"},["4480"] = {line = 156, file = "drone.ts"},["4481"] = {line = 157, file = "drone.ts"},["4482"] = {line = 158, file = "drone.ts"},["4483"] = {line = 159, file = "drone.ts"},["4484"] = {line = 160, file = "drone.ts"},["4485"] = {line = 156, file = "drone.ts"},["4486"] = {line = 162, file = "drone.ts"},["4487"] = {line = 162, file = "drone.ts"},["4488"] = {line = 163, file = "drone.ts"},["4489"] = {line = 164, file = "drone.ts"},["4490"] = {line = 165, file = "drone.ts"},["4491"] = {line = 166, file = "drone.ts"},["4492"] = {line = 162, file = "drone.ts"},["4493"] = {line = 168, file = "drone.ts"},["4494"] = {line = 168, file = "drone.ts"},["4495"] = {line = 169, file = "drone.ts"},["4496"] = {line = 170, file = "drone.ts"},["4497"] = {line = 171, file = "drone.ts"},["4498"] = {line = 172, file = "drone.ts"},["4499"] = {line = 168, file = "drone.ts"},["4500"] = {line = 24, file = "drone.ts"},["4501"] = {line = 10, file = "drone.ts"},["4502"] = {line = 177, file = "drone.ts"},["4503"] = {line = 179, file = "drone.ts"}});
local ____entry = require("src.entry.drone", ...)
return ____entry
