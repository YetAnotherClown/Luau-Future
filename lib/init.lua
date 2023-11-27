--!strict

--[[
	Future     1.1.0
	A Minimal, Typed Future Implementation inspired by the concept of Futures from the Rust Ecosystem.

	https://yetanotherclown.github.io/Luau-Future/
]]

local Package = script.Parent

local Output = require(script.Output)
type Output<T, E> = Output.Output<T, E>

local ThreadPool = require(Package.ThreadPool)
type ThreadPool = ThreadPool.ThreadPool

local threadPool = ThreadPool.new()

--[=[
	@class Future
	
	A Minimal, Typed Future Implementation inspired by the concept of Futures from the Rust Ecosystem.

	### Creating a Future

	To create a Future, use the ``new`` function or call the Library as a function and provide a yielding function as a parameter.
	```lua
	local Future = require(path.to.module)
	
	local myFuture = Future.new(function(...)
		-- Something that yields
	end, ...)
	```

	### Polling a Future

	To check if a Future is ready with it's results, you poll it! You can either call the ``isReady()``
	or ``isPending`` methods to check whether or not the Future is ready.
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

	To retrieve the Output of a Future, call the ``output()`` method on the Future when it is ready.
	```lua
	if myFuture:isReady() then
		local result = myFuture:output()

		if result:ok() then
			local a, b, c... = result:unwrap()

			-- Do something
		elseif result:error() then
			warn(result:unwrap())
		end
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

function Future:__call<T, E>(callback: (T) -> T | E, ...: T): Future<T, E>
	return self.new(callback) :: Future<T, E>
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
	@function new
	@within Future

	Creates a new future from the provided callback.

	@return Future
]=]
function Future.new<T, E>(callback: (T) -> T | E, ...: T): Future<T, E>
	local newFuture = setmetatable({}, Future)

	threadPool:spawn(function(...)
		newFuture.output = Output.new(callback, ...)
	end, ...)

	return newFuture
end

export type Future<T, E> = typeof(setmetatable({
	output = nil :: Output<T, E>?,
}, Future))

return setmetatable({}, Future)
