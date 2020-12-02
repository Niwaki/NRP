ENT.Type = "anim"
ENT.Base = "base_anim"
 
ENT.PrintName = "GMP_Stove"
ENT.Author = "GmodeProject.com [Ivitokun]"
ENT.Category = "GMPSys"
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()

	self:NetworkVar("Entity", 0, "owning_ent");

	self:NetworkVar("Bool", 1, "One");
	self:NetworkVar("String", 1, "NameOne");
	self:NetworkVar("Float", 1, "TimerOne");
	self:NetworkVar("Int", 1, "TimeOne");

	self:NetworkVar("Bool", 2, "Two");
	self:NetworkVar("String", 2, "NameTwo");
	self:NetworkVar("Float", 2, "TimerTwo");
	self:NetworkVar("Int", 2, "TimeTwo");

	self:NetworkVar("Bool", 3, "Three");
	self:NetworkVar("String", 3, "NameThree");
	self:NetworkVar("Float", 3, "TimerThree");
	self:NetworkVar("Int", 3, "TimeThree");

	self:NetworkVar("Bool", 4, "Four");
	self:NetworkVar("String", 0, "NameFour"); --[[ Because look wiki ]]--
	self:NetworkVar("Float", 4, "TimerFour");
	self:NetworkVar("Int", 4, "TimeFour");

end

