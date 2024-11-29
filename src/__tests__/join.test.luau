local JestGlobals = require("@DevPackages/JestGlobals")

local describe = JestGlobals.describe
local test = JestGlobals.test
local expect = JestGlobals.expect

local Futures = require("../init")
local Future = Futures.Future

describe("join", function()
	test("ok", function()
		local myFuture = Future.new(function()
			return "a", "b", "c"
		end)

		local nextFuture = myFuture:join(Future.new(function()
			return "d", "e", "f"
		end))

		local result = nextFuture:await()
		expect(result:isOk()).toBe(true)

		local values = result:unwrapOk()

		expect(values).toEqual({ "a", "b", "c", "d", "e", "f" })
	end)

	test("err", function()
		local myFuture = Future.new(function()
			error("A", 0)
		end)

		local nextFuture = myFuture:join(Future.new(function()
			error("B", 0)
		end))

		local result = nextFuture:await()
		expect(result:isOk()).toBe(true)

		local values = result:unwrapErr()

		expect(values[1]:unwrapErr()).toEqual("A")
		expect(values[2]:unwrapErr()).toEqual("B")
	end)
end)
