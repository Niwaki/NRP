ENT.Type = "anim"
ENT.Base = "base_anim"
 
ENT.PrintName = "Traders Cabinet Slot"
ENT.Author = "GmodeProject.com [Ivitokun]"
ENT.Category = "GMPSys"
ENT.Instructions = "" 
ENT.Spawnable = true
ENT.AdminSpawnable = true



function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "CanMod")
	self:NetworkVar("Int", 1, "WeapPrice")
	self:NetworkVar("Entity", 0, "owning_ent")
end








