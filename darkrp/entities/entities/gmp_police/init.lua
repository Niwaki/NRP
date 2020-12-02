AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local Shit = {"fas2_dv2", "fas2_m1911", "fas2_toz34", "fas2_sks", "fas2_ak47", "fas2_ak74", "fas2_an94", "fas2_g36c", "fas2_g3", "fas2_deagle", "fas2_galil", "fas2_mac11", "fas2_m14", "fas2_m21", "fas2_m4a1", "fas2_m67", "fas2_machete", "fas2_mp5a5", "fas2_p226", "fas2_rem870", "gmp_craft_metal", "gmp_craft_wood", "lockpick"} 

function ENT:Initialize()

	self:SetModel("models/props_wasteland/controlroom_desk001b.mdl")
	self:PhysicsInit( SOLID_VPHYSICS )     
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )         
	self:SetUseType( SIMPLE_USE )
	
end

function ENT:StartTouch(ent)
	if table.HasValue(Shit,ent:GetClass()) then
		ent:Remove()
		DarkRP.createMoneyBag(self:GetPos()- Vector(1,1,-30), math.random(150, 340))
	end
end

