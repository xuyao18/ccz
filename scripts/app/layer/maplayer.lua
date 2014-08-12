local MapLayer = class("MapLayer", function()
    return display.newLayer("MapLayer")
end)

local MapParser{
	
}


function load_map(path)
	local map =  CCTMXTiledMap:create(path)
	addChild(map)	
end




return MapLayer	