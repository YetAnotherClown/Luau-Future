--[=[
	@class Result
	
	The result of a Future, either equal to the return values or an error message.

	### Checking the Result

	You can retrieve either the Returned Values (as a tuple), or the Error Message (as a string) by calling the result as a function.
	```lua
	local result = myFuture:output()

	if result:ok() then
		local returnedValues = result()

		-- Do something
	elseif result:error() then
		warn(result())
	end
	```
]=]

local Result = {}
Result.__index = Result

function Result:__call<T, E>(): (T | E)?
	if not self.enumValue then
		return nil
	end

	return table.unpack(self.enumValue)
end

--[=[
    @method ok
    @within Result
    
    Returns whether the Result has returned the values of the Future successfully or not.
    
    @return boolean
]=]
function Result:ok(): boolean
	if self.enumType ~= "Ok" then
		return false
	end

	return true
end

--[=[
    @method error
    @within Result
    
    If the Result is an Error, returns true.
    
    @return boolean
]=]
function Result:error(): boolean
	if self.enumType ~= "Error" then
		return false
	end

	return true
end

function Result.new<T, E>(enumType: "Ok" | "Error", results: T | E): Result<T, E>
	local self = setmetatable({}, Result)

    self.type = "Enum"
    self.enumType = enumType :: "Ok" | "Error"
    self.enumValue = results

	return self
end

export type Result<T, E> = typeof(setmetatable({
    type = "Enum",
    enumType = "Ok" :: "Ok" | "Error",
	enumValue = nil :: {T | E}?
}, Result))

return Result