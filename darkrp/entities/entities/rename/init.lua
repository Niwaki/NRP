AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("gepard")
util.AddNetworkString("newName")

function ENT:Initialize()
	self:SetModel("models/props/cs_office/offcorkboarda.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	--self:SetAmount(0) 
end
function ENT:Use(inputName, activator, called, data )
	if !cantUse then
		net.Start("gepard")
		net.Send(activator)
		cantUse = true
	end
	timer.Simple(1, function() cantUse = false end)
end

net.Receive("newName", function(len, ply)
	if ply:canAfford(500)then
		ply:addMoney(-500)
		local name = net.ReadString()
		ply:setRPName(name)
	end
end)