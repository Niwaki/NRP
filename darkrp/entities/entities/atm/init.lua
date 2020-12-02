AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("sasa")

function ENT:Initialize()
	self:SetModel("models/props/cs_assault/TicketMachine.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetAmount(0) 
end

canuse = true
function ENT:Use(activator, caller)
	if canuse then
		net.Start("sasa")
		net.Send(activator)
		canuse = false	
	end
	timer.Simple(3, function() canuse = true end)
end