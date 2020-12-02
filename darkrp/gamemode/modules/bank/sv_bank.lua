util.AddNetworkString("fuck")
mainbank = 0
net.Receive("fuck", function(len, ply)
	ent = net.ReadEntity()
	ent:SetNWInt("mon", ent:GetNWInt("mon")+40)
	--ply:ChatPrint("dsad"..ent:GetNWInt("mon"))
end)
function spawn(ply)
	ply:SetMoney()
	--ply:ChatPrint("dsd"..ply:GetPData("money"))
end

hook.Add("PlayerInitialSpawn", "dsda", spawn)
concommand.Add( "addmon", function( ply, cmd, args )
	if ply:canAfford(args[1]) then
		--ply:ChatPrint("вы можете")
		ply:SetNWInt("mon", ply:GetNWInt("mon")+args[1])
		ply:addMoney(-args[1])
		ply:SaveMoney()
		--ply:ChatPrint("dsd"..ply:GetNWInt("mon"))
		mainbank = mainbank + args[1]
		sendBank()
	end
end )
concommand.Add( "withdraw", function( ply, cmd, args )
	if (tonumber(ply:GetNWInt("mon")) >= tonumber(args[1])) then
		--ply:ChatPrint("вы можете")
		ply:SetNWInt("mon", ply:GetNWInt("mon")-args[1])
		ply:addMoney(args[1])
		ply:SaveMoney()
		mainbank = mainbank - args[1]
		sendBank()
		--ply:ChatPrint("dsd"..ply:GetNWInt("mon"))
	end
end )

concommand.Add( "tra", function( ply, cmd, args )
	local rec = DarkRP.findPlayer(args[2])
	if (tonumber(ply:GetNWInt("mon")) >= tonumber(args[1])) then
		--ply:ChatPrint("вы можете")
		rec:SetNWInt("mon", rec:GetNWInt("mon")+args[1])
		--rec:ChatPrint("вам пришло лавэ")
		ply:SetNWInt("mon", ply:GetNWInt("mon")-args[1])
		rec:SaveMoney()
		ply:SaveMoney()
		
		--ply:ChatPrint("dsd"..rec:GetNWInt("mon"))
	end
end )
function dis(ply)
	ply:SaveMoney()
end
hook.Add("PlayerDisconnected", "dsda", dis)
local ply = FindMetaTable("Player")

function ply:SaveMoney()
	self:SetPData("money", self:GetNWInt("mon"))
end
local function init()
	if (not file.IsDir("mainbank", "DATA")) then
		file.CreateDir("mainbank")
	end
	mainBank()
	sendBank()
end
hook.Add( "Initialize", "uniquename", init )
function mainBank()
	local path = "mainbank/fuck.txt"
	if file.Exists(path, "DATA") then
		mainbank = tonumber( file.Read( path, "DATA" ))
	else
		mainbank = 0
	end
end
function sendBank()
	local path = "mainbank/fuck.txt"
	file.Write(path, tostring(mainbank))
end
function ply:SetMoney()
	if self:GetPData("money") == nil then
		self:SetPData("money", 2)
		self:SetNWInt("mon", 2)
	else
		self:SetNWInt("mon", self:GetPData("money"))
	end
end