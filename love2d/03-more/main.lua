-- run it with <path-to-love2d>/love.exe 02-main-structure

-- it called once at the beginning
function love.load()
  gamebert = {}
  gamebert.img = love.graphics.newImage("gamebert-64px.png")
  gamebert.x = 400
  gamebert.y = 400
  stepSize = 5

  snowflake = love.graphics.newImage("snowflake-16px.png")
  snow = {}
  for i = 1, 64, 1 do
    newSnowflake = { x = love.math.random(800), y = - love.math.random( 1000 )}
	   table.insert(snow, newSnowflake)
  end
end

-- is called for every frame, updates the world
function love.update(dt)
  if love.keyboard.isDown("left") then
    gamebert.x  = gamebert.x  - stepSize
  elseif love.keyboard.isDown("right") then
    gamebert.x  = gamebert.x  + stepSize
  end

  -- deal with the snow
  for i, snowf in ipairs(snow) do
	  snowf.y = snowf.y + 1
  	if snowf.y > 480 then -- remove snowflake
		    table.remove(snow, i)
	end

end
end

-- is called every frame, draws world
function love.draw()
  love.graphics.draw(gamebert.img, gamebert.x, gamebert.y)
  for i, snowf in ipairs(snow) do
	  love.graphics.draw(snowflake, snowf.x, snowf.y)
  end
end
