function create()
	if (not file.IsDir("ment", "DATA")) then
		file.CreateDir("ment")
	end
end
hook.Add( "Initialize","creatr", create)
local function spawnfe( ply )
	local strSteamID = string.Replace(ply:SteamID(), ":", "_") 
	local path = "ment/" .. strSteamID .. ".txt"
	if file.Exists(path, "DATA") then
		ply:SetNWBool("ment",tobool(file.Read(path)))
	else
		ply:SetNWBool("ment",false)
	end
	pidor(ply)
end
hook.Add( "PlayerInitialSpawn", "ww3", spawnfe)
function pidor(ply)
	local strSteamID = string.Replace(ply:SteamID(), ":", "_") 
	local path = "ment/" .. strSteamID .. ".txt"
	file.Write(path, tostring(ply:GetNWBool("ment"))) 
end