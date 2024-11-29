local JestGlobals = require("@DevPackages/JestGlobals")

local describe = JestGlobals.describe
local test = JestGlobals.test
local expect = JestGlobals.expect

local Futures = require("../init")
local Future = Futures.Future

describe("poll", function()
	test("immediate", function()
		local myFuture = Future.new(function()
			return "a", "b", "c"
		end)

		local poll = myFuture:poll()
		expect(poll:isReady()).toBe(true)

		local result = poll:unwrap()
		expect(result:isOk()).toBe(true)

		local values = { result:unwrapOk() }

		expect(values).toEqual({ "a", "b", "c" })
	end)

	test("yielding", function()
		local wait = wait
		local myFuture = Future.new(function()
			wait(0.1)
			return "a", "b", "c"
		end)

		local poll = myFuture:poll()
		expect(poll:isPending()).toBe(true)

		wait(0.1)

		poll = myFuture:poll()
		expect(poll:isReady()).toBe(true)

		local result = poll:unwrap()
		expect(result:isOk()).toBe(true)

		local values = { result:unwrapOk() }

		expect(values).toEqual({ "a", "b", "c" })
	end)
end)
