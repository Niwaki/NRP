--[[---------------------------------------------------------------------------
This is an example of a custom entity.
---------------------------------------------------------------------------]]
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.SeizeReward = 950
util.AddNetworkString("money" )
util.AddNetworkString("withdraw" )
util.AddNetworkString("reset" )
util.AddNetworkString("uplvl" )
local PrintMore
local energ;
function ENT:Initialize()
	self:SetEnergy(10)
	self:SetModel("models/props_junk/garbage128_composite001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:Wake()
	--self:Energy()
	self.sparking = false
	self.damage = 100
	self.IsMoneyPrinter = true
	timer.Simple(2, function() PrintMore(self) end)
	timer.Simple(1, function() energ(self) end)
	self.sound = CreateSound(self, Sound("ambient/levels/labs/equipment_printer_loop1.wav"))
	self.sound:SetSoundLevel(52)
	self.sound:PlayEx(1, 100)
	self:Level()
end

function ENT:OnTakeDamage(dmg)
	if self.burningup then return end
	
	self.damage = (self.damage or 100) - dmg:GetDamage()
	
	if self.damage <= 0 then
		local rnd = math.random(1, 10)
		if rnd < 3 then
			self:BurstIntoFlames()
		else
			self:Destruct()
			self:Remove()
		end
	end
end

function ENT:Destruct()
	local vPoint = self:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(1)
	util.Effect("Explosion", effectdata)
	DarkRP.notify(self:Getowning_ent(), 1, 4, DarkRP.getPhrase("money_printer_exploded"))
end

function ENT:BurstIntoFlames()
	DarkRP.notify(self:Getowning_ent(), 0, 4, DarkRP.getPhrase("money_printer_overheating"))
	self.burningup = true
	local burntime = math.random(8, 18)
	self:Ignite(burntime, 0)
	timer.Simple(burntime, function() self:Fireball() end)
end

function ENT:Fireball()
	if not self:IsOnFire() then self.burningup = false return end
	local dist = math.random(20, 280) -- Explosion radius
	self:Destruct()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), dist)) do
		if not v:IsPlayer() and not v:IsWeapon() and v:GetClass() ~= "predicted_viewmodel" and not v.IsMoneyPrinter then
			v:Ignite(math.random(5, 22), 0)
		elseif v:IsPlayer() then
			local distance = v:GetPos():Distance(self:GetPos())
			v:TakeDamage(distance / dist * 100, self, self)
		end
	end
	self:Remove()
end
function ENT:Level()
	self:SetLevel(1);
end
function PrintMore(ent)
	if not IsValid(ent) then return end

	ent.sparking = true
	timer.Simple(2, function()
		if not IsValid(ent) then return end
		ent:CreateMoneybag()
	end)
end
function energ(ent)
	timer.Simple(1, function()
		ent:Energy()
	end)
end
function ENT:Energy()
	self:SetEnergy(self:GetEnergy()-1)
	if self:GetEnergy() <= 0 then
		self:SetEnergy(0)
	end
	timer.Simple(1, function()energ(self) end)	
end
function ENT:CreateMoneybag()
	if not IsValid(self) or self:IsOnFire() then return end

	local MoneyPos = self:GetPos()
	local amount = 400
	if self:GetLevel() == 2 then
		amount = 500
	elseif self:GetLevel()== 3 then
		amount = 800
	elseif self:GetLevel()== 4 then
		amount = 1100
	elseif self:GetLevel()== 5 then
		amount = 1400
	end
	if self:GetEnergy() > 0 then
		self:SetMoney(self:GetMoney() + amount)
	end
	--DarkRP.createMoneyBag(Vector(MoneyPos.x + 15, MoneyPos.y, MoneyPos.z + 15), amount)
	self.sparking = false
	timer.Simple(2, function() PrintMore(self) end)
end
function ENT:Use(call)
	timer.Simple(0.25, function()
		net.Start("money")
		net.WriteEntity(self)
		net.Send(call)
	end)
end
net.Receive("withdraw", function(len, ply) 
	local pri = net.ReadEntity()
	if pri:GetMoney() > 0 then
		DarkRP.notify(ply, 1,4, "Вы собрали: ".. pri:GetMoney())
		ply:addMoney(pri:GetMoney())
		pri:SetMoney(0)
		--DarkRP.notify(ply, 1,4, "Вы собрали: ".. pri:GetMoney())
	end
end)
net.Receive("reset", function(len,ply)
	local pr = net.ReadEntity()
	local reset = 500
	if pr:GetEnergy() < 2 then
		pr:SetEnergy(10)
		ply:addMoney(-reset)
	else
		DarkRP.notify(ply, 1,4, "принтер еще недостаточно разряжен")
	end
end)
net.Receive("uplvl", function(len,ply)
	local pro = net.ReadEntity()
	uplevl = 3000
	if pro:GetLevel() < 5 then
		if pro:GetLevel() == 2 then
			uplevl = 4000
		elseif pro:GetLevel() == 3 then
			uplevl = 6000
		elseif pro:GetLevel() == 4 then
			uplevl = 8000
		end
	pro:SetLevel(pro:GetLevel()+ 1)
	ply:addMoney(-uplevl)
	DarkRP.notify(ply, 1,4, "И заплатили за улучшение:"..uplevl)
	DarkRP.notify(ply, 1, 4, "Вы улучшили принтер:"..pro:GetLevel().."уровень")
	else
		DarkRP.notify(ply, 1, 4, "У вас максимальный уровень")
	end
	
end)
function ENT:Think()

	if self:WaterLevel() > 0 then
		self:Destruct()
		self:Remove()
		return
	end

	if not self.sparking then return end

	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())
	effectdata:SetMagnitude(1)
	effectdata:SetScale(1)
	effectdata:SetRadius(2)
	util.Effect("Sparks", effectdata)
end

function ENT:OnRemove()
	if self.sound then
		self.sound:Stop()
	end
end
