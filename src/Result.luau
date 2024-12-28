local utils = require("./utils")
local prettyPrint = utils.prettyPrint

type ResultType = "Ok" | "Err"

type ResultImpl<E, U...> = {
	isOk: (self: Result<E, U...>) -> boolean,
	isErr: (self: Result<E, U...>) -> boolean,
	unwrapOk: (self: Result<E, U...>) -> U...,
	unwrapErr: (self: Result<E, U...>) -> E,
}

--- @class Result
---
--- A Result type for use with Futures, with API designed
--- to support strict typing.
local Result = {}
Result.__index = Result

function Result:__tostring()
	local results = prettyPrint(table.unpack(self._results))

	if self:isOk() then
		return `Result::Ok({results})`
	elseif self:isErr() then
		return `Result::Err({results})`
	end

	return "Result::Unknown"
end

export type Result<E, U...> = {
	_type: ResultType,
	_results: { any },
} & ResultImpl<E, U...>

--- @within Result
---
--- Checks whether the Result is of the `Ok` type.
function Result:isOk(): boolean
	return self._type == "Ok"
end

--- @within Result
---
--- Checks whether the Result is of the `Err` type.
function Result:isErr(): boolean
	return self._type == "Err"
end

--- @within Result
---
--- Unwraps the results of an `Ok` Result.
---
--- :::danger
--- Make sure you use [Result:isOk] before using this method.
---
--- ```lua
--- if result:isOk() then
--- 	local result = result:unwrapOk()
--- end
--- ```
--- :::
function Result:unwrapOk<E, U...>(): U...
	return table.unpack(self._results :: any)
end

--- @within Result
---
--- Unwraps the results of an `Err` Result.
---
--- :::danger
--- Make sure you use [Result:isErr] before using this method.
---
--- ```lua
--- if result:isErr() then
--- 	local err = result:unwrapErr()
--- end
--- ```
--- :::
function Result:unwrapErr<E, U...>(): E
	return table.unpack(self._results)
end

--- @within Result
---
--- Creates a new Result of the `Ok` type.
function Result.ok<U...>(...: U...): Result<never, U...>
	local result = setmetatable({
		_type = "Ok",
		_results = table.pack(...),
	}, Result) :: any

	return result
end

--- @within Result
---
--- Creates a new Result of the `Err` type.
function Result.err<E>(errValue: E): Result<E, never>
	local result = setmetatable({
		_type = "Err",
		_results = { errValue },
	}, Result) :: any

	return result
end

type Library = {
	ok: <U...>(U...) -> Result<never, U...>,
	err: <E>(E) -> Result<E, never>,
}

return (Result :: any) :: Library
