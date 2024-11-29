local JestGlobals = require("@DevPackages/JestGlobals")

local describe = JestGlobals.describe
local test = JestGlobals.test
local expect = JestGlobals.expect

local Futures = require("../init")
local Future = Futures.Future

describe("await", function()
	test("immediate", function()
		local myFuture = Future.new(function()
			return "a", "b", "c"
		end)

		local result = myFuture:await()
		expect(result:isOk()).toBe(true)

		local values = { result:unwrapOk() }

		expect(values).toEqual({ "a", "b", "c" })
	end)

	test("yielding", function()
		local myFuture = Future.new(function()
			wait()
			return "a", "b", "c"
		end)

		local result = myFuture:await()
		expect(result:isOk()).toBe(true)

		local values = { result:unwrapOk() }

		expect(values).toEqual({ "a", "b", "c" })
	end)
end)
