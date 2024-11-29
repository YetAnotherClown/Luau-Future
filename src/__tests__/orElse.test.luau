local JestGlobals = require("@DevPackages/JestGlobals")

local test = JestGlobals.test
local expect = JestGlobals.expect

local Futures = require("../init")
local Future = Futures.Future

test("orElse", function()
	local myFuture = Future.new(function()
		error("A", 0)
	end)

	myFuture = myFuture:orElse(function(err)
		expect(err).toEqual("A")
		return Future.new(function()
			return 1, 2, 3
		end)
	end)

	local result = myFuture:await()
	expect(result:isOk()).toBe(true)

	local results = { result:unwrapOk() }
	expect(results).toEqual({ 1, 2, 3 })

	expect.assertions(3)
end)
