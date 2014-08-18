local StoryLayer = class("StoryLayer", function()
    return display.newLayer("StoryLayer")
end)

require("app.utils.util")
require("app.engine.data")
variable = {}
roles = {}
heads = {}
walkanimation = {}
localheros = heros
resize = 1

local StoryWidgetParser = {
	["variableSet"] = function(value)
	end,
	["variableTest"] = function(value)
		table.insert(variable, value)
	end,
	["loadBackground"] = function(sl , value)
		local path = nil
		if string.sub(value, 1, 4) == 'MMap' then
			local idx = string.sub(value,6)
			tolua.cast(idx ,"number")
			idx = idx - 1
			path = string.format("res/tmx/map/1- (%d).jpg", idx)
		else
			path = value
		end
		log(DEBUG, "load background "..path)
		background = display.newSprite(path)
		local rect = background:boundingBox()
		dump(rect)
		resize = display.width / rect.size.width
		background:setPosition(CCPoint(display.cx, display.cy))
		background:setScale(resize)
		sl:addChild(background)
		-- background = display.newBackgroundTilesSprite(path)
		-- StoryLayer:setBackgroundImage(path, nil)
	end,
	["backGroundMusic"] = function(self, value)
		audio.preloadMusic(value)
	end,
	["headPortraitPlay"] = function(self, value)
		local name,x,y,id = split(value,",", 4)
		local head = getHead(localheros, name)
		local spHead = display.newSprite(head)
		spHead:setTag(id)
		spHead:setPosition(ccp(x, y))
		StoryLayer:addChild(spHead)
		roles[id] = spHead
	end,
	["headPortraitMove"] = function(self, value)
		local id , x, y = split(value, ',', 3)
		local action = cc.MoveTo(x,y)
		roles[id]:runAction(action)
	end,
	["headPortraitDisappear"] = function(value)
		local id = value
		local action = CCAction()
		roles[id]:runAction(action) -- wrong
		roles[id]:cleanup()-- clean up this node , this clean up must behind the disaper action 
		roles[id] = nil      
	end,
	["rolePlay"] = function(self, value)
		
		local name , x, y, idx, id = split(value, ',', 5)
		local path1, path2 = getStobj(localheros, name)
		local role = display.newSprite()
		local sharedTextureCache = CCTextureCache:sharedTextureCache()
		local texture1 = sharedTextureCache:addImage(path1)
		local texture2 = sharedTextureCache:addImage(path2)
		tolua.cast(idx, "number")
		local currentFrame = CCSpriteFrame:createWithTexture(texture1, CCRect(0,64*(idx-1),48,64))
		local walkframe1 = CCSpriteFrame:createWithTexture(texture1, CCRect(0,64*1,48,64))
		local walkframe2 = CCSpriteFrame:createWithTexture(texture1, CCRect(0,64*2,48,64))
		
		local walkarray = CCArray:create()
		walkarray:addObject(walkframe1)
		walkarray:addObject(walkframe2)
		local walkanim = CCAnimation:createWithSpriteFrames(walkarray, 0.1)
		walkanimation[id] = walkanim
		role:setDisplayFrame(currentFrame)
		role:setScale(resize)

		log(DEBUG, "loading role "..path1.. "  "..path2)
		
		x, y = transfer(x, y)
		role:setPosition(CCPoint(x,y))
		self:addChild(role)
		roles[id] = role
	end,
	["roleMove"] = function(self, value)
		dump(roles)
		local moves = split(value, "@")
		for idx, move in ipairs(moves) do
			local x,y,id = split(move, ",", 3)
			if string.sub(x, 1,1) == '*' then
				x = string.sub(x, 2, -1)
			end
			if string.find(id , "_") ~= nil then
				ids = split(id, "_")
				log(DEBUG, transfer(x, y))
				for pidx , perid in ipairs(ids) do
					transition.execute(roles[perid], CCMoveTo:create(1.5, CCPoint(transfer(x, y))), {
  					delay = 0,
    				easing = "backout",
    				onComplete = function()
        			log(DEBUG, "move completed")
    			end,		
    			})
				end
			else
				log(DEBUG, "move :"..move)
				log(DEBUG, transfer(x, y))
				transition.execute(roles[id], CCMoveTo:create(1.5, CCPoint(transfer(x, y))), {
  				delay = 0,
    			onComplete = function()
        			log(DEBUG, "move completed")
    			end,
				})
			end
		end
	end,
	["dialogue"] = function(self, value)
	end,
	["storyAction"] = function(self, value)
	end,
	["ChoiceBox"] = function(self, value)
	end,
	["sonThings"] = function(self, value)
	end,
	["codeValueTest"] = function(self, value)
	end,
	["addCareerism"] = function(self, value)
	end,
	["delayTime"] = function(self, value)
	end,
	["SceneNameSet"] = function(self, value)
	end,
	["RShowMenu"] = function(self, value)
	end,
	["Plot"] = function(self, value)
	end,
	["Scene"] = function(self, value)
	end,
	["section"] = function(self, value)
	end,
}

function StoryLayer:ctor()
	self.queue = nil 	
	log(DEBUG,"story layer ctor..")
	--self:addChild(nil)
end

function StoryLayer:setQueue(tab)
	self.queue = tab 
end

function StoryLayer:setGUI()
	--dump(self.queue)
	self:parseTable(self.queue)
end

function StoryLayer:parseTable(tab)
	local k = nil 
	local v = nil 
	for key,value in pairs(tab) do
		if (type(value) == "table") then 
			self:parseTable(value)
		elseif key =='head' then
			log(INFO,"head->"..value)
			k = value
		elseif key == 'text' then
			log(INFO, "text->"..value)
			v = value
		end	
		if k ~= nil and v ~= nil then
			self:parseWidget(k, v)
			k = nil 
			v = nil
		end
	end
end

function StoryLayer:parseWidget(key, value)
	log(INFO, "key is " .. key)
	f = StoryWidgetParser[key]
	f(self, value)

end

return StoryLayer