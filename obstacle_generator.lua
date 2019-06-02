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
   evt = math.random()
   if evt <= 0.8 then
      self:trigger_single_random()
   elseif evt < 0.9  then
      self:trigger_diagonal_jars()
   elseif evt < 0.95 then
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
      obs = Obstacle:new(pos, 0, "box")
      self.obstacles[obs] = 1
   end
end

function ObstacleGenerator:trigger_diagonal_jars()
   nbBoxes = math.random(4, 8)

   rnd = math.random()
   if rnd <= 0.5 then
      jar = "jar0"
      direction = true
   else
      jar = "jar1"
      direction = false
   end
   
   offset = (math.random() - 0.5) * 0.25
   -- offset = 0
   delta = math.random() * 0.5
   -- delta = 0.1
   for i=1, nbBoxes, 1
   do
      if direction then
	 delay = i * delta
      else
	 delay = (nbBoxes - i) * delta
      end
      pos = i /nbBoxes - 0.5 / nbBoxes + offset
      obs = Obstacle:new(pos, delay, jar)
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
