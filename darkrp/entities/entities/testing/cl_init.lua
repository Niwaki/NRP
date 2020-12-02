include("shared.lua")

function ENT:Initialize()
end
function ENT:Draw()
	self:DrawModel()
end
function ENT:Think()
end

net.Receive("m1sd", function()
local bal = 0

local frame = vgui.Create( "DFrame" )
frame:SetSize( 300, 250 )
frame:Center()
frame:SetTitle( 'Тест' )
frame:SetSkin( 'DarkRP' )
frame:SetDraggable( false );
frame:MakePopup()
local DScrollPanel = vgui.Create( "DScrollPanel", frame )
DScrollPanel:Dock( FILL )

for k, v in pairs(question) do
Dlabel = vgui.Create("DLabel", DScrollPanel)
Dlabel:SetText(question[k].name)
Dlabel:Dock(TOP)
Dlabel:SizeToContents()
local DComboBox = vgui.Create( "DComboBox", DScrollPanel )
DComboBox:Dock(TOP)
DComboBox:SetValue( "Варианты" )
for j, i in pairs(question[k].variants) do
	DComboBox:AddChoice(i)
end
DComboBox.Paint = function( _, w, h )
	surface.SetDrawColor(100, 100, 100)
	surface.DrawRect(0, 0, w, h)
end
DComboBox.OnSelect = function( self, index, value )
	if value == question[k].answer then
		bal = bal + 1
	else
		if(bal > 0) then
			bal = bal -1
		end
	end
end
end
	local baton = vgui.Create("DButton", frame)
	baton:Dock(BOTTOM)
	baton:SetText("Отправить")
	function baton:DoClick()
		if bal == #question then
			frame:Close()
			net.Start("j2df")
			net.SendToServer()
		else
			net.Start("odf")
			net.SendToServer()
			frame:Close()
		end
	end
end)