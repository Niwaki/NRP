AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString("ImageSet")

function ENT:Initialize()
	self:SetModel( "models/maxofs2d/hover_plate.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )     
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )         
	self:SetModelScale(0.7)
	self:SetFlexScale(0.2)
	self:SetUseType( SIMPLE_USE )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetNWInt("BackColorR",255)
	self:SetNWInt("BackColorG",255)
	self:SetNWInt("BackColorB",255)
	self:SetNWInt("ForwColorR",255)
	self:SetNWInt("ForwColorG",255)
	self:SetNWInt("ForwColorB",255)
	self:SetNWString("Text","Надпись.")
	self:SetNWString("TextFont","GMP_TitleFontN2")
	self:SetNWFloat("TextSize",0.25)
	self:SetNWInt("TextMoving", 0)
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

function ENT:Use (act, caller, useType, integ)
	local owner = self:Getowning_ent()
	if (!IsValid(owner) and owner != caller) then return end
	if (owner != caller) then return end
	local ent = caller:GetEyeTrace().Entity
	if (!IsValid(ent)) then return end
	if caller:GetPos():Distance(self:GetPos()) < 200  then
        net.Start( "ImageSet" )
          net.WriteEntity(self)
        net.Send(caller)
	end




end

concommand.Add("gmp_settableText", function (ply, cmd, args)

	if (args[1] != "sedjkfgdjkewfuijhwer124sak") then return end
	local ent = ents.GetByIndex(args[2])

	ent:SetNWInt("BackColorR",args[3])
	ent:SetNWInt("BackColorG",args[4])
	ent:SetNWInt("BackColorB",args[5])
	ent:SetNWInt("ForwColorR",args[6])
	ent:SetNWInt("ForwColorG",args[7])
	ent:SetNWInt("ForwColorB",args[8])
	ent:SetNWString("Text",args[9])
	ent:SetNWString("TextFont",args[10])
	ent:SetNWFloat("TextSize",args[11])
	ent:SetNWInt("TextMoving", tonumber(args[12], 10))

end)

function ENT:CanTool (ply, tr, tool)
	if ( tool == "remover" and IsValid( tr.Entity ) and ply == tr.Entity:Getowning_ent()) then
    	return true
   	end
end
 
function ENT:PhysgunPickup (ply, tr, tool)
	if (IsValid( tr.Entity ) and ply == tr.Entity:Getowning_ent()) then
    	return true
   	end
end