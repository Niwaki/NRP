net.Receive("startelection", function()
	local candidats = net.ReadTable()
	
	local ElectPanel = vgui.Create( "DFrame" )
	ElectPanel:SetSize( 700, 800 )
	ElectPanel:SetTitle( "Список кондидатов." )
	ElectPanel:SetSkin( "DarkRP" )
	ElectPanel:SetDraggable( true )
	ElectPanel:MakePopup()
	ElectPanel:Center();
	
	local EScorePanel = vgui.Create( 'DPropertySheet', ElectPanel )
	EScorePanel:Dock( FILL );
	
	local ElectPlayer = vgui.Create( 'DPanel', EScorePanel )
		for k, v in pairs(candidats) do 
			local E1 = vgui.Create( "DPanel", ElectPlayer )
			E1:Dock(TOP) 
			E1:SetTall( 38 );

			local E2 = vgui.Create( "DLabel", E1 )
			E2:SetPos( 50, 10 ) 
			E2:SetText( v:GetName().." | ".."Речь: "..v:GetNWString("nullptr") ) 
			E2:SizeToContents() 
			E2:SetDark( 1 )
		
			local E3 = vgui.Create( 'SpawnIcon', E1 ) 
			E3:SetSize( 35, 35 );
			E3:SetPos( 5, 3 );
			E3:SetModel( v:GetModel() );
		
			local E4 = vgui.Create( 'DButton', E1 )
			E4:SetPos( 600, 5 )
			E4:SetText( 'Голосовать' )
			function E4:DoClick()
				net.Start("votinge")
				net.WriteFloat(k)
				net.SendToServer()
				ElectPanel:Close()
			end
		end
		EScorePanel:AddSheet( 'Кандидаты на выборы.', ElectPlayer, 'icon16/wrench.png');
	end)