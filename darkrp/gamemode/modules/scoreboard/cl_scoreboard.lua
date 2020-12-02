local function DermaInput()
	local Panel = vgui.Create( "DFrame" )
	Panel:SetSize( 200, 80 )
	Panel:SetTitle( '' );
	Panel:SetSkin("DarkRP")
	Panel:SetText("Смена описания персонажа.")
	Panel:Center()
	Panel:MakePopup()

	--local DLabel = vgui.Create( "DLabel", Panel )
	--DLabel:Dock(TOP)
	--DLabel:SetText("")
	local TextEntry = vgui.Create( "DTextEntry", Panel ) -- create the form as a child of frame
	TextEntry:Dock(TOP)
	TextEntry:SetText( LocalPlayer():GetNWString("desc") )
	local Apply = vgui.Create("DButton", Panel)
	Apply:SetText("Применить")
	Apply:Dock(BOTTOM)
	function Apply:DoClick()
		LocalPlayer():SetNWString("desc", TextEntry:GetValue())
		net.Start("setdesc")
		net.WriteString(TextEntry:GetValue())
		net.SendToServer()
	end
end

local function ScoreboardGM()

	ScorePlayer = vgui.Create( 'DFrame' )
	ScorePlayer:SetSize( 700, 800 );
	ScorePlayer:SetSkin("DarkRP")
	ScorePlayer:SetTitle( 'Список игроков.' );
	ScorePlayer:SetDraggable( false );
	ScorePlayer:ShowCloseButton( false )
	ScorePlayer:MakePopup();
	ScorePlayer:Center();
    gui.EnableScreenClicker( true );
	
	local ScorePanel = vgui.Create( 'DPropertySheet', ScorePlayer )
	ScorePanel:Dock( FILL );
	
	local CityPlayer = vgui.Create( 'DPanel', ScorePanel )
	local DScrollPanel = vgui.Create( "DScrollPanel", CityPlayer )
	DScrollPanel:Dock( FILL )
	local DButt = vgui.Create("DButton", CityPlayer)
	DButt:Dock(BOTTOM)
	DButt:SetText("Изменить описание")
	DButt:SetTall( 38 );
		for k, v in pairs( player.GetAll() ) do
			local city_player_pnl = vgui.Create( 'DPanel', DScrollPanel )
				city_player_pnl:Dock( TOP );
				city_player_pnl:SetTall( 38 );
					
			local city_player_desc = vgui.Create( 'DLabel', city_player_pnl )
				city_player_desc:SetPos( 50, 10 );
				city_player_desc:SetText( "Описание игрока: "..v:GetNWString("desc") )
				city_player_desc:SizeToContents(); 
				city_player_desc:SetDark( 1 );
					
			local city_player_mdl = vgui.Create( 'SpawnIcon', city_player_pnl ) 
				city_player_mdl:SetSize( 35, 35 );
				city_player_mdl:SetPos( 5, 3 );
				city_player_mdl:SetModel( v:GetModel() );
			end
			
			function DButt:DoClick()
				DermaInput()
			end
	ScorePanel:AddSheet( 'Игроки FinelyRP', CityPlayer, 'icon16/wrench.png');

end

hook.Add( 'ScoreboardShow', 'ScoreOpen', function()
    ScoreboardGM()
    return true
end )

hook.Add( 'ScoreboardHide', 'ScoreClose', function()
    ScorePlayer:SetVisible( false )
    gui.EnableScreenClicker( false )
    return true
end )