# Future
**[View Docs](https://clownxz.github.io/Luau-Future/)**

> A Minimal, Typed Future Implementation inspired by the concept of Futures from the Rust Ecosystem.


## Luau Futures

Futures represent a value that does not exist quite yet, similar to Promises. This makes
Futures or Promises perfect to use when handling asynchronous calls.

---

### Why use this?

Don't. Use Promises. You shouldn't need to use this and shouldn't unless it fits a certain use case.

Promises have Chaining, Joining, Cancellation, and many more features that Futures don't have.

Futures are simply
built to be performant, unlike Promises. Even then, the performance gains you may see will be so insignificant
you'd only be hurting yourself by using Futures.

> See [Roblox Lua Promise](https://eryn.io/roblox-lua-promise/)
> and [Why Use Promises?](https://eryn.io/roblox-lua-promise/docs/WhyUsePromises) by Evaera


### Why I use Luau Futures

I needed to represent dozens of values from asynchronous calls within a single frame, each frame. Promises proved to not be performant and full of unnecessary features I had no need of, this is where Luau Futures comes in.

I built Luau Futures to be used within systems that run every frame, built for a library such as [Matter](https://github.com/evaera/matter), which had no built-in method for handling Asynchronous Calls.

With minimal features and with use of my [ThreadPool](https://github.com/Clownxz/ThreadPool) library, I created a minimal and performant alternative to promises fit for my use case.

---

### Basic Usage

```lua
local Future = require(path.to.module)

-- Create a future
local myFuture = Future(function(...)
    -- Something that yields
end, ...)

-- Poll the Future to see if it is ready.
if myFuture:isReady() then
    local ... = myFuture:output()
    
    -- Do something
end

-- Poll the Future to see if it is still pending.
if myFuture:isPending() then
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
            future = Future(function()
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
                local returnedValues = result()
                -- Do something
            elseif result:error() then
                warn(result())
            end

            world:remove(id, Future)
        end
    end
end
```

---

### Building with Rojo

To build yourself, use: 
```bash
rojo build -o "Future.rbxm"
```

For more help, check out [the Rojo documentation](https://rojo.space/docs).