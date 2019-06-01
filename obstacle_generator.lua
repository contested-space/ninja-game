require "obstacle"

ObstacleGenerator = {}
ObstacleGenerator.__index = ObstacleGenerator

function ObstacleGenerator:new()
   local og
   og = {}
   setmetatable(og, ObstacleGenerator)

   og.obstacles = {}
   
   
   return og
end

function ObstacleGenerator:trigger_full_line()
   for i = 0, 10, 1
   do
      obs = Obstacle:new(i, 100)
      -- table.insert(self.updateable, obs)
      -- table.insert(self.drawable, obs)
      self.obstacles[obs] = 1
   end
end

function ObstacleGenerator:update(dt)
   for obs, _ in next, self.obstacles do
      if obs ~= nil then
	 obs:update(dt)
      end
   end
end


function ObstacleGenerator:draw(dt)
   for obs, _ in next, self.obstacles do
      if obs ~= nil then
	 obs:draw(dt)
      end
   end
end

function ObstacleGenerator:destroy(obs)
   if obs ~= nil then
      self.obstacles = remove_element(self.obstacles, obs)
   end
end

function remove_element(t, k)
   output = {}
   for obs, val in next, t do
      if k ~= obs then
	 output[obs] = val
      end
   end
   return output
end
