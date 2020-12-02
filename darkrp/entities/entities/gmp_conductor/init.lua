AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
 
include("shared.lua")

function ENT:Initialize()

	self:SetModel("models/props_wasteland/controlroom_desk001b.mdl")
	self:PhysicsInit( SOLID_VPHYSICS )     
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )         
	self:SetUseType( SIMPLE_USE )
	
end

function ENT:Use(act, cal)
	if not self.ControTable then return end
	if not (#self.ControTable > 0) then return end
	if not cal:IsValid() then return end

	cal:addMoney(#self.ControTable * 100)
	cal:SetLoyality(cal:GetLoyality()+0.1)
	-- + 150 гос.банку
	-- - 1 очко нарушения
	--if cal:GetNWInt("violition") > 1 then 
		--
	--end
	
	local phrase = string.gsub("ВЫВФЫ1ВЫФ", "<clothes>", tostring(#self.ControTable))
	phrase = string.gsub("ВЫВ2ФЫВЫФ", "<money>", tostring(#self.ControTable * 150) .. GAMEMODE.Config.currency)

	DarkRP.notify(cal, 0, 7, "Вы получили: 0.1 лояльности и 150"..GAMEMODE.Config.currency..",".." и -0.1 очков нарушения.")
	
	for _, ent in pairs(self.ControTable) do
		ent:Remove()
	end
	cal:Save()
end

function ENT:Think()
	local pos = self:LocalToWorld(self:OBBCenter())
	local ang = self:GetAngles()
	self.ControTable = {}
	
	for _, ent in pairs(ents.FindInSphere(pos - (ang:Forward() * 20), 20)) do
		if ent:GetClass() == "gmp_craft_metal" or ent:GetClass() == "gmp_craft_wood" then
			table.insert(self.ControTable, ent)
		end
	end

	self:NextThink(CurTime() + 0.1)
	return true
end
