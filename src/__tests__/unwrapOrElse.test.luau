local JestGlobals = require("@DevPackages/JestGlobals")

local test = JestGlobals.test
local expect = JestGlobals.expect

local Futures = require("../init")
local Future = Futures.Future

test("unwrapOrElse", function()
	local myFuture = Future.new(function()
		error("A", 0)
	end)

	myFuture = myFuture:unwrapOrElse(function(err)
		expect(err).toEqual("A")
		return 1, 2, 3
	end)

	local result = myFuture:await()
	expect(result:isOk()).toBe(true)

	local results = { result:unwrapOk() }
	expect(results).toEqual({ 1, 2, 3 })

	expect.assertions(3)
end)
