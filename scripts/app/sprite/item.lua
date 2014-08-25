local Item = class("Item", function()
    return display.newSprite(filename, x, y, params)
end)

function Item:ctor( )
	self.name = nil 
	self.type = nil --物品类型 ARMOR/WEAPON/ASSIT/CUST
	self.spec = nil -- 特殊效果
	self.spectxt = ""
	self.cust = nil --消耗品的效果
	self.prise = 0
	self.image = nil 
	self.data = 0 -- 效果数值
	self.sepcdata = 0  -- 特殊效果值
	self.levelinc = 0   -- 每一级增加的效果
	self.level = 0    -- 等级
	self.unitlimit = nil -- 单位限定
	self.area = nil   -- 作用范围
	self.story = nil  -- 说明文字
end

function Item:getItem( name )
	-- get item from data.lua
end

