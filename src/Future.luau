local Poll = require("./Poll")
export type Poll<E, U...> = Poll.Poll<E, U...>

local Result = require("./Result")
export type Result<E, U...> = Result.Result<E, U...>

--- @class Future
---
--- A Future represents a read-only asynchronous value, one that may not
--- have finished computation.
---
--- Futures are lazy in their computation, meaning execution will not begin
--- until [Future:poll] or [Future:await] is used.
---
--- ## Types
---
--- You should refer to the [Typechecking Guide](/docs/typechecking) for more information.
---
--- ### Future
---
--- This type should only be used when returning a Future from a function,
--- using Futures.FutureLike will not provide intellisense.
---
--- ### FutureLike
---
--- This type should be used to typecheck function parameters, using
--- Futures.Future will not work as expected.
---
local Future = {}
Future.__index = Future

--- @method after
--- @within Future
--- @param fn (Result<E, U...>) -> Future<E, T...>
--- @return Future<E, T...>
---
--- After completion, passes the Result of the current future
--- to the closure, returning a new Future.
function Future:after(fn)
	-- DEVIATION: `then` is a reserved keyword in Luau,
	-- this method is equivalent to FutureExt::then
	return self.new(function()
		local future = fn(self:await())
		local result = future:await()

		if result:isOk() then
			return result:unwrapOk()
		elseif result:isErr() then
			error(result:unwrapErr(), 0)
		end
	end)
end

--- @method andThen
--- @within Future
--- @param fn <T>(U...) -> Future<E, T...>
--- @return Future<E, T...>
---
--- After successfully resolving, create and execute another Future
--- created within the closure, with the Ok result passed in the
--- closure arguments, otherwise it is never executed.
function Future:andThen(fn)
	return self.new(function()
		local result = self:await()

		if result:isOk() then
			local newFuture = fn(result:unwrapOk())
			local newResult = newFuture:await()

			if newResult:isOk() then
				return newResult:unwrapOk()
			elseif newResult:isErr() then
				error(newResult:unwrapErr(), 0)
			end
		elseif result:isErr() then
			error(result:unwrapErr(), 0)
		end
	end)
end

--- @method await
--- @within Future
--- @yields
--- @return Result<E, U...>
---
--- Yields until the Future finishes execution, then returns the result.
---
--- :::warning
--- Because this is a yielding method, it is suggested that it is only
--- used within Futures, as opposed to the main thread. \
--- \
--- See [Future:poll] for the recommended way of executing Futures.
--- :::
function Future:await()
	local poll = self:poll()

	if not poll:isReady() then
		table.insert(self._yieldedThreads, coroutine.running())
		coroutine.yield()
	end

	poll = self:poll()
	return poll:unwrap()
end

--- @method inspectErr
--- @within Future
--- @param fn (E) -> ()
--- @return Future<E, U...>
---
--- Allows you to read the error value of a Future before passing it on.
function Future:inspectErr(fn)
	table.insert(self._onCompletion, {
		on = "Err",
		type = "inspect",
		fn = fn,
	})

	return self
end

--- @method inspectOk
--- @within Future
--- @param fn (U...) -> ()
--- @return Future<E, U...>
---
--- Allows you to read the success value of a Future before passing it on.
function Future:inspectOk(fn)
	table.insert(self._onCompletion, {
		on = "Ok",
		type = "inspect",
		fn = fn,
	})

	return self
end

--- @method join
--- @within Future
--- @param otherFuture Future<E, T...>
--- @return Future<never, { Result<E, never> | (U..., T...) }>
---
--- Joins the results of two futures into a table.
---
--- Futures of different types, Err and Ok will still
--- have their results joined into a table.
---
--- Results of type Ok will be unwrapped in the table,
--- whereas Results of type Err will not be unwrapped
--- and will be added as `Result<E, never>` in the table.
function Future:join(otherFuture)
	return self.new(function()
		local result = self:await()
		local otherResult = otherFuture:await()

		-- unwrapOk and unwrapErr are functionally similar
		local results = result:isOk() and { result:unwrapOk() } or { result }

		if otherResult:isOk() then
			for _, v in { otherResult:unwrapOk() } do
				table.insert(results, v)
			end
		else
			table.insert(results, otherResult)
		end

		return results
	end)
end

