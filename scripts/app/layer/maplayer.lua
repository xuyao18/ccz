local MapLayer = class("MapLayer", function()
    return display.newLayer("MapLayer")
end)

local MapParser{
	
}




function MapLayer:load_map(path)
	local map =  CCTMXTiledMap:create(path)
	addChild(map)	
end

function MapLayer:oneTouch(event, points)

end

function MapLayer:twoTouch(event, points)
end

function MapLayer:onTouch( event, points )
	if #points  == 1 then
		self:oneTouch(event, points)
	elseif #points == 2 then
		self:twoTouch(event, points)
	else
		log(DEBUG, "more than three points , ignore")
	end
end


return MapLayer	