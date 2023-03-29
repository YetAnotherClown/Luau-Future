--!strict

--[[
	Future     1.0.0-beta1
	A Minimal, Typed Future Implementation inspired by the concept of Futures from the Rust Ecosystem.

	https://clownxz.github.io/Future/
]]

local ThreadPool = require(script.ThreadPool)
type ThreadPool = ThreadPool.ThreadPool

local threadPool = ThreadPool.new()

local Output = {}
Output.__index = Output

function Output:__call<T>(): T?
	if not self.results then
		return nil
	end

	return table.unpack(self.results)
end

function Output:poll(): boolean
	if not self.results then
		return false
	end

	return true
end

function Output.new<T>(callback: (T) -> T, ...: T): Output<T>
	local self = setmetatable({}, Output)

	local _, results = xpcall(
		function(...)
			return { callback(...) }
		end, 
		function(err)
			return { err }
		end, ...
	)

	self.results = results :: {T}

	return self
end

type Output<T> = typeof(setmetatable({
	results = nil :: {T}?
}, Output))

--[=[
	@class Future
	
	A Minimal, Typed Future Implementation inspired by the concept of Futures from the Rust Ecosystem.

	### Creating a Future

	To create a Future, call the Library as a function and provide a yielding function as a parameter.
	```lua
	local Future = require(path.to.module)
	
	local myFuture = Future(function(...)
		-- Something that yields
	end, ...)
	```

	### Polling a Future

	To check if a Future is ready with it's results, you poll it! You can either call ``isReady()`` or ``isPending``
	to check whether or not the Future is ready.
	```lua
	-- Poll the Future to see if it is ready.
	if myFuture:isReady() then
		-- Do something
	end

	-- Poll the Future to see if it is pending.
	if myFuture:isPending() then
		-- Future is still pending!
	end
	```

	### Retrieving Output

	To retrieve the Output of a Future, call ``output()`` on the Future when it is ready.
	```lua
	if myFuture:isReady() then
		local a, b, c... = myFuture:output()

		-- Do something
	end
	```

	:::warning
	It is important to Poll a Future first instead of just calling ``output()``!
	
	Your Future could no longer be Pending but not return anything, in which case
	``output()`` will return ``nil``.
	:::
]=]
local Future = {}
Future.__index = Future

function Future:__call<T>(callback: (T) -> T, ...: T) : Future<T>
	local newFuture = setmetatable({}, Future)

	threadPool:spawn(function(...)
		newFuture.output = Output.new(callback, ...)
	end, ...)

	return newFuture
end

--[=[
    @method isPending
    @within Future
    
    Polls the Future and returns ``true`` if the Future is pending.
    
    @return boolean
]=]
function Future:isPending(): boolean
	return not self:isReady()
end

--[=[
    @method isReady
    @within Future
    
    Polls the Future and returns ``true`` if the Future is ready.
    
    @return boolean
]=]
function Future:isReady(): boolean
	return self.output and self.output:poll() or false
end

--[=[
    @method output
    @within Future
    
    If the Future is ready, returns the results ``...T``. Otherwise, returns ``nil``.
    
    @return ...T?
]=]

type Future<T> = typeof(setmetatable({
	output = nil :: Output<T>?
}, Future))

return setmetatable({}, Future)