headoffset = 7

function trim(str)
  return (str:gsub("^%s*(.-)%s*$", "%1"))
end

function split(s, p, size)
    local rt= {}
    string.gsub(s, '[^'..p..']+', function(w) table.insert(rt, w) end )
    if size == nil then
   		return rt
	end
	if size == 3 then
		return rt[1],rt[2],rt[3]
	end
	if size == 4 then
		return rt[1],rt[2],rt[3],rt[4]
	end
	if size == 5 then
		return rt[1],rt[2],rt[3],rt[4],rt[5]
	end
end

function getHead( tab, name, offset)
	if string.sub(name, 1,1) == '!' then
		name = string.sub(name, 2, -1)
	end
	v = tab[name]
	if v == nil then
		return nil
	end
	if offset == nil then
		offset = headoffset
	end
	tolua.cast(v.head, "number")
	return string.format("res/head/%d.png", v.head + offset)
end

function getStobj(tab, name)
	if string.sub(name, 1,1) == '!' then
		name = string.sub(name, 2, -1)
	end
	v = tab[name]
	if v == nil then
		return nil
	end
	log(DEBUG, "name "..name .. "  image " .. v.image)
	tolua.cast(v.image, "number")
	return string.format("res/stobj/%d-1.png", (v.image * 2) + 1), string.format("res/stobj/%d-1.png",(v.image * 2) + 2)
end

function transfer(x, y)
	--x = tolua.cast(x, "number")
	--y = tolua.cast(y, "number")
	log(DEBUG, "x = "..x .. " y = "..y )
	widthrate = display.width / 106 
	heightrate = display.height / 66
	return display.width - x * widthrate, display.height - y*heightrate
end