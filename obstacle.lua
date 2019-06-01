Obstacle = {}
Obstacle.__index = Obstacle

function Obstacle:new(position, speed)
   local o
   o = {}
   setmetatable(o, Obstacle)
   size = windowWidth/gridWidth
   o.x = position * size
   o.y = 0
   o.width = size
   o.height = size
   o.speed = speed

   return o
end


function Obstacle:update(dt)
   self.y = self.y + self.speed * dt
end


function Obstacle:draw()
   love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
