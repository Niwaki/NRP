function intmain()
	if (not file.IsDir("violation", "DATA")) then
		file.CreateDir("violation")
	end
end
hook.Add( "Initialize","intmain", intmain)

local function spawnfg( ply )
	local strSteamID = string.Replace(ply:SteamID(), ":", "_") 
	local path = "violation/" .. strSteamID .. ".txt"
	if file.Exists(path, "DATA") then
		ply:SetNWInt("violation",tonumber(file.Read(path)))
	else
		ply:SetNWInt("violation",0)
	end
	ply:saveViolation()
	ply:SetPoliceVioll()
end
hook.Add( "PlayerInitialSpawn", "ww1", spawnfg)
local function commaned(ply, args)
	--ply:ChatPrint(ply.loyalgive)
	if ply:GetEyeTrace().Entity:IsPlayer()and ply:isCP()and ply.violgive >= tonumber(args) then
		local traceply = ply:GetEyeTrace().Entity
		traceply:SetViolation(traceply:GetViolation()+tonumber(args))
		ply.violgive = ply.violgive - tonumber(args)
		DarkRP.notify(traceply, 1, 5, "Вам выдали:"..args);
		DarkRP.notify(ply, 1, 5, "Вы выдали:"..args);
		ply:RestoreV()
		ply:saveViolation()
		traceply:saveViolation()
	else
		DarkRP.notify(ply, 1, 5, "Не так быстро!");
	end
end
DarkRP.defineChatCommand("giveviol", commaned)
local function commanfed(ply, args)
	--ply:ChatPrint(ply.loyalgive)
	if ply:GetEyeTrace().Entity:IsPlayer()and ply:isCP()and ply.violgive >= tonumber(args) then
		local traceply = ply:GetEyeTrace().Entity
		traceply:SetViolation(traceply:GetViolation()-tonumber(args))
		ply.violgive = ply.violgive - tonumber(args)
		DarkRP.notify(traceply, 1, 5, "У вас забрали:"..args);
		DarkRP.notify(ply, 1, 5, "Вы забрали:"..args);
		ply:RestoreV()
		ply:saveViolation()
		traceply:saveViolation()
	else
		DarkRP.notify(ply, 1, 5, "Не так быстро!");
	end
end
DarkRP.defineChatCommand("takeviol", commanfed)
local met = FindMetaTable("Player")
function met:SetViolation(loyal)
	self:SetNWInt("violation",loyal)
end
function met:GetViolation()
	return self:GetNWInt("violation")
end
function met:SetPoliceVioll()
	self.violgive = 1
end
function met:RestoreV()
	if(self.violgive < 1 )then
		timer.Create("violation", 900, 1, function()
			self.violgive = 1
		end)
	end
end
function met:saveViolation()
	local strSteamID = string.Replace(self:SteamID(), ":", "_") 
	local path = "violation/" .. strSteamID .. ".txt"
	file.Write(path, tostring(self:GetNWInt("violation")))
end