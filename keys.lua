KeyDown = {}

function love.keypressed( key, scancode, isrepeat )
	KeyDown[ key ] = true
end

function love.keyreleased( key, scancode, isrepeat )
	KeyDown[ key ] = false
end