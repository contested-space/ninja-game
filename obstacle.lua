Obstacle = {}
Obstacle.__index = Obstacle

function Obstacle:new(position, speed, delay, generator)
   local o
   o = {}
   setmetatable(o, Obstacle)
   size = windowWidth/gridWidth
   o.x = position * size
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

function Obstacle:hit_player()
end
