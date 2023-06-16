local Result = require(script.Parent.Result)

type Result<T, E> = Result.Result<T, E>

--[=[
    @method output
    @within Future
    
    When the Result of the Future is ready, calling ``output`` will return a [Result](https://yetanotherclown.github.io/Luau-Future/api/Result).
    
    @return Result
]=]

local Output = {}
Output.__index = Output

function Output:__call<T, E>(): Result<T, E>
	return self.result
end

function Output:poll(): boolean
	if not self.result then
		return false
	end

	return true
end

function Output.new<T, E>(callback: (T) -> T | E, ...: T): Output<T, E>
	local self = setmetatable({}, Output)

	local success, results = xpcall(
		function(...)
			return { callback(...) }
		end, 
		function(err)
			return { err }
		end, ...
	)

	local enumType = success and "Ok" or "Error" :: "Ok" | "Error"

	self.result = Result.new(enumType, results)

	return self
end

export type Output<T, E> = typeof(setmetatable({
	result = Result.new("Ok", {}) :: Result<T, E>
}, Output))

return Output