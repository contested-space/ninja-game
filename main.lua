require "obstacle"


function love.load()
   windowWidth = love.graphics.getWidth()
   windowHeight = love.graphics.getHeight()
   gridWidth = 10

   obstacle0 = Obstacle:new(2, 10)
   obstacle1 = Obstacle:new(5, 10)
   obstacle2 = Obstacle:new(7, 10)

   updateable = {obstacle0, obstacle1, obstacle2}
   drawable = {obstacle0, obstacle1, obstacle2}
end


function love.update(dt)
   for i, el in pairs(updateable) do
      el:update(dt)
   end
end

function love.draw()
   for i, el in pairs(drawable) do
      el:draw()
   end
end
