AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("arsenal")
util.AddNetworkString("togivef")
util.AddNetworkString("stripwep")

function ENT:Initialize()
	self:SetModel( "models/props_c17/Lockers001a.mdl" )
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    phys:Wake()
end

function ENT:AcceptInput( name, activator, caller )
	timer.Simple(1, function()
		canuse = true
	end)
	if canuse == true then
		if activator:isCP() then
			net.Start("arsenal")
			net.Send(activator)
			canuse = false
		end
	end
end
net.Receive("togivef", function(len, ply)
	if(!ply:GetNWBool("arsn") and !ply:GetNWBool("coold") )then
		local fesa = net.ReadString()
		ply:Give(fesa)
		ply:SetNWString("fuckars", fesa)
		DarkRP.notify(ply, 0, 2, "Вы взяли оружие из полицейского арсенала.")
		ply:SetNWBool("arsn", true)
		ply:SetNWBool("coold", true)
		timer.Simple(900, function()
			ply:SetNWBool("coold", false)
		end)
	else
		DarkRP.notify(ply, 0, 2, "Для начала верните оружие или подождите 15 мин")
	end
end)
net.Receive("stripwep", function(len, ply)
	local pidor = net.ReadString()
	ply:StripWeapon( pidor)
	ply:SetNWBool("arsn", false)
	ply:SetNWBool("coold", false)
	ply:SetNWString("fuckars", nil)
end)