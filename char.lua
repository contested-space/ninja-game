require "settings"
require "utils"
require "dash"

Char = {}
Char.__index = Char

function Char:new(x,y)
   local obj = {}
   setmetatable(obj,Char)

   obj.img = love.graphics.newImage("img/ninja.png")
   obj.animation = newAnimation(obj.img, 32, 49, 0.5)
   obj.x = x
   obj.y = y
   obj.w = 32
   obj.h = obj.img:getHeight()
   obj.speed = 100 * xscale
   obj.direction = 1

   obj.dashing = false
   obj.dash = Dash:new(10, 10)

   return obj
end

function Char:update(dt)
   self.bar:update(dt)

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


   if love.keyboard.isDown("a") and not false then
      -- dash left
   end

   if love.keyboard.isDown("l") and not false then
      -- dash right
   end

   self.animation.currentTime = self.animation.currentTime + dt
end

function Char:draw()
   -- hitbox
   -- love.graphics.rectangle(
   --    "fill",
   --    self.x, self.y,
   --    self.w * xscale, self.h * yscale)
   self.dash:draw()

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
