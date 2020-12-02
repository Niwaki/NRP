AddCSLuaFile( 'cl_init.lua' );
AddCSLuaFile( 'shared.lua' );  

include( 'shared.lua' );
 
function ENT:Initialize()
	self:SetModel( 'models/props_junk/garbage_metalcan002a.mdl' );
	self:PhysicsInit( SOLID_VPHYSICS );      
	self:SetMoveType( MOVETYPE_VPHYSICS );   
	self:SetSolid( SOLID_VPHYSICS );      
	self:SetUseType( SIMPLE_USE );
end
 
function ENT:Use( activator, caller )
    caller:setDarkRPVar("Energy", caller:getDarkRPVar("Energy") + 25 )
	self:Remove()
end
 
