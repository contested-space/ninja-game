require "settings"
require "utils"


GameOver = {}
GameOver.__index = GameOver

function GameOver:new()
   local obj = {}
   setmetatable(obj, GameOver)

   obj.main = love.graphics.newImage("img/opening.png")
   obj.title = nil
   obj.gameover = nil

   obj.current = obj.main
   obj.x = 0
   obj.y = 0
   obj.state = state
   return obj
end

-- function GameOver:update(dt)
--    self.active = false
--    self.animation.currentTime = self.animation.currentTime + dt
-- end

function GameOver:draw()
   love.graphics.draw(
      self.main,
      self.x, self.y,
      0,
      xscale, yscale)
   
   if score.score == 0 then
      love.graphics.print(
	 "You lost everything.",
	 20 * yscale,
	 windowHeight - windowHeight * 0.5,
	 0, xscale, yscale)
      
   else
      love.graphics.print("You lost everything, and got hurt in the process.",
      	 20 * yscale,
	 windowHeight - windowHeight * 0.5,
	 0, xscale, yscale)
   end
   love.graphics.print(
      score.score,
      20 * yscale,
      windowHeight - windowHeight * 0.1,
      0, xscale, yscale)
end

