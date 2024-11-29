local JestGlobals = require("@DevPackages/JestGlobals")

local describe = JestGlobals.describe
local test = JestGlobals.test
local expect = JestGlobals.expect

local Futures = require("../init")
local Future = Futures.Future

describe("mapErr", function()
	test("to error", function()
		local myFuture = Future.new(function()
			error("A", 0)
		end)

		myFuture:mapErr(function(err)
			expect(err).toEqual("A")
			error("B", 0)
		end)

		local result = myFuture:await()
		expect(result:isErr()).toBe(true)

		local err = result:unwrapErr()
		expect(err).toEqual("B")
		expect.assertions(3)
	end)

	test("to string", function()
		local myFuture = Future.new(function()
			error("A", 0)
			return "A"
		end)

		myFuture:mapErr(function(err)
			expect(err).toEqual("A")
			return "B"
		end)

		local result = myFuture:await()
		expect(result:isErr()).toBe(true)

		local err = result:unwrapErr()
		expect(err).toEqual("B")
		expect.assertions(3)
	end)
end)
