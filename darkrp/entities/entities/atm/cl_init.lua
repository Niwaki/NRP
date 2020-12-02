include("shared.lua")

function ENT:Initialize()
end
function ENT:Draw()
	self:DrawModel()
end
function ENT:Think()
end

local function deposit()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetSize( 200, 100 )
	DermaPanel:Center()
	DermaPanel:SetTitle( "" )
	DermaPanel:SetSkin("DarkRP")
	DermaPanel:SetDraggable( false )
	DermaPanel:MakePopup()
	
	local TextEntry = vgui.Create( "DTextEntry", DermaPanel ) -- create the form as a child of frame
	TextEntry:Dock(TOP)
	TextEntry.OnEnter = function( self )
		chat.AddText( self:GetValue() )	-- print the form's text as server text
	end
	local dbs = vgui.Create("DButton", DermaPanel)
	dbs:SetText("Внести деньги")
	function dbs:DoClick()
		RunConsoleCommand("addmon", TextEntry:GetValue())
	end
	dbs:Dock(BOTTOM)
end

local function withdraw()
	local ermaPanel = vgui.Create( "DFrame" )
	ermaPanel:SetSize( 200, 100 )
	ermaPanel:Center()
	ermaPanel:SetTitle( "" )
	ermaPanel:SetSkin("DarkRP")
	ermaPanel:SetDraggable( false )
	ermaPanel:MakePopup()
	
	local TextEntry = vgui.Create( "DTextEntry", ermaPanel ) -- create the form as a child of frame
	TextEntry:Dock(TOP)
	TextEntry.OnEnter = function( self )
		chat.AddText( self:GetValue() )	-- print the form's text as server text
	end
	local dbs = vgui.Create("DButton", ermaPanel)
	dbs:SetText("Снять деньги")
	function dbs:DoClick()
		RunConsoleCommand("withdraw", TextEntry:GetValue())
	end
	dbs:Dock(BOTTOM)
end

net.Receive("sasa", function()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetSize( 400, 300 )
	DermaPanel:Center()
	DermaPanel:SetSkin("DarkRP")
	DermaPanel:SetTitle( "Банкомат" )
	DermaPanel:SetDraggable( false )
	DermaPanel:MakePopup()
	local label = vgui.Create("DLabel", DermaPanel)
	label:Dock(TOP)
	label:SetText("Ваш счет:"..LocalPlayer():GetNWInt("mon").."$\n")
	local db = vgui.Create("DButton", DermaPanel)
	db:SetText("Внести деньги")
	function db:DoClick()
		deposit()
	end
	db:Dock(TOP)
	local dba = vgui.Create("DButton", DermaPanel)
	dba:SetText("Снять деньги")
	function dba:DoClick()
		withdraw()
	end
	dba:Dock(TOP)
	local label = vgui.Create("DLabel", DermaPanel)
	label:Dock(TOP)
	label:SetText("Транзакция на счет другого гражданина")
	local DComboBox = vgui.Create( "DComboBox", DermaPanel )
	DComboBox:Dock(TOP)
	DComboBox:SetSize( 100, 20 )
	DComboBox:SetValue( "Выбрать транзакцию" )
	DComboBox.Paint = function( _, w, h )
		surface.SetDrawColor(100, 100, 100)
		surface.DrawRect(0, 0, w, h)
	end
	for k, v in pairs(player.GetAll()) do
		DComboBox:AddChoice( v:Name() )
	end
	DComboBox.OnSelect = function( panel, index, value )
	end
	local TextEntry = vgui.Create( "DTextEntry", DermaPanel ) -- create the form as a child of frame
	TextEntry:Dock(TOP)
	TextEntry:SetText('Введите сумму...')
	TextEntry.OnEnter = function( self )
		chat.AddText( self:GetValue() )	-- print the form's text as server text
	end
	local dbaf = vgui.Create("DButton", DermaPanel)
	dbaf:SetText("Отправить")
	dbaf:Dock(TOP)
	function dbaf:DoClick()
		RunConsoleCommand("tra", TextEntry:GetValue(), DComboBox:GetSelected())
	end
end)