# Luau Futures

[**View Documentation**](https://yetanotherclown.github.io/luau-future)

Futures represent a read-only asynchronous value, one that may not have
finished computation like.

This design is inspired by the Futures crate in Rust.

> [!IMPORTANT]
> After almost two years of being the oldest Futures implementation on Wally,
> Luau Futures v2.0.0 has released, with several key changes.
>
> Importantly, the Wally scope has been changed to `yetanotherclown/luau-futures`.
> If you are still using the v1.x.x Future library make sure to update your `wally.toml` to upgrade.
>
> You can find out more [here](https://github.com/YetAnotherClown/luau-futures/releases/tag/v2.0.0).

## Basic Use

Creating a future is very simple:

```luau
local Futures = require("@packages/LuauFutures")
local Future = Futures.Future

local myFuture = Future.new(function()
    yield()
    return 1, 2, 3
end)

```

When you create a future, it wont begin execution until it is either polled or awaited.

Polling will advance the future to it's next resumption point every time that it is called, returning a [Poll](https://yetanotherclown.github.io/luau-future/api/Poll) to let you check the status of the future.

If the Poll is ready, you can also unwrap it to get the [Result](https://yetanotherclown.github.io/luau-future/api/Result)

```luau
local poll = myFuture:poll()
if poll:isReady() then
    local result = poll:unwrap()
    -- Handle result
end
```

Awaiting a future will yield the current thread until the future finishes execution. As such, it is recommended that you only use the await method within other futures, preferring to use poll instead.

```luau
local result = myFuture:await()
-- Handle result
```

To read the result, you can use [Result:isOk](https://yetanotherclown.github.io/luau-future/api/Result#isOk) or [Result:isErr](https://yetanotherclown.github.io/luau-future/api/Result#isOk) to check what type the Result is.

You can then use [Result:unwrapOk](https://yetanotherclown.github.io/luau-future/api/Result#unwrapOk) or [Result:unwrapErr](https://yetanotherclown.github.io/luau-future/api/Result#unwrapErr) to get the value of the result.

```luau
if result:isOk() then
    print(result:unwrapOk()) -- 1, 2, 3
elseif result:isErr() then
    warn(result:unwrapErr()) -- An error occurred
end
```

There are also several other methods for chaining, combining, and mapping futures, as well as other utilities for working with futures.

It is suggested to read the [API Documentation](https://yetanotherclown.github.io/luau-future) for more information about these methods.

## Why Luau Futures

### Laziness

Like in Rust, Luau Future is lazy. Unlike Promises which are eager.

Futures will not begin execution until polled or awaited, where as in Promises, execution is begun immediately or scheduled to be done as soon as it can.

Polling will execute until the next suspension point, until execution is finished. By awaiting a Future, it will yield the current thread until execution has completed.

## Why you Shouldn't Use Luau Futures

### Futures are Lazy

Sometimes, you might not want the Laziness of Futures, and instead want execution to begin when it can. Promises begin execution as soon as they're made,
allowing the result to be completed much sooner than with a Future. Futures are lazy by design, you might find that you want this laziness for a certain
purpose and that is fine, but sometimes you might not.

### Promises Just Work

roblox-lua-promise works, and has worked for some time now. Do you need a battle tested strategy for asynchronous programming? Use roblox-lua-promise!
If you're already using Promises, keep using them.

### Promises are more Common

Working on a library? Introducing new developers to your team? It would be easier for them to understand Promises, as they're already widely popular in
the JavaScript ecosystem as well as in Luau.

## A Note on Typechecking

The following typechecking restrictions should be resolved in the Luau Solver V2, in which recursive type restrictions
should be loosened.

### Exported Types

The Futures library exports two types because of these restrictions. `FutureLike` should be used when your being given a future, such as in a function with a future as a parameter. The `Future` type should be used when returning a future, such as in a function return.

```luau
function Class:method<E, U...>(future: Futures.FutureLike<E, U...>): Futures.Future<E, U...>
    return future:andThen(function(...)
        -- ...
    end) :: any
end
```

> [!NOTE]
> To avoid recursive type restrictions, there are internally multiple types like FutureFirst, FutureNext, FutureLast and FutureExhausted.
>
> The Futures.Future type is just FutureFirst, so when you use that type it will expect a FutureFirst which is the first type you get when creating a future with Future.new().
>
> If you are chaining a future in a function that returns one, you can annotate the return type to be Futures.Future and then typecast the returned future with :: any like in the example.

### Recursive Types

Some methods, such as `andThen`, `mapOk`, `mapErr`, etc. will return a recursive type with different parameters.
Currently, there are restrictions in place in the Luau type solver to prevent this. The Futures library has a workaround
to allow you to chain up to 3 of these methods. When you hit the limit, you will be returned a generic
Future that is typed as `Future<any, ...any>`.

### Join Methods

The Join methods currently will always return a generic Future. Currently, it is impossible to type these methods.

### UnwrapOrElse
[Future:unwrapOrElse](https://yetanotherclown.github.io/luau-future/api/Future#unwrapOrElse) should return the type `Future<never, U...>`. However, due to recursive type restrictions, it will return `Future<E, U...>`.