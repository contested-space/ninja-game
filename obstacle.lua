Obstacle = {}
Obstacle.__index = Obstacle

function Obstacle:new(position, speed, delay, generator)
   local o
   o = {}
   setmetatable(o, Obstacle)
   size = windowWidth/gridWidth
   o.x = position * windowWidth
   o.y = 0
   o.width = size
   o.height = size
   o.speed = speed
   o.generator = generator
   o.imageFile = love.graphics.newImage("img/Bawks.png")

   return o
end


function Obstacle:update(dt)
   self.y = self.y + self.speed * dt
   if self.y > windowHeight then
      gen:destroy(self)
   end
end


function Obstacle:draw()
   -- love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
   love.graphics.draw(self.imageFile, self.x, self.y, 0, 1, 1, 0, 0, 0, 0)
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
