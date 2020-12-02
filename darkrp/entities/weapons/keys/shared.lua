AddCSLuaFile()

if SERVER then
    AddCSLuaFile("cl_menu.lua")
end

if CLIENT then
    SWEP.PrintName = "Keys"
    SWEP.Slot = 1
    SWEP.SlotPos = 1
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = false

    include("cl_menu.lua")
end

SWEP.PrintName			= "Ключи/Руки"
SWEP.Author				= "Rudard"
SWEP.Spawnable				= true
SWEP.Category				= "FNSystem"
SWEP.ViewModelFOV	= 62
SWEP.ViewModel			= "models/weapons/v_crowbar.mdl"
SWEP.WorldModel			= "models/weapons/w_crowbar.mdl"
SWEP.ViewModelFlip	= false
SWEP.AnimPrefix	 		= "rpg"
SWEP.HoldType		= "normal"
SWEP.UseHands       = true
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.DrawCrosshair = false

function SWEP:Initialize()
    self:SetHoldType("normal")
		self.Time = 0
	self.Range = 150
end
function SWEP:Think()
	if self.Drag and (not self.Owner:KeyDown(IN_ATTACK) or not IsValid(self.Drag.Entity)) then
		self.Drag = nil
	end
end
function SWEP:Deploy()
    if CLIENT or not IsValid(self:GetOwner()) then return true end
    self:GetOwner():DrawWorldModel(false)
    return true
end

function SWEP:Holster()
    return true
end

function SWEP:PreDrawViewModel()
    return true
end

local function lookingAtLockable(ply, ent)
    local eyepos = ply:EyePos()
    return IsValid(ent)             and
        ent:isKeysOwnable()         and
        (
            ent:isDoor()    and eyepos:DistToSqr(ent:GetPos()) < 4225
            or
            ent:IsVehicle() and eyepos:DistToSqr(ent:NearestPoint(eyepos)) < 10000
        )

end

local function lockUnlockAnimation(ply, snd)
    ply:EmitSound("npc/metropolice/gear" .. math.floor(math.Rand(1,7)) .. ".wav")
    timer.Simple(0.9, function() if IsValid(ply) then ply:EmitSound(snd) end end)

    local RP = RecipientFilter()
    RP:AddAllPlayers()

    umsg.Start("anim_keys", RP)
        umsg.Entity(ply)
        umsg.String("usekeys")
    umsg.End()
    ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true)
end

local function doKnock(ply, sound)
    ply:EmitSound(sound, 100, math.random(90, 110))
    umsg.Start("anim_keys")
        umsg.Entity(ply)
        umsg.String("knocking")
    umsg.End()
    ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST, true)
end


function SWEP:SetupDataTables()
    self:NetworkVar( "String", 0, "ActionName" )
    self:NetworkVar("Int", 1, "ActionColorR")
    self:NetworkVar("Int", 2, "ActionColorG")
    self:NetworkVar("Int", 3, "ActionColorB")
    self:NetworkVar( "Int", 0, "ActionProgress" )
end


function SWEP:Hand()
	local Pos = self.Owner:GetShootPos()
	local Aim = self.Owner:GetAimVector()

	local Tr = util.TraceLine{
		start = Pos,
		endpos = Pos +Aim *self.Range,
		filter = player.GetAll(),
	}

	local HitEnt = Tr.Entity
	if self.Drag then
		HitEnt = self.Drag.Entity
	else
		if not IsValid( HitEnt ) or HitEnt:GetMoveType() ~= MOVETYPE_VPHYSICS or
			HitEnt:IsVehicle() or HitEnt:GetNWBool( "NoDrag", false ) or
			HitEnt.BlockDrag or
			IsValid( HitEnt:GetParent() ) then
			return
		end

		if not self.Drag then
			self.Drag = {
				OffPos = HitEnt:WorldToLocal(Tr.HitPos),
				Entity = HitEnt,
				Fraction = Tr.Fraction,
			}
		end
	end

	if CLIENT or not IsValid( HitEnt ) then return end

	local Phys = HitEnt:GetPhysicsObject()

	if IsValid( Phys ) then
		local Pos2 = Pos +Aim *self.Range *self.Drag.Fraction
		local OffPos = HitEnt:LocalToWorld( self.Drag.OffPos )
		local Dif = Pos2 -OffPos
		local Nom = (Dif:GetNormal() *math.min(1, Dif:Length() /100) *500 -Phys:GetVelocity()) *Phys:GetMass()

		Phys:ApplyForceOffset( Nom, OffPos )
		Phys:AddAngleVelocity( -Phys:GetAngleVelocity() /4 )
	end
end
function SWEP:PrimaryAttack()
	
	
	 local trace = self:GetOwner():GetEyeTrace()

    if not lookingAtLockable(self:GetOwner(), trace.Entity, trace.HitPos) then self:Hand() 
	else

    self:SetNextPrimaryFire(CurTime() + 0.3)
	
    local trace = self:GetOwner():GetEyeTrace()


    self:SetNextPrimaryFire(CurTime() + 0.3)

    if CLIENT then return end

    if self:GetOwner():canKeysLock(trace.Entity) then
        local some = 0
        self:GetOwner():Freeze(true)
        timer.Create ("GMP_OpenDoor", 1, 2, function ()
            some = some + 50
            self:SetActionProgress(some)
            self:SetActionName ("Закрытие...")
            self:SetActionColorR (255)
            self:SetActionColorG (0)
            self:SetActionColorB (0)
        end)
        timer.Simple(3, function ()
            self:SetActionProgress(-1)
            trace.Entity:keysLock() -- Lock the door immediately so it won't annoy people
            lockUnlockAnimation(self:GetOwner(), "doors/door_latch3.wav")
            self:GetOwner():Freeze(false)
            RunConsoleCommand("GMP_LOCKER_SPAWN", "aqkjlsndajkshdfwq12", trace.Entity:EntIndex())
        end)

    elseif trace.Entity:IsVehicle() then
        DarkRP.notify(self:GetOwner(), 1, 3, DarkRP.getPhrase("do_not_own_ent"))
    else
        doKnock(self:GetOwner(), "physics/wood/wood_crate_impact_hard2.wav")
    end
	end
end


function SWEP:SecondaryAttack()
    local trace = self:GetOwner():GetEyeTrace()

    if not lookingAtLockable(self:GetOwner(), trace.Entity) then return end

    self:SetNextSecondaryFire(CurTime() + 0.3)

    if CLIENT then return end

    if self:GetOwner():canKeysUnlock(trace.Entity) then
                local some = 0
        self:GetOwner():Freeze(true)
        timer.Create ("GMP_OpenDoor", 1, 2, function ()
            some = some + 50
            self:SetActionProgress(some)
            self:SetActionName ("Открытие...")
            self:SetActionColorR (0)
            self:SetActionColorG (255)
            self:SetActionColorB (0)
        end)
        timer.Simple(3, function ()
            self:SetActionProgress(-1)
            trace.Entity:keysUnLock() -- Unlock the door immediately so it won't annoy people
            lockUnlockAnimation(self:GetOwner(), self.UnlockSound)
            self:GetOwner():Freeze(false)
            RunConsoleCommand("GMP_LOCKER_REMOVE", "asdzxcsswqee1", trace.Entity:EntIndex())
        end)

    elseif trace.Entity:IsVehicle() then
        DarkRP.notify(self:GetOwner(), 1, 3, DarkRP.getPhrase("do_not_own_ent"))
    else
        doKnock(self:GetOwner(), "physics/wood/wood_crate_impact_hard3.wav")
    end
end

function SWEP:Reload()
    local trace = self:GetOwner():GetEyeTrace()

    if SERVER then
        umsg.Start("KeysMenu", self:GetOwner())
        umsg.End()
    end
end
  if CLIENT then
	local x, y = ScrW() /2, ScrH() /2
	local MainCol = Color( 255, 255, 255, 255 )
	local Col = Color( 255, 255, 255, 255 )

	function SWEP:DrawHUD()
		if IsValid( self.Owner:GetVehicle() ) then return end
		local Pos = self.Owner:GetShootPos()
		local Aim = self.Owner:GetAimVector()

		local Tr = util.TraceLine{
			start = Pos,
			endpos = Pos +Aim *self.Range,
			filter = player.GetAll(),
		}

		local HitEnt = Tr.Entity
		if IsValid( HitEnt ) and HitEnt:GetMoveType() == MOVETYPE_VPHYSICS and
			not self.rDag and
			not HitEnt:IsVehicle() and
			not IsValid( HitEnt:GetParent() ) and
			not HitEnt:GetNWBool( "NoDrag", false ) then

			self.Time = math.min( 1, self.Time +2 *FrameTime() )
		else
			self.Time = math.max( 0, self.Time -2 *FrameTime() )
		end

		if self.Time > 0 then
			Col.a = MainCol.a *self.Time

			draw.SimpleText(
				"",
				"DermaLarge",
				x,
				y,
				Col,
				TEXT_ALIGN_CENTER
			)
		end

		if self.Drag and IsValid( self.Drag.Entity ) then
			local Pos2 = Pos +Aim *100 *self.Drag.Fraction
			local OffPos = self.Drag.Entity:LocalToWorld( self.Drag.OffPos )
			local Dif = Pos2 -OffPos

			local A = OffPos:ToScreen()
			local B = Pos2:ToScreen()

			surface.DrawRect( A.x -2, A.y -2, 4, 4, MainCol )
			surface.DrawRect( B.x -2, B.y -2, 4, 4, MainCol )
			surface.DrawLine( A.x, A.y, B.x, B.y, MainCol )
		end
		 if (self:GetActionProgress() > 0) then
            draw.RoundedBox(4,ScrW() / 2.2, ScrH() /2.15 , 140, 50,Color(10,10,10,150))
            draw.SimpleText(self:GetActionName(),"HudNumbers",ScrW() / 2.2, ScrH() /2.15 ,Color(self:GetActionColorR(),self:GetActionColorG(),self:GetActionColorB(),255)) 

            draw.RoundedBox(2,ScrW() / 2.2, ScrH() /2 , self:GetActionProgress(), 20,Color(255,140,0,250))
        else  

        end
	end
end

