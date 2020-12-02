local player = FindMetaTable("Player")
function mainf()
	if (not file.IsDir("rang", "DATA")) then
		file.CreateDir("rang")
	end
end
hook.Add( "Initialize","mainf", mainf)
function player:Load()
	local strSteamID = string.Replace(self:SteamID(), ":", "_") 
	local path = "rang/" .. strSteamID .. ".txt"
	if(file.Exists(path, "DATA")) then
		self.Rang = util.JSONToTable(file.Read(path))
	else
		self.Rang = {}
		self.Rang.Rt = 1
		self.Rang.Xp = 0 
	end
	self:SaveRang()
	self:SetNWInt("rang", self.Rang.Rt)
	self:SetNWInt("xp", self.Rang.Xp)
		--self:ChatPrint(self.Rang.Xp)
		--self:ChatPrint(#Rangs)
	self:SetNWInt("rang", self.Rang.Rt)
	self:SetNWInt("xp", self.Rang.Xp)
	timer.Create("loyaladd",1800, 0,  function()
		if IsValid(self) then
			self:SetLoyality(self:GetLoyality() + 0.5)
			DarkRP.notify(self, 10, 0, "Вам дали 0.5 лояльности ")
		end
	end)
end
function player:SaveRang()
	local strSteamID = string.Replace(self:SteamID(), ":", "_") 
	local path = "rang/" .. strSteamID .. ".txt"
	file.Write(path, util.TableToJSON(self.Rang)) 
end
function player:refreshCoolDown()
	timer.Simple(900, function()
		if IsValid(self) then
			self.CoolDownRang = false
		end
	end)
end
function player:AddXp(int)
	if self.Rang.Rt < #Rangs then
		if self.Rang.Xp < Rangs[self.Rang.Rt+1].xp then
			self.Rang.Xp =self.Rang.Xp+ int
		else 
			self.Rang.Xp = 0
			self.Rang.Rt = self.Rang.Rt + 1
			DarkRP.notify(self, 10, 0, "Вас повысили до: "..Rangs[self.Rang.Rt].name)
		end
		self:SaveRang()
	end
end
function giveRang(ply, args)
	if ply:isCP() and !ply.CoolDownRang then
		if ply:isMayor() or ply.Rang.Rt > 2 then
			local traceply = ply:GetEyeTrace().Entity
			traceply:AddXp(tonumber(args))
			ply.CoolDownRang = true
			ply:refreshCoolDown()
			DarkRP.notify(traceply, 10, 0, "Вам дали полицейской лояльности:"..args)
			DarkRP.notify(ply, 10, 0, "Вы дали полицейской лояльности:"..args)
		end
	else
		DarkRP.notify(ply, 10, 0, "Вы не полицейский или подождите восполнения")
	end
end
DarkRP.defineChatCommand("givepollol", giveRang)