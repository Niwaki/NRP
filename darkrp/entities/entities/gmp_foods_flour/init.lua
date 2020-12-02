AddCSLuaFile( 'cl_init.lua' );
AddCSLuaFile( 'shared.lua' );  
 
include( 'shared.lua' );

function ENT:Initialize()
	self:SetModel( 'models/props_junk/garbage_bag001a.mdl' );
	self:PhysicsInit( SOLID_VPHYSICS );      
	self:SetMoveType( MOVETYPE_VPHYSICS );   
	self:SetSolid( SOLID_VPHYSICS );      
	self:SetUseType( SIMPLE_USE );
end;

