AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString("m1sd")
util.AddNetworkString("j2df")
util.AddNetworkString("odf")

function ENT:Initialize()
	self:SetModel("models/player/kleiner.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	
	self:SetSequence(table.Random({"idle_all_01", "idle_all_02", "idle_passive"}))
end
function ENT:Use(inputName, activator, called, data )
	if !cantUse then
		 if activator:GetNWFloat("loyality") >= 1 and activator:GetNWBool("Gun") and activator:GetNWBool("Home") and activator:GetNWInt("violition") == 0 and not activator:GetNWBool("ment") then
			net.Start("m1sd")
			net.Send(activator)
			cantUse = true
		else
			DarkRP.notify(activator, 0, 2, "У вас не хватает ОЛ или много ОН, либо нету лицензий.") -- ИЛИ ВЫ УЖЕ ЗДАЛИ ТЕСТ!
		end
	end
	timer.Simple(1, function() cantUse = false end)
end
net.Receive("j2df", function(len, ply)
	ply:SetNWBool("ment", true)
	pidor(ply)
	DarkRP.notify(ply, 0, 2, "Поздровляю, пора служить FinelyCity!")
end)