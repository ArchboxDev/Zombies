Players = {
}

function InitPlayer( id, connection )
	local this = {}
	setmetatable( this, Players )
	
	this.Position = {
		x = 1683,
		y = 1728,
		tx = 1683,
		ty = 1728
	}
	
	this.Rotation = 0
	
	this.ActiveSlot = 1
	
	this.Health = 180
	
	this.Speed = 75 -- Original : 75 --
	this.SpeedLerp = 1
	
	this.Sprite = Sprites.Player1
	
	this.Inventory = InitPlayerInventory(this)
	this.ActiveWeapon = this.Inventory.Hotbar[ this.ActiveSlot ]
	
	function this.Update()
		this.Position.x = lerp( this.Position.x, this.Position.tx, this.SpeedLerp )
		this.Position.y = lerp( this.Position.y, this.Position.ty, this.SpeedLerp )
	end
	
	-- Controls: Movement --
	
	function this.Move( x, y )
		local NextX = this.Position.x + ( dt * x )
		local NextY = this.Position.y + ( dt * y )
		
		this.Position.tx = NextX
		this.Position.ty = NextY
		
		this.Update()
	end
	
	function this.Reload()
		local AmmoForWeapon = player.Inventory.Ammo[ player.ActiveWeapon.Base.Ammo.Id ]
		
		if ( AmmoForWeapon > 0 ) then
			local AddToClip = 0
			
			if ( AmmoForWeapon >= 8 ) then
				AddToClip = player.ActiveWeapon.Base.MaxClip - player.ActiveWeapon.Clip
			else
				AddToClip = AmmoForWeapon
			end
			
			if ( this.ActiveWeapon.Base.Sounds.Reload ) then
				love.audio.newSource( this.ActiveWeapon.Base.Sounds.Reload, "stream" ):play()
			end
			
			player.Inventory.Ammo[ player.ActiveWeapon.Base.Ammo.Id ] = player.Inventory.Ammo[ player.ActiveWeapon.Base.Ammo.Id ] - AddToClip
			player.ActiveWeapon.Clip = player.ActiveWeapon.Clip + AddToClip
		else
		end
	end

	function this.MoveUp()
		this.Move( 0, -this.Speed )
	end

	function this.MoveDown()
		this.Move( 0, this.Speed )
	end

	function this.MoveLeft()
		this.Move( -this.Speed, 0 )
	end

	function this.MoveRight()
		this.Move( this.Speed, 0 )
	end
	
	function this.HotbarLeft()
		if ( this.ActiveSlot > 1 ) then
			this.ActiveSlot = this.ActiveSlot - 1
			this.ActiveWeapon = this.Inventory.Hotbar[ this.ActiveSlot ]
		end
	end
	
	function this.HotbarRight()
		if ( this.ActiveSlot < this.Inventory.HotbarSlots ) then
			this.ActiveSlot = this.ActiveSlot + 1
			this.ActiveWeapon = this.Inventory.Hotbar[ this.ActiveSlot ]
		end
	end
	
	-- Controls: Weapons --
	
	function this.FireWeapon()
		if ( this.ActiveWeapon ) then
			if ( this.ActiveWeapon.Clip <= 0 ) then
				if ( this.ActiveWeapon.Base.Sounds.Click ) then
					love.audio.newSource( this.ActiveWeapon.Base.Sounds.Click, "stream" ):play()
				end
			return end
			
			local Direction = math.atan2( ( TranslateY( y ) - this.Position.y ), ( TranslateX( x ) - this.Position.x ) )
			
			local Position = CloneObject( this.Position )
			Position.x = Position.x - 5
			Position.y = Position.y
			
			if ( this.ActiveWeapon.Base.Sounds.Fire ) then
				love.audio.newSource( this.ActiveWeapon.Base.Sounds.Fire, "stream" ):play()
			end
			
			SpawnProjectile( this.ActiveWeapon.Base.Projectile, this, Position, Direction )
			
			this.ActiveWeapon.Clip = this.ActiveWeapon.Clip - 1
		end
	end
	
	-- Controls --
	
	this.Controls =
	{
		["r"] = this.Reload,
		["left"] = this.HotbarLeft,
		["right"] = this.HotbarRight
	}
	
	this.RepeatControls =
	{
		["w"] = this.MoveUp,
		["a"] = this.MoveLeft,
		["s"] = this.MoveDown,
		["d"] = this.MoveRight
	}
	
	Players[ id ] = this
	
	return this
