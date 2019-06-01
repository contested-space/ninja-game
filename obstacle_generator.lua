require "obstacle"

ObstacleGenerator = {}
ObstacleGenerator.__index = ObstacleGenerator

function ObstacleGenerator:new()
   local og
   og = {}
   setmetatable(og, ObstacleGenerator)
   og.updateable = {}
   og.drawable = {}
   
   return og
end

function ObstacleGenerator:trigger_full_line()
   for i = 0, gridWidth, 1
   do
      obs = Obstacle:new(i, 100)
      table.insert(self.updateable, obs)
      table.insert(self.drawable, obs)
   end
end

function ObstacleGenerator:update(dt)
   for _, value in next, self.updateable do
      value:update(dt)
   end
end


function ObstacleGenerator:draw(dt)
   for _, value in next, self.drawable do
      value:draw(dt)
   end
end
