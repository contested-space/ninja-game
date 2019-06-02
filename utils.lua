math.randomseed(os.time())

function newAnimation(image, width, height, duration)
   local animation = {}

   animation.spritesheet = image
   animation.quads = {}
   animation.currentTime = 0
   animation.duration = duration

   for y = 0, image:getHeight() - height, height do
      for x = 0, image:getWidth() - width, width do
         table.insert(animation.quads,
                      love.graphics.newQuad(
                         x, y,
                         width, height,
                         image:getDimensions()))
      end
   end

   return animation
end
