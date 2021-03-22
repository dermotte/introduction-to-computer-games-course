-- run it with <path-to-love2d>/love.exe 02-main-structure

-- it called once at the beginning
function love.load()
   image = love.graphics.newImage("gamebert.png")
   imgx = 0
   imgy = love.graphics.getHeight() - 320
   stepSize = 300 -- in pixel per second
end

-- is called for every frame, updates the world
function love.update(dt)
  dt = love.timer.getDelta()
  if love.keyboard.isDown("left") then
    imgx = imgx - stepSize * dt
  end
  if love.keyboard.isDown("right") then
    imgx = imgx + stepSize * dt
  end
end

-- is called every frame, draws world
function love.draw()
  love.graphics.draw(image, imgx, imgy)
end