--- @method joinAll
--- @within Future
--- @param ... Future<E, ...any>
--- @return Future<never, { Result<E, never> | ...any }>
---
--- Joins the results of two or more futures into a table.
function Future:joinAll(...)
	local previousFuture = self

	for i = 1, select("#", ...) do
		previousFuture = self.join(previousFuture, select(i, ...)):mapOk(function(t)
			return table.unpack(t)
		end)
	end

	return previousFuture
end

--- @method mapErr
--- @within Future
--- @param fn (E) -> T
--- @return Future<T, U...>
---
--- Maps the type of the Err result of a Future.
function Future:mapErr(fn)
	table.insert(self._onCompletion, {
		on = "Err",
		type = "map",
		fn = fn,
	})

	return self
end

--- @method mapOk
--- @within Future
--- @param fn (U...) -> T...
--- @return Future<E, T...>
---
--- Maps the type of the Ok result of a Future.
function Future:mapOk<E, U..., T...>(fn)
	table.insert(self._onCompletion, {
		on = "Ok",
		type = "map",
		fn = fn,
	})

	return self
end

--- @method orElse
--- @within Future
--- @param fn (E) -> Future<E, U...>
--- @return Future<E, U...>
---
--- On Err, executes another Future of the same type.
function Future:orElse(fn)
	return self.new(function()
		local result = self:await()

		if result:isOk() then
			return result:unwrapOk()
		elseif result:isErr() then
			local newFuture = fn(result:unwrapErr())
			local newResult = newFuture:await()

			if newResult:isOk() then
				return newResult:unwrapOk()
			elseif newResult:isErr() then
				error(newResult:unwrapErr(), 0)
			end
		end
	end)
end

--- @method unwrapOrElse
--- @within Future
--- @param fn (E) -> U...
--- @return Future<never, U...>
---
--- On Err, the result is passed to the closure to create a Ok result,
--- then returns a Future with that Ok result.
function Future:unwrapOrElse(fn)
	return self.new(function()
		local result = self:await()

		if result:isOk() then
			return result:unwrapOk()
		elseif result:isErr() then
			return fn(result:unwrapErr())
		end
	end)
end

--- @method poll
--- @within Future
--- @return Poll<E, U...>
---
--- Executes the Future on it's next resumption point,
--- returning `Result::Pending` if it is not ready yet or
--- `Result::Ready` if it is ready.
---
--- :::danger
--- Polling a Future that is ready will return the same result.
--- This will however not be guaranteed behavior, and you should
--- avoid polling a Future that is already ready.
--- :::
function Future:poll()
	local threadExists = self.thread ~= nil

	if not threadExists then
		local thread = coroutine.create(function(...)
			local success, result = xpcall(function(...)
				local results = { self._callback(...) }

				for _, command in self._onCompletion do
					if command.on == "Err" then
						continue
					end

					if command.type == "map" then
						results = { command.fn(table.unpack(results)) }
					else
						command.fn(table.unpack(results))
					end
				end

				return results
			end, function(err)
				for _, command in self._onCompletion do
					if command.on == "Ok" then
						continue
					end

					if command.type == "map" then
						_, err = pcall(command.fn, err)
					else
						command.fn(err)
					end
				end

				return err
			end, ...)

			if not success then
				result = { result }
			end

			self._threadStatus = {
				success = success,
				result = result,
			}

			for _, yieldedThread in self._yieldedThreads do
				if coroutine.status(yieldedThread) ~= "suspended" then
					continue
				end

				coroutine.resume(yieldedThread)
			end
		end)

		self.thread = thread
		coroutine.resume(thread, table.unpack(self._arguments))
	end

	local ready = if self._threadStatus then true else false
	local success = if ready then self._threadStatus.success else false
	local result = if ready then self._threadStatus.result else {}

	local resultType: ("Ok" | "Err")? = if success then "Ok" elseif ready then "Err" else nil

	if resultType == "Ok" then
		return Poll.ok(table.unpack(result))
	elseif resultType == "Err" then
		return Poll.err(table.unpack(result))
	else
		return Poll.notReady()
	end
end

--- @function new
--- @within Future
--- @param callback (T...) -> U...
--- @param ... T...
--- @return Future<E, U...>
---
--- Creates a new Future, taking an asynchronous callback and
--- parameters to pass into that callback.
function Future.new(callback, ...)
	return setmetatable({
		_onCompletion = {},
		_arguments = table.pack(...),
		_callback = callback,
		_yieldedThreads = {},
	}, Future)
end

return Future
