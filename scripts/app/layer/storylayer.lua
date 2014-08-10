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
	dump(self.queue)
	for name,value in pairs(self.queue) do
		--dump(value)
	end
end

return StoryLayer