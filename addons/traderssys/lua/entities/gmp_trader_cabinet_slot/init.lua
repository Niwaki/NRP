AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("autorun/sh_traders.lua")


util.AddNetworkString( "SetWeapSettings" )



function ENT:Initialize()
	
	self:SetModel( "models/hunter/plates/plate025.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )     
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )         
	self:SetUseType( SIMPLE_USE )
	self:CPPISetOwner(self:Getowning_ent()) 

end

function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 16

	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:SetAngles(Angle(0,ply:EyeAngles().y,0))
	ent:Spawn()
	ent:Activate()

	return ent

end

function ENT:Use(act, call, some) 

	local owner = self:Getowning_ent()
	if (!IsValid(owner) and owner != call) then return end
	if (owner != call) then return end
	//self:SetModel("models/hunter/plates/plate075.mdl")

	//self:SetModel("models/hunter/plates/plate05.mdl")

	net.Start("SetWeapSettings")
		net.WriteEntity(self)
	net.Send(call)


end

concommand.Add("gmp_setPriceSetting", function (ply, cmd, args)

	if (args[1] != "ZJKXFBJKFJKHWJjwjjwjwejqe312") then return end
	local ent = ents.GetByIndex(args[2])

	ent:SetNWInt("CanChangeWeapModel",tonumber(args[4], 10))
	ent:SetNWString("WeapPrice", args[3])

end)


net.Receive("GetSlotWeaponModel",function() 

	local ent = ents.GetByIndex(net.ReadInt())
	ent:SetWeapEnt(net.ReadEntity())


end)

function ENT:OnRemove()
	if (IsValid(self:GetChildren()[1])) then
		local ent = self:GetChildren()[1]
		ent:SetParent()
		ent.CanUse = true
	end
end




function ENT:StartTouch(ent)
	if (self:GetNWInt("CanChangeWeapModel",0) == 1 ) then return end
	if (ent:GetClass() != "spawned_weapon") then return end

	local Ang = self:GetAngles()
		Ang:RotateAroundAxis(Ang:Forward(), 90)
		Ang:RotateAroundAxis(Ang:Right(), 90)
		
	if (table.HasValue(pistols, ent:GetWeaponClass())) then
		self:SetModel( "models/hunter/plates/plate025.mdl" )
	elseif (table.HasValue(rifles, ent:GetWeaponClass())) then
		self:SetModel("models/hunter/plates/plate05.mdl")
	else
		self:SetModel("models/hunter/plates/plate075.mdl")
	end

	if (!IsValid(self:GetChildren()[1])) then
		ent:SetParent(self)
		ent.CanUse = false
	else
		local oldChild = self:GetChildren()[1]
			oldChild:SetParent()
			oldChild:SetPos(oldChild:GetPos() + Ang:Up() * 40)
			oldChild.CanUse = true

		ent:SetParent(self)
		ent.CanUse = false
	end
end
	
