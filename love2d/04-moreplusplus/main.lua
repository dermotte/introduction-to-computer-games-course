function love.load()
  -- init gamebert
  gamebert = {}
  gamebert.img = love.graphics.newImage("gamebert-64px.png")
  gamebert.x = 400
  gamebert.y = love.graphics.getHeight() - 64 - 16
  gamebertSpeed = 280 -- pixels per second

  -- init snow
  snowflake = love.graphics.newImage("snowflake-16px.png")
  snowSpeed = 30  -- pixels per second
  snow = {}
  for i = 1, 64, 1 do
    newSnowflake = { x = love.math.random(800), y = - love.math.random( 1000 ), scale = love.math.random()/2.0 + 0.5}
	   table.insert(snow, newSnowflake)
  end
end

function love.update(dt)
  dt = love.timer.getDelta()
  -- move gamebert
  if love.keyboard.isDown("left") then
    gamebert.x  = gamebert.x  - gamebertSpeed * dt
  elseif love.keyboard.isDown("right") then
    gamebert.x  = gamebert.x  + gamebertSpeed * dt
  end

  -- deal with the snow
  for i, snowf in ipairs(snow) do
	  snowf.y = snowf.y + snowSpeed * dt * snowf.scale
  	if snowf.y > love.graphics.getHeight() then -- remove snowflake
		    table.remove(snow, i)
	  end
  end
end

function love.draw()
  love.graphics.draw(gamebert.img, gamebert.x, gamebert.y)
  for i, snowf in ipairs(snow) do -- draw snow
	  love.graphics.draw(snowflake, snowf.x, snowf.y, 0, snowf.scale)
  end
end
