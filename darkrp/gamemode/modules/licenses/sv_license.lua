function createlicensefolder()
	if (not file.IsDir("license", "DATA")) then
		file.CreateDir("license")
	end
end
hook.Add( "Initialize","createlicfolder", createlicensefolder)
local function FirstInitSpawn(ply)
	local strSteamID = string.Replace(ply:SteamID(), ":", "_") 
	local path = "license/" .. strSteamID .. ".txt"
	if(file.Exists(path, "DATA")) then
		ply.Licenses = util.JSONToTable(file.Read(path))
		updateAllLicenses(ply)
	else
		ply.Licenses = {}
		ply.Licenses.Gun = false
		ply.Licenses.GunTrade = false
		ply.Licenses.Trade = false
		ply.Licenses.Home = false
		updateAllLicenses(ply)
	end
	savelicense(ply)
end
hook.Add( "PlayerInitialSpawn", "FirstSpawn", FirstInitSpawn )

function savelicense(ply)
	local strSteamID = string.Replace(ply:SteamID(), ":", "_") 
	local path = "license/" .. strSteamID .. ".txt"
	file.Write(path, util.TableToJSON(ply.Licenses)) 
end
function updateAllLicenses(ply)
	for k, v in pairs(ply.Licenses) do
			ply:SetNWBool(k, v)
	end
end
function giveTradeLicense(ply, args)
	if ply:isMayor() and ply:GetEyeTrace().Entity:IsPlayer() then
		local traceply = ply:GetEyeTrace().Entity
		--ply:ChatPrint("fdsfsdg")
		if traceply.Licenses.Trade == false then
			traceply.Licenses.Trade = true
			updateAllLicenses(traceply)
			savelicense(traceply)
				DarkRP.notify(traceply, 1, 5, "Вам выдали лицензию на торговлю.")
		end
	end
end
DarkRP.defineChatCommand("givetradelic", giveTradeLicense)

function giveTradeGunLicense(ply, args)
	if ply:isMayor() and ply:GetEyeTrace().Entity:IsPlayer() then
		local traceply = ply:GetEyeTrace().Entity
		--ply:ChatPrint("fdsfsdg")
		if traceply.Licenses.GunTrade==false then
			traceply.Licenses.GunTrade = true
			updateAllLicenses(traceply)
			savelicense(traceply)
				DarkRP.notify(traceply, 1, 5, "Вам выдали лицензию на продажу оружия.")
		end
	end
end
DarkRP.defineChatCommand("giveguntradelic", giveTradeGunLicense)


function giveGunLicense(ply, args)
	if ply:isMayor() and ply:GetEyeTrace().Entity:IsPlayer() then
		local traceply = ply:GetEyeTrace().Entity
		--ply:ChatPrint("fdsfsdg")
		if !traceply.Licenses.Gun then
			traceply.Licenses.Gun = true
			updateAllLicenses(traceply)
			savelicense(traceply)
				DarkRP.notify(traceply, 1, 5, "Вам выдали лицензию на ношение оружия.")
		end
	end
end
DarkRP.defineChatCommand("givegunlic", giveGunLicense)
function giveHomeLicense(ply, args)
	if ply:isMayor() and ply:GetEyeTrace().Entity:IsPlayer() then
		local traceply = ply:GetEyeTrace().Entity
		--ply:ChatPrint("fdsfsdg")
		if !traceply.Licenses.Home then
			traceply.Licenses.Home = true
			updateAllLicenses(traceply)
			savelicense(traceply)
				DarkRP.notify(traceply, 1, 5, "Вам выдали лицензию на дом.")
		end
	end
end
DarkRP.defineChatCommand("givehomelic", giveHomeLicense)

function removeHomeLicense(ply, args)
	if ply:isMayor() and ply:GetEyeTrace().Entity:IsPlayer() then
		local traceply = ply:GetEyeTrace().Entity
		--ply:ChatPrint("fdsfsdg")
		if traceply.Licenses.Home then
			traceply.Licenses.Home = false
			updateAllLicenses(traceply)
			savelicense(traceply)
			DarkRP.notify(traceply, 1, 5, "У вас забрали лицензию на дом.")
		end
	end
end
DarkRP.defineChatCommand("removehomelic", removeHomeLicense)

function removeGunLicense(ply, args)
	if ply:isMayor() and ply:GetEyeTrace().Entity:IsPlayer() then
		local traceply = ply:GetEyeTrace().Entity
		--ply:ChatPrint("fdsfsdg")
		if traceply.Licenses.Gun then
			traceply.Licenses.Gun = false
			updateAllLicenses(traceply)
			savelicense(traceply)
			DarkRP.notify(traceply, 1, 5, "У вас забрали лицензию на ношение оружие.")
		end
	end
end
DarkRP.defineChatCommand("removegunlic", removeGunLicense)

function removeGunTradeLicense(ply, args)
	if ply:isMayor() and ply:GetEyeTrace().Entity:IsPlayer() then
		local traceply = ply:GetEyeTrace().Entity
		--ply:ChatPrint("fdsfsdg")
		if traceply.Licenses.GunTrade then
			traceply.Licenses.GunTrade = false
			updateAllLicenses(traceply)
			savelicense(traceply)
			DarkRP.notify(traceply, 1, 5, "У вас забрали лицензию на торговлю оружием.")
		end
	end
end
DarkRP.defineChatCommand("removeguntradelic", removeGunTradeLicense)
function removeTradeLicense(ply, args)
	if ply:isMayor() and ply:GetEyeTrace().Entity:IsPlayer() then
		local traceply = ply:GetEyeTrace().Entity
		--ply:ChatPrint("fdsfsdg")
		if traceply.Licenses.Trade then
			traceply.Licenses.Trade = false
			updateAllLicenses(traceply)
			savelicense(traceply)
			DarkRP.notify(traceply, 1, 5, "У вас забрали лицензию на торговлю.")
		end
	end
end
DarkRP.defineChatCommand("removetradelic", removeTradeLicense)