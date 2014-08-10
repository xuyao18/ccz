slaxml = require("app.utils.SLAXML.slaxml")

function parse(content, parser)
	local ret = parser:parse(content, {stripWhitespce=true})
	return ret 
end