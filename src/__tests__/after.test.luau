local JestGlobals = require("@DevPackages/JestGlobals")

local describe = JestGlobals.describe
local test = JestGlobals.test
local expect = JestGlobals.expect
local jest = JestGlobals.jest

local Futures = require("../init")
local Future = Futures.Future

describe("after", function()
	test("success", function()
		local myFuture = Future.new(function()
			return "a", "b", "c"
		end)

		local _mockSuccess, onSuccess = nil, function()
			return 1, 2, 3
		end

		local mockFailure, onFailure = jest.fn(function()
			error("This should never be called")
		end)

		local nextFuture = myFuture:after(function(result)
			if result:isOk() then
				return Future.new(onSuccess)
			else
				return Future.new(onFailure :: any)
			end
		end)

		local result = nextFuture:await()
		expect(result:isOk()).toBe(true)

		-- FUTURE: use jest.spyOn
		-- expect(mockSuccess).toHaveBeenCalled()
		expect(mockFailure).never.toHaveBeenCalled()

		local values = { result:unwrapOk() }
		expect(values).toEqual({ 1, 2, 3 })
	end)
end)
