include("shared.lua")

function ENT:Initialize()
end
function ENT:Draw()
	self:DrawModel()
end
function ENT:Think()
end

net.Receive("gepard", function()
	Derma_StringRequest(
	"Смена имени и фамилии",
	"Напишите новое имя и фамилие",
	"",
	function( text ) net.Start("newName")net.WriteString(text)net.SendToServer() end,
	function( text ) print( "Cancelled input" ) end
	)	
end)