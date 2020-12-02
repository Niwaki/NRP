AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()
 
	self:SetModel( "models/props_wasteland/prison_padlock001a.mdl" )
	self:SetModelScale(0.2)
	self:SetFlexScale(0.2)
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_NONE )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	self.LockHealth = 50
    
end


hook.Add("EntityTakeDamage", "doSomeShit", function(ent, inflictor, attacker, amount, dmginfo)
	print(ent)

	if (ent:GetClass() ==  "gmp_doorsys_lock") then
		ent:GetParent():keysUnLock() 
		RunConsoleCommand("GMP_LOCKER_REMOVE", "asdzxcsswqee1", ent:GetParent():EntIndex())
	end
end)

function ENT:OnTakeDamage ()
	if (!IsValid(self:GetParent())) then return end
	parent = self:GetParent()
	//print (self.LockHealth)
end

 
function ENT:Destroy()

end

function ENT:Use( activator, caller )
    return
end
 
function ENT:Think()
    -- We don't need to think, we are just a prop after all!
end