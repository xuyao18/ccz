God = {}
God.__index = God

function God.game_start()
	display.replaceScene(require("scenes.story").new(), "fade", 0.6, display.COLOR_WHITE)
end

function God.game_load()
	
end

function God.game_setting()
	
end