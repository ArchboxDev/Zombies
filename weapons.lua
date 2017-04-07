local AmmoMeta = {}
function AmmoBase( Id, Cost, Packs )
	local this = {}
	setmetatable( this, AmmoMeta )
	
	this.Id = Id
	
	this.Cost = Cost
	
	this.Packs = Packs
	
	return this
end

Ammo =
{
	Generic =
	{
		Grenade = AmmoBase( "Grenade", 100, { Small = 5, Medium = 10, Large = 30, MetaLarge = 100 } )
	},
	Pistol = AmmoBase( "Pistol", 30, { Small = 30, Medium = 60, Large = 120 } )
}

Weapons =
{
	Fists =
	{
		FireSpeed = 2
	},
	StockPistol =
	{
		FireSpeed = 100,
		MaxClip = 8,
		Ammo = Ammo.Pistol,
		Sprite = Sprites.LamePistol,
		Icon = Sprites.PistolIcon,
		Sounds = {
			Fire = Sound.PistolBasic.Fire,
			Reload = Sound.PistolBasic.Reload1,
			Click = Sound.PistolBasic.Click
		},
		Projectile = Projectiles.PistolBasic
	},
	Grenade =
	{
		FireSpeed = 500,
		MaxClip = 0,
		Ammo = Ammo.Generic.Grenade,
		Sprite = Sprites.Grenade,
		Icon = Sprites.GrenadeIcon,
		Sounds = {
			Fire = nil
		}
	}
}

local WeaponsMeta = {}

function SpawnWeapon( Owner, Weapon )
	local this = {}
	setmetatable( this, WeaponsMeta )
	
	this.Owner = Owner
	
	this.Clip = Weapon.MaxClip
	
	this.Base = Weapon
	
	this.NextFire = 0
	
	return this
end

function GiveAmmo( Player, Type, Amount )
	local Ammo = Player.Inventory.Ammo[ Type ]
	
	if Ammo then
		Ammo = Ammo + Amount
	else
		Ammo = Amount
	end
end