local StoryScene = class('StoryScene', function()
	return display.newScene("StoryScene")
end)


function StoryScene:readScript( idx )
	cotent = io.readfile("script"..idx.."")

end

function StoryScene:analyseScript(content)

end

function StoryScene:next()
	
end

function StoryScene:end()
	
end

return StoryScene