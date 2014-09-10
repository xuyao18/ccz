local StoryLayer = class("StoryLayer", function()
    return display.newLayer("StoryLayer")
end)

require("app.utils.util")
require("app.engine.data")
RichLabel = require("app.layer.RichLabel")
variable = {}
roles = {}
heads = {}
walkanimation = {}
localheros = heros
wresize = 1
hresize = 1

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
		wresize = display.width / rect.size.width
		hresize = display.height / rect.size.height
		print("width, ", display.width, "height ", display.height)
		print("hresize ", hresize, "wresize ", wresize)
		background:setPosition(CCPoint(display.cx, display.cy))
		background:setScaleX(wresize)
		background:setScaleY(hresize)
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
		
		local name , x, y, dir, id = split(value, ',', 5)
		local path1, path2 = getStobj(localheros, name)
		local role = display.newSprite()
		local sharedTextureCache = CCTextureCache:sharedTextureCache()
		local texture1 = sharedTextureCache:addImage(path1)
		local texture2 = sharedTextureCache:addImage(path2)
		tolua.cast(dir, "number")
		local frameset1 = {}
		local frameset2 = {}
		for i = 0 , 20, 1 do
			local frame1 = CCSpriteFrame:createWithTexture(texture1, CCRect(0,64*(i),48,64))
			local frame2 = CCSpriteFrame:createWithTexture(texture2, CCRect(0,64*(i),48,64))
			table.insert(frameset1, frame1)
			table.insert(frameset2, frame2)
			frame1:retain()
			frame2:retain()
		end

		-- dir:
		-- 0 右上   id * 2 + 2           fmset2
		-- 1 右下   id * 2 + 1  reverse  fmset1
		-- 2 左下   id * 2 + 1           fmset1
		-- 3 左上   id * 2 + 2  reverse  fmset2
		-- 65535 无

		local currentFrame = nil 
		if dir == "0" then
			currentFrame = frameset2[1]
			--role:setFlipX(true)
		elseif dir == "1" then
			currentFrame = frameset1[1]
			role:setFlipX(true)
		elseif dir == "2" then
			currentFrame = frameset1[1]
			
		elseif dir == "3" then
			currentFrame = frameset2[1]
        end

		role:setDisplayFrame(currentFrame)
		role:setScale(wresize)

		log(DEBUG, "loading role "..path1.. "  "..path2)
		role['dir'] = dir
		role['frameset1'] = frameset1
		role['frameset2'] = frameset2
		x, y = transfer(x, y, wresize, hresize)
		role:setPosition(CCPoint(x,y))
		role["name"] = name
		self:addChild(role)
		roles[id] = role
		role:retain()
	end,
	["roleMove"] = function(self, value)
		local moves = split(value, "@")
		for idx, move in ipairs(moves) do
			local x,y,id = split(move, ",", 3)
			if string.sub(x, 1,1) == '*' then
				x = string.sub(x, 2, -1)
			end
			local role = roles[id]
			local walkframe1 = nil 
			local walkframe2 = nil 
			if role['dir'] == "0" then
				walkframe1 = role['frameset2'][2]
				walkframe2 = role['frameset2'][3]
			elseif role['dir'] == "1" then
				walkframe1 = role['frameset1'][2]
				walkframe2 = role['frameset1'][3]
				role:setFlipX(true)
			elseif role['dir'] == "2" then
				walkframe1 = role['frameset1'][2]
				walkframe2 = role['frameset1'][3]
			elseif role['dir'] == "3" then
				walkframe1 = role['frameset2'][2]
				walkframe2 = role['frameset2'][3]
				role:setFlipX(true)
			end
			local walkarray = CCArray:create()
			walkarray:addObject(walkframe1)
			walkarray:addObject(walkframe2)
			local walkanim = CCAnimation:createWithSpriteFrames(walkarray, 0.1)
			role:playAnimationForever(walkanim, 0)
			transition.execute(role, CCMoveTo:create(1.0, CCPoint(transfer(x, y, wresize, hresize))), {
  			delay = 0,
    		onComplete = function()
    			transition.stopTarget(role)
    		end,
			})
			
		end
	end,
	["dialogue"] = function(self, value)
		local id, title , line = split_dlg(value)
		print("id ", id , " titile ", title, " line " , line)
		local role = roles[id]
		local head = getHead(heros, role["name"])
		local str = "[background=dlg_bg.png] [/background][head=%s]口[/head][color=a number=998]%s[/color]"
		str = string.format(str, head, line)
		print("str", str)
    	local ricLab = RichLabel.new({str=str, font="Microsoft Yahei", fontSize=12, rowWidth=230, rowSpace = -2})
   		ricLab:setPosition(ccp(display.cx-200, display.height-50))
   	 	self:addChild(ricLab)

    -- 添加事件监听函数
    	local function listener(button, params)
        	print("click dialog.", params.text, params.tag, params.number)
    	end
    	ricLab:setClilckEventListener(listener)
	end,
	["storyAction"] = function(self, value)
		local frame, dir, id = split(value, "," , 3)
		print(frame, dir, id)
		frame = frame + 1
		-- dir:
		-- 0 右上   id * 2 + 2           fmset2
		-- 1 右下   id * 2 + 1  reverse  fmset1
		-- 2 左下   id * 2 + 1           fmset1
		-- 3 左上   id * 2 + 2  reverse  fmset2
		-- 65535 无
		local idx = 0;
		local role = roles[id]
		if dir == '0' or dir == '3' then
			idx = id * 2 + 2
			role:setDisplayFrame(role['frameset2'][frame])
		elseif dir == '1' or dir == '2' then
			idx = id * 2 + 1
			role:setDisplayFrame(role['frameset1'][frame])
		end
		if dir == '1' or dir == '3' then
			role:setFlipX(true)
		end
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
	["sceneIntroduce"] = function(self, value)
	end,
	["section"] = function(self, value)
	end,
}

function StoryLayer:ctor()
	self.queue = nil 	
	self.scpidx = 1
	self.scpqueue = {}
	log(DEBUG,"story layer ctor..")
	--self:addChild(nil)
end

function StoryLayer:setQueue(tab)
	self.queue = tab 
end

function StoryLayer:setGUI()
	--dump(self.queue)
	log(DEBUG, "SET GUI..")
	self:parseTable(self.queue)
	self:setTouchEnabled(true)
	self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
	
		if event.name == "began"or event.name == "added" then
			ret = self:doAction()
		end
		return false
	end)
	
end

function StoryLayer:doAction()
	--log(DEBUG, "doing action..")
	if self.scpidx > #self.scpqueue then
		log(DEBUG, "done")
		return false
	end
	k,v = self.scpqueue[self.scpidx][1],self.scpqueue[self.scpidx][2]
	self:parseWidget(k, v)
	self.scpidx = self.scpidx + 1
	return true
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
			
			table.insert(self.scpqueue, {k,v})
			k = nil 
			v = nil
		end
	end
end

function StoryLayer:parseWidget(key, value)
	log(DEBUG, "key is " .. key)
	f = StoryWidgetParser[key]
	f(self, value)

end

return StoryLayer