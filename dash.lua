Dash = {}
Dash.__index = Dash

function Dash:new(x, y)
   local obj = {}
   setmetatable(obj,Dash)

   self.img = love.graphics.newImage("img/gust.png")
   self.x = x
   self.y = y
   self.w = self.img:getWidth()
   self.h = self.img:getHeight()
   self.spacing = 1

   self.count = 3
   self.current = 3

   -- seconds
   self.cooldown = 2

   self.tick = 0

   return obj
end

function Dash:canUse()
   return self.current > 0
end

function Dash:use()
   if self.current > 0 then
      self.current = self.current - 1
   end
end

function Dash:update(dt)
   self.current = self.current + dt
end

function Dash:draw()
   for i=1,self.current do
      love.graphics.draw(
         self.img,
         self.x + ((5 + self.w) * i) * xscale,
         self.y, 0,
         xscale, yscale
      )
   end
end
