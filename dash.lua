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
   self.useCooldownSetting = 0.5
   self.useCooldown = 0

   self.tick = 0

   return obj
end

function Dash:canUse()
   return self.current > 0 and self.useCooldown <= 0
end

function Dash:use()
   if self.current > 0 then
      self.current = self.current - 1
      self.useCooldown = self.useCooldownSetting
   end
end

function Dash:update(dt)
   if self.current < self.count then
      self.tick = self.tick + dt
   end

   while self.current < self.count and
         self.tick > self.cooldown do
      self.current = self.current + 1
      self.tick = self.tick - self.cooldown
   end

   -- used, cooldown stuff
   self.useCooldown = self.useCooldown - dt
   if self.useCooldown < 0 then
      self.useCooldown = 0
   end
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
