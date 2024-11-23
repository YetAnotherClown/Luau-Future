# Luau Futures

![GitHub License](https://img.shields.io/github/license/yetanotherclown/luau-futures?style=flat-square)
[![Documentation](https://img.shields.io/badge/Documentation-02B1E9?style=flat-square&logo=data:image/svg%2bxml;base64,PHN2ZyByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAyNCAyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8dGl0bGU+TW9vbndhdmU8L3RpdGxlPgogIDxwYXRoIGQ9Ik0xMy43MzkgMTQwLjMzMWMuMjguNDkyLjQ2NSAxLjAwOC44NTEgMS40MzguODczLjk3MyAyLjE3MyAxLjAzMyAzLjI2NC4zOTcuOTg5IDIuMzc1IDMuNTg4IDIuOTgzIDUuODk5IDIuNTQ3LjUzNC0uMSAxLjkxOS0uMyAyLjEzMi0uODYyLTEuNDgzIDAtMy4xMDYuMTctNC4zNjMtLjgxOS0yLjE0Ny0xLjY4OS0uNzE1LTQuNiAxLjM4OC01LjQ3Ny0uMTM4LS40MjYtMS4xNTgtLjM5OC0xLjUzNy0uMzk2LTEuNzYyLjAwNy0yLjk0OCAxLjEwOC0zLjY2OCAyLjYyNy0uNjc1LTEuNzQ4LS4zNTQtMy4yOCAxLjE0LTQuNDg4LjM5Ny0uMzIxLjg0My0uNTM5IDEuMjg5LS43OC4xMTgtLjA2NC4zNDItLjE5Ni4xOC0uMzQxLS4xNjUtLjE0OC0uNTE2LS4xNy0uNzI1LS4yMjJhMTIuMjcyIDEyLjI3MiAwIDAgMC0yLjA4Mi0uMzJjLS44MTktLjA1OC0xLjYyNC0uMDQ0LTIuNDMuMTQ3LTMuMDcuNzI5LTQuMjc2IDMuNTg5LTUuNjM2IDYuMTAzLS41NjcgMS4wNS0xLjA1MSAyLjEyNi0xLjk5OCAyLjkwMi0xLjE1MS45NDQtMi42NzYgMS4xOC00LjExNSAxLS4zNjktLjA0Ni0uNzMtLjEyOC0xLjA5LS4yMTUtLjA4NC0uMDItLjMyNC0uMS0uMzUxLjA0My0uMDQ0LjIzNC43MzEuNDcuODk2LjU0MSAxLjA0NC40NDUgMi4xLjY4OSAzLjIyMi44MjEgMy4wNTkuMzYxIDYuNTMtMS44NTcgNy43MzQtNC42NDZ6IiBzdHlsZT0iZmlsbDojZmZmZmZmO2ZpbGwtb3BhY2l0eToxO3N0cm9rZTpub25lO3N0cm9rZS13aWR0aDouMDQ5NTc0MyIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoLTEuODg1IC0xMjcuMzEpIi8+Cjwvc3ZnPg==)](https://yetanotherclown.github.io/luau-future)
[![Wally Package](https://img.shields.io/badge/Wally-ad4646?style=flat-square&logoSize=auto&logo=data:image/svg%2bxml;base64,PHN2ZyByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAyNCAyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGl0bGU+V2FsbHk8L3RpdGxlPjxwYXRoIGZpbGw9Im5vbmUiIGQ9Ik0yMC4zMjUgMTguMTkxYy0xLjkxNSAyLjU5OS01LjEyNyA0LjI1NC04LjM1OCA0LjE4MS0uMjk2LS41MjgtLjc2My0xLjY3My4zNDgtMS4yOTcgMi4zNTUtLjA3NiA0Ljc3LTEuMDE0IDYuMzc1LTIuNzYxLjI5OS0uODUzLjgyLS45ODcgMS4zOC0uMzAxbC4xMjcuMDkuMTI4LjA4OHpNMTIuNzg1IDYuMmMtLjg5Mi4yNjQtLjEwNCAyLjY2LjQ1OSAxLjI3Mi0uMDc1LS40MDcuMjItMS4yODgtLjQ1OC0xLjI3MnptLS41OS0uMjQyYy0uNjY0LTEuMzM1IDEuOTY2LS4zNTMgMS44ODItLjIyOC0uMzI2LS44NTYtMi4zMDItMS4yNC0yLjI2My0uMTA4bC4xNzMuMTk3ek0xMS41NCAxOS4zOGMtLjI4LTEuMzY0IDEuOTY1LS45NTggMS45My0xLjgwMS0uOTkyLS4xNi0yLjM4Mi0uODMyLTEuMzQtMS45NjMgMS4wMjctMS4wMjIgMi41MzMtMS45NTYgMi40OTItMy42NDktLjI4NS42MTItLjkyIDEuOTMtMS44MzUgMi4zODctMS41NzMgMS4wOC00LjA5IDEuMTc5LTUuMjYtLjU1LS4zNDktLjQ2My0uNjg3LTEuNDkxLS40NC0uMzQyLjQ2Ni42NjguNiAxLjcwMi0uNTYxIDEuNDUzLTEuMjQ1LS40NDEtLjM2Mi0xLjc2NC0uNC0yLjY0Ni0uNi0xLjE0NCAxLjM3Ni0uNjA4IDEuNjIzLTEuNjk0QzguNjQgOS40MyA2LjcyIDguODMgNS44NDggOC45MWMtLjk5Ni4xNjUuODUxLS40OTUgMS4xOC0uNzkuNzczLS40NTMgMS41MDYtLjk5NiAyLjA5LTEuNjgyLS41NjIuNDgyLS43NjEuNTE2LS43NDktLjI4LTEuMTUyLS41Ny0uMTM3IDEuNjkzLTEuMzk3IDEuNjY4LS45MTIuNjA1LjYxOS0xLjE0NC4yMzItMS43ODctLjIxOS0xLjIzNCAxLjUtMS4zMjIgMS40My0uMjMuNzYyLS42MjQtLjYxNi0xLjAyMy0uNjE2LTEuMTczIDEuMzQ3LTEuMzA3IDMuNDEzLTEuMzk1IDUuMTItLjg3My45MTYuMjUgMS43MDQuODYyIDIuMDA2IDEuNzg2Ljg5NCAyLjA2NC40NzMgNC4zNTEuMjc4IDYuNTA0LS4xOCAxLjExNi40OTMgMi4wNzcgMS4zODEgMi40NjYuNDI2LjkxNyAxLjkxIDEuNzUyLjU3NSAyLjYwOC0xLjUzOSAxLjQ4OC0zLjY2MyAyLjQ3Ny01LjgzOCAyLjI1MnptOS4xMjMtMS42NjVjLTEuMjctLjQ3MS0xLjc3My0xLjc0Mi0yLjg4NC0yLjM2NS0uNTMzLS42MzgtLjk2LTEuMTU0LS4yOS0xLjc4My4yOTktMS4zNjggMS43OC0xLjg1MiAyLjQ1NC0yLjk4Ljc4Ny0uOTY4LjcwNC0yLjQzMS0uMjAyLTMuMjkxLS43OTctLjg2LTIuMDc2LTEuMjA2LTIuNTI3LTIuMzg1LTEuMjMtMS4wMi0zLjAyMS0xLjA1NS00LjQ5OS0xLjY3NS0xLjMyOC0uMTk0LTIuOTA1LS4yNjEtNC4wMjEuNjA2LTEuNDkyLjAzLTEuODA3IDEuNzc3LTIuNTk0IDIuNzI2LS43My42NDktMS42NTMgMS4yNjYtMS4xNTMgMi4zMzQtMS4wNDguNzE3LjE3OCAyLjAzNi42OTIgMi43NTQuMzA3IDEuMjAyLS45OTQgMy4xNzYuOTY4IDMuNTM4Ljc4NC4wMjYgMS4xNzMtLjg2OCAxLjc5Ni0uMDQzIDEuMzc1LjIyNSAxLjA5IDEuODk4IDEuMDE4IDIuOTM2LjA4Mi45MDItMS4wMiAxLjU2NS0uMzI5IDIuNS0uMTQuODc4LS4zMDMgMS42Ni0xLjI3Ni45MjMtMy45OTktMS43MTgtNi42NDktNi4xMy02LjE2Ny0xMC40NzMuMzM0LTQuMTIyIDMuMzc3LTcuODM0IDcuMzQ1LTguOTg4IDQuMDgtMS4zMSA4Ljg0Ny4yODggMTEuMzUzIDMuNzU1IDIuNTg0IDMuNDAxIDIuNzMxIDguMzguMzE2IDExLjkxWk0xMS43NjguMDAzQzYuODQ4LjAzOSAyLjE4NSAzLjQ0NS42NTIgOC4xMmMtMS40OTUgNC4xOC0uMzU4IDkuMTEzIDIuNzc2IDEyLjI0OSAzLjI1NiAzLjQ0IDguNjMzIDQuNTY5IDEzLjAxIDIuNzc0IDQuNjM2LTEuNzg5IDcuODMtNi42OTIgNy41NDItMTEuNjYtLjE1NS00LjY2My0zLjMtOS4wNC03LjY3MS0xMC42NzJhMTEuODcyIDExLjg3MiAwIDAgMC00LjU0LS44MVoiIHN0eWxlPSJmaWxsOiNGRkY7ZmlsbC1vcGFjaXR5OjE7c3Ryb2tlOm5vbmUiLz48L3N2Zz4=)](https://wally.run/package/yetanotherclown/luau-futures)
[![Pesde Package](https://img.shields.io/badge/Pesde-F19D1E?style=flat-square&logo=data:image/svg%2bxml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMTAwIDEwMCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiIGQ9Ik00OS42MDI1IDBMOTIuOTAzOCAyNVY3NUw0OS42MDI1IDEwMEw2LjMwMTI3IDc1VjI1TDQ5LjYwMjUgMFpNMTQuMzAxMyAyOS42MTg4TDQ5LjYwMjUgOS4yMzc2TDg0LjkwMzggMjkuNjE4OFY3MC4zODEyTDQ5LjYwMjUgOTAuNzYyNEwzMy42MTQ4IDgxLjUzMTlWNjcuMzg0OEMzNC41MTY3IDY4LjUwNzEgMzUuNjM4OCA2OS40MjE1IDM2Ljk4MSA3MC4xMjc5QzM4Ljk3MDEgNzEuMTQ4IDQxLjAzNTcgNzEuNjU4IDQzLjE3NzkgNzEuNjU4QzQ2LjQ0MiA3MS42NTggNDkuMTQ1MiA3MC44OTI5IDUxLjI4NzMgNjkuMzYyOUM1My40ODA1IDY3Ljc4MTggNTUuMTEyNiA2NS43NjcyIDU2LjE4MzYgNjMuMzE5QzU3LjA5MTUgNjEuMzM4MiA1Ny42MzIgNTkuMjc0IDU3LjgwNTQgNTcuMTI2M0M1OS44NzIzIDU3Ljc0NTcgNjIuMjE1NyA1OC4wNTU0IDY0LjgzNTYgNTguMDU1NEM2Ny42OTE4IDU4LjA1NTQgNzAuMzY5NSA1Ny42NDczIDcyLjg2ODYgNTYuODMxM0M3NS4zNjc4IDU1Ljk2NDIgNzcuNDA3OSA1NC44MTY3IDc4Ljk4OSA1My4zODg2TDc1Ljc3NTggNDcuODAzOEM3NC41NTE3IDQ4LjkyNTggNzIuOTk2MSA0OS44NDM5IDcxLjEwOSA1MC41NTc5QzY5LjIyMTkgNTEuMjIxIDY3LjIwNzMgNTEuNTUyNSA2NS4wNjUyIDUxLjU1MjVDNjEuMzkyOSA1MS41NTI1IDU4LjY2NDMgNTAuNjg1NCA1Ni44NzkyIDQ4Ljk1MTNDNTYuNzE5NSA0OC43OTYyIDU2LjU2NyA0OC42MzY1IDU2LjQyMTcgNDguNDcyQzU1LjYxMDIgNDcuNTUzOSA1NS4wMjExIDQ2LjQ4OTYgNTQuNjU0NiA0NS4yNzkxTDU0LjY0NDMgNDUuMjQ1Mkw1NC42NjkgNDUuMjc5MUg3OS4yMTg1VjQxLjk4OTRDNzkuMjE4NSAzOS4wMzEzIDc4LjU1NTUgMzYuMzUzNiA3Ny4yMjk0IDMzLjk1NjVDNzUuOTU0MyAzMS41NTkzIDc0LjA5MjcgMjkuNjQ2NyA3MS42NDQ1IDI4LjIxODZDNjkuMjQ3NCAyNi43Mzk1IDY2LjM2NTcgMjYgNjIuOTk5NSAyNkM1OS42ODQzIDI2IDU2LjgwMjcgMjYuNzM5NSA1NC4zNTQ1IDI4LjIxODZDNTEuOTA2NCAyOS42NDY3IDUwLjAxOTMgMzEuNTU5MyA0OC42OTMyIDMzLjk1NjVDNDcuNjc0MyAzNS43OTgzIDQ3LjA0NjkgMzcuODA1NyA0Ni44MTA4IDM5Ljk3ODhDNDUuNjg4OCAzOS43MjggNDQuNDc3OCAzOS42MDI2IDQzLjE3NzkgMzkuNjAyNkM0MS4wMzU3IDM5LjYwMjYgMzguOTcwMSA0MC4xMTI3IDM2Ljk4MSA0MS4xMzI3QzM1LjMxNjIgNDEuOTY1MSAzMy45OTAyIDQzLjE1NDkgMzMuMDAyOCA0NC43MDIzVjQwLjM2NzdIMjAuNjg1NVY0Ni4yNTg1SDI1LjgxMTNWNzcuMDI2NkwxNC4zMDEzIDcwLjM4MTJWMjkuNjE4OFpNNTUuMTk2MSAzNi4wOTg2QzU0LjY1MjggMzcuMTAxNSA1NC4zMzIxIDM4LjEyMTYgNTQuMjM0IDM5LjE1ODhINzEuNzk3NkM3MS43OTc2IDM4LjAzNjcgNzEuNDQwNSAzNi45NDAxIDcwLjcyNjUgMzUuODY5MUM3MC4wNjM0IDM0Ljc0NyA2OS4wNjg5IDMzLjgwMzUgNjcuNzQyOCAzMy4wMzg0QzY2LjQ2NzcgMzIuMjczNCA2NC44ODY3IDMxLjg5MDggNjIuOTk5NSAzMS44OTA4QzYxLjExMjQgMzEuODkwOCA1OS41MDU4IDMyLjI5ODkgNTguMTc5OCAzMy4xMTQ5QzU2LjkwNDcgMzMuODggNTUuOTEwMSAzNC44NzQ1IDU1LjE5NjEgMzYuMDk4NlpNNDkuNjQ1MSA1MS41NjkyQzQ5LjMwNzYgNTAuNjY0MSA0OC44MzgxIDQ5Ljg3MSA0OC4yMzY3IDQ5LjE4OThDNDguMDg4NSA0OS4wMjE5IDQ3LjkzMjMgNDguODYwOSA0Ny43NjgxIDQ4LjcwNjdDNDYuMDg1IDQ3LjA3NDYgNDQuMDQ0OSA0Ni4yNTg1IDQxLjY0NzggNDYuMjU4NUM0MC4xMTc3IDQ2LjI1ODUgMzguNjEzMSA0Ni41NjQ1IDM3LjEzNCA0Ny4xNzY2QzM1Ljg1OTQgNDcuNjc3MyAzNC42ODYzIDQ4LjU0MzggMzMuNjE0OCA0OS43NzU5VjYxLjQ3QzM0LjY4NjMgNjIuNjY2NCAzNS44NTk0IDYzLjUzNzggMzcuMTM0IDY0LjA4NEMzOC42MTMxIDY0LjY5NjEgNDAuMTE3NyA2NS4wMDIxIDQxLjY0NzggNjUuMDAyMUM0NC4wNDQ5IDY1LjAwMjEgNDYuMDg1IDY0LjE4NjEgNDcuNzY4MSA2Mi41NTRDNDkuNDUxMiA2MC45MjE5IDUwLjI5MjggNTguNjAxMiA1MC4yOTI4IDU1LjU5MjFDNTAuMjkyOCA1NC4wNjc5IDUwLjA3NjkgNTIuNzI3IDQ5LjY0NTEgNTEuNTY5MloiIGZpbGw9IiNGRkZGRkYiPjwvcGF0aD4KPC9zdmc+)](https://pesde.daimond113.com/packages/yetanotherclown/luau_futures)

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

### Strictly Typed

Strict Typing is a feature, with API designed to work with the Luau type solver.

There are currently some restrictions, see below for more information.

### Functional

The API is designed to be functional, taking inspiration from the Rust futures crate.

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
