headoffset = 7

require("math")

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

function transfer(x, y, wresize, hresize)
	--x = tolua.cast(x, "number")
	--y = tolua.cast(y, "number")
	--widthrate = display.width / 106 
	--heightrate = display.height / 66
	--rawx = display.width - x * widthrate
	--rawy = display.height - y*heightrate
	--local radiam = 75
	--x = (rawx)*math.cos(math.rad(radiam)) - (rawy) * math.sin(math.rad(radiam)) 
	--y = (rawx)*math.sin(math.rad(radiam)) - (rawy) * math.cos(math.rad(radiam)) + 700
	--local a = (148 * x + 148 * y) / 480
	--local b = (58* x + 138 * y) / 854

	local a = ((150 - x - y) / 2 * 8 -4) * hresize
	local b = ((x - y + 42) / 2 * 16 -16) * wresize

	
	a = a + hresize * 20
	b = (b ) + wresize * 48
	print('x = ', x , 'y = ', y, 'a = ', a, 'b = ', b)

	return b, a
end