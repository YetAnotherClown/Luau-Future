local Poll = require("./Poll")
export type Poll<E, U...> = Poll.Poll<E, U...>

local Result = require("./Result")
export type Result<E, U...> = Result.Result<E, U...>

local Future = require("./Future") :: any

-- FUTURE: FutureLike<E, U...> = Future<E, U...> for backwards compatibility
-- This type should be used to typecheck function parameters,\
-- using Futures.Future will not work as expected.
export type FutureLike<E, U...> = {
	await: (self: FutureLike<E, U...>) -> Result<E, U...>,
	poll: (self: FutureLike<E, U...>) -> Poll<E, U...>,
	[any]: any,
}

-- FUTURE: Replace when recursive type restrictions are lifted
-- This type should only be used when returning a Future from a function,\
-- Using Futures.FutureLike will not provide intellisense.
export type Future<E, U...> = FutureFirst<E, U...>

type FutureExhausted = {
	_onResolve: { (...any) -> () },
	_onErr: { (any) -> () },
	_mapOn: {
		ok: { <T...>(...any) -> T... },
		err: { <T>(any) -> T },
	},
	_arguments: { any },
	_callback: (...any) -> ...any,
	_threadStatus: { success: boolean, results: { any } },
	_thread: thread?,

	after: <T...>(self: FutureLike<any, ...any>, fn: (Result<any, ...any>) -> FutureLike<any, T...>) -> FutureExhausted,
	andThen: <T...>(self: FutureLike<any, ...any>, fn: (...any) -> FutureLike<any, T...>) -> FutureExhausted,
	await: (self: FutureLike<any, ...any>) -> Result<any, ...any>,
	inspectErr: (self: FutureLike<any, ...any>, fn: (any) -> ()) -> FutureExhausted,
	inspectOk: (self: FutureLike<any, ...any>, fn: (...any) -> ()) -> FutureExhausted,
	join: <T...>(self: FutureLike<any, ...any>, otherFuture: FutureLike<any, T...>) -> FutureExhausted,
	joinAll: (...FutureLike<any, ...any>) -> FutureExhausted,
	mapErr: <T>(self: FutureLike<any, ...any>, fn: (any) -> T) -> FutureExhausted,
	mapOk: <T...>(self: FutureLike<any, ...any>, fn: (...any) -> T...) -> FutureExhausted,
	orElse: (self: FutureLike<any, ...any>, fn: (any) -> FutureExhausted) -> FutureExhausted,
	unwrapOrElse: (self: FutureLike<any, ...any>, fn: (err: any) -> ...any) -> FutureExhausted,
	poll: (self: FutureLike<any, ...any>) -> Poll<any, ...any>,
}

type FutureLast<E, U...> = {
	_onResolve: { (U...) -> () },
	_onErr: { (E) -> () },
	_mapOn: {
		ok: { <T...>(U...) -> T... },
		err: { <T>(E) -> T },
	},
	_arguments: { any },
	_callback: (...any) -> U...,
	_threadStatus: { success: boolean, results: { any } },
	_thread: thread?,

	after: <T...>(self: FutureLike<E, U...>, fn: (Result<E, U...>) -> FutureLike<E, T...>) -> FutureExhausted,
	andThen: <T...>(self: FutureLike<E, U...>, fn: (U...) -> FutureLike<E, T...>) -> FutureExhausted,
	await: (self: FutureLike<E, U...>) -> Result<E, U...>,
	inspectErr: (self: FutureLike<E, U...>, fn: (E) -> ()) -> FutureLast<E, U...>,
	inspectOk: (self: FutureLike<E, U...>, fn: (U...) -> ()) -> FutureLast<E, U...>,
	join: <T...>(self: FutureLike<E, U...>, otherFuture: FutureLike<E, T...>) -> FutureExhausted,
	joinAll: (...FutureLike<any, ...any>) -> FutureExhausted,
	mapErr: <T>(self: FutureLike<E, U...>, fn: (E) -> T) -> FutureExhausted,
	mapOk: <T...>(self: FutureLike<E, U...>, fn: (U...) -> T...) -> FutureExhausted,
	orElse: (self: FutureLike<E, U...>, fn: (E) -> FutureLast<E, U...>) -> FutureLast<E, U...>,
	unwrapOrElse: (self: FutureLike<E, U...>, fn: (err: E) -> U...) -> FutureLast<E, U...>,
	poll: (self: FutureLike<E, U...>) -> Poll<E, U...>,
}

