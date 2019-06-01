require "settings"
require "utils"

Char = {}
Char.__index = Char

function Char:new(x,y)
   local obj = {}
   setmetatable(obj,Char)

   obj.img = love.graphics.newImage("img/ninja.png")
   obj.animation = newAnimation(obj.img, 32, 64, 1)
   obj.x = x
   obj.y = y
   obj.w = 32
   obj.h = obj.img:getHeight()
   obj.speed = 100

   return obj
end

function Char:update(dt)
   if love.keyboard.isDown("s") then
      self.x = self.x - self.speed * dt
   end

   if love.keyboard.isDown("k") then
      self.x = self.x + self.speed * dt
   end

   if love.keyboard.isDown("a") then
      -- dash left
      self.x = self.x - self.speed* dt * 2
   end

   if love.keyboard.isDown("l") then
      -- dash right
      self.x = self.x + self.speed* dt * 2
   end
end

function Char:draw()
   if not self.active then
   end

   local spriteNum = math.floor(
      (self.animation.currentTime / self.animation.duration)
         * #self.animation.quads) % #self.animation.quads + 1

   love.graphics.draw(
      self.animation.spritesheet,
      self.animation.quads[spriteNum],
      self.x, self.y, 0,
      self.last_direction, 1,
      self.width, 0)
end
