local StoryLayer = class("StoryLayer", function()
    return display.newLayer("StoryLayer")
end)

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
end

return StoryLayer