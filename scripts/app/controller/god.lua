God = {}
God.__index = God

God.data = nil 
God.item = nil 
God.force = nil 
God.terrian = nil 
God.store = nil 
God.variables = {}

function God:loadData()
	data = require("app.engine.data")
	God.data = data.heros
end

function God:start()
	display.replaceScene(require("app.scenes.story"):new(), "fade", 0.6, display.COLOR_WHITE)
end

function God:load()
	-- use data as save data 
	-- if in battle , read the battle data .
	-- if not , read the current script .
end

function God:save()
	-- save data into file
	-- battle data save format , under concideration
end

function God:setting()
	
end

function God:exit()
	-- body
end
