Mirage = {}
Mirage.__index = Mirage

function Mirage:new(the_obj)
   local obj = {}
   setmetatable(obj,Mirage)
   obj.img = love.graphics.newImage("img/ninja.png")
   obj.animation = newAnimation(obj.img, 32, 49, 1)

   obj.obj = the_obj
   obj.speed = 100
   obj.active = false
   obj.animationTime = 0.3
   obj.currentAnimationTime = 0

   return obj
end

function Mirage:activate(to_pos)
   self.active = true
   self.to_pos = to_pos
   self.lastX = self.obj.x
end

function Mirage:update(dt)
   if not self.active then
      return
   end

   self.currentAnimationTime = self.currentAnimationTime + dt
   if self.currentAnimationTime >= self.animationTime then
      self.currentAnimationTime = 0
      self.active = false
      return
   end
end

function Mirage:draw()
   if not self.active then
      return
   end
   -- so we can reset afterwards
   local r, g, b, a = love.graphics.getColor()

   love.graphics.setColor(0.3, 0, 0, 0.4)

   local maxnum = 10
   for i=1,maxnum do
      local pos = self.lastX

      love.graphics.draw(
         self.animation.spritesheet,
         self.animation.quads[math.random(#self.animation.quads)],
         pos + (self.to_pos - pos) * (i/maxnum),
         self.obj.y,
         0,
         xscale, yscale, 0)
   end

   -- reset
   love.graphics.setColor(r, g, b, a)
end
