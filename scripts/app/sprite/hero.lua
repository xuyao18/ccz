local Hero = class("Hero", function()
    return display.newSprite(filename, x, y, params)
end)

function Hero:ctor( )
	--basic information 
	self.location = {x = 0, y = 0}
	self.hero = nil --node in layer map
	self.skills = {}
	self.items = {}
	self.army = nil --兵种
	self.name = nil

	--basic stats
	self.level = 0
	self.str = 0 
	self.ali = 0 
	self.inte = 0
	self.expl = 0
	self.HP = 0 
	self.MP = 0
	self.HPinc = 0 
	self.MPinc = 0
	self.move = 0 
	self.atk = 0 

	--attributes 
	self.attr_atk = 'S'
	self.attr_int = 'S'
	self.attr_def = 'S'
	self.attr_exp = 'S'
	self.attr_mor = 'S'

	-- equipment
	self.weapon = nil
	self.armor = nil 
	self.assist = nil 

	-- lines 
	self.story = nil
	self.critical = nil 
	self.die = nil 

	--images 
	self.face = nil 
	self.rimage = nil
	self.simage = nil 
	self.anims = {}

	--utility
	self.barea = {}
	self.confirm = {}

	--real time status
	self.nomagic = false
	self.nomove = false
	self.doom = false
	self.debuff = 0
	self.buff = 0
	self.bufftime = 0 
	self.debufftime = 0

	--mother pointers
	self.maplayer = nil 
	self.mapscene = nil 
end

function Hero:getHero(name)
	-- from data to hero class
end

function Hero:load(param)
	-- load hero from save file
end

function Hero:getEffectAtk( )
	-- body
end

function Hero:getAttack( )
	self.atk = self.str / 2 + self.attr_str * self.level
	
end

function Hero:getMoveArea()
	self.barea = self:getBasicArea(self.move)
	self.confirm = {}
	for idx , v in ipairs(barea) do
		confirm[v] = 0
	end
	self:MoveLoop(self.move , self.location.x , self.location.y, self.barea, self.confirm)
	return barea 
end

function Hero:getCost(x, y)
	local target = self.maplayer:getTile(x,y)
	if target:getHero() != nil then
		return 255
	end
	if target:getCost(self.army)

	return 1
end

function Hero:MoveLoop(m, x, y, arearange, confirm)
	k = table.keyof(arearange, {x,y})
	m = m - self:getCost(x,y)
	if (k == nil and m < 0) or confirm[{x,y}] == 4
		return
	if k == nil and m >=0 
		table.insert(arearange , {x, y})
	if m < 0 then 
		arearange[k] = nil 
		--table.remove(arearange, k)
	else
		m = m - self:getCost(x,y)
		confirm[{x, y }] = confirm[{x, y }] + 1
		self:MoveLoop(m, x - 1, y , arearange, confirm)
		self:MoveLoop(m, x , y + 1, arearange, confirm)
		self:MoveLoop(m, x + 1, y , arearange, confirm)
		self:MoveLoop(m, x , y - 1, arearange, confirm)
	end
end

function Hero:getBasicArea(range)
	--if move , range is hero's move , if magic , range can be set .
	--get the basic area the hero can move as below. easy math trick.
	--              *
	--             ***
	--            **H**
	--             ***
	--              *
	local areas = {}
	for i = 0, range , 1 do
		for j = i , 0 ,-1 do 
			table.insert(areas, {i + self.location.x , j + self.location.y})
			if self.location.x - i > 0 then
				table.insert(areas, {-i + self.location.x , j + self.location.y})
			end 
			if -j + self.location.y > 0 then
				table.insert(areas, {i + self.location.x , -j + self.location.y})
			end	
			if -i + self.location.x and -j + self.location.y then
				table.insert(areas, {-i + self.location.x , -j + self.location.y})
			end
		end
	end
	return areas
end

function Hero:persist()
	
end