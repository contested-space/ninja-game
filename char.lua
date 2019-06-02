require "settings"
require "utils"
require "dash"
require "mirage"

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

   obj.dash = Dash:new(10, 10)

   obj.mirage = Mirage:new(obj)

   return obj
end

function Char:update(dt)
   self.active = false

   self.animation.currentTime = self.animation.currentTime + dt

   if love.keyboard.isDown("s") then
      -- left
      self.active = true
      self.direction = -1

      -- snap to left
      local dist = self.x - self.speed * dt
      if dist <= 0 then
         dist = 0
         self.active = false
      end
      self.x = dist
   end

   if love.keyboard.isDown("k") then
      -- right
      self.active = true
      self.direction = 1

      -- snap to left
      local dist = self.x + self.speed * dt
      if dist > windowWidth - self.w * xscale then
         dist = windowWidth - self.w * xscale
         self.active = false
      end
      self.x = dist
   end

   if love.keyboard.isDown("a") and self.dash:canUse() then
      -- dash left
      self.dash:use()
      local dashDist  = self.x - 100 * xscale
      if dashDist < 0 then
         dashDist = 0
      end
      self.mirage:activate(dashDist)
      self.x = dashDist
   end

   if love.keyboard.isDown("l") and self.dash:canUse() then
      -- dash right
      self.dash:use()
      local dashDist = self.x + 100 * xscale
      if dashDist > windowWidth then
         dashDist = windowWidth - self.w * xscale
      end
      self.mirage:activate(dashDist)
      self.x = dashDist
   end

   self.dash:update(dt)
   self.mirage:update(dt)
end

function Char:draw()
   -- hitbox
   -- love.graphics.rectangle(
   --    "fill",
   --    self.x, self.y,
   --    self.w * xscale, self.h * yscale)
   self.dash:draw()
   self.mirage:draw()

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
