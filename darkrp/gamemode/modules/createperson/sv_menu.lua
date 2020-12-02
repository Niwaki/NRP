local player = FindMetaTable("Player")
util.AddNetworkString("registered")
util.AddNetworkString("getinfo")
util.AddNetworkString("getdesc")
util.AddNetworkString("setdesc")
function createfolder()
	if (not file.IsDir("info", "DATA")) then
		file.CreateDir("info")
	end
end
hook.Add( "Initialize","createfolder", createfolder)
local function register( ply )
	local strSteamID = string.Replace(ply:SteamID(), ":", "_") 
	local path = "info/" .. strSteamID .. ".txt"
	if(file.Exists(path, "DATA")) then
		ply.Info = util.JSONToTable(file.Read(path))
		ply:SetNWString("desc", ply.Info.Desc)
	else
		ply.Info = {}
		ply.Info.Model = ""
		ply.Info.Skin = 0
		ply.Info.Desc = ""
		ply.Info.bool = false
	end
	sendinfo(ply)
	if(not ply.Info.bool) then
		net.Start("registered")
		net.WriteString(ply:GetModel())
		net.Send(ply)
	end
end
hook.Add( "PlayerSpawn", "registerply", register )

function sendinfo(ply)
	local strSteamID = string.Replace(ply:SteamID(), ":", "_") 
	local path = "info/" .. strSteamID .. ".txt"
	file.Write(path, util.TableToJSON(ply.Info)) 
end
net.Receive("getinfo", function(len, ply)
	DarkRP.notify(ply, 1, 5, "Вы успешно создали персонажа.")
	local fname = net.ReadString()
	local lname = net.ReadString()
	local model = net.ReadString()
	local desc = net.ReadString()
	local skin = net.ReadFloat()
	ply:setRPName(fname.." "..lname)
	ply:SetModel(model)
	ply:SetSkin(skin)
	ply.Info.bool = true
	ply.Info.Model = model
	ply.Info.Desc = desc
	ply.Info.Skin = skin
	ply:SetNWString("desc", ply.Info.Desc)
	sendinfo(ply)
end)

net.Receive("setdesc", function(len, ply)
	local fud = net.ReadString()
	ply.Info.Desc = fud
	sendinfo(ply)
end)