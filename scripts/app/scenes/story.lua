local StoryScene = class('StoryScene', function()
	return display.newScene("StoryScene")
end)
scpt = require("app.script.plotscript")
stly = require("app.layer.storylayer")
require("app.utils.log")

function StoryScene:ctor()
	self.script = nil
	self.content = nil
	self.layer = stly:new()
	self.idx = 0
	self:addChild(self.layer)
	self:analyseScript("res/plot/R_plot0.xml")
end

function StoryScene:analyseScript(path)
	self.content = io.readfile(path)
	scpt.content = self.content
	self.script = scpt:analyse(self.content)
	self.layer:setQueue(self.script)
	self.layer:setGUI()
end

function StoryScene:next()
	
end

function StoryScene:finish()
	
end

return StoryScene