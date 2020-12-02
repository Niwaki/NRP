local meta = FindMetaTable("Player")

function meta:SetStamina(num)
	if type(num) == "number" then
		self:SetNWInt("stamina", num)
	end
	self.SetRestore = 2
	self.Drying = 1
	self.isDamaged = false
end

function meta:StartTimer()
	timer.Create("starting", 2, 0, function()
		self:SetNWInt("stamina", self:GetNWInt("stamina")-1)
		if (self:GetNWInt("stamina") <= 0 ) then
			self:DestroyTimer()
		end
	end)
end
function meta:DamageStamina(ctakedamage)
	if (ctakedamage:GetDamage() > 1) then
		self:SetRunSpeed(160)
		self.Drying = 4
		self.isDamaged = true
	end
	timer.Create("setdefaultspeed", 5, 0, function()
		self:SetRunSpeed(260)
		self.Drying = 1
		self.isDamaged = false
	end)
end
function meta:DestroyTimer()
	timer.Destroy("starting")
end
function meta:Restored(scale)
		if (self:IsOnGround())then
			if self:GetNWInt("stamina") < 100 then
				local c = 2 * scale
				self:SetNWInt("stamina", self:GetNWInt("stamina") +c )
			else
				self:SetNWInt("stamina", 100 )
			end
	end
end
function meta:Dryed(scale1)
	local locaf = DRYED * scale1
	if self:GetNWInt("stamina") > 0 then
		self:SetNWInt("stamina", self:GetNWInt("stamina") -locaf )
	end
	if self:GetNWInt("stamina") < 3 then
		self:SetRunSpeed(160)
	else
		if(not self.isDamaged) then
			self:SetRunSpeed(260)
		end
	end
end
function damage(target, dmg)
	if (target:IsPlayer()) then	
		target:DamageStamina(dmg)
	end
end
hook.Add("EntityTakeDamage", "entdamage", damage)

function spawnedply(ply)
	ply:SetStamina(100)
end
hook.Add("PlayerSpawn", "skd", spawnedply)
local DefaultWalkSpeed = 140
hook.Add( "KeyPress", "keypress_use_hi", function( ply, key )
	if ( key==IN_SPEED or ply:KeyDown(IN_SPEED) ) then
		timer.Create( "tcb_StaminaTimer", 0.5, 0, function( )
			local vel = ply:GetVelocity()
			if vel.x >= DefaultWalkSpeed or vel.x <= -DefaultWalkSpeed or vel.y >= DefaultWalkSpeed or vel.y <= -DefaultWalkSpeed then
				timer.Destroy("restore")
				ply:Dryed(ply.Drying)
				--ply:ChatPrint(ply:GetNWInt("stamina"))
				--ply:ChatPrint(vel.x)
			end
		end)
	end
	if key == IN_JUMP then
		timer.Destroy( "restore" )
		ply:Dryed(ply.Drying)
	end
end )
	function KeyRele( ply, key )
		if key == IN_SPEED and !ply:KeyDown(IN_SPEED)  then
			timer.Destroy( "tcb_StaminaTimer" )
			timer.Create("restore", 0.5, 0, function()
				ply:Restored(ply.SetRestore)
				--ply:ChatPrint(ply:GetNWInt("stamina"))
			end)
		end
	end
	hook.Add( "KeyRelease", "tcb_StaminaRelease", KeyRele ) 