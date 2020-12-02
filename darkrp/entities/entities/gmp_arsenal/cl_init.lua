include("shared.lua")
function ENT:Initialize()
	self:DrawModel()
end

net.Receive( 'arsenal', function()
	local f = vgui.Create( "DFrame" )
	f:SetSize( 700, 800 )
	f:SetTitle( 'Полицейский арсенал' );
	f:SetSkin('DarkRP')
	f:SetDraggable( false );
	f:MakePopup();
	f:Center();
	
	for k, v in pairs(weapond) do
		local DPanel = vgui.Create( "DPanel", f )
		DPanel:SetTall( 38 );
		DPanel:Dock(TOP) 
		local SpawnI = vgui.Create( "SpawnIcon" , DPanel )
		SpawnI:SetSize(35, 35)
		SpawnI:SetPos( 5, 3 )
		SpawnI:SetModel( weapond[k].model )
		local Dlab = vgui.Create("DLabel", DPanel)
		Dlab:SetText(weapond[k].name)
		Dlab:SizeToContents()
		Dlab:SetPos(50, 10)
		Dlab:SetDark( 1 )
		if (LocalPlayer():HasWeapon(k) and LocalPlayer():GetNWString("fuckars")==k) then
			local DermaButtons = vgui.Create( "DButton", DPanel ) 				
			DermaButtons:SetPos( 525, 5 )	
			DermaButtons:SetText( "Сдать" )		
			function DermaButtons:DoClick()
				net.Start("stripwep")
				net.WriteString(k)
				net.SendToServer()
			end
		end
		local DermaButton = vgui.Create( "DButton", DPanel ) 					
		DermaButton:SetPos( 600, 5 )	
		DermaButton:SetText( "Выбрать" )						
		DermaButton.DoClick = function()				
			net.Start("togivef")
			net.WriteString(k)
			net.SendToServer()
		end
	end
end )