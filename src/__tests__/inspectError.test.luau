local JestGlobals = require("@DevPackages/JestGlobals")

local test = JestGlobals.test
local expect = JestGlobals.expect

local Futures = require("../init")
local Future = Futures.Future

test("inspectErr", function()
	local myFuture = Future.new(function()
		error("A", 0)
	end)

	myFuture:inspectErr(function(...)
		expect(...).toEqual("A")
	end)

	local result = myFuture:await()
	expect(result:isErr()).toBe(true)

	expect(result:unwrapErr()).toEqual("A")
	expect.assertions(3)
end)
