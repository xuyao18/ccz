local StoryScene = class('StoryScene', function()
	return display.newScene("StoryScene")
end)
require("app.script.story")

function StoryScene:ctor()
	self.script = nil
	self.content = nil
end

function StoryScene:analyseScript(idx)
	self.content = io.readfile("script"..idx.."")
	self.analyse(self.content)
end

function StoryScene:next()
	
end

function StoryScene:finish()
	
end

return StoryScene