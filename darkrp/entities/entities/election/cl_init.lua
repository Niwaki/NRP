include("shared.lua")

function ENT:Initialize()
end
function ENT:Draw()
	self:DrawModel()
end
function ENT:Think()
end

net.Receive("gepard2", function()
	Derma_StringRequest(
	"Баллотироваться на выборы",
	"Предвыборная речь",
	"",
	function( text ) net.Start("newName")RunConsoleCommand( "addlinlist", text ) end,
	function( text ) print( "Cancelled input" ) end
	)	
end)