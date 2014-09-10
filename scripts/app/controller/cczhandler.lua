require 'astar.middleclass'

CczHandler = clazz('CczHandler')

function CczHandler:initialize()
	log(DEBUG, "cczhandler init..")
end

function CczHandler:getNode(location)
	-- Here you make sure the requested node is valid (i.e. on the map, not blocked)
  if location.x > #self.tiles[1] or location.y > #self.tiles then
    -- print 'location is outside of map on right or bottom'
    return nil
  end

  if location.x < 1 or location.y < 1 then
    -- print 'location is outside of map on left or top'
    return nil
  end

  if self.tiles[location.y][location.x] == 1 then
    -- print(string.format('location is solid: (%i, %i)', location.x, location.y))
    return nil
  end

  return Node(location, 1, location.y * #self.tiles[1] + location.x)
end

function CczHandler:getAdjacentNodes(curnode, dest)
  -- Given a node, return a table containing all adjacent nodes
  -- The code here works for a 2d tile-based game but could be modified
  -- for other types of node graphs
  local result = {}
  local cl = curnode.location
  local dl = dest
  
  local n = false
  
  n = self:_handleNode(cl.x + 1, cl.y, curnode, dl.x, dl.y)
  if n then
    table.insert(result, n)
  end

  n = self:_handleNode(cl.x - 1, cl.y, curnode, dl.x, dl.y)
  if n then
    table.insert(result, n)
  end

  n = self:_handleNode(cl.x, cl.y + 1, curnode, dl.x, dl.y)
  if n then
    table.insert(result, n)
  end

  n = self:_handleNode(cl.x, cl.y - 1, curnode, dl.x, dl.y)
  if n then
    table.insert(result, n)
  end
  
  return result
end

function CczHandler:locationsAreEqual(a, b)
  return a.x == b.x and a.y == b.y
end

function CczHandler:_handleNode(x, y, fromnode, destx, desty)
  local loc = {
    x = x,
    y = y
  }
  
  local n = self:getNode(loc)
  
  if n ~= nil then
    local dx = math.max(x, destx) - math.min(x, destx)
    local dy = math.max(y, desty) - math.min(y, desty)
    local emCost = dx + dy
    
    n.mCost = n.mCost + fromnode.mCost
    n.score = n.mCost + emCost
    n.parent = fromnode
    
    return n
  end
  
  return nil
end
