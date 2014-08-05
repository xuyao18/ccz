json = require("json")

function parse(content)
	local tab = {}
	if content != nil then
		tab = json.encode(content)
	end
	return tab
end