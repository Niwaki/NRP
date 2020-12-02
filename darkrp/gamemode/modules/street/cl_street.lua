gang_zones.mapMaterial = nil

--[[gang_zones.CreateMenu = function()
	
	local frame = vgui.Create'DFrame'
	frame:SetSize( 800, 500 )
	frame:Center()
	frame:SetTitle("")
	frame:MakePopup()
	frame:SetSkin( 'DarkRP' )

	local sell = frame:Add("DButton")
	sell:SetPos( 620, 3 )
	sell:SetSize( 140, 20 )
	sell:SetText( 'Отказаться от владения' )

	sell.DoClick = function()
		Derma_Query( 
			'Вы действительно хотите отказаться от владения территорией?\nДействие является добровольным, деньги не подлежат возврату',
			'Зоны', 
			
			'Да', function()
			RunConsoleCommand( 'darkrp', 'gz_sellzone' )
			end, 

			'Нет', function() 
		end )
	end

	local map = frame:Add("EditablePanel")
	map:Dock( FILL )
	map.Paint = function( map, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0,0,0,140 ) )
		if gang_zones.mapMaterial then
			surface.SetMaterial( gang_zones.mapMaterial )
			surface.SetDrawColor( 255,255,255 )
			surface.DrawTexturedRect( 0,0,w,h )
		else
			draw.SimpleText( 'Пожалуйста, подождите'..string.rep( '.', CurTime()%3), 'DermaLarge', w/2, h/2, Color( 255,255,255), 1, 1 )
		end
	end

	for k,v in pairs( gang_zones.Zones ) do

		local pos, color = v.vgui_pos, v.color

		local b = vgui.Create( 'EditablePanel', map )
		b:SetPos( pos[1], pos[2] )
		b:SetSize( pos[3], pos[4] )

		b.Paint = function( b, w, h )

			if gang_zones.mapMaterial then
				surface.SetDrawColor( color.r, color.g, color.b, 30)
				surface.DrawRect( 0, 0, w, h)

				surface.SetDrawColor( 80, 80, 80 )
				surface.DrawOutlinedRect( 0, 0, w, h)

				local w2,h2 = w/2, h/2

				draw.RoundedBox( 0, w2 - 100, h2 - 50, 200, 100, Color( 0, 0, 0, 140) )
				draw.DrawText( "Территория "..v.PrintName, 'DarkRPHUD2', w2, h2-30, Color( 255,255,255 ), 1)
				draw.SimpleText( 'Цена: '..DarkRP.formatMoney( v.Price ), 'DermaDefault', w2, h2 + 35, Color( 255,255,255), 1, 1 )

				local zoneData = gang_zones.ZoneData[k]

				if zoneData then
					if IsValid( zoneData.Owner ) then
						local owner_name = zoneData.Owner:GetName()
						local owner_org = zoneData.Owner:GetNWString("orgName")
						local name = ( owner_org ~= nil and owner_org ~= "" and owner_org ~= " " ) and owner_org or owner_name
						draw.SimpleText( 'Собственность '..name, 'DermaDefault', w2, h2, Color( 255,255,255), 1, 1 )
						draw.SimpleText( 'Владелец: '..owner_name, 'DermaDefault', w2, h2 + 15, Color( 255,255,255), 1, 1 )
					end
				end

			end
		end

		local buy = vgui.Create( 'DButton', b )
		buy:SetPos( 0, 0 )
		buy:SetSize( 100, 24 )
		buy:SetText( 'Купить' )

		buy.PaintOver = function( buy, w, h)
			local p = buy:GetParent()
			local wp, hp = p:GetSize()
			local w2, h2 = wp/2, hp/2

			local zoneData = gang_zones.ZoneData[k]

			if zoneData then

				buy:SetVisible( !(IsValid( zoneData.Owner )) )

			end

			buy:SetPos( w2 - 50, h2 )
		end

		buy.DoClick = function()
			Derma_Query( 
			string.format( 'Вы действительно хотите купить %s?\nЭто обойдется вам в %s.\nВ этой зоне ваша банда будет получать реген здоровья и уменьшенный урон по её участникам.', v.PrintName, DarkRP.formatMoney( v.Price ) ),
			'Зоны', 
			
			'Да', function()
			RunConsoleCommand( 'darkrp', 'gz_buyzone', k )
			end, 

			'Нет', function() 
			end )
		end

	end

end--]]

local t = 255
local ct = CurTime() + 3
local oz = 1

hook.Add( 'HUDPaint', 'GangZones', function()
	
	local LocalPlayer = LocalPlayer()

	local active_zone = LocalPlayer:GetNWInt('gz_zone', 1)

	local id = active_zone or 1
	local zone = active_zone
	local azone = gang_zones.Zones[id]

	if oz ~= id then
		t = 255
		ct = CurTime() + 10
		oz = id
	end

	if CurTime() > ct then
		t = Lerp( 0.05, t, 0 )
	end

	local name = azone.PrintName
	local color = ColorAlpha( azone.color, t )
	--local owner = (gang_zones.ZoneData[id]) and gang_zones.ZoneData[id].Owner or nil

	local y = ScrH() - 25

	--if mayor_policy > 0 then y = y  + 35 end
	local ourMat = Material("gui/gradient")
	surface.SetDrawColor( 0, 0, 0, 205 )
	surface.SetMaterial( ourMat	) -- If you use Material, cache it!
	surface.DrawTexturedRect( 0, 0, 212, 112 )
	draw.DrawText( "Улица: ".. name, 'GModNotify', 5, 20, color )

end)

file.CreateDir'cakerp'

http.Fetch( 'https://aww.moe/4mpayj.png', function(d)
	file.Write('cakerp/map.png',d)
	gang_zones.mapMaterial = Material( 'data/cakerp/map.png' )
end)

net.Receive( 'zone_data', function()
	gang_zones.ZoneData = net.ReadTable()
end )