require "settings"
require "utils"

Intro = {}
Intro.__index = Intro

function Intro:new(dur)
   local obj = {}
   setmetatable(obj,Intro)

   obj.img = love.graphics.newImage("img/Scene.png")
   print(obj.img)
   obj.duration = dur
   obj.animation = newAnimation(obj.img, obj.img:getWidth()/31, obj.img:getHeight(),  obj.duration)
   obj.x = 0
   obj.y = 0
   obj.w = obj.img:getWidth()
   obj.h = obj.img:getHeight()
   obj.active = true
   return obj
end

function Intro:update(dt)
   self.active = false
   self.animation.currentTime = self.animation.currentTime + dt
end

function Intro:draw(dt)
   local spriteNum = math.floor(
      (self.animation.currentTime / (self.animation.duration ))
         * #self.animation.quads) % #self.animation.quads + 1

   love.graphics.draw(
      self.animation.spritesheet,
      self.animation.quads[spriteNum],
      self.x, self.y, 0,
      xscale,
      yscale,
      self.width, 0)
end
