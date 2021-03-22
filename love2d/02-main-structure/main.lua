-- run it with <path-to-love2d>/love.exe 02-main-structure

-- it called once at the beginning
function love.load()
   image = love.graphics.newImage("gamebert.png")
   imgx = 0
   imgy = 0
   stepSize = 5
end

-- is called for every frame, updates the world
function love.update(dt)
  if love.keyboard.isDown("left") then
    imgx = imgx - stepSize
  end
  if love.keyboard.isDown("right") then
    imgx = imgx + stepSize
  end
end

-- is called every frame, draws world
function love.draw()
  love.graphics.draw(image, imgx, imgy)
end
