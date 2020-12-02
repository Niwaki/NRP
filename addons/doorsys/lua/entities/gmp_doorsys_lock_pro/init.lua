AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()
 
	self:SetModel( "models/props_wasteland/prison_padlock001a.mdl" )
	self:SetModelScale(0.2)
	self:SetFlexScale(0.2)
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox

end

function ENT:StartTouch(ent)
    if ent:GetClass() == "prop_door_rotating" then
		RunConsoleCommand( "GMP_LOCKERPRO_SPAWN", "aqkjlsndajkswdadadhdfwq12", ent:GetParent():EntIndex() )
		self:Remove()
	end
end

function ENT:Destroy()

end

function ENT:Use( activator, caller )
    return
end
 
function ENT:Think()
    -- We don't need to think, we are just a prop after all!
end