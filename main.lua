Storage = require( "lib/storage" )
json = require( "lib/json" )

require( "graphics" )
require( "map" )
require( "deployables" )
require( "projectiles" )
require( "entities" )
require( "weapons" )
require( "keys" )
require( "player" )

Version = "ECA-2-7-5"

function TranslateX( x )
	return ( ( mousex - 1.35 ) / 1.35 ) - ( ( width / 2.65 ) - player.Position.x )
end

function TranslateY( y )
	return ( ( mousey - 1.35 ) / 1.35 ) - ( ( height / 2.65 ) - player.Position.y )
end

-- nerd stuff --
function lerp(a,b,t) return (1-t)*a + t*b end
function lerp2(a,b,t) return a+(b-a)*t end

function TranslatePosition( Position )
	return {
		x = TranslateX( Position.x ),
		y = TranslateY( Position.y )
	}
end

function CloneObject( obj )
	local res = {}
	for k, v in pairs( obj ) do
		res[ k ] = v
	end
	return res
end

function love.load()
	love.mouse.setVisible( false )
	Map = InitMap()

	player = InitPlayer( 0, nil )
end

function love.draw()
	Camera()
		DrawMap()
		DrawBullets()
		DrawPlayer( player )
		DrawEntities()
	EndCamera()
	DrawHUD()
end

function love.update( d )
	width, height = love.graphics.getDimensions()
	mousex, mousey = love.mouse.getPosition()
	dt = d
	
	mousext = TranslateX( mousex )
	mouseyt = TranslateY( mousey )
	
	for key, func in pairs( player.RepeatControls ) do
		if ( love.keyboard.isDown( key ) ) then
			player.RepeatControls[ key ]()
		end
	end

	UpdateMap()
	UpdatePlayers()
	EntityBehaviour()
end

function love.keypressed( key, scancode, isrepeat )
	for k, func in pairs( player.Controls ) do
		if ( key == k ) then
			player.Controls[ k ]()
		end
	end
end