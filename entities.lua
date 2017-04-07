EntTypes =
{
	Enemy,
	Deployable,
	Projectile
}

ActiveEntities = {}

ActiveBullets = {}

function DrawEntities()
	for id, entity in pairs( ActiveEntities ) do
		if ( entity.Base.Sprite ) then
			Scale = {
				x = 1,
				y = 1
			}
			if ( entity.Base.Scale ) then
				Scale = entity.Base.Scale
			end
			
			love.graphics.draw( entity.Base.Sprite, entity.Position.x, entity.Position.y, entity.Rotation, Scale.x, Scale.y )
		end
	end
end

function DrawBullets() -- bubbie's late night laziness
	for id, entity in pairs( ActiveBullets ) do
		if ( entity.Base.Sprite ) then
			Scale = {
				x = 1,
				y = 1
			}
			if ( entity.Base.Scale ) then
				Scale = entity.Base.Scale
			end
			
			love.graphics.draw( entity.Base.Sprite, entity.Position.x, entity.Position.y, entity.Rotation, Scale.x, Scale.y )
		end
	end
end

function EntityBehaviour()
	for id, entity in pairs( ActiveEntities ) do
		if entity.Base.Behaviour then
			entity.Base.Behaviour( entity )
		end
	end
	
	for id, entity in pairs( ActiveBullets ) do
		if entity.Base.Behaviour then
			entity.Base.Behaviour( entity )
		end
	end
end