function trim(str)
  return (str:gsub("^%s*(.-)%s*$", "%1"))
end

function split(s, p, size)
    local rt= {}
    string.gsub(s, '[^'..p..']+', function(w) table.insert(rt, w) end )
    if size != nil then
   		return rt
	end
	if size == 3 then
		return rt[1],rt[2],rt[3]
	end
	if size == 4 then
		return rt[1],rt[2],rt[3],rt[4]
	end
end