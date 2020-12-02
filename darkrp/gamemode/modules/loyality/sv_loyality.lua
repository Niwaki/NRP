function main()
	if (not file.IsDir("loyality", "DATA")) then
		file.CreateDir("loyality")
	end
end
hook.Add( "Initialize","main", main)

local function spawnf( ply )
	local strSteamID = string.Replace(ply:SteamID(), ":", "_") 
	local path = "loyality/" .. strSteamID .. ".txt"
	if file.Exists(path, "DATA") then
		ply:SetNWInt("loyality",tonumber(file.Read(path)))
	else
		ply:SetNWInt("loyality",0)
	end
	ply:Save()
end
hook.Add( "PlayerInitialSpawn", "ww2", spawnf)
local function comman(ply, args)
	--ply:ChatPrint(ply.loyalgive)
	if ply:GetEyeTrace().Entity:IsPlayer()and ply:isCP()and ply.loyalgive >= tonumber(args) then
		local traceply = ply:GetEyeTrace().Entity
		traceply:SetLoyality(traceply:GetLoyality()+tonumber(args))
		ply.loyalgive = ply.loyalgive - tonumber(args)
		DarkRP.notify(traceply, 1, 5, "Вам выдали:"..args);
		DarkRP.notify(ply, 1, 5, "Вы выдали:"..args);
		ply:Restore()
		ply:Save()
		traceply:Save()
	else
		DarkRP.notify(ply, 1, 5, "Не так быстро!");
	end
end
DarkRP.defineChatCommand("giveloyal", comman)
local function commanf(ply, args)
	--ply:ChatPrint(ply.loyalgive)
	if ply:GetEyeTrace().Entity:IsPlayer()and ply:isCP()and ply.loyalgive >= tonumber(args) then
		local traceply = ply:GetEyeTrace().Entity
		traceply:SetLoyality(traceply:GetLoyality()-tonumber(args))
		ply.loyalgive = ply.loyalgive - tonumber(args)
		DarkRP.notify(traceply, 1, 5, "У вас забрали:"..args);
		DarkRP.notify(ply, 1, 5, "Вы забрали:"..args);
		ply:Restore()
		ply:Save()
		traceply:Save()
	else
		DarkRP.notify(ply, 1, 5, "Не так быстро!");
	end
end
DarkRP.defineChatCommand("takeloyal", commanf)
local met = FindMetaTable("Player")
function met:SetLoyality(loyal)
	self:SetNWInt("loyality",loyal)
end
function met:GetLoyality()
	return self:GetNWInt("loyality")
end
function met:SetPoliceLoyal()
	self.loyalgive = 0.5
end
function met:Restore()
	if(self.loyalgive < 5 )then
		timer.Create("loyality", 900, 1, function()
			self.loyalgive = 0.5
		end)
	end
end
function met:Save()
	local strSteamID = string.Replace(self:SteamID(), ":", "_") 
	local path = "loyality/" .. strSteamID .. ".txt"
	file.Write(path, tostring(self:GetNWInt("loyality")))
end
local function PlayerDeath( victim, inflictor, attacker )
	if victim:GetLoyality() >= 0.3 then
		victim:SetLoyality(victim:GetLoyality()-0.3)
		DarkRP.notify(victim, 1, 5, "Вы потеряли: 0.3 лояльности");
		victim:Save()
	end
end
hook.Add("PlayerDeath", "maindeath", PlayerDeath)