local game = class('game', function()
	return display.newScene("game")
end)

require("app.controller.god")

function game:ctor()
	items = {}
	table.insert(items, {name="start", cb=self.start})
	local m = self:createMenuScene(items)
	self:addChild(menu)
end

function game:startup()
	CCFileUtils:sharedFileUtils():addSearchPath("res/")

	game.enterMenuScene()
end

function game:ententerMenuScene()
	display.replaceScene(require("scenes.MainScene").new(), "fade", 0.6, display.COLOR_WHITE)
end

function game:createMenuScene(items)
	local labels = {}
	for idx, item in ipairs(items) do
		local label = ui.newTTFLabelMenuItem({
			text = item.name, 
			listener = function ()item.cb() end
		})
		labels[#labels + 1] = label
	end
	menu = ui.newMenu(labels)
	menu:alignItemsVertically()

	menu:setPosition(display.cx, display.cy)
	--self:addChild(menu)
	return menu
end

function game:start( ... )
	God.start()
	
end

function  game:exit()
	os.exit()
end

function  game:load()
	
end

function game:about()
	
end

return game