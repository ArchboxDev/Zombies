-- Turret --

local function TurretBehaviour( self )
	-- TODO: Turret stuff --
end

-- Deployables --

ActiveDeployables = {}

local DeployableBaseMeta = {}
function DeployableBase( Health, Damage, Behaviour, Buyable, BuyPrice, Craftable )
	local this = {}
	setmetatable( this, DeployabeBaseMeta )
	
	this.Health = Health
	
	this.Damage = Damage
	
	this.Behaviour = Behaviour
	
	this.Buyable = Buyable
	
	this.BuyPrice = BuyPrice
	
	this.Craftable = Craftable
	
	return this
end

local DeployableMeta = {}
function SpawnDeployable( deployable, owner, Position )
	local this = {}
	setmetatable( this, DeployabeMeta )
	
	this.Owner = owner
	
	this.Base = deployable
	
	this.Health = deployable.Health
	
	this.Position = Position
	
	this.Type = EntTypes.Deployable
	
	table.insert( ActiveEntities, this )
	table.insert( ActiveDeployables, this )
	
	return this
end

Deployables =
{
	Turret = DeployableBase( true, 300, false, TurretBehaviour, true, 300 )
}