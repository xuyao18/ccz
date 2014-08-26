AI = {}
AI.__index = AI

local ai_type = {paattack = 1 , poattack = 2, defence = 3, ceattach = 4, tposition = 5, follow = 6, rpostion = 7}
--被动攻击, 主动攻击, 防守，攻击特定目标， 到达某地， 跟随， 逃跑至某地。
local physic_worth = {kill = 78, over10 = 14 , tgtless10 = 14, middle = 8, bad = -4, atklink = {10,4}, confuse = 8, tgtname = 4, tgtfirst = 8}
local skill_worth = {}
local postion_worth = {noinrange = 1, cure = 8, imcure = 58, tgtatk = 10, tgtgot = 9 , notgt = -1}

function AI:AIMove(unit, handler, x, y )
	-- ai move , get the action 
end

function AI:getPath( unit, handler, x, y)
	-- get the nearest path , using a star
end

function AI:getAction( unit, handler, x, y)
	-- after move , what to do next. 	
end

function AI:getWorth(starter, action, target)
	-- get action worth
end