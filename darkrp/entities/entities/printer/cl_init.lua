--[[---------------------------------------------------------------------------
This is an example of a custom entity.
---------------------------------------------------------------------------]]
include("shared.lua")

function ENT:Initialize()
end

function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	local owner = self:Getowning_ent()
	owner = (IsValid(owner) and owner:Nick()) or DarkRP.getPhrase("unknown")

	surface.SetFont("HUDNumber5")
	local text = DarkRP.getPhrase("money_printer")
	local TextWidth = surface.GetTextSize(text)
	local TextWidth2 = surface.GetTextSize(owner)

	Ang:RotateAroundAxis(Ang:Up(), 90)
	--[[
	cam.Start3D2D(Pos + Ang:Up() * 11.5, Ang, 0.11)
		draw.WordBox(2, -TextWidth*0.5, -30, text, "HUDNumber5", Color(140, 0, 0, 100), Color(255,255,255,255))
		draw.WordBox(2, -TextWidth2*0.5, 18, owner, "HUDNumber5", Color(140, 0, 0, 100), Color(255,255,255,255))
		draw.WordBox(2, -TextWidth2*0.5, 38, self:GetMoney(), "HUDNumber5", Color(140, 0, 0, 100), Color(255,255,255,255))
		draw.WordBox(2, -TextWidth2*0.5, 58, self:GetEnergy(), "HUDNumber5", Color(140, 0, 0, 100), Color(255,255,255,255))
	cam.End3D2D()--]]
end
net.Receive("money", function()
	local mon = net.ReadEntity()
	local frame = vgui.Create( "DFrame" )
	frame:SetSize( 300, 200 )
	frame:Center()
	frame:SetTitle( "My new Derma frame" )
	frame:SetDraggable( true )
	frame:MakePopup()
	local sheet = vgui.Create( "DPropertySheet", frame )
	sheet:Dock( FILL )
	local panel1 = vgui.Create( "DPanel", sheet )
	panel1.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 128, 255, 0 ) ) end
	Db = vgui.Create("DButton", panel1)
	Db:SetPos(15, 60)
	Db:SetSize(250, 30)
	Db:SetText("Напечатано: "..mon:GetMoney())
	function Db:DoClick()
		net.Start("withdraw")
		net.WriteEntity(mon)
		net.SendToServer()
	end
	res = vgui.Create("DButton", panel1)
	res:SetPos(15, 95)
	res:SetSize(250, 30)
	res:SetText("Перезарядить за 500$")
	progress = vgui.Create("DPanel", panel1)
	progress:SetSize(250, 20)
	progress:SetPos(15, 30)
	progressd = vgui.Create("DPanel", panel1)
	progressd:SetSize(mon:GetEnergy()* 25, 20)
	progressd:SetPos(15, 30)
	function progressd:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 255, 0 ) )
	end
		--draw.RoundedBox(0, 25, 90, 250, 20, Color(0, 255, 0, 255))
	
	function res:DoClick()
		net.Start("reset")
		net.WriteEntity(mon)
		net.SendToServer()
	end
	sheet:AddSheet( "главная", panel1, "icon16/money.png" )
	local panel2 = vgui.Create( "DPanel", sheet )
	panel2.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 128, 255, 0 ) ) end
	up = vgui.Create("DButton", panel2)
	up:SetPos(15, 95)
	up:SetSize(250, 30)
	up:SetText("Улучшить ваш текущий уровень:"..mon:GetLevel() )
	function up:DoClick()
		net.Start("uplvl")
		net.WriteEntity(mon)
		net.SendToServer()
	end
	sheet:AddSheet( "Улучшение", panel2, "icon16/wrench.png" )
end)
function ENT:Think()
end
