hook.Add("canDropWeapon", "ddtest", function(ply, weapon)
	if (weapon:GetClass() == ply:GetNWString("fuckars")) then
		return false
	end 
end)

hook.Add("PlayerDeath", "plydeath", function(victim, ent, attacker)
	if victim:GetNWBool("arsn") then
		victim:SetNWBool("coold", true)
		victim:SetNWBool("arsn", false)
	end
	victim:SetNWString("fuckars", nil)
	victim:SetNWBool("coold", true)
	timer.Simple(900, function()
		victim:SetNWBool("coold", false)
	end)
end)