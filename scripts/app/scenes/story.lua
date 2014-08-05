local StoryScene = class('StoryScene', function()
	return display.newScene("StoryScene")
end)
scpt = require("app.script.story")


function StoryScene:ctor()
	self.script = nil
	self.content = nil
	self.layer = require("app.layer.storylayer").new()
	self.idx = 0
end

function StoryScene:analyseScript(idx)
	self.content = io.readfile("script"..idx.."")
	self.script = scpt.analyse(self.content)
end

function StoryScene:next()
	
end

function StoryScene:finish()
	
end

return StoryScene