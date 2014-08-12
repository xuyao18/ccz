local StoryLayer = class("StoryLayer", function()
    return display.newLayer("StoryLayer")
end)

require("app.utils.util")
variable = {}
roles = {}
heads = {}


local StoryWidgetParser{
	["variableTest"] = function(value)
		table.insert(variable, value)
	end,
	["loadBackground"] = function(value)
		local path = nil
		if string.sub(value, 1, 5) == 'MMAP' then
			local idx = tolua.cast(number, string.sub(value,6))
			idx = idx - 1
			path = string.format("res/tmx/map/1- (%d).jpg", idx)
		else
			path = value
		-- background = display.newBackgroundTilesSprite(path)
		StoryLayer:setBackgroundImage(path, nil)
	end,
	["backGroundMusic"] = function(value)
		audio.preloadMusic(value)
	end,
	["headPortraitPlay"] = function(value)
		local name,length,width,id = split(value,",", 4)
		head = display.newSprite(name)
		head.setTag(id)
		table.insert(roles ,id)
	end,
	["headPortraitMove"] = function(value)
		local id , x, y = split(value, ',', 3)
		
	end,
	["headPortraitDisappear"] = function(value)
	end,
	["rolePlay"] = function(value)
		local name , x, y, idx, id = split(value, ',', 5)
	end,
	["roleMove"] = function(value)
	end,
	["dialogue"] = function(value)
	end,
	["storyAction"] = function(value)
	end,
	["ChoiceBox"] = function(value)
	end,
	["sonThings"] = function(value)
	end,
	["codeValueTest"] = function(value)
	end,
	["addCareerism"] = function(value)
	end,
	["delayTime"] = function(value)
	end,
	["SceneNameSet"] = function(value)
	end,
	["RShowMenu"] = function(value)
	end,
	["Plot"] = function(value)
	end,
	["Scene"] = function(value)
	end,
	["section"] = function(value)
	end,
}

function StoryLayer:ctor()
	self.queue = nil 	
end

function StoryLayer:setQueue(tab)
	self.queue = tab 
end

function StoryLayer:setGUI()
	--dump(self.queue)
	self:parseTable(self.queue)
end

function StoryLayer:parseTable(tab)
	for key,value in pairs(tab) do
		if (type(value) == "table") then 
			StoryLayer:parseTable(value)
		else
			if key =='head' then
			print("head->"..value)
		elseif key == 'text' then
			print("text->"..value)
		end	
	end
end

function StoryLayer:parseWidget(key, value)

end

return StoryLayer