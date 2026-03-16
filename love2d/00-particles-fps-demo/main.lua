
-- downloaded and adapted from https://github.com/tonetheman/lua-love-snow-particles

-- set the background color to off white
love.graphics.setBackgroundColor(255, 255, 255)

local snow_img = love.graphics.newImage("small_snow_flake_32_white.png")
local ps = love.graphics.newParticleSystem(snow_img, 10)
ps:setBufferSize(1000)
ps:setEmissionArea("normal",300,0)
ps:setLinearAcceleration(1,500,1,600)
ps:setRadialAcceleration(-100,100)
ps:setSpeed(1,3)
ps:setEmissionRate(100)
ps:setDirection(.45)
ps:setParticleLifetime(1,3.5)
ps:setSizes(0.5, 0.7, 0.8)
ps:setRotation(-1, 1)

-- change FPS here ...
fpslist = {6, 12, 24, 30, 60}
fpsindex = 0

function love.update(dt)
	ps:update(dt)
	fps = fpslist[fpsindex+1]
	seconds = 2/fps
	if dt < seconds then
		love.timer.sleep(seconds - dt)
	end
end

function love.draw()
	love.graphics.clear()
	love.graphics.setBackgroundColor(255, 255, 255)
	love.graphics.print("Current FPS: "..tostring(love.timer.getFPS()), 10, 10)
	love.graphics.print("Hit <return> to change FPS", 10, 30)
	love.graphics.draw(ps,100,100)
end

function love.keyreleased(key)
    if key=="return" then
        fpsindex = (fpsindex + 1) % 5
    end
end