end

local PlayerInv = {}
function InitPlayerInventory( player )
	local this = {}
	setmetatable( this, PlayerInv )
	
	this.ItemSlots = 0
	this.HotbarSlots = 6
	
	this.Hotbar =
	{
		SpawnWeapon( player, Weapons.StockPistol ),
	}
	
	this.Items =
	{
	}
	
	this.Ammo =
	{
		["Pistol"] = 60
	}
	
	this.FindItem = function( name )
		local res = {}
		
		for slot, item in pairs( this.Inventory.Hotbar ) do
			
		end
		
		return res
	end
	
	return this
end

function DrawPlayer( player )
	if ( player.Sprite ) then
		love.graphics.draw( player.Sprite, player.Position.x, player.Position.y, player.Rotation, 1, 1, player.Sprite:getWidth()/2, player.Sprite:getHeight()/2 )
	end
	
	if ( player.ActiveWeapon ) then
		player.Rotation = ( math.atan2( mousext - player.Position.x, player.Position.y - mouseyt ) - math.pi / 2 ) - 4.595
		
		if ( player.ActiveWeapon ) then
			love.graphics.draw( player.ActiveWeapon.Base.Sprite, player.Position.x, player.Position.y, player.Rotation, 1, 1, (player.Sprite:getWidth()-30)/2.65, (player.Sprite:getHeight())/3.15 )
		end
	end
end

function UpdatePlayers()
	for id, player in pairs( Players ) do
		--player.Update()
	end
end

function DrawHUD()
	love.graphics.printf( "Zombies " .. Version, 0, 0, 150, "left" )
	love.graphics.draw( Sprites.Dot, mousex, mousey, 0, 1, 1, Sprites.Dot:getWidth() / 2, Sprites.Dot:getHeight() / 2 )
	
	-- Health --
	
	love.graphics.draw( Sprites.Heart, 10, height - 85, 0, 1, 1 )
	love.graphics.printf( player.Health, 35, height - 82, 47, "left" )
	
	-- Draw Hotbar --
	local x = 10
	
	for i = 1, player.Inventory.HotbarSlots, 1 do
		local colour = { 205, 205, 205, 155 }
		if ( i == player.ActiveSlot ) then
			colour = { 35, 113, 196, 155 }
		end
		
		local item = player.Inventory.Hotbar[ i ]
	
		love.graphics.setColor( unpack( colour ) )
		
		love.graphics.rectangle( "fill", x, height - 60, 50, 50 )
		
		love.graphics.setColor( 255, 255, 255, 255 )
		
		if ( item and item.Base.Icon ) then
			love.graphics.draw( item.Base.Icon, x, height - 60, 0, 1, 1 )
			if ( item.Clip ) then
				love.graphics.setFont( Fonts.WhiteChocolateMint )
				love.graphics.printf( item.Clip, x, height - 30, 47, "right" )
			end
		else
			
		end
		
		x = x + 60
	end
	
	-- Weapon Status --
	
	if ( player.ActiveWeapon ) then
		local AmmoForWeapon = player.Inventory.Ammo[ player.ActiveWeapon.Base.Ammo.Id ]
		if ( AmmoForWeapon ) then
			if ( player.ActiveWeapon.Clip <= 0 and AmmoForWeapon > 0 ) then
				love.graphics.printf( "RELOAD", width / 2 - 16, height / 2 + 35, 70, "center" )
			elseif ( AmmoForWeapon <= 0 ) then
				love.graphics.printf( "NO AMMO", width / 2 - 24, height / 2 + 35, 79, "center" )
			end
		end
	end
end

function WeaponCooldowns()
end

function love.mousepressed( x, y, button, istouch )
	if ( player.ActiveWeapon ) then
		player.FireWeapon()
	end
end