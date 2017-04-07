--[[
	Copyright (C) 2017 Bubbie
	do whatever the fuck you want with this I don't really give a shit
	https://github.com/bubbie/LuaStorage/
]]--

local Storage = {}

function Storage.Create()

	local this = {}
	setmetatable( this, Storage )
	
	local Items = {}

	function this:SetItem( Key, Value )
		Items[ Key ] = Value
	end

	function this:SetItems( Keys, Value )
		local C = 0
		
		for i, Key in pairs( Keys ) do
			Items[ Key ] = Value
			C = C + 1
		end
		
		return C
	end

	function this:GetItems()
		return Items
	end

	function this:GetItem( Item )
		return Items[ Item ]
	end

	function this:FindItem( Query )
		for i, Item in pairs( Items ) do
			if ( Item == Query ) then
				return Item
			end
		end
	end

	function this:FindItems( Query )
		local Res = {}
		
		for i, Item in pairs( Items ) do
			if ( Item == Query ) then
				Res[i] = Item
			end
		end
		
		return Res
	end
	
	function this:Count( Query )
		local C = 0
		
		for Key, Item in pairs( Items ) do
			if ( ( Query and Item == Query ) or not Query ) then
				C = C + 1
			end
		end
		
		return C
	end
	
	return this
	
end

return Storage
