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
	for name,value in pairs(self.queue) do
		print(name)
		print(value)
	end
end

return StoryLayer