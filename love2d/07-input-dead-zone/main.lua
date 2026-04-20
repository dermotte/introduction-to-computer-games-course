-- simple visualization of joystick analog axes

function love.load()
	local joysticks = love.joystick.getJoysticks()
	joystick = joysticks[1]

	leftCircle = {x = 200, y = 120, size = 50}
	rightCircle = {x = 600, y = 120, size = 50}
	speed = 300

	leftStick = {x = 200, y = 300, outlineRadius = 100, dotRadius = 15}
	rightStick = {x = 600, y = 300, outlineRadius = 100, dotRadius = 15}

	-- Dead zone configuration
	deadZoneThreshold = 0.75

	-- Processed axis state
	leftX, leftY = 0, 0
	rightX, rightY = 0, 0

	-- Raw axis state for visualization
	leftXRaw, leftYRaw = 0, 0
	rightXRaw, rightYRaw = 0, 0
end

function love.update(dt)
	if not joystick then return end

	-- Left stick dead zone calculation
	local lx_raw = joystick:getGamepadAxis("leftx")
	local ly_raw = joystick:getGamepadAxis("lefty")
	leftXRaw, leftYRaw = lx_raw, ly_raw
	local l_mag = math.sqrt(lx_raw^2 + ly_raw^2)

	if l_mag < deadZoneThreshold then
		leftX, leftY = 0, 0
	else
		-- Rescale to smooth transition from edge of dead zone
		local l_mag_scaled = (l_mag - deadZoneThreshold) / (1 - deadZoneThreshold)
		leftX = (lx_raw / l_mag) * l_mag_scaled
		leftY = (ly_raw / l_mag) * l_mag_scaled
	end

	-- Right stick dead zone calculation
	local rx_raw = joystick:getGamepadAxis("rightx")
	local ry_raw = joystick:getGamepadAxis("righty")
	rightXRaw, rightYRaw = rx_raw, ry_raw
	local r_mag = math.sqrt(rx_raw^2 + ry_raw^2)

	if r_mag < deadZoneThreshold then
		rightX, rightY = 0, 0
	else
		-- Rescale to smooth transition from edge of dead zone
		local r_mag_scaled = (r_mag - deadZoneThreshold) / (1 - deadZoneThreshold)
		rightX = (rx_raw / r_mag) * r_mag_scaled
		rightY = (ry_raw / r_mag) * r_mag_scaled
	end

	-- Move circles based on processed axes
	-- leftCircle.x = leftCircle.x + dt * speed * leftX
	-- leftCircle.y = leftCircle.y + dt * speed * leftY
	-- rightCircle.x = rightCircle.x + dt * speed * rightX
	-- rightCircle.y = rightCircle.y + dt * speed * rightY
end

function love.draw()
	if not joystick then return end

	local leftSize = (1-joystick:getGamepadAxis("triggerleft"))*leftCircle.size
	local rightSize = (1-joystick:getGamepadAxis("triggerright"))*rightCircle.size
	love.graphics.circle("fill", leftCircle.x, leftCircle.y, leftSize)
	love.graphics.circle("fill", rightCircle.x, rightCircle.y, rightSize)

	-- Left stick (using processed axes for visual feedback)
	love.graphics.circle("line", leftStick.x, leftStick.y, leftStick.outlineRadius)
	love.graphics.circle("fill", leftStick.x + leftX * (leftStick.outlineRadius - leftStick.dotRadius), leftStick.y + leftY * (leftStick.outlineRadius - leftStick.dotRadius), leftStick.dotRadius)
	-- Raw position visualization
	love.graphics.setColor(1, 0, 0)
	love.graphics.circle("fill", leftStick.x + leftXRaw * (leftStick.outlineRadius - leftStick.dotRadius), leftStick.y + leftYRaw * (leftStick.outlineRadius - leftStick.dotRadius), 5)
	love.graphics.setColor(1, 1, 1)
	-- crosshair
	love.graphics.line(leftStick.x, leftStick.y-leftStick.outlineRadius, leftStick.x, leftStick.y+leftStick.outlineRadius)
	love.graphics.line(leftStick.x-leftStick.outlineRadius, leftStick.y, leftStick.x+leftStick.outlineRadius, leftStick.y)

	-- Right stick (using processed axes for visual feedback)
	love.graphics.circle("line", rightStick.x, rightStick.y, rightStick.outlineRadius)
	love.graphics.circle("fill", rightStick.x + rightX * (rightStick.outlineRadius - rightStick.dotRadius), rightStick.y + rightY * (rightStick.outlineRadius - rightStick.dotRadius), rightStick.dotRadius)
	-- Raw position visualization
	love.graphics.setColor(1, 0, 0)
	love.graphics.circle("fill", rightStick.x + rightXRaw * (rightStick.outlineRadius - rightStick.dotRadius), rightStick.y + rightYRaw * (rightStick.outlineRadius - rightStick.dotRadius), 5)
	love.graphics.setColor(1, 1, 1)
	-- crosshair
	love.graphics.line(rightStick.x, rightStick.y-rightStick.outlineRadius, rightStick.x, rightStick.y+rightStick.outlineRadius)
	love.graphics.line(rightStick.x-rightStick.outlineRadius, rightStick.y, rightStick.x+rightStick.outlineRadius, rightStick.y)
end