type FutureNext<E, U...> = {
	_onResolve: { (U...) -> () },
	_onErr: { (E) -> () },
	_mapOn: {
		ok: { <T...>(U...) -> T... },
		err: { <T>(E) -> T },
	},
	_arguments: { any },
	_callback: (...any) -> U...,
	_threadStatus: { success: boolean, results: { any } },
	_thread: thread?,

	after: <T...>(self: FutureLike<E, U...>, fn: (Result<E, U...>) -> FutureLike<E, T...>) -> FutureLast<E, T...>,
	andThen: <T...>(self: FutureLike<E, U...>, fn: (U...) -> FutureLike<E, T...>) -> FutureLast<E, T...>,
	await: (self: FutureLike<E, U...>) -> Result<E, U...>,
	inspectErr: (self: FutureLike<E, U...>, fn: (E) -> ()) -> FutureNext<E, U...>,
	inspectOk: (self: FutureLike<E, U...>, fn: (U...) -> ()) -> FutureNext<E, U...>,
	join: <T...>(self: FutureLike<E, U...>, otherFuture: FutureLike<E, T...>) -> FutureExhausted,
	joinAll: (...FutureLike<any, ...any>) -> FutureExhausted,
	mapErr: <T>(self: FutureLike<E, U...>, fn: (E) -> T) -> FutureLast<T, U...>,
	mapOk: <T...>(self: FutureLike<E, U...>, fn: (U...) -> T...) -> FutureLast<E, T...>,
	orElse: (self: FutureLike<E, U...>, fn: (E) -> FutureNext<E, U...>) -> FutureNext<E, U...>,
	unwrapOrElse: (self: FutureLike<E, U...>, fn: (err: E) -> U...) -> FutureNext<E, U...>,
	poll: (self: FutureLike<E, U...>) -> Poll<E, U...>,
}

type FutureFirst<E, U...> = {
	_onResolve: { (U...) -> () },
	_onErr: { (E) -> () },
	_mapOn: {
		ok: { <T...>(U...) -> T... },
		err: { <T>(E) -> T },
	},
	_arguments: { any },
	_callback: (...any) -> U...,
	_threadStatus: { success: boolean, results: { any } },
	_thread: thread?,

	after: <T...>(self: FutureLike<E, U...>, fn: (Result<E, U...>) -> FutureLike<E, T...>) -> FutureNext<E, T...>,
	andThen: <T...>(self: FutureLike<E, U...>, fn: (U...) -> FutureLike<E, T...>) -> FutureNext<E, T...>,
	await: (self: FutureLike<E, U...>) -> Result<E, U...>,
	inspectErr: (self: FutureLike<E, U...>, fn: (E) -> ()) -> FutureFirst<E, U...>,
	inspectOk: (self: FutureLike<E, U...>, fn: (U...) -> ()) -> FutureFirst<E, U...>,
	-- FUTURE: Return Future<E, (U..., T...)>
	join: <T...>(self: FutureLike<E, U...>, otherFuture: FutureLike<E, T...>) -> FutureExhausted,
	-- NOTE: This might be a little tricky to type, we can supply join3, join4, join5... methods
	joinAll: (...FutureLike<any, ...any>) -> FutureExhausted,
	mapErr: <T>(self: FutureLike<E, U...>, fn: (E) -> T) -> FutureNext<T, U...>,
	mapOk: <T...>(self: FutureLike<E, U...>, fn: (U...) -> T...) -> FutureNext<E, T...>,
	orElse: (self: FutureLike<E, U...>, fn: (E) -> FutureFirst<E, U...>) -> FutureFirst<E, U...>,
	-- FUTURE: Return Future<never, U...>
	unwrapOrElse: (self: FutureLike<E, U...>, fn: (err: E) -> U...) -> FutureFirst<E, U...>,
	poll: (self: FutureLike<E, U...>) -> Poll<E, U...>,
}

type Library = {
	Poll: typeof(Poll),
	Result: typeof(Result),

	-- FUTURE: Replace when recursive type restrictions are lifted
	Future: {
		new: <E, U..., T...>(callback: (T...) -> U..., T...) -> FutureFirst<E, U...>,
		[any]: any,
	},
}

return {
	Poll = Poll,
	Result = Result,

	Future = Future,
} :: Library
