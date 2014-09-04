AI = {}
AI.__index = AI

local ai_type = {paattack = 1 , poattack = 2, defence = 3, ceattach = 4, tposition = 5, follow = 6, rpostion = 7}

local physic_worth = {kill = 78, over10 = 14 , tgtless10 = 14, middle = 8, bad = -4, atklink = {10,4}, confuse = 8, tgtname = 4, tgtfirst = 8}
local skill_worth = {}
local postion_worth = {noinrange = 1, cure = 8, imcure = 58, tgtatk = 10, tgtgot = 9 , notgt = -1}

function AI:getMoveArea(unit)
	-- ai move , get the action 
	unit:get
end

function AI:getPath( unit, handler, tx, ty)
	-- get the nearest path , using a star
end

function AI:getAction( unit, handler, x, y)
	-- after move , what to do next. 	
	-- if paattack 
end

function AI:getWorth(starter, action, tx, ty)
	-- get action worth
end

function AI:getPhysicalWorth( starter, action, tx, ty)
	-- body
end

function AI:getMagicWorth( starter, action, tx, ty )
	-- body
end

function AI:doMove( starter, tx, ty )
	-- body
end

function AI:doAction( starter, target, action)
	--do the certain action 
end

function AI:getResult( starter, target )
	--get the action's result
end

function AI:aiRun(unit, handler)
	--1, get move area
	--pre2, get can phisical&magic area , and targets ,in list or dir
	--2, calc worth of every area , physic and magic 
	--3, get the highest worth postion 
	--4, get route to the postion got .
	--5, move to target , one tile by on tile 
	--6, after got target , do action 
	--7, done action return result .
end