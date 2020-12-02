ENT.Type = "anim"
ENT.Base = "base_anim"
 
ENT.PrintName = "Holo_Signboard"
ENT.Author = "GmodeProject.com [Ivitokun]"
ENT.Category = "GMPSys"
ENT.Instructions = "" 
ENT.Spawnable = true
ENT.AdminSpawnable = true


ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
end