slaxml = require("app.utils.SLAXML.slaxml")

function parse(content, parser)
	print("parse content -->"..content)
	
	local ret = parser:parse(content, {stripWhitespce=true})
	return ret 
end