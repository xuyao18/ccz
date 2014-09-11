local BusinessLayer = class("BusinessLayer", function()
    return display.newLayer("BusinessLayer")
end)

function BusinessLayer:ctor()
	
end

function BusinessLayer:loadShop(index)
	-- read data from store.lua
end

function BusinessLayer:loadItem()
	-- get items from items.lua
end

function BusinessLayer:initGUI()
	-- init GUI system, using ccs
end

return BusinessLayer