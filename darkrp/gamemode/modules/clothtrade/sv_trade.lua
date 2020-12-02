util.AddNetworkString("usingselll")
util.AddNetworkString("csharp")
util.AddNetworkString("cmake")
util.AddNetworkString("kuler")
function ClothesUse(ply, ent)
	if(ent:IsPlayer()) then
		if ent:Team() == TEAM_DRES and ply.canusing then
				net.Start("usingselll")
				net.WriteEntity(ent)
				net.Send(ply)
				ply.canusing = false
				timer.Simple(1, function()
					ply.canusing = true
				end)
		end
	end
	if(ent:IsPlayer()) then
		if ent:Team() == TEAM_MEDIC and ply.canusing then
				net.Start("cmake")
				net.WriteEntity(ent)
				net.Send(ply)
				ply.canusing = false
				timer.Simple(1, function()
					ply.canusing = true
				end)
		end
	end
end
hook.Add( "PlayerUse", "usetrade", ClothesUse)

local function spawnall( ply )
	ply.canusing = true
end
hook.Add( "PlayerSpawn", "spall", spawnall )

net.Receive("csharp", function(len, ply)
	local niwakagondon = net.ReadEntity()
	local float = net.ReadFloat()
	if(ply:canAfford(500)) then
		ply:addMoney(-500)
		niwakagondon:addMoney(500)
		DarkRP.notify(niwakagondon, 0, 4, "Вы получили 500 за продажу одежды!")
		DarkRP.notify(ply, 0, 4, "Вы купили одежду за 500!")
		ply.Info.Skin = float
		ply:SetSkin(float)
		sendinfo(ply)
	end
end)
net.Receive("kuler", function(len, ply)
	local niwakagondon = net.ReadEntity()
	local float = net.ReadString()
	if(ply:canAfford(500)) then
		ply:addMoney(-500)
		niwakagondon:addMoney(500)
		DarkRP.notify(niwakagondon, 0, 4, "Вы получили 500 за операцию!")
		DarkRP.notify(ply, 0, 4, "Вы изменили внешность за 500!")
		ply.Info.Model = float
		ply:SetModel(float)
		sendinfo(ply)
	end
end)