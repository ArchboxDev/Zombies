-- Bullet --

local function BulletBehaviour( self )
	self.Position.x = self.Position.x + ( ( self.Base.Speed * math.cos( self.Direction ) ) * dt )
	self.Position.y = self.Position.y + ( ( self.Base.Speed* math.sin( self.Direction ) ) * dt )
end

-- Projectiles --

ActiveProjectiles = {}

local ProjectileBaseMeta = {}
function ProjectileBase( Damage, Speed, Sprite, Behaviour, Scale )
	local this = {}
	setmetatable( this, ProjectileMeta )
	
	this.Damage = Damage
	
	this.Speed = Speed
	
	this.Sprite = Sprite
	
	this.Behaviour = Behaviour
	
	this.Scale = Scale
	
	return this
end

local ProjectileMeta = {}
function SpawnProjectile( projectile, owner, Position, Direction )
	local this = {}
	setmetatable( this, ProjectileMeta )
	
	this.Owner = owner
	
	this.Base = projectile
	
	this.Position =
	{
		x = 0,
		y = 0,
		tx = 0,
		ty = 0
	}
	
	this.Rotation = Direction
	this.Direction = Direction
	
	this.Type = EntTypes.Projectile
	
	this.Position.x = this.Position.x + Position.x
	this.Position.y = this.Position.y + Position.y
	this.Position.tx = this.Position.x + Position.x
	this.Position.ty = this.Position.y + Position.y
	
	table.insert( ActiveBullets, this )
	table.insert( ActiveProjectiles, this )
	
	return this
end

Projectiles = {
	PistolBasic = ProjectileBase( 280, 800, Sprites.PistolBullet, BulletBehaviour, { x = 1, y = 1 } )
}