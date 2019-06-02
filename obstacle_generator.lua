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

function ObstacleGenerator:trigger()
   evt = math.random(0, 100)  
   if evt <= 1 then
      self:trigger_full_line()
   elseif evt < 2 then
      self:trigger_diagonal_jars()
   else
      self:trigger_single_random()
   end

end

function ObstacleGenerator:trigger_single_random()
   
--   obs = Obstacle:new(math.random(), 0, "piano")
   obs = Obstacle:new(math.random(), 0, random_object())
   
   self.obstacles[obs] = 1
end

function ObstacleGenerator:trigger_full_line()
   for i = 0, 9, 1
   do
      obs = Obstacle:new(i * 0.1, 0.1, "jar0")
      self.obstacles[obs] = 1
   end
end

function ObstacleGenerator:trigger_diagonal_jars()
   for i=0, 9, 1
   do
      obs = Obstacle:new(i * 0.1 + 0.05, i * 0.1, "jar0")
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


function random_object()
   obj = math.random(1, 5)
   objects = {"box",
	      "big_piano",
	      "jar0",
	      "jar1",
	      "piano"}
   return objects[obj]
end
