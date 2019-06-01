require "char"
require "obstacle"
require "obstacle_generator"
require "background"
require "settings"

function love.load()
   sett = settings()
   windowWidth = love.graphics.getWidth()
   windowHeight = love.graphics.getHeight()
   xscale = windowWidth / sett.window.x
   yscale = windowHeight / sett.window.y

   gridWidth = 10
   gameState = "main"

   background = Background:new()
   char = Char:new(windowWidth / 2, windowHeight / 5)

   -- obstacle0 = Obstacle:new(2, 10)
   -- obstacle1 = Obstacle:new(5, 10)
   -- obstacle2 = Obstacle:new(7, 10)

   -- updateable = {obstacle0, obstacle1, obstacle2}
   -- drawable = {obstacle0, obstacle1, obstacle2}

   gen = ObstacleGenerator:new()
   gen:trigger_full_line()

   updateable = {gen, char}
   drawable = {background, gen, char}

end

function love.update(dt)
   if love.keyboard.isDown("escape") then
      love.event.quit()
   end

   if gameState == "main" then
      for i, el in pairs(updateable) do
         el:update(dt)
      end
   end
end

function love.draw()
   if gameState == "main" then
      for i, el in pairs(drawable) do
         el:draw()
      end
   end
end
