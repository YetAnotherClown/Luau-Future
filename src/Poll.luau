local Result = require("./Result")
type Result<E, U...> = Result.Result<E, U...>

type PollImpl<E, U...> = {
	isReady: (self: Poll<E, U...>) -> boolean,
	isPending: (self: Poll<E, U...>) -> boolean,
	unwrap: (self: Poll<E, U...>) -> Result<E, U...>,
}

--- @class Poll
---
--- A Poll represents the status of a [Result],
--- whether that result is Ready or Pending.
---
--- ```lua
--- local poll = Poll.ok(...)
---
--- if poll:isReady() then
--- 	local result = poll:unwrap()
--- 	-- ...
--- elseif poll:isPending() then
--- 	-- ...
--- end
--- ```
local Poll = {}
Poll.__index = Poll

function Poll:__tostring()
	if self:isReady() then
		local result = self:unwrap()
		return `Poll::Ready({result})`
	elseif self:isPending() then
		return "Poll::Pending"
	end

	return "Poll::Unknown"
end

export type Poll<E, U...> = {
	_ready: boolean,
	_results: { any },
	_resultType: ("Ok" | "Err")?,
} & PollImpl<E, U...>

--- @within Poll
---
--- Checks whether the Result of a Poll is ready.
--- ```lua
--- local poll = future:poll()
--- if poll:isReady() then
--- 	local result = poll:unwrap()
--- 	-- ...
--- end
--- ```
function Poll:isReady(): boolean
	return self._ready
end

--- @within Poll
---
--- Checks whether the Result of a Poll is pending.
--- ```lua
--- local poll = future:poll()
--- if poll:isPending() then
--- 	continue
--- end
--- ```
function Poll:isPending(): boolean
	return not self._ready
end

--- @within Poll
--- @error Attempt to unwrap a pending future -- To prevent this, use Poll:isReady() or Future:await() to ensure the Result is ready.
---
--- Checks whether the Result of a Poll is ready.
--- ```lua
--- local poll = future:poll()
--- if poll:isReady() then
--- 	local result = poll:unwrap()
--- 	-- ...
--- else
--- 	local result = poll:unwrap() --! Errors
--- 	-- Error: Attempt to unwrap a pending future
--- end
--- ```
function Poll:unwrap<E, U...>(): Result<E, U...>
	if not self._ready then
		error("Attempt to unwrap a pending future, use Poll:isReady() or Future:await() to avoid this error.")
	else
		if self._resultType == "Ok" then
			return Result.ok(table.unpack(self._results)) :: any
		else
			return Result.err(table.unpack(self._results)) :: any
		end
	end
end

--- @within Poll
---
--- Creates a Poll with an `Ok` result.
function Poll.ok<U...>(...: U...): Poll<never, U...>
	local poll = setmetatable({
		_ready = true,
		_resultType = "Ok",
		_results = table.pack(...),
	}, Poll) :: any

	return poll
end

--- @within Poll
---
--- Creates a Poll with an `Err` result.
function Poll.err<E>(errValue: E): Poll<E, never>
	local poll = setmetatable({
		_ready = true,
		_resultType = "Err",
		_results = { errValue },
	}, Poll) :: any

	return poll
end

--- @within Poll
---
--- Creates a Poll which status is not ready.
function Poll.notReady(): Poll<never, never>
	local poll = setmetatable({
		_ready = false,
		_resultType = nil,
		_results = {},
	}, Poll) :: any

	return poll
end

type Library = {
	ok: <U...>(U...) -> Poll<never, U...>,
	err: <E>(errValue: E) -> Poll<E, never>,
	notReady: () -> Poll<never, never>,
}

return (Poll :: any) :: Library
