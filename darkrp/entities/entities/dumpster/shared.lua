ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "dumpster"
ENT.Author = "DarkRP Developers and <enter name here>"
ENT.Spawnable = true
ENT.AdminSpawnable = false

function ENT:SetupDataTables() /*next next next next next next next next next next next __index*/
	self:NetworkVar( "Int", 0, "Amount" )
end