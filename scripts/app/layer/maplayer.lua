local MapLayer = class("MapLayer", function()
    return display.newLayer("MapLayer")
end)

require("app.data.const")
scpt = require("app.script.plotscript")

local MapParser{
	
}


local map_path = nil 
local map = nil 
local layers = nil 
local objects = nil
local scripts = nil 


function MapLayer:init_layer(tmxpath, scptpath)
	self.map_path = tmxpath 
	self.map = CCTMXTiledMap:create(tmxpath)
	self:analyse_layer()
	self:analyse_map()

	self.content = io.readfile(scptpath)
	scpt.content = self.content
	self.scripts = scpt:analyse(self.content)
	
	addChild(map)	
end

function MapLayer:analyse_map()

	local widthcount = self.map:getMapSize().width / TILE_WIDTH
	local heightcound = self.map:getMapSize().height / TILE_HEIGHT

	for i = 0, widthcount , 1 do
		for j = 0, heightcount, 1 do
			towerLoc = CCPoint(i,j)
			--map->getChildByTag(tag_number); // 0=1st layer, 1=2nd layer, 2=3rd layer, etc...

		end
	end
end

function MapLayer:analyse_layer()
	local curlayer = nil
	for idx, layer_name in ipairs(layer_names) do
		curlayer = self.map:layerNamed(layer_name)
		table.insert(layers, curlayer)
	end
	self.objects = self.map:getObjects()
end


return MapLayer	