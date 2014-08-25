local Hero = class("Hero", function()
    return display.newSprite(filename, x, y, params)
end)

function Hero:ctor( )
	self.location = {x = 0, y = 0}
	self.hero = nil --node in layer map
	self.skills = {}
	self.items = {}
	self.army = nil 
	self.name = nil

	self.str = 0 
	self.ali = 0 
	self.inte = 0
	self.expl = 0
	self.HP = 0 
	self.MP = 0
	self.HPinc = 0 
	self.MPinc = 0

	self.weapon = nil
	self.armor = nil 
	self.assist = nil 

	self.story = nil
	self.critical = nil 
	self.die = nil 

	self.face = nil 
	self.rimage = nil
	self.simage = nil 
end

function Hero:getHero(name)
	-- from data to hero class
end

function Hero:load(param)
	-- load hero from save file
end


