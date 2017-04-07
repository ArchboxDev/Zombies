local MapMeta = {}
function InitMap()
	local this = {}
	setmetatable( this, MapMeta )
	
	-- Init
	local img = love.graphics.newImage( "map/map.png" )
	local wid = img:getWidth()
	local hei = img:getHeight()
	
	map = love.graphics.newSpriteBatch( img )
	map:add( love.graphics.newQuad( 0, 0, wid, hei, wid, hei ) )
	map:flush()
	-- thumbs up
	
	
	function this.Draw()
		love.graphics.draw( map, 0, 0 )
	end
	
	this.MapZones = json.decode( love.filesystem.read( "map/mapCollisions.json" ) )
	this.Zones = Storage.Create()
	
	for ztype, lis in pairs( this.MapZones ) do
		
		for zname, zone in pairs( lis ) do
			local zID = ztype .. "=" .. zname .. " " .. zone.xStart .. "," .. zone.yStart .. "-" .. zone.xEnd .. "," .. zone.yEnd
			this.Zones:SetItem( zID, {
				zID = zID,
				zType = ztype,
				xStart = zone.xStart,
				xEnd = zone.xEnd,
				yStart = zone.yStart,
				yEnd = zone.yEnd
			} )
		end
		
	end
	
	function this.ZoneOf( x, y )
		local ReturnZone = false
		for id, zone in pairs( this.Zones:GetItems() ) do
			if ( zone.zType == "Nullify" ) then
				if ( x >= zone.xStart and x <= zone.xEnd and y >= zone.yStart and y <= zone.yEnd ) then
					return false
				end
			else
				if ( x >= zone.xStart and x <= zone.xEnd and y >= zone.yStart and y <= zone.yEnd ) then
					ReturnZone = zone
				end
			end
		end
		return ReturnZone
	end
	
	return this
end

function DrawMap()
	return Map.Draw()
end

function UpdateMap()
end