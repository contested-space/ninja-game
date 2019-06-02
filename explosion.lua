Explosion = {}
Explosion.__index = Explosion

function Explosion:new(x, y, dur)
   local obj
   obj = {}
   setmetatable(obj, Explosion)
   obj.img = love.graphics.newImage("img/Scene.png")
   obj.duration = dur
   obj.animation = newAnimation(obj.img, obj.img:getWidth()/31, obj.img:getHeight(),  obj.duration)
   obj.x = x
   obj.y = y
   obj.w = obj.img:getWidth()
   obj.h = obj.img:getHeight()
   obj.active = true
   return obj
end

function Explosion:update(dt)
   self.animation.currentTime = self.animation.currentTime + dt

end

function Explosion:draw(dt)
      local offset = 0

   -- if not self.active then
   --    love.graphics.draw(
   --       self.animation.spritesheet,
   --       self.animation.quads[1],
   --       self.x + offset, self.y,
   --       0,
   --       xscale,
   --       yscale)
   --    return
   -- end
   
      local spriteNum = math.floor(
	 (self.animation.currentTime / (self.animation.duration ))
	    * #self.animation.quads) % #self.animation.quads + 1

      love.graphics.draw(
	 self.animation.spritesheet,
	 self.animation.quads[spriteNum],
	 self.x + offset, self.y, 0,
	 xscale,
	 yscale,
	 self.width, 0)
end
