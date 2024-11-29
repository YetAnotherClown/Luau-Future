local JestGlobals = require("@DevPackages/JestGlobals")

local test = JestGlobals.test
local expect = JestGlobals.expect

local Futures = require("../init")
local Future = Futures.Future

test("mapOk", function()
	local myFuture = Future.new(function()
		return "a", "b", "c"
	end)

	myFuture:mapOk(function(a, b, c)
		return a == "a" and 1, b == "b" and 2, c == "c" and 3
	end)

	local result = myFuture:await()
	expect(result:isOk()).toBe(true)

	local values = { result:unwrapOk() }

	expect(values).toEqual({ 1, 2, 3 })
end)
