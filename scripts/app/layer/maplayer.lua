local MapLayer = class("MapLayer", function()
    return display.newLayer("MapLayer")
end)

local MapParser{
	[""]: function(MapLayer)
		
	end
}

function MapLayer:ctor(path)
	self:load_map(path)
	self.currentX = 0
	self.currentY = 0
	self.layers = {}
end

function MapLayer:load_map(path)
	self.map =  CCTMXTiledMap:create(path)
	addChild(self.map)	
	local layers = self.map:getChildren()
	for idx, layer in ipairs(layers) do 
		tolua.cast(layer, "TMXLayer")
		local name = layer:getLayerName()
		self.layers[name] = layer
		--initial the walkable , items and some other things.
	end
	local xlength = self.map:getMapSize().width
	local ylength = self.map:getMapSize().height
	for i = 1 , xlength, 1 do 
		for j = 1 , ylength, 1 do
			--need to dump the data in area information 	
			self:mapAnalyse(i, j)
		end
	end
end

function MapLayer:mapAnalyse(x,y)
	
end

function MapLayer:oneTouch(event, points)
	local x, y  = points[1], points[2]
	if event == "began" then
		--select the tile
		-- if area , show area info 
		-- if unit , show move area 
		

	elseif event == "move" then
		--change direct view .
		self.map:setPositionX(x)
		self.map:setPositionY(y)
	end
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