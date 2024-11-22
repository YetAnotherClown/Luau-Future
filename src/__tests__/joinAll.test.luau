local JestGlobals = require("@DevPackages/JestGlobals")

local test = JestGlobals.test
local expect = JestGlobals.expect

local Futures = require("../init")
local Future = Futures.Future

test("joinAll", function()
	local myFuture = Future.new(function()
		return "a", "b", "c"
	end)

	local nextFuture = myFuture:joinAll(
		Future.new(function()
			return "d", "e", "f"
		end),
		Future.new(function()
			return "g", "h", "i"
		end),
		Future.new(function()
			return "j", "k", "l"
		end)
	)

	local result = nextFuture:await()
	expect(result:isOk()).toBe(true)

	local values = { result:unwrapOk() }

    -- stylua: ignore
	expect(values).toEqual({
        "a", "b", "c",
        "d", "e", "f",
        "g", "h", "i",
        "j", "k", "l",
    })
end)
