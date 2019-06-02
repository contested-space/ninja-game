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
   if evt <= 40 then
      self:trigger_single_random()
   elseif evt <45  then
      self:trigger_diagonal_jars()
   elseif evt < 49 then
      self:trigger_full_line()
   end

end

function ObstacleGenerator:trigger_single_random()
   
--   obs = Obstacle:new(math.random(), 0, "piano")
   obs = Obstacle:new(math.random(), 0, random_object())
   
   self.obstacles[obs] = 1
end

function ObstacleGenerator:trigger_full_line()
   nbBoxes = math.random(2, 7)

   offset = math.random() - 0.5
   
   for i = 1, nbBoxes, 1
   do
      -- split the screen in N units and add N/2 to center things
      pos = i /nbBoxes - 0.5 / nbBoxes + offset
      obs = Obstacle:new(pos, i * 0.01, "jar0")
      self.obstacles[obs] = 1
   end
end

function ObstacleGenerator:trigger_diagonal_jars()
   nbBoxes = math.random(2, 7)

   direction = math.random(-1, 1)
   if direction == 1 then
      jar = "jar0"
   elseif direction == -1 then
      jar = "jar1"
   else
      jar = "box"
   end
   
   offset = math.random() - 0.5
   for i=1, nbBoxes, 1
   do
      pos = i /nbBoxes - 0.5 / nbBoxes + offset
      obs = Obstacle:new(pos, i * 0.1 * direction, jar)
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
