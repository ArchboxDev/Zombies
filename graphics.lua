local p = love.graphics.newImage -- Shorten
local f = love.graphics.newFont
local s = love.audio.newSource

Sprites =
{
	Player1 = p( "sprites/Player1.png" ),
	Dot = p( "sprites/dotty.png" ),
	Heart = p( "sprites/Heart.png" ),
	LamePistol = p( "sprites/lamepistol.png" ),
	Grenade = p( "sprites/grenade.png" ),
	PistolBullet = p( "sprites/pistolbasic.png" ),
	PistolIcon = p( "sprites/PistolIcon.png" ),
	GrenadeIcon = p( "sprites/GrenadeIcon.png" )
}

Fonts =
{
	WhiteChocolateMint = f( "fonts/white-chocolate-mint.ttf", 20 )
}

Sound =
{
	PistolBasic =
	{
		Fire = "sound/PistolBasic/Fire.wav",
		Reload1 = "sound/PistolBasic/Reload1.wav",
		Click = "sound/PistolBasic/Click.wav"
	}
}

function Camera()
	love.graphics.push()
	love.graphics.rotate( 0 )
	love.graphics.scale( 1.35, 1.35 )
	love.graphics.translate( ( ( width / 2.65 ) - player.Position.x ), ( ( height / 2.65 ) - player.Position.y ) )
end

function EndCamera()
	love.graphics.pop()
end