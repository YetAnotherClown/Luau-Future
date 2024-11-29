local JestGlobals = require("@DevPackages/JestGlobals")

local test = JestGlobals.test
local expect = JestGlobals.expect

local Futures = require("../init")
local Future = Futures.Future

test("andThen", function()
	local myFuture = Future.new(function()
		return "a", "b", "c"
	end)

	local nextFuture = myFuture:andThen(function()
		return Future.new(function()
			return 1, 2, 3
		end)
	end)

	local result = nextFuture:await()
	expect(result:isOk()).toBe(true)

	local values = { result:unwrapOk() }

	expect(values).toEqual({ 1, 2, 3 })
end)
