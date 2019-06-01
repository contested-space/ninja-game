Background = {}
Background.__index = Background

function Background:new(state)
   local obj = {}
   setmetatable(obj, Background)

   obj.main = love.graphics.newImage("img/sunset-castle.png")
   obj.title = nil
   obj.gameover = nil

   obj.current = obj.main
   obj.x = 0
   obj.y = 0
   obj.state = state
   return obj
end

function Background:draw()
   love.graphics.draw(
      self.current,
      self.x, self.y,
      0,
      xscale, yscale)
end
