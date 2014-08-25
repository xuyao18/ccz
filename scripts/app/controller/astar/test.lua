-- 
--  test.lua
--  lua-astar
--  
--  Created by Jay Roberts on 2011-01-12.
--  Copyright 2011 GloryFish.org. All rights reserved.
-- 
--  This is a simple test script which demonstrates the AStar class in use.
--


require 'astar'
require 'tiledmaphandler'
require 'profiler'


local handler = TiledMapHandler()
local astar = AStar(handler)

profiler = newProfiler()
profiler:start()

print 'Beginning...'

for i=1,2 do

   local start = {
     --x = math.random(1, 23),
     --y = math.random(1, 23)
     --u
     x = 2,
     y = 6
   }

   local goal = {
      --x = math.random(1, 23),
      --y = math.random(1, 23)

      x = 22,
      y = 22
   }
   
   -- print(string.format('Testing: (%i, %i) (%i, %i)', start.x, start.y, goal.x, goal.y))
   
   local path = astar:findPath(start, goal)

   for k,v in pairs(path.nodes) do 
       print(k)
       print("lid", v.lid)
       print("location", v.location.x, v.location.y)
   end
   print(path.totalCost)
end



print 'Done'

profiler:stop()

local outfile = io.open('profile.txt', 'w+')
profiler:report(outfile)
outfile:close()
