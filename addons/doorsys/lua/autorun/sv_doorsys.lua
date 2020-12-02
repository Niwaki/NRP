print("---------------------------------------GMODPROJECT.COM-----------------------------------------------------")
print("---------------------------------------DOORSYS LOADED------------------------------------------------------")


concommand.Add("GMP_LOCKER_SPAWN", function (ply, cmd, args) 
if (args[1] != "aqkjlsndajkshdfwq12" ) then return end
local ent = ents.GetByIndex(args[2])

entLockerLeft = ents.Create("gmp_doorsys_lock")
entLockerLeft:SetParent (ent, -1)
local Ang = ent:GetAngles()
	Ang:RotateAroundAxis(Ang:Forward(), 90)
local spPos = ent:GetPos()
	entLockerLeft:SetPos(ent:GetPos() + Ang:Forward() - Ang:Up() * 43 + Ang:Right() * 8 )
	entLockerLeft:SetAngles(ent:GetAngles())
	entLockerLeft:Spawn()

entLockerRight = ents.Create("gmp_doorsys_lock")
entLockerRight:SetParent (ent, -1)
local Ang = ent:GetAngles()
	Ang:RotateAroundAxis(Ang:Forward(), 90)
local spPos = ent:GetPos()
	entLockerRight:SetPos(ent:GetPos() - Ang:Forward() * 1 - Ang:Up() * 43 + Ang:Right() * 8 )
	entLockerRight:SetAngles(ent:GetAngles())
	entLockerRight:Spawn()


end) 

concommand.Add("GMP_LOCKERPRO_SPAWN", function (ply, cmd, args) 
if (args[1] != "aqkjlsndajkswdadadhdfwq12" ) then return end
local ent = ents.GetByIndex(args[2])

entLockerLeft = ents.Create("gmp_doorsys_lock_pro")
entLockerLeft:SetParent (ent, -1)
local Ang = ent:GetAngles()
	Ang:RotateAroundAxis(Ang:Forward(), 90)
local spPos = ent:GetPos()
	entLockerLeft:SetPos(ent:GetPos() + Ang:Forward() - Ang:Up() * 43 + Ang:Right() * 8 )
	entLockerLeft:SetAngles(ent:GetAngles())
	entLockerLeft:Spawn()

entLockerRight = ents.Create("gmp_doorsys_lock_pro")
entLockerRight:SetParent (ent, -1)
local Ang = ent:GetAngles()
	Ang:RotateAroundAxis(Ang:Forward(), 90)
local spPos = ent:GetPos()
	entLockerRight:SetPos(ent:GetPos() - Ang:Forward() * 1 - Ang:Up() * 43 + Ang:Right() * 8 )
	entLockerRight:SetAngles(ent:GetAngles())
	entLockerRight:Spawn()


end) 


concommand.Add("GMP_LOCKER_REMOVE", function (ply, cmd, args)
	//print ("XAX: 1") 
if (args[1] != "asdzxcsswqee1") then return end
	//print ("XAX: 2")
local ent = ents.GetByIndex(args[2])
PrintTable(ent:GetChildren())
for _,lockers in pairs(ent:GetChildren()) do
	//print ("XAX: ".. lockers)
	lockers:Remove()
end


end)
