Score = {}
Score.__index = Score

function Score:new(x, y)
   local obj = {}
   setmetatable(obj, Score)
   obj.x = x
   obj.y = y
   obj.score = 0
   return obj
end

function Score:update(dt)
end

function Score:draw()
   love.graphics.print(
      self.score,
      20 * yscale,
      windowHeight - windowHeight * 0.1,
      0, xscale, yscale
   )
end
