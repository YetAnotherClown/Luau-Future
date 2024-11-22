---
title: Typechecking Guide
description: A guide on Typechecking Futures
---

Currently, in the Luau type solver, there are restrictions placed on recursive types. Luau Futures works around this, by allowing you to chain up
to 3 recursive functions (andThen, map, join, etc.) before the types are exhausted.

## Future vs FutureLike Types

The Futures library exports two types because of these restrictions.
`FutureLike` should be used when your being given a future, such as in a
function with a future as a parameter.
The `Future` type should be used when returning a future, such as in a
function return.

Example usage,
```lua
function Class:method<E, U...>(future: Futures.FutureLike<E, U...>): Futures.Future<E, U...>
    return future:andThen(function(...)
        -- ...
    end) :: any
end
```

:::note
To avoid recursive type restrictions, there are internally multiple types like 
`FutureFirst`, `FutureNext`, `FutureLast` and `FutureExhausted`.

The `Futures.Future` type is just `FutureFirst`, so when you use that type it
will expect a `FutureFirst` which is the first type you get when creating
a future with `Future.new()`.

If you are chaining a future in a function that returns one, you can annotate
the return type to be `Futures.Future` and then typecast the returned future
with `:: any` like in the example.
:::

In the Future, `Futures.FutureLike` will be deprecated, but it will remain
available for backwards compatibility.

## Join Methods

Currently, the Luau type solver cannot properly type the join methods.
So for now, they will always return an exhausted future.

## UnwrapOrElse

[Future:unwrapOrElse] should return the type `Future<never, U...>`. However,
due to recursive type restrictions, it will return `Future<E, U...>`.

You should make a mental note that using this method will never error, and
write your code accordingly.

## Getting Around Exhaustion

So, you have an exhausted future that you want to typecheck.
You can use type annotations and type casts to get around exhausted
futures.

```lua
local newFuture: Future<string, number, number, number> = exhaustedFuture:andThen(function(...)
    -- ...
    return 1, 2, 3
end) :: any
```