
net.Receive("registered", function()
	DermaPanel = vgui.Create( "DFrame" ) -- Creates the frame itself-- Position on the players screen
	DermaPanel:SetSize( 385, 750 ) 
	DermaPanel:SetSkin("DarkRP")
	DermaPanel:Center() -- Size of the frame
	DermaPanel:SetTitle( "Создание персонажа" ) -- Title of the frame
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( false ) -- Draggable by mouse?
	DermaPanel:ShowCloseButton( false ) -- Show the close button?
	DermaPanel:MakePopup()
	DermaPanel:Add("choosename")
end)

local PANEL = {}

function PANEL:Init()
	local Good = "icon16/accept.png" -- gui/silkicons/check_on
	local Bad = "icon16/cross.png" -- gui/silkicons/check_off
	local gender_male = true
	local var = 1
		local gender_table =Config_Models.male_models
	local panel = vgui.Create("DPanel", DermaPanel)
	panel:Dock(FILL)
	local ScrollPanelf = vgui.Create( "DScrollPanel", panel )
	ScrollPanelf:Dock( FILL )
	--local Label = vgui.Create("DLabel", ScrollPanelf)
	--Label:SetText("Имя")
	--Label:SetPos(10, 10)
	--Label:SetDark(1)

	local NameBad = vgui.Create( "DImage", ScrollPanelf )    -- Add image to Frame
	NameBad:SetPos( 265, 15 )    -- Move it into frame
	NameBad:SetSize( 16, 16 )    -- Size it to 150x150
	NameBad:SetImage( Bad )
	
	local NameGood = vgui.Create( "DImage", ScrollPanelf )    -- Add image to Frame
	NameGood:SetPos( 265, 15 )    -- Move it into frame
	NameGood:SetSize( 16, 16 )    -- Size it to 150x150
	NameGood:SetImage( Good )
	
	local TextEntry = vgui.Create( "DTextEntry", ScrollPanelf ) -- create the form as a child of frame
	TextEntry:SetPos( 25, 10 )
	TextEntry:SetSize( 235, 25 )
	TextEntry:SetText( "Введите имя..." )
	--TextEntry.MaxName = 15
	TextEntry.OnEnter = function( self )
		--chat.AddText( self:GetValue() )	-- print the form's text as server text
	end
	/*TextEntry.OnChange = function(self)
		name = self:GetValue()
		local amts = string.len(name)
		
		if amts > self.MaxName then
			self:SetText(self.OldText)
			self:SetValue(self.OldText)
		else
			self.OldText = name
		end
	end*/
	--local Labelf = vgui.Create("DLabel", ScrollPanelf)
	--Labelf:SetText("Фамилия")
	--Labelf:SetPos(10, 80)
	--Labelf:SetDark(1)
	
	local SurnameBad = vgui.Create( "DImage", ScrollPanelf )    -- Add image to Frame
	SurnameBad:SetPos( 265, 55 )    -- Move it into frame
	SurnameBad:SetSize( 16, 16 )    -- Size it to 150x150
	SurnameBad:SetImage( Bad )
	--
	local SurnameGood = vgui.Create( "DImage", ScrollPanelf )    -- Add image to Frame
	SurnameGood:SetPos( 265, 55 )    -- Move it into frame
	SurnameGood:SetSize( 16, 16 )    -- Size it to 150x150
	SurnameGood:SetImage( Good )
	
	local TextEntr = vgui.Create( "DTextEntry",  ScrollPanelf) -- create the form as a child of frame
	TextEntr:SetPos( 25, 50 )
	TextEntr:SetSize( 235, 25 )
	TextEntr:SetText( "Введите фамилию..." )
	--TextEntr.MaxSurName = 15 
	TextEntr.OnEnter = function( self )
		--chat.AddText( self:GetValue() )	-- print the form's text as server text
	end
	/*TextEntr.OnChange = function(self)
		surname = self:GetValue()
		local amts = string.len(surname)
		
		if amts > self.MaxSurName then
			self:SetText(self.OldText)
			self:SetValue(self.OldText)
		else
			self.OldText = surname
		end
	end*/
	--local Labelff = vgui.Create("DLabel", ScrollPanelf)
	--Labelff:SetText("Описание персонажа")
	--Labelff:SetPos(10, 130)
	--Labelff:SetDark(1)
	
	local DescBad = vgui.Create( "DImage", ScrollPanelf )    -- Add image to Frame
	DescBad:SetPos( 325, 95 )    -- Move it into frame + 5
	DescBad:SetSize( 16, 16 )    -- Size it to 150x150
	DescBad:SetImage( Bad )
	--
	local DescGood = vgui.Create( "DImage", ScrollPanelf )    -- Add image to Frame
	DescGood:SetPos( 325, 95 )       -- Move it into frame + 5
	DescGood:SetSize( 16, 16 )   -- Size it to 150x150
	DescGood:SetImage( Good )
	
	local TextEntrDesc = vgui.Create( "DTextEntry",  ScrollPanelf) -- create the form as a child of frame
	TextEntrDesc:SetPos( 25, 90 )
	TextEntrDesc:SetSize( 295, 25 )
	TextEntrDesc:SetText( "Введите описание персонажа..." )
	--TextEntrDesc.MaxDesc = 30
	TextEntrDesc.OnEnter = function( self )
		--chat.AddText( self:GetValue() )	-- print the form's text as server text
	end
	/*TextEntrDesc.OnChange = function(self)
		desc = self:GetValue()
		local amts = string.len(desc)
		
		if amts > self.MaxDesc then
			self:SetText(self.OldText)
			self:SetValue(self.OldText)
		else
			self.OldText = desc
		end
	end*/
	------------
	--local Label3 = vgui.Create("DLabel", ScrollPanelf)
	--Label3:SetText("выберите пол")
	--Label3:SetPos(10, 190)
	--Label3:SizeToContents()
	--Label3:SetDark(1)
	
	local icon = vgui.Create( "DModelPanel", ScrollPanelf )
		icon:SetPos( 10, 200 )
		icon:SetSize( 360, 350 )
		icon:SetModel( gender_table[var]) 
		--icon.Entity:SetSkin( LocalPlayer():GetSkin() )
	local DermaButton3 = vgui.Create( "DButton", ScrollPanelf ) // Create the button and parent it to the frame
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
	local DermaButton4 = vgui.Create( "DButton", ScrollPanelf ) // Create the button and parent it to the frame
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
	local DermaNumSlider = vgui.Create( "DNumSlider", DermaPanel )
	DermaNumSlider:Dock(TOP)		// Set the size
	DermaNumSlider:SetText( "Выберите одежду" )	// Set the text above the slider
	DermaNumSlider:SetMin( 0 )				// Set the minimum number you can slide to
	DermaNumSlider:SetMax( 23 )				// Set the maximum number you can slide to
	DermaNumSlider:SetDecimals( 0 )	
	function DermaNumSlider:ValueChanged( value )
		icon.Entity:SetSkin(value)
	end
	local DermaButton = vgui.Create( "DButton", ScrollPanelf ) // Create the button and parent it to the frame
	DermaButton:SetText( "<=" )					// Set the text on the button
	DermaButton:SetPos( 100, 350 )				// Set the position on the frame
	DermaButton:SetSize( 25, 25 )				
	DermaButton.DoClick = function()				
		if var > 1 then
			var = var - 1
		end
		icon:SetModel(gender_table[var])
	end
	local DermaButton2 = vgui.Create( "DButton", ScrollPanelf ) // Create the button and parent it to the frame
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
	local button = vgui.Create("DButton", ScrollPanelf)
	button:SetPos( 0, 655 )
	button:SetSize( 375, 25 )		
	button:SetText("Создать персонажа")
	function button:DoClick()
		if (!string.find(TextEntry:GetValue(), "^[%w%p0-9]+$") and !string.find(TextEntr:GetValue(), "^[%w%p0-9]+$") and !string.find(TextEntrDesc:GetValue(), "^[%w%p0-9]+$" ) ) then
			DermaPanel:Remove()
			net.Start("getinfo")
			net.WriteString(TextEntry:GetValue())
			net.WriteString(TextEntr:GetValue())
			net.WriteString(icon:GetModel())
			net.WriteString(TextEntrDesc:GetValue())
			net.WriteFloat(icon.Entity:GetSkin())
			net.SendToServer()
		end
	end
end
vgui.Register("choosename", PANEL, "panel")

local PANEL = {}

function PANEL:Init()
	
end

vgui.Register("choosemodel", PANEL, "panel")

