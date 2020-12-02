AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
util.AddNetworkString( "sfw" )
util.AddNetworkString( "st" )
util.AddNetworkString( "test" )
include("shared.lua")

function ENT:Initialize()
	self:SetModel( "models/props_c17/Lockers001a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS );      
	self:SetMoveType( MOVETYPE_VPHYSICS );   
	self:SetSolid( SOLID_VPHYSICS );      
	self:SetUseType( SIMPLE_USE );
end

function ENT:AcceptInput( name, activator, caller )
	sendstorage(activator, activator.storage.ship)
	sendstweps(activator, activator.storage.weps)
	sendstent(activator, activator.storage.ent)
	sendmax2(activator, activator.storage.max)
	getDetails(activator)
	net.Start("sfw")
	net.Send(activator)
end
