require "settings"
require "utils"

Char = {}
Char.__index = Char

function Char:new(x,y)
   local obj = {}
   setmetatable(obj,Char)

   obj.img = love.graphics.newImage("img/ninja.png")
   obj.animation = newAnimation(obj.img, 32, 64, 0.5)
   obj.x = x
   obj.y = y
   obj.w = 32
   obj.h = obj.img:getHeight()
   obj.speed = 100
   obj.direction = 1

   return obj
end

function Char:update(dt)
   self.active = false

   if love.keyboard.isDown("s") then
      -- left
      self.active = true
      self.direction = -1
      self.x = self.x - self.speed * dt
   end

   if love.keyboard.isDown("k") then
      -- right
      self.active = true
      self.direction = 1
      self.x = self.x + self.speed * dt
   end

   if love.keyboard.isDown("a") then
      -- dash left
      self.active = true
      self.direction = -1
      self.x = self.x - self.speed* dt * 2
   end

   if love.keyboard.isDown("l") then
      -- dash right
      self.active = true
      self.direction = 1
      self.x = self.x + self.speed* dt * 2
   end

   self.animation.currentTime = self.animation.currentTime + dt
end

function Char:draw()
   -- hitbox
   -- love.graphics.rectangle(
   --    "fill",
   --    self.x, self.y,
   --    self.w * xscale, self.h * yscale)

   local offset = 0
   if self.direction < 0 then
      offset = 32 * yscale
   end

   if not self.active then
      love.graphics.draw(
         self.animation.spritesheet,
         self.animation.quads[1],
         self.x + offset, self.y,
         0,
         self.direction * xscale,
         yscale)
      return
   end

   local spriteNum = math.floor(
      (self.animation.currentTime / self.animation.duration)
         * #self.animation.quads) % #self.animation.quads + 1

   love.graphics.draw(
      self.animation.spritesheet,
      self.animation.quads[spriteNum],
      self.x + offset, self.y, 0,
      self.direction * xscale,
      yscale,
      self.width, 0)
end