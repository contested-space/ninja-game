require "explosion"

Obstacle = {}
Obstacle.__index = Obstacle

function Obstacle:new(position, delay, object)
   local o
   o = {}
   setmetatable(o, Obstacle)
   asset = selectObject(object)
   imageFile = love.graphics.newImage(asset)
   o.imageFile = imageFile
   o.x = position * windowWidth
   o.y = -500
   o.width = imageFile:getWidth() * xscale
   o.height = imageFile:getHeight() * yscale
   
   o.speed = falling_speed
   o.velocity = 0
   o.accleration = acceleration
   
   o.delay = delay
   o.start_time = love.timer.getTime()

   o.exploding = false
   o.explosion_dur = 0.3
   o.expiration = 0

   return o
end


function Obstacle:update(dt)
   if not self.exploding then
      if love.timer.getTime() > self.start_time + self.delay then
	 -- self.y = self.y + self.speed * dt

	 self.y = self.y + dt * (self.velocity + dt * acceleration / 2)
	 self.velocity = self.velocity + dt * acceleration
	 
      end
      if self.y > windowHeight then
	 gen:destroy(self)
      end
      if self:collidesWith(char) then
	 score.score = score.score - 1
	 -- gen:destroy(self)
	 self:explode()
      end
   elseif love.timer.getTime() > self.expiration then
      gen:destroy(self)
   else
      self.explosion:update(dt)
   end
end


function Obstacle:draw()
   -- love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
   if not self.exploding then
      love.graphics.draw(self.imageFile, self.x, self.y, 0, xscale, yscale, 0, 0)
   else
      self.explosion:draw()
   end
end

function Obstacle:collidesWith(other)
   -- Intersection check between two rectangles
   -- can be done this way:
   --   Bx + Bw > Ax &&
   --   By + Bh > Ay &&
   --   Ax + Aw > Bx &&
   --   Ay + Ah > By;

   -- And translated to this:
   return other:getX() + other:getWidth() > self.x and
      other:getY() + other:getHeight() > self.y and
      self.x + self.width > other:getX() and
      self.y + self.height > other:getY()
end

function Obstacle:setVelRight()
   if self.vel_x < 0 then
      self.vel_x = self.vel_x * -1
   end
end

function Obstacle:setVelLeft()
   if self.vel_x > 0 then
      self.vel_x = self.vel_x * -1
   end
end

function Obstacle:getY()
   return self.y
end

function Obstacle:getX()
   return self.x
end

function Obstacle:getHeight()
   return self.height
end

function Obstacle:getWidth()
   return self.width
end

function selectObject(object)
   objects = {}
   objects["box"] = "img/Bawks.png"
   objects["big_piano"] = "img/BiggerPiano.png"
   objects["jar0"] = "img/Jaro.png"
   objects["jar1"] = "img/JaroAltColor.png"
   objects["piano"] = "img/Piano.png"

   return objects[object]
   --return "img/Bawks.png"
end

function Obstacle:explode()
   self.exploding = true
   self.explosion = Explosion:new(self.x, self.y, self.explosion_dur)
   self.expiration = self.explosion_dur + love.timer.getTime()
end
