AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("gepard2")
util.AddNetworkString("newName2")

function ENT:Initialize()
	self:SetModel("models/props/cs_office/offcorkboarda.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	--self:SetAmount(0) 
end
function ENT:Use(inputName, activator, called, data )
	if !cantUse  then
		if(!findMayor()) then
			net.Start("gepard2")
			net.Send(activator)
			cantUse = true
		else
			DarkRP.notify(activator, 1, 4, "Мэр уже есть")
		end
	end
	timer.Simple(1, function() cantUse = false end)
end
