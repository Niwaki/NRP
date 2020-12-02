AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
 
include("shared.lua")

local RECYLW = {"gmp_wood"} 
local RECYLM = {"gmp_metal"} 

function ENT:Initialize()

	self:SetModel("models/props_canal/winch02.mdl")
	self:PhysicsInit( SOLID_VPHYSICS )     
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )         
	self:SetUseType( SIMPLE_USE )
	
end

function ENT:StartTouch(ent)
	if table.HasValue(RECYLW,ent:GetClass()) then
		ent:Remove()
		timer.Create( "timer_wrecyler", 10, 1, function() -- 10 RECYLING
			local entw = ents.Create("gmp_craft_wood")
			entw:SetPos(self:GetPos()- Vector(1,1,-30))
			entw:Spawn()
		end)
	end
	if table.HasValue(RECYLM,ent:GetClass()) then
		ent:Remove()
		timer.Create( "timer_mrecyler", 10, 1, function() -- 10 RECYLING
			local entm = ents.Create("gmp_craft_metal")
			entm:SetPos(self:GetPos() - Vector(1,1,-30))
			entm:Spawn()
		end)
	end
end 
