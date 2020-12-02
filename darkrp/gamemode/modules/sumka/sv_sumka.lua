-- Мне впадлу делать комментарии в коде
util.AddNetworkString( "start")
util.AddNetworkString( "table")
util.AddNetworkString( "ship")
util.AddNetworkString( "remove")
util.AddNetworkString( "removeship")
util.AddNetworkString( "fuck")
util.AddNetworkString( "java")
util.AddNetworkString( "Cpp")
util.AddNetworkString( "python")
util.AddNetworkString( "html")
util.AddNetworkString( "js")
util.AddNetworkString( "php")
util.AddNetworkString( "sumka")
util.AddNetworkString( "gas")
util.AddNetworkString( "op")
util.AddNetworkString( "perl")
util.AddNetworkString( "sql")
util.AddNetworkString( "int")
util.AddNetworkString( "using")
util.AddNetworkString( "int2")
util.AddNetworkString( "mainf")
util.AddNetworkString( "lua")
util.AddNetworkString( "lod")
util.AddNetworkString( "dropdown")
util.AddNetworkString( "fuckent")
util.AddNetworkString( "throwdetails")
util.AddNetworkString( "throwdet")
util.AddNetworkString( "givedetails")
local function CreateFolder()--функция типа void
	if not file.IsDir("drp", "DATA")  and not file.IsDir("storage", "DATA") then
        file.CreateDir("drp") 
		file.CreateDir("storage") 
    end 
end
hook.Add( "Initialize", "FolderCreate", CreateFolder )
local function spawn( ply )--функция типа void
	local strSteamID = string.Replace(ply:SteamID(), ":", "_") 
	local path = "drp/" .. strSteamID .. ".txt"
	local path2 = "storage/" .. strSteamID .. ".txt"
	local pos = ply:EyePos()
	local tracedata = {}
	tracedata.start = pos
	tracedata.endpos = pos+(ply:GetForward()*150)
	tracedata.filter = ply
	local tr = util.TraceLine(tracedata)
	if file.Exists( path, "DATA" )and file.Exists(path2, "DATA") then
		--ply:ChatPrint("dffgh")
		ply.inv = util.JSONToTable(file.Read(path))
		ply.storage = util.JSONToTable(file.Read(path2))
	else
		ply.storage = {}--вот это таблица хранилища
		ply.storage.ship = {}
		ply.storage.weps = {}
		ply.storage.ent = {}
		ply.storage.details = {}
		ply.storage.max = 0
		ply.inv = {}
		ply.inv.max = 0
		ply.inv.ent = {}
		ply.inv.test = {}
		ply.inv.weps = {}
		ply.inv.ship = {}
		savestorage(ply)
		save(ply) 
		--ply:ChatPrint("fgh")
	end
	sendmax2(ply, ply.storage.max)
	sendswep(ply, ply.inv.weps)
	sendship(ply, ply.inv.ship)
	sendstorage(ply, ply.storage.ship)
	sendstweps(ply, ply.storage.weps)
	sendstent(ply, ply.storage.ent)
	sendent(ply, ply.inv.ent)
	sendmax(ply, ply.inv.max)
	sendty(ply)
end
hook.Add( "PlayerSpawn", "some_unique_name", spawn )
function sendty(ply)
	for k, v in pairs(ply.inv.test) do
		sendtest(ply, k)
	end
end
function getDetails(ply)
	for k, v in pairs(ply.storage.details) do
		senddetail(ply, k)
	end
end
hook.Add( "PlayerUse", "some_unique_name2", function( ply, ent )--функция типа bool

	if CLIENT then
		 if (self:GetActionProgress() > 0) then
            draw.RoundedBox(4,ScrW() / 2.2, ScrH() /2.15 , 140, 50,Color(10,10,10,150))
            draw.SimpleText(self:GetActionName(),"HudNumbers",ScrW() / 2.2, ScrH() /2.15 ,Color(self:GetActionColorR(),self:GetActionColorG(),self:GetActionColorB(),255)) 

            draw.RoundedBox(2,ScrW() / 2.2, ScrH() /2 , self:GetActionProgress(), 20,Color(255,140,0,250))
        else  
			print('d')
		end
	end
	
	if ply:KeyDown(IN_DUCK) and item[ent:GetClass()] then
		local some = 0
		ply:Freeze(true)
		timer.Create ("GMP_Pick", 1, 2, function ()
            some = some + 50
            self:SetActionProgress(some)
            self:SetActionName ("Открытие...")
            self:SetActionColorR (0)
            self:SetActionColorG (255)
            self:SetActionColorB (0)
        end)
		timer.Simple(3, function()
			self:SetActionProgress(-1)
			ply:Freeze(false)
		end)
		if(ply.inv.max <= 10 ) then
			ply:Freeze( false )
			--ply:ChatPrint("ss")
			table.insert(ply.inv.ent, ent:GetClass())
			ply.inv.max  = ply.inv.max +1
			sendent(ply, ply.inv.ent)
			sendmax(ply, ply.inv.max)
			save(ply)
			ent:Remove()
			return false
		end
	end
	if ply:KeyDown(IN_DUCK)  and test[ent:GetClass()] then
		if !ply.inv.test[ent:GetClass()] then
			ply.inv.test[ent:GetClass()] = 0
		end
		addtest(ply, ent:GetClass(), 1)
		save(ply)
		ent:Remove()
		return false
	end
	if(ply:KeyDown(IN_DUCK) and ent:GetClass() == "spawned_weapon" and tabl[ent:GetWeaponClass()]) then
		ply:Freeze(true)
		timer.Simple(2, function()
			ply:Freeze(false)
		end)
		if(ply.inv.max <= 10 ) then
			--ply:ChatPrint("ss")
			table.insert(ply.inv.weps, ent:GetWeaponClass())
			sendswep(ply,ply.inv.weps)
			ply.inv.max = ply.inv.max + 1
			ent:Remove()
			sendmax(ply, ply.inv.max)
			save(ply)
			return false
		else
			--ply:ChatPrint("limit")
			return false
		end
	end
	if(ent:GetClass()=="spawned_shipment" and ply:KeyDown(IN_DUCK) and ply.inv.max <= 10) then
		ply:Freeze(true)
		timer.Simple(2, function()
			ply:Freeze(false)
		end)
		if(ply.inv.max <= 10 ) then
			local ship = {
				cont = ent.dt.contents,
				count = ent.dt.count
			}
			table.insert(ply.inv.ship, ship)
			ply.inv.max = ply.inv.max +2
			sendship(ply, ply.inv.ship)
			sendmax(ply, ply.inv.max)
			save(ply)
			ent:Remove()
			return false
		end
	end
end)
net.Receive("dropdown", function(len, ply)
	local itemd = net.ReadString()
	if( ply.inv.test[itemd] < 1) then
		return
	end
	local pos = ply:EyePos()
	local tracedata = {}
	tracedata.start = pos
	tracedata.endpos = pos+(ply:GetForward()*150)
	tracedata.filter = ply
	local tr = util.TraceLine(tracedata)
	
	local entd = ents.Create(itemd)
	entd:SetPos(tr.HitPos + tr.HitNormal*10)
	entd.ShareGravgun = true
	entd.nodupe = true
	entd:Spawn()
	entd:Activate()
	
	addtest(ply, itemd, -1)
	
	save(ply)
end)
net.Receive("remove", function(len, ply)--функция типа void
	if(!ply:isArrested()) then
		local trace = {}
		trace.start = ply:EyePos()
		trace.endpos = trace.start + ply:GetAimVector() * 85
		trace.filter = ply

		local tr = util.TraceLine(trace)
		local fg = net.ReadFloat()
		local str = net.ReadString()
		local button = ents.Create( "spawned_weapon")
		if ( !IsValid( button ) ) then return 
		end // Check whether we successfully made an entity,  - bail
		button:SetModel( tabl[str].model )
		button:SetWeaponClass(ply.inv.weps[fg] )
		button:SetPos( tr.HitPos )
		button:Spawn()
		ply.inv.weps[fg] = nil
		save(ply)
	end
end)
net.Receive("using", function(len, ply)
	local indx = net.ReadFloat()
	local strings = net.ReadString()
	ply.inv.max = ply.inv.max -1
	local button = ents.Create( "spawned_weapon")
	if ( !IsValid( button ) ) then return 
	end // Check whether we successfully made an entity,  - bail
	button:SetModel( tabl[strings].model )
	button:SetWeaponClass(ply.inv.weps[indx] )
	button:SetPos( ply:GetPos())
	button:Spawn()
	button:Use(ply, ply, SIMPLE_USE, 0)
	ply.inv.weps[indx] = nil
	sendswep(ply,ply.inv.weps)
	sendmax(ply, ply.inv.max)
	save(ply)
end)
net.Receive("op", function(len, ply)
	if(ply.storage.max <= 20) then
	local var1 = net.ReadFloat()
	--ply:ChatPrint(ply.inv.ent[var1])
	table.insert(ply.storage.ent, ply.inv.ent[var1])
	ply.storage.max = ply.storage.max +1
	ply.inv.max = ply.inv.max -1
	ply.inv.ent[var1] = nil
	sendent(ply, ply.inv.ent)
	save(ply)
	sendstent(ply, ply.storage.ent)
	sendmax(ply, ply.inv.max)
	savestorage(ply)
	end
end)

net.Receive("gas", function(len, ply)
	local ind = net.ReadFloat()
	local fg = net.ReadString()
	local pos = ply:EyePos()
	local tracedata = {}
	tracedata.start = pos
	tracedata.endpos = pos+(ply:GetForward()*150)
	tracedata.filter = ply
	local tr = util.TraceLine(tracedata)
	
	local ent = ents.Create(fg)
	ent:SetPos(tr.HitPos + tr.HitNormal*10)
	ent.ShareGravgun = true
	ent.nodupe = true
	ent:Spawn()
	ent:Activate()
	ply.inv.ent[ind] = nil
	sendmax(ply, ply.inv.max)
	ply.inv.max = ply.inv.max -1
	sendmax(ply, ply.inv.max)
	save(ply)
end)
net.Receive("removeship", function(len, ply)
	if(not ply:isArrested()) then
		local f = net.ReadFloat()
		local trace = {}
		trace.start = ply:EyePos()
		trace.endpos = trace.start + ply:GetAimVector() * 85
		trace.filter = ply

		local tr = util.TraceLine(trace)
	
		local ent = ents.Create("spawned_shipment")
		ent:SetPos(tr.HitPos)
		ent:SetContents(ply.inv.ship[f].cont, ply.inv.ship[f].count, 10)
		ent.nodupe = true
		ent:Spawn()
		ent:Activate()
		ply.inv.ship[f] = nil
		ply.inv.max = ply.inv.max -2
		sendmax(ply, ply.inv.max)
		save(ply)
	end
end)
function savestorage(ply)
	local strSteamID = string.Replace(ply:SteamID(), ":", "_")
	file.Write("storage/" .. strSteamID .. ".txt", util.TableToJSON(ply.storage)) 
end
function sendent(ply, tbl)
	net.Start("sumka")
	net.WriteTable(tbl)
	net.Send(ply)
end
function sendstent(ply, tbl)
	net.Start("perl")
	net.WriteTable(tbl)
	net.Send(ply)
end
function sendmax2(ply, int)
	net.Start("int2")
	net.WriteFloat(int)
	net.Send(ply)
end

function sendmax(ply, int)
	net.Start("int")
	net.WriteFloat(int)
	net.Send(ply)
end
function senddetail(ply, class)
	net.Start("throwdet")
	net.WriteString(class)
	net.WriteFloat(ply.storage.details[class])
	net.Send(ply)
end
function adddetails(ply,class, amt)
	if !ply.storage.details[class] then
		ply.storage.details[class] = 0
	end
	if test[class] then
		ply.storage.details[class] = ply.storage.details[class] + amt
	end
	senddetail(ply, class)
	savestorage(ply)
end
function addtest(ply,class, amt)
	if test[class] then
		ply.inv.test[class] = ply.inv.test[class] + amt
	end
	sendtest(ply, class)
	save(ply)
end
function sendtest(ply, tbl)
	net.Start("lod")
	net.WriteString(tbl)
	net.WriteFloat(ply.inv.test[tbl])
	net.Send(ply)
end
function sendstweps(ply, tbl)
	net.Start("python")
	net.WriteTable(tbl)
	net.Send(ply)
end
function sendstorage(ply, tbl)
	net.Start("java")
	net.WriteTable(tbl)
	net.Send(ply)
end
function save(ply)--функция типа void
	local strSteamID = string.Replace(ply:SteamID(), ":", "_")
	file.Write("drp/" .. strSteamID .. ".txt", util.TableToJSON(ply.inv)) 
end
function sendship(ply, tbl)--функция типа void
	net.Start("ship")
	net.WriteTable(tbl)
	net.Send(ply)
end
function sendswep(ply, tbl)--функция типа void
	net.Start("table")
	net.WriteTable(tbl)
	net.Send(ply)
end
net.Receive("Cpp", function(len , ply)
	if(ply.storage.max <= 20 ) then
	local f = net.ReadFloat()
	table.insert(ply.storage.ship, ply.inv.ship[f])
	ply.inv.max = ply.inv.max -2
	ply.storage.max = ply.storage.max +2
	ply.inv.ship[f] = nil
	sendstorage(ply, ply.storage.ship)
	savestorage(ply)
	sendmax(ply, ply.inv.max)
	sendmax2(ply, ply.storage.max)
	save(ply)
	end
end)
net.Receive("html", function(len , ply)
	if(ply.storage.max <= 20 ) then
	local m = net.ReadFloat()
	local h = net.ReadString()
	table.insert(ply.storage.weps, ply.inv.weps[m])
	ply.inv.max = ply.inv.max - 1
	ply.storage.max = ply.storage.max +1
	ply.inv.weps[m] = nil
	sendstorage(ply, ply.storage.weps)
	savestorage(ply)
	sendmax(ply, ply.inv.max)
	sendmax2(ply, ply.storage.max)
	save(ply)
	end
end) 
net.Receive("givedetails", function(len, ply)
	local mgg = net.ReadString()
	if(ply.inv.max <= 10 ) then
		if( ply.storage.details[mgg] < 1) then
			return
		end
		ply.inv.max = ply.inv.max+ 1
		ply.storage.max = ply.storage.max -1
		addtest(ply, mgg, 1)
		adddetails(ply, mgg, -1)
		savestorage(ply)
		sendmax(ply, ply.inv.max)
		sendmax2(ply, ply.storage.max)
		save(ply)
	end
end)
net.Receive("sql", function(len , ply)
	if(ply.inv.max <= 10 ) then
	local var = net.ReadFloat()
	table.insert(ply.inv.ent, ply.storage.ent[var])
	ply.storage.max = ply.storage.max -1
	ply.inv.max = ply.inv.max + 1
	ply.storage.ent[var] = nil
	sendstent(ply, ply.storage.ent)
	sendent(ply, ply.inv.ent)
	savestorage(ply)
	sendmax(ply, ply.inv.max)
	sendmax2(ply, ply.storage.max)
	save(ply)
	end
end)
net.Receive("js", function(len, ply)
	if(ply.inv.max <= 10 ) then
	local js = net.ReadFloat()
	table.insert(ply.inv.ship, ply.storage.ship[js])
	ply.storage.max = ply.storage.max -2
	ply.inv.max = ply.inv.max + 2
	ply.storage.ship[js] = nil
	sendstorage(ply, ply.storage.ship)
	sendstweps(ply, ply.storage.weps)
	savestorage(ply)
	sendship(ply, ply.inv.ship)
	sendmax(ply, ply.inv.max)
	sendmax2(ply, ply.storage.max)
	save(ply) 
	end
end)
net.Receive("throwdetails", function(len, ply)
	if(ply.storage.max <= 20 ) then
		local h = net.ReadString()
		if( ply.inv.test[h] < 1) then
			return
		end
		ply.inv.max = ply.inv.max - 1
		ply.storage.max = ply.storage.max +1
		addtest(ply, h, -1)
		adddetails(ply, h, 1)
		savestorage(ply)
		sendmax(ply, ply.inv.max)
		sendmax2(ply, ply.storage.max)
		save(ply)
	end
end)
net.Receive("php", function(len, ply)
	if(ply.inv.max <= 10 ) then
	local php = net.ReadFloat()
	table.insert(ply.inv.weps, ply.storage.weps[php])
	ply.inv.max = ply.inv.max +1
	ply.storage.max = ply.storage.max - 1
	ply.storage.weps[php] = nil
	sendstweps(ply, ply.storage.weps)
	savestorage(ply)
	sendswep(ply, ply.inv.weps)
	sendmax(ply, ply.inv.max)
	sendmax2(ply, ply.storage.max)
	save(ply)
	end
end)
function Death( victim, inflictor, attacker )
	--victim:ChatPrint("dfgggggggggggg")
	for k, v in pairs(victim.inv.test) do
		if ( v > 0 ) then
			local ends = ents.Create(k)
			ends:SetPos(victim:GetPos())
			ends:Spawn()
			addtest(victim, k, -1)
			save(victim)
		end
	end
	for k, v in pairs(victim.inv.weps) do
		local button = ents.Create( "spawned_weapon")
		if ( !IsValid( button ) ) then return 
		end // Check whether we successfully made an entity,  - bail
		button:SetModel( tabl[v].model )
		button:SetWeaponClass(victim.inv.weps[k] )
		button:SetPos( victim:GetPos())
		button:Spawn()
		victim.inv.weps[k] = nil
	end
	for k, v in pairs(victim.inv.ship) do 
		local ent = ents.Create("spawned_shipment")
		ent:SetPos(victim:GetPos())
		ent:SetContents(victim.inv.ship[k].cont, victim.inv.ship[k].count, 10)
		ent.nodupe = true
		ent:Spawn()
		ent:Activate()
		victim.inv.ship[k] = nil
	end
	victim.inv.max = 0
	sendmax(victim, victim.inv.max)
	save(victim)
