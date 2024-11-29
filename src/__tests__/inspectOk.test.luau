local JestGlobals = require("@DevPackages/JestGlobals")

local test = JestGlobals.test
local expect = JestGlobals.expect

local Futures = require("../init")
local Future = Futures.Future

test("inspectOk", function()
	expect.assertions(3)

	local myFuture = Future.new(function()
		return "a", "b", "c"
	end)

	myFuture:inspectOk(function(...)
		expect({ ... }).toEqual({ "a", "b", "c" })
	end)

	local result = myFuture:await()
	expect(result:isOk()).toBe(true)

	local values = { result:unwrapOk() }

	expect(values).toEqual({ "a", "b", "c" })
end)
