Bar = {}
Bar.__index = Bar

function Bar:new(x, y, w, h, from, to)
   local obj = {}
   setmetatable(obj,Bar)
   obj.x = x
   obj.y = y
   obj.w = w
   obj.h = h
   obj.from = from
   obj.to = to
   obj.current = to

   obj.currentTime = 0
   obj.timestep = 0.1

   return obj
end

function Bar:update(dt)
   self.currentTime = self.currentTime + dt

   if self.currentTime > self.timestep then
      self.currentTime = self.currentTime - self.timestep
      self:step()
   end
end

function Bar:step()
   if not (self.current < self.to) then
      return
   end

   self.current = self.current + 1
end

function Bar:unstep()
   if not (self.current > self.from) then
      return
   end

   self.current = self.current - 1
end

function Bar:notZero()
   return self.current > 0
end

function Bar:draw()
   love.graphics.setColor(0.4,0,0)

   love.graphics.rectangle(
      "fill",
      self.x, self.y,
      self.w, self.h
   )

   love.graphics.setColor(1,0,0)

   love.graphics.rectangle(
      "fill",
      self.x, self.y,
      self.w * self.current / self.to, self.h
   )

   love.graphics.setColor(255,255,255)
end
