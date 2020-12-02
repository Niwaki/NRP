AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_junk/garbage128_composite001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetAmount(0) 
end
function ENT:Use(activator, caller)
	local bottle = math.random(0, 20)
	local pos = self:GetPos()
	local model = self:GetModel()
	local modelferum = "models/props_debris/metal_panelshard01c.mdl"
	local modelwood = "models/props_debris/wood_chunk02a.mdl"
		timer.Create("DTime ", 1, 10, function()
			if (activator:GetEyeTrace().Entity:GetClass() == "dumpster") then
			activator:ChatPrint("Собираю...")
			self:SetAmount(self:GetAmount()+1)
			if self:GetAmount() == 10 then
				self:Remove()
				if math.random(0, 20) > 15 then
					local waste = ents.Create( "gmp_wood" )
					 waste :SetModel( modelwood )
					 waste :SetPos( pos )
					 waste :Spawn()
				else
					local waste = ents.Create( "gmp_metal" )
					 waste :SetModel( modelferum )
					 waste :SetPos( pos )
					 waste :Spawn()
				end
					timer.Simple(300, function()
						local button = ents.Create( "dumpster" )
						button:SetModel( model )
						button:SetPos( pos )
						button:Spawn()
					end)
				end
			else
				timer.Remove("DTime")
				activator:ChatPrint("вы ушли от мусора")
			end
		end)
end