# Future
**[View Docs](https://yetanotherclown.github.io/Luau-Future/)**

> A Minimal, Typed Future Implementation inspired by the concept of Futures from the Rust Ecosystem.


## Luau Futures

Futures are a Data-Driven approach to asynchronous calls, what this means is that Futures
represent a value that does not exist quite yet, similar to Promises.

Unlike Promises, Futures take on a Data-Driven approach as opposed to a Event-Driven approach.
Futures have no events for you to react to, there is no `andThen` or any other event-like methods
or functions for Futures. 

In order to use Futures, you must do something called polling, you can call `isReady` to see if the
future has a result ready, and then you can call `output` to receive a result.
The future can either be ok or an error, you can use the `ok` and `error` methods respectively to check.
To get the value `T` or `Error` you can call the `unwrap` method on the result.

---

### Why use this?

Don't. Use Promises. You shouldn't need to use this and shouldn't unless it fits a certain use case.
Promises have Chaining, Joining, Cancellation, and many more features that Futures don't have.

Futures are simply a lightweight alternative to Promises that uses long polling. Any gains you may get from
using Futures will be so insignificant you'd only be hurting yourself by using them in most cases.

> See [Roblox Lua Promise](https://eryn.io/roblox-lua-promise/)
> and [Why Use Promises?](https://eryn.io/roblox-lua-promise/docs/WhyUsePromises) by Evaera


### Why I use Luau Futures

When writing code that ran every frame I found myself needing to represent yielding asynchronous calls in a way where
I could store the future value and use it in a future frame. Promises felt like a good first step, but it just felt like
they did not fit the Data-Driven architecture I was going for, with Promises being Event-Driven.

So here comes Luau Futures, a Data-Driven Approach to handling asynchronous code,
built for a library such as [Matter](https://github.com/evaera/matter), which had no built-in method for handling Asynchronous Calls.

---

### Basic Usage

```lua
local Future = require(path.to.module)

-- Create a future
local myFuture = Future.new(function(...)
    -- Something that yields
end, ...)

-- Poll the Future to see if it is ready.
if future:isReady() then
    local result = myFuture:output()

    if result:ok() then
        local returnedValues = result:unwrap()
        -- Do something
    elseif result:error() then
        warn(result:unwrap())
    end
elseif myFuture:isPending() then
    -- Poll the Future to see if it is still pending.

    warn("Future is still pending!")
end
```

In a [Matter](https://github.com/evaera/matter) System:
```lua
-- Basic concept of Futures in a Matter System
local function exampleSystem(world)

    -- Create Futures
    for id in world:query():without(Future) do
        world:insert(id, Future {
            future = Future.new(function()
                -- Something that yields
            end)
        })
    end

    -- Poll Futures
    for id, future in world:query(Future) do
        local future = future.future

        if future:isReady() then
            local result = myFuture:output()

            if result:ok() then
                local returnedValues = result:unwrap()
                -- Do something
            elseif result:error() then
                warn(result:unwrap())
            end

            world:remove(id, Future)
        end
    end
end
```

---

### Installing with Wally

```toml
[dependencies]
Future = "yetanotherclown/future@1.0.0"
```

Note: Wally does not export types automatically and will display a type-error in one of the Dependencies.
To fix this, see https://github.com/JohnnyMorganz/wally-package-types.

### Building with Rojo

To build yourself, use: 
```bash
rojo build -o "Future.rbxm"
```

For more help, check out [the Rojo documentation](https://rojo.space/docs).