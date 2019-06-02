require "char"
require "obstacle"
require "obstacle_generator"
require "background"
require "settings"
require "score"
require "intro"
require "game_over"

function love.load()
   ninjaTheme = love.audio.newSource("snd/move-in-ninja.ogg", "stream")
   ninjaTheme:setLooping(true)
   ninjaTheme:play()

   love.graphics.setDefaultFilter("nearest", "nearest", 1)

   score = Score:new(10, 10)

   sett = settings()
   windowWidth = love.graphics.getWidth()
   windowHeight = love.graphics.getHeight()
   xscale = windowWidth / sett.window.x
   yscale = windowHeight / sett.window.y
   acceleration = 600

   gridWidth = 10
   gameState = "intro"
   intro_duration = 10
   game_duration = 5

   background = Background:new()
   char = Char:new(windowWidth / 2, windowHeight * 0.57)

   -- obstacle0 = Obstacle:new(2, 10)
   -- obstacle1 = Obstacle:new(5, 10)
   -- obstacle2 = Obstacle:new(7, 10)

   -- updateable = {obstacle0, obstacle1, obstacle2}
   -- drawable = {obstacle0, obstacle1, obstacle2}

   gen = ObstacleGenerator:new()
   --gen:trigger_full_line()

   intro_animation = Intro:new(intro_duration)
   game_over_screen = GameOver:new()

   updateable = {gen, char, intro_animation}

   drawable = {
      background,
      gen,
      char,
      score}
   delay = 0
   last = love.timer.getTime() + intro_animation.duration
   start = last

end

function love.update(dt)
   if love.keyboard.isDown("escape") then
      love.event.quit()
   end

   if gameState == "main" then
      if love.timer.getTime() > last + delay then
	 gen:trigger()
	 dur = love.timer.getTime() - start
	 difficulty = dur + 60
	 delay = (math.random() / difficulty) * 100
	 last = love.timer.getTime()
      end
      for i, el in pairs(updateable) do
         el:update(dt)
      end
      if love.timer.getTime() > game_duration + start then
	 game_over()
      end
   elseif gameState == "intro" then
      intro_animation:update(dt)
      if love.keyboard.isDown("space") then
	 delay = 0
	 start_game()
      end


      if love.timer.getTime() > last then

	 start_game()
      end
   elseif gameState == "game_over" then
      if love.keyboard.isDown("space") then
	 delay = 0
	 start_game()
      end
   end
end

function love.draw()
   if gameState == "main" then
      for i, el in pairs(drawable) do
         el:draw()
      end
   elseif gameState == "intro" then
      intro_animation:draw(dt)
   elseif gameState == "game_over" then
      game_over_screen:draw()
   end
      
end

function start_game()
   gameState = "main"
   start = love.timer.getTime()
   last = start
   game_end = start + game_duration
   score.score = 0
end

function game_over()
   gameState = "game_over"
end
