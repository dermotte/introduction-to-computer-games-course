function love.load()
  -- load and init layers
  layers = {}
  sky = {img = love.graphics.newImage("bg/layer07_Sky.png"), x = 0, speed = 0}
  table.insert(layers, sky)
  rocks = {img = love.graphics.newImage("bg/layer06_Rocks.png"), x = 0, speed = 8}
  table.insert(layers, rocks)
  hills2 = {img = love.graphics.newImage("bg/layer05_Hills.png"), x = 0, speed = 20}
  table.insert(layers, hills2)
  clouds = {img = love.graphics.newImage("bg/layer04_Clouds.png"), x = 0, speed = 30}
  table.insert(layers, clouds)
  hills = {img = love.graphics.newImage("bg/layer03_Hills_Castle.png"), x = 0, speed = 45}
  table.insert(layers, hills)
  trees = {img = love.graphics.newImage("bg/layer02_Trees_rocks.png"), x = 0, speed = 60}
  table.insert(layers, trees)
  ground = {img = love.graphics.newImage("bg/layer01_Ground.png"), x = 0, speed = 80}
  table.insert(layers, ground)
end

function love.update(dt)
  dt = love.timer.getDelta()
  -- scrolling layers
  for i, layer in ipairs(layers) do
	  layer.x = (layer.x - layer.speed * dt) % 1920
  end
end

function love.draw()
  for i, layer in ipairs(layers) do -- draw layers
    love.graphics.draw(layer.img, layer.x, 0)
    love.graphics.draw(layer.img, layer.x-1920, 0)
  end
end