end

hook.Add("PlayerDeath", "ddd", Death)
function HaveItem(ply, it1, indx)
	return ply.inv.ent[indx] == it1
end
-- craft
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
net.Receive("fuckent", function(len, ply)
	tavsd = net.ReadTable()
	jkdw = net.ReadString()
	--ply:ChatPrint(#tavsd)
		local num = 0

	for k, v in pairs(ply.inv.test)  do
		for l, j in pairs(tavsd) do
			if k == l and v >=j then
				--ply:ChatPrint("pizda")
				num = num + 1
			end
		end
	end
		if num == table.Count(tavsd) then
			for k, v in pairs(ply.inv.test)  do
		for l, j in pairs(tavsd) do
			if k == l and v >=j then
				--ply:ChatPrint("pizda")
				addtest(ply, k, -j)
			end
		end
	end
			table.insert(ply.inv.ent, jkdw)
			sendent(ply, ply.inv.ent)
			save(ply)
			ply:setDarkRPVar("Energy", ply:getDarkRPVar("Energy")-15)
		end
	PrintTable(tavsd)
end)
net.Receive("mainf", function(len, ply)
	tavs = net.ReadTable()
	jkd = net.ReadString()
	--ply:ChatPrint(#tavs)
		local num = 0

	for k, v in pairs(ply.inv.test)  do
		for l, j in pairs(tavs) do
			if k == l and v >=j then
				--ply:ChatPrint("pizda")
				num = num + 1
			end
		end
	end
		if num == table.Count(tavs) then
			for k, v in pairs(ply.inv.test)  do
		for l, j in pairs(tavs) do
			if k == l and v >=j then
				--ply:ChatPrint("pizda")
				addtest(ply, k, -j)
			end
		end
	end
			table.insert(ply.inv.weps, jkd)
			sendswep(ply, ply.inv.weps)
			save(ply)
			ply:setDarkRPVar("Energy", ply:getDarkRPVar("Energy")-15)
		end
	PrintTable(tavs)
end)