God = {}
God.__index = God

God.data = nil 
God.imsg = nil
function God.loadData()
	data = require("app.engine.data")
	God.data = data.heros
end

function God.game_start()
	display.replaceScene(require("app.scenes.story"):new(), "fade", 0.6, display.COLOR_WHITE)
end

function God.game_load()
	
end

function God.game_setting()
	
end