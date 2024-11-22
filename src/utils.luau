-- https://stackoverflow.com/questions/7526223/how-do-i-know-if-a-table-is-an-array/52697380#52697380
local function isArray(t)
	if type(t) ~= "table" then
		return false
	end

	if #t > 0 then
		return true
	end

	for _, _ in pairs(t) do
		return false
	end

	return true
end

local function printArray(arr, indentation: number): string
	local output = ""

	local indent = ""
	for _ = 1, indentation do
		indent ..= "\t"
	end

	local outerIndent = " "
	if #arr ~= 0 and string.len(indent) >= 1 then
		outerIndent = string.sub(indent, 1, string.len(indent) - 1)
	end

	for i, v in arr do
		local vOutput = if type(v) == "table" then prettyPrintTable(v, indentation + 1) else prettyPrint(v)

		output ..= `\n{indent}{vOutput},`

		if i == #arr then
			output ..= `\n`
		end
	end

	return `\{ {output}{outerIndent}\}`
end

local function printDictionary(dict, indentation: number): string
	local output = ""

	local indent = ""
	for _ = 1, indentation do
		indent ..= "\t"
	end

	local outerIndent = ""
	if string.len(indent) >= 1 then
		outerIndent = string.sub(indent, 1, string.len(indent) - 1)
	end

	for k, v in dict do
		local kOutput = if type(k) == "table" then prettyPrintTable(k, indentation + 1) else prettyPrint(k)
		local vOutput = if type(v) == "table" then prettyPrintTable(v, indentation + 1) else prettyPrint(v)

		output ..= `\n{indent}[{kOutput}] = {vOutput},`
	end

	return `\{ {output} \n{outerIndent}\}`
end

function prettyPrintTable(t: any, indentation: number): string
	if isArray(t) then
		return printArray(t, indentation)
	else
		return printDictionary(t, indentation)
	end
end

local function prettyPrintString(str)
	local singleFound = string.find(str, "'")
	local doubleFound = string.find(str, '"')

	if not doubleFound then
		return `"{str}"`
	elseif not singleFound then
		return `'{str}'`
	else
		str = string.gsub(str, '"', '\\"')
		str = string.gsub(str, "'", "\\'")
		return `"{str}"`
	end
end

function prettyPrint(...): string
	local output = {}

	for i = 1, select("#", ...) do
		local v = select(i, ...)

		if type(v) == "table" then
			output[i] = prettyPrintTable(v, 1)
			continue
		elseif type(v) == "string" then
			output[i] = prettyPrintString(v)
			continue
		end

		output[i] = tostring(v)
	end

	return table.concat(output, ", ")
end

return {
	prettyPrint = prettyPrint,
}
