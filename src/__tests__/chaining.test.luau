local JestGlobals = require("@DevPackages/JestGlobals")

local test = JestGlobals.test
local expect = JestGlobals.expect

local Futures = require("../init")
local Future = Futures.Future

test("chaining", function()
	expect.assertions(6)

	local myFuture = Future.new(function()
		return 1, 2, 3
	end)
		:andThen(function(a, b, c)
			return Future.new(function()
				expect({ a, b, c }).toEqual({ 1, 2, 3 })
				return tostring(a), tostring(b), tostring(c)
			end)
		end)
		:inspectOk(function(a, b, c)
			expect({ a, b, c }).toEqual({ "1", "2", "3" })
		end)
		:mapErr(function(_err)
			return "I don't expect an error here"
		end)
		:mapOk(function(a, b, c)
			expect({ a, b, c }).toEqual({ "1", "2", "3" })
			return false, true, 22
		end)
		:inspectOk(function(a, b, c)
			expect({ a, b, c }).toEqual({ false, true, 22 } :: { any })
		end)
		:orElse(function(_err)
			return Future.new(function()
				return false, true, 21
			end) :: any
		end)

	local result = myFuture:await()
	expect(result:isOk()).toBe(true)

	local values = { result:unwrapOk() }
	expect(values).toEqual({ false, true, 22 } :: { any })
end)
