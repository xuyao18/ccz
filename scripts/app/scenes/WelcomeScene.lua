local WelcomeScene = class("WelcomeScene", function()
	return display.newScene("WelcomeScene")
	end)

game = {}

function WelcomeScene:ctor()
	print "ctor"
	--items = {}

	--table.insert(items, {name="start", callback=self.start})
	--table.insert(items, {name="load", callback=self.load})
	--table.insert(items, {name="about", callback=self.about})
	--table.insert(items, {name="exit", callback=self.exit})
	--WelcomeScene.createMenuScene(items)
end

function WelcomeScene:onEnter()
	if device.platform == "android" then
        -- avoid unmeant back
        self:performWithDelay(function()
            -- keypad layer, for android
            local layer = display.newLayer()
            layer:addKeypadEventListener(function(event)
                if event == "back" then app.exit() end
            end)
            self:addChild(layer)

            layer:setKeypadEnabled(true)
        end, 0.5)
    end
end

function WelcomeScene:createMenuScene(items)
	local labels = {}
	for idx, item in ipairs(items) do
		local label = ui.newTTFLabelMenuItem({
			text = item.name, 
			listener = function ()item.callback() end
		})
		labels[#labels + 1] = label
	end
	local menu = ui.newMenu(labels)
	menu:alignItemsVertically()
	menu:setPosition(display.cx, display.cy)
	return menu
end

function WelcomeScene:start()
	
end

function  WelcomeScene:exit()
	os.exit()
end

function  WelcomeScene:load()
	
end

function WelcomeScene:about()
	
end