net.Receive("showpass", function() -- ДОБАВИТЬ POLICE_RANG!
	local licenses = {
		Gun = "Ношение оружия",
		GunTrade = "Продажа оружия",
		Home = "Дом",
		Trade = "Торговля"
	}
	local player = net.ReadEntity()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:Center()
	DermaPanel:SetSize( 300, 250 )
	DermaPanel:SetTitle( "Паспорт гражданина FinelyCity" )
	DermaPanel:SetDraggable( true )
	local SpawnI = vgui.Create( "SpawnIcon" , DermaPanel ) -- SpawnIcon
	SpawnI:SetPos(20, 25 )
	SpawnI:SetModel( player:GetModel() )
	local DLabel = vgui.Create( "DLabel", DermaPanel)
	DLabel:SetPos( 75, 90 )
	DLabel:SetSize(300, 20)
	DLabel:SetText( "Имя/Фамилия:"..player:GetName())
	DLabel:SizeToContents()
	local DLabel2 = vgui.Create( "DLabel", DermaPanel)
	DLabel2:SetPos( 75, 110 )
	DLabel2:SetSize(300, 20)
	DLabel2:SetText( "Лояльность: "..string.format("%g", player:GetNWFloat("loyality")).." | ".."Очки нарушения: "..player:GetNWInt("violition"))
	DLabel2:SizeToContents()
	local DLabel3 = vgui.Create( "DLabel", DermaPanel)
	DLabel3:SetPos( 75, 130 )
	DLabel3:SetSize(300, 20)
	DLabel3:SetText( "Лицензии:")
	DLabel3:SizeToContents()
	local i = 0
	for k, v in pairs(licenses) do
		if LocalPlayer():GetNWBool(k) then 
			i = i + 10
			local DLabel4 = vgui.Create( "DLabel", DermaPanel)
			DLabel4:SetPos( 75, 150 + i )
			DLabel4:SetSize(300, 20)
			DLabel4:SetText(v)
			DLabel4:SizeToContents()
		end
	end
end)