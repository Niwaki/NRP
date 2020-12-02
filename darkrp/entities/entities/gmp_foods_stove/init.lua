AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

function ENT:Initialize()

	--[[ Initialization ]]--
	self:SetModel("models/props_c17/furnitureStove001a.mdl");
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:SetSolid(SOLID_VPHYSICS);

	self:GetPhysicsObject():SetMass(105);

	self:GetPhysicsObject():Wake();

	--[[ Health ]]--
	self.maxStrength = 300;
	self.Strength = self.maxStrength;

	--[[ Setup dishes ]]--
	self.Dishes = {
		{
			["name"] = "Хлеб",
			["entity"] = "gmp_foods_food",
			["time"] = 45,
			["ingredient"] = "gmp_foods_flour"
		}
	};

end

function ENT:StartTouch(toucher)

	if (!IsValid(toucher)) then 
		return;
	end

	--[[ Check: is toucher ingredient? ]]--
	for k, v in pairs(self.Dishes) do

		if (v["ingredient"] != toucher:GetClass()) then
			continue;
		end

		--[[ Reserve slot ]]--
		local reservedSlot = self:ReserveSlot(v["name"], v["time"], v["time"]);
		
		if (!reservedSlot) then 
			return; 
		end

		--[[ Remove ingredient entity ]]--
		toucher:Remove();

		--[[ Make new timer identifier ]]--
		local identifier = "np_stove_"..self:Getowning_ent():Nick().."_"..reservedSlot; -- !!!

		--[[ Create unique timer ]]--
		timer.Create(identifier, 1, v["time"], function()

			if (!IsValid(self)) then 
				return;
			end

			--[[ Update slot time ]]--
			self:UpdateTime(reservedSlot, timer.RepsLeft(identifier));

			if (timer.RepsLeft(identifier) < 1) then

				--[[ Release slot ]]--
				self:ReleaseSlot(reservedSlot);

				--[[ Spawn food ]]--
				local food = ents.Create(v["entity"]);
				-- food:SetCollisionGroup(1);
				food:SetPos(self:GetPos() + Vector(-5, -5, 25));
				-- food:SetOwner(self:Getowning_ent());
				food:Spawn();

			end

		end);

	end

end

function ENT:ReserveSlot(name, thaimer, time)
	if (!self:GetOne()) then
		self:SetOne(true);
		self:SetNameOne(name);
		self:SetTimerOne(thaimer);
		self:SetTimeOne(time);
		return 1;
	elseif (!self:GetTwo()) then
		self:SetTwo(true);
		self:SetNameTwo(name);
		self:SetTimerTwo(thaimer);
		self:SetTimeTwo(time);
		return 2;
	elseif (!self:GetThree()) then
		self:SetThree(true);
		self:SetNameThree(name);
		self:SetTimerThree(thaimer);
		self:SetTimeThree(time);
		return 3;
	elseif (!self:GetFour()) then
		self:SetFour(true);
		self:SetNameFour(name);
		self:SetTimerFour(thaimer);
		self:SetTimeFour(time);
		return 4;
	else
		return false;
	end 
end

function ENT:UpdateTime(slot, time)
	if (slot == 1) then
		self:SetTimeOne(time);
	elseif (slot == 2) then
		self:SetTimeTwo(time);
	elseif (slot == 3) then
		self:SetTimeThree(time);
	elseif (slot == 4) then
		self:SetTimeFour(time);
	end
end

function ENT:ReleaseSlot(slot)
	if (slot == 1) then
		self:SetOne(false);
	elseif (slot == 2) then
		self:SetTwo(false);
	elseif (slot == 3) then
		self:SetThree(false);
	elseif (slot == 4) then
		self:SetFour(false);
	end
end


function ENT:Think()

end

function ENT:OnTakeDamage(damage)

	self.Strength = math.Clamp(self.Strength - damage:GetDamage(), 0, self.maxStrength);
	
	if (self.Strength == 0) then
		self:Destruct();
	end

end

function ENT:Destruct()

	local effect = EffectData();
	effect:SetStart(self:GetPos());
	effect:SetOrigin(self:GetPos());
	effect:SetScale(1);
	util.Effect("Explosion", effect);

	self:Remove();	

end