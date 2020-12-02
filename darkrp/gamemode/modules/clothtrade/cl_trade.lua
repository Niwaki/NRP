net.Receive("usingselll", function()
	local mai = net.ReadEntity()
	local frame = vgui.Create("DFrame")
	frame:SetSize( 385, 750 ) 
	frame:MakePopup()
	frame:SetSkin("DarkRP")
	frame:Center()
	frame:SetTitle( "Смена гардероба" ) -- Title of the frame
	
	local Panel = vgui.Create( "DPanel" , frame)
	Panel:Dock(FILL)
	
	local DScrollPanel = vgui.Create( "DScrollPanel",Panel )
	DScrollPanel:Dock( FILL )
	
	local icon = vgui.Create( "DModelPanel",  Panel )
	icon:SetPos( 10, 200 )
	icon:SetSize( 360, 350 )
	icon:SetModel( LocalPlayer():GetModel() )
	
	local DermaNumSlider = vgui.Create( "DNumSlider", Panel )
	DermaNumSlider:Dock(TOP)// Set the size
	DermaNumSlider:SetText( "Выберите одежду" )	// Set the text above the slider
	DermaNumSlider:SetMin( 0 )				// Set the minimum number you can slide to
	DermaNumSlider:SetMax( 23 )
	DermaNumSlider:SetDecimals( 0 )	
	function DermaNumSlider:ValueChanged( value )
		icon.Entity:SetSkin(value)
	end
	
	local niwakaPidor = vgui.Create("DButton", Panel)
	niwakaPidor:SetText("Сменить гардероб")
	niwakaPidor:SetPos( 0, 655 )
	niwakaPidor:SetSize( 375, 25 )	
	function niwakaPidor:DoClick()
		net.Start("csharp")
		net.WriteEntity(mai)
		net.WriteFloat(DermaNumSlider:GetValue())
		net.SendToServer()
	end
end)

net.Receive("cmake", function()
	local mai = net.ReadEntity()
	local gender_table = Config_Models.male_models
	local frame = vgui.Create("DFrame")
	local var = 1
	frame:SetSize( 385, 750 ) 
	frame:SetSkin("DarkRP")
	frame:MakePopup()
	frame:SetTitle( "Смена внешности" ) -- Title of the frame
	frame:Center()
	local Panel = vgui.Create( "DPanel" , frame)
	Panel:Dock(FILL)
	local DScrollPanel = vgui.Create( "DScrollPanel",Panel )
	DScrollPanel:Dock( FILL )
	
	local icon = vgui.Create( "DModelPanel",  Panel )
	icon:SetPos( 10, 200 )
	icon:SetSize( 360, 350 )
	icon:SetModel( LocalPlayer():GetModel() )
	
	local DermaButton3 = vgui.Create( "DButton", Panel ) // Create the button and parent it to the frame
	DermaButton3:SetText( "М" )					// Set the text on the button
	DermaButton3:SetPos( 200,200 )					// Set the position on the frame
	DermaButton3:SetSize( 25, 25 )						
	DermaButton3.DoClick = function()
		var = 1	
		if (gender_table !=Config_Models.male_models) then
			gender_table =Config_Models.male_models
			icon:SetModel(gender_table[var])
		end
	end
	local DermaButton4 = vgui.Create( "DButton",Panel ) // Create the button and parent it to the frame
	DermaButton4:SetText( "Ж" )					// Set the text on the button
	DermaButton4:SetPos( 150, 200 )					// Set the position on the frame
	DermaButton4:SetSize( 25, 25 )						
	DermaButton4.DoClick = function()
		var = 1
		if (gender_table ==Config_Models.male_models) then
			gender_table =Config_Models.female_models
			icon:SetModel(gender_table[var])
		end
	end
		local DermaButton = vgui.Create( "DButton", Panel ) // Create the button and parent it to the frame
	DermaButton:SetText( "<=" )					// Set the text on the button
	DermaButton:SetPos( 100, 350 )				// Set the position on the frame
	DermaButton:SetSize( 25, 25 )					
	DermaButton.DoClick = function()				
		if var > 1 then
			var = var - 1
		end
		icon:SetModel(gender_table[var])
	end
	local DermaButton2 = vgui.Create( "DButton", Panel) // Create the button and parent it to the frame
	DermaButton2:SetText( "=>" )					// Set the text on the button
	DermaButton2:SetPos( 250, 350 )				// Set the position on the frame
	DermaButton2:SetSize( 25, 25 )					
	DermaButton2.DoClick = function()				
		if var<#gender_table then
			var = var + 1
		end
		local m =Config_Models.male_models[var]
		icon:SetModel(gender_table[var])
	end
	local niwakaPidor = vgui.Create("DButton", Panel)
	niwakaPidor:SetText("Сменить внешность")
	niwakaPidor:SetPos( 0, 655 )
	niwakaPidor:SetSize( 375, 25 )	
	function niwakaPidor:DoClick()
		net.Start("kuler")
		net.WriteEntity(mai)
		net.WriteString(icon:GetModel())
		net.SendToServer()
	end
end)