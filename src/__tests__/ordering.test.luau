local JestGlobals = require("@DevPackages/JestGlobals")

local test = JestGlobals.test
local expect = JestGlobals.expect
local describe = JestGlobals.describe

local Futures = require("../init")
local Future = Futures.Future

describe("ordering", function()
	test("chaining", function()
		expect.assertions(7)

		local callOrder = {}

		local myFuture = Future.new(function()
			table.insert(callOrder, "A")
			return 1, 2, 3
		end)
			:andThen(function(a, b, c)
				return Future.new(function()
					table.insert(callOrder, "B")
					expect({ a, b, c }).toEqual({ 1, 2, 3 })
					return tostring(a), tostring(b), tostring(c)
				end)
			end)
			:inspectOk(function(a, b, c)
				table.insert(callOrder, "C")
				expect({ a, b, c }).toEqual({ "1", "2", "3" })
			end)
			:mapErr(function(_err)
				table.insert(callOrder, "Should not be called")
				return "I don't expect an error here"
			end)
			:mapOk(function(a, b, c)
				table.insert(callOrder, "D")
				expect({ a, b, c }).toEqual({ "1", "2", "3" })
				return false, true, 22
			end)
			:inspectOk(function(a, b, c)
				table.insert(callOrder, "E")
				expect({ a, b, c }).toEqual({ false, true, 22 } :: { any })
			end)
			:orElse(function(_err)
				table.insert(callOrder, "Should not be called")
				return Future.new(function()
					return false, true, 21
				end) :: any
			end)

		local result = myFuture:await()
		expect(result:isOk()).toBe(true)

		local values = { result:unwrapOk() }
		expect(values).toEqual({ false, true, 22 } :: { any })

		expect(callOrder).toEqual({ "A", "B", "C", "D", "E" })
	end)
end)
