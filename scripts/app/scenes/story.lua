local StoryScene = class('StoryScene', function()
	return display.newScene("StoryScene")
end)
scpt = require("app.script.storyscript")
stlay = require("app.layer.storylayer")

function StoryScene:ctor()
	self.script = nil
	self.content = nil
	self.layer = stlay.new()
	self.idx = 0
	self:analyseScript("res/plot/R_plot0.xml")
end

function StoryScene:analyseScript(path)
	self.content = io.readfile(path)
	--print(self.content)
	scpt.content = self.content
	--print("DUMP SCPT")
	--dump(scpt)
	--print("story content -> "..self.content)
	--print("DUMP SELF")
	--dump(self)
	self.script = scpt:analyse(self.content)
	self.layer.setQueue(self.script)
	self.layer.setGUI()
end

function StoryScene:next()
	
end

function StoryScene:finish()
	
end

return StoryScene