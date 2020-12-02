local HUD = {}
local y = 20
local x = 20
local smthd = 0
local smthdd = 0
local smthh = 0
local smter = 0
local ourMat = Material( "gui/gradient_down" )
HUD.__index= HUD
function HUD:new()
	obj = {}
	obj.x = 0
	obj.y = 0
	obj.w = 0
	obj.h = 0
	setmetatable(obj, self)
	return obj
end

function HUD:AddBar(valuestxt,values,  x, y, w, h, material, col)
	local alpha = math.Clamp(math.abs(math.cos(UnPredictedCurTime()) * 100), 0, 100);
	draw.RoundedBox(0,x-2, y-2 , w+4, h+4,Color(0, 0, 0,106*0.75));
	surface.SetDrawColor( alpha, alpha,alpha,alpha)
	surface.SetMaterial( material	)
	surface.DrawTexturedRect(x, y,w , h )
	surface.SetDrawColor(col)
	surface.DrawRect(x, y, values , h )
	surface.SetDrawColor( alpha, alpha,alpha,alpha)
	surface.SetMaterial( material	)
	surface.DrawTexturedRect(x, y,values , h )
	--draw.SimpleText(math.Round(valuestxt), "TargetID", x+w*0.5, y-h*0.05, Color(255, 255, 255, 255))
	if alpha > 0 then
		draw.RoundedBox(0, x , y , w, h,Color(150, 150, 150,math.min( alpha, 200)));
	end
end
function HUD:PoliceHud(x, y)
	local c = 1
	self.x = x
	self.y = y
	if LocalPlayer():GetNWInt("rang") < #Rangs then
		c = 1
	else
		c = 0
	end
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Material("icon16/shield.png"	)) -- If you use Material, cache it!
	surface.DrawTexturedRect( self.x - 125, self.y, 20, 20 )
	draw.SimpleText(LocalPlayer():GetNWInt("Xp"),"TargetID", self.x-105, self.y, Color(255, 255, 255))
	--draw.SimpleText("Опыт:"..LocalPlayer():GetNWInt("Xp").."/"..Rangs[LocalPlayer():GetNWInt("rang")+c].xp,"TargetID", self.x, self.y+25, Color(255, 255, 255))
end
smth = 0
function HUD:TextMoney(x, y)
	self.x = x
	self.y = y
	smth= Lerp(FrameTime()*2, smth, LocalPlayer():getDarkRPVar("money"))
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Material("icon16/money.png"	)) -- If you use Material, cache it!
	surface.DrawTexturedRect( self.x, self.y, 20, 20	)
	draw.SimpleText(DarkRP.formatMoney(math.Round(smth)), "TargetID", self.x+20 , self.y, Color(255, 255, 255, 255))
	smth2= Lerp(FrameTime()*2, smth2 or 0, LocalPlayer():getDarkRPVar("salary"))
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Material("icon16/coins.png"	)) -- If you use Material, cache it!
	surface.DrawTexturedRect( self.x+surface.GetTextSize(LocalPlayer():getDarkRPVar("money") )+45, self.y, 20, 20	)
	draw.SimpleText(GAMEMODE.Config.currency.. math.Round(smth2), "TargetID", self.x+surface.GetTextSize(LocalPlayer():getDarkRPVar("money") )+65, self.y, Color(255, 255, 255, 255))
end
function HUD:TextInfo()
	local job = LocalPlayer():getDarkRPVar("job")
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Material("icon16/vcard.png"	)) -- If you use Material, cache it!
	surface.DrawTexturedRect( self.x+surface.GetTextSize(LocalPlayer():getDarkRPVar("salary") )+80+surface.GetTextSize(LocalPlayer():getDarkRPVar("money") ), self.y, 20, 20	)
	draw.SimpleText(job, "TargetID", self.x + surface.GetTextSize(LocalPlayer():getDarkRPVar("salary"))+105+surface.GetTextSize(LocalPlayer():getDarkRPVar("money") ), self.y, Color(255, 255, 255, 255))
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Material("icon16/exclamation.png"	)) -- If you use Material, cache it!
	surface.DrawTexturedRect( self.x - 85, self.y, 20, 20 )
	draw.SimpleText(string.format("%g" ,LocalPlayer():GetNWInt("violation")), "TargetID", self.x - 65, self.y, Color(255, 255, 255, 255))
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Material("icon16/emoticon_smile.png"	)) -- If you use Material, cache it!
	surface.DrawTexturedRect( self.x - 50, self.y, 20, 20 )
	draw.SimpleText(string.format("%g" ,LocalPlayer():GetNWFloat("loyality")), "TargetID", self.x - 30, self.y, Color(255, 255, 255, 255))
	
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Material("icon16/brick.png"	)) -- If you use Material, cache it!
	surface.DrawTexturedRect( self.x+surface.GetTextSize(LocalPlayer():getDarkRPVar("job"))+140+surface.GetTextSize(LocalPlayer():getDarkRPVar("money") ), self.y, 20, 20	)
	draw.SimpleText(LocalPlayer():GetCount("props").."/"..cvars.Number( "sbox_maxprops", 0), "TargetID", self.x + surface.GetTextSize(LocalPlayer():getDarkRPVar("job"))+165+surface.GetTextSize(LocalPlayer():getDarkRPVar("money") ), self.y, Color(255, 255, 255, 255))
end

local AngleDelta, OldDelta, delta
local licenseTable = {}
local icons = 
{
	Gun = "icon16/gun.png",
	GunTrade = "icon16/bomb.png",
	Home = "icon16/house.png",
	Trade = "icon16/cart.png"
}
net.Receive("sendlicense", function()
	
end)
local function hud() 
	local i = 0
	if (LocalPlayer():Alive() and IsValid(LocalPlayer())) then
		smthd= Lerp(FrameTime()*2, smthd , LocalPlayer():Health())
		smter = Lerp(FrameTime()*2, smter, LocalPlayer():GetNWInt("stamina"))
		smthh= Lerp(FrameTime()*2, smthh , LocalPlayer():getDarkRPVar("Energy"))
		smthdd= Lerp(FrameTime()*2, smthdd , LocalPlayer():Armor())
		progress = math.Approach( progress or 0, LocalPlayer():Health() , FrameTime()*50);
		progressa = math.Approach( progressa or 0, LocalPlayer():Armor() , FrameTime()*50);
		progresh = math.Approach( progresh or 0,LocalPlayer():getDarkRPVar("Energy") , FrameTime()*50);
		progrese= math.Approach( progrese or 0,LocalPlayer():GetNWInt("stamina"), FrameTime()*50);
		local hd = HUD:new()
		hd:AddBar(smthd,math.min(progress*2.8, 280),  ScrW()/60, ScrH()-140, 100*2.8, 20, ourMat, Color(255, 0, 0, 255))
		if(LocalPlayer():Armor() <= 0 ) then
			hd:AddBar(smthh,math.min(progresh*2.8, 280),  ScrW()/60, ScrH()-100, 100*2.8, 20, ourMat, Color(245, 95, 2))
		else
			hd:AddBar(smthh,math.min(progresh*2.8, 280),  ScrW()/60, ScrH()-60, 100*2.8, 20, ourMat, Color(245, 95, 2))
		end
		hd:AddBar(smter,math.min(progrese*2.8, 280),  ScrW()/60, ScrH()-160, 100*2.8, 5, ourMat, Color(2, 172, 245,255))
		hd:TextMoney(ScrW()-450, math.Round(ScrH()/100))
		hd:TextInfo()
		if LocalPlayer():isCP() and !LocalPlayer():isMayor() then
			hd:PoliceHud(ScrW()-450, ScrH()/100)
		end
		for k, v in pairs(icons) do
			if LocalPlayer():GetNWBool(k) then
				i =  i + 40
				surface.SetDrawColor( 255, 255, 255, 255 )
				surface.SetMaterial( Material(v)	) -- If you use Material, cache it!
				surface.DrawTexturedRect( ScrW()-50, ScrH()-150-i, 20, 20 )
			end
		end
		if LocalPlayer():Armor() >0 then
			hd:AddBar(smthdd,math.min(progressa*2.8, 280),  ScrW()/60, ScrH()-100, 100*2.8, 20, ourMat, Color(0, 0, 255, 255))
		end
	end

end

hook.Add("HUDPaint", "fg", hud) 

local testtable = {}

local function DisplayNotify(msg)
    local txt = msg:ReadString()
	table.insert(testtable, txt)
	for k, v in pairs(testtable) do
		local NotifyPanel = vgui.Create( "DNotify" )
		NotifyPanel:SetPos( 10, k*20 )
		NotifyPanel:SetSize( 500, 40 )
-- Text label
		local lbl = vgui.Create( "DLabel", NotifyPanel )
		lbl:Dock( FILL )
		lbl:SetText( v )
		lbl:SetFont( "TargetID" )
		lbl:SizeToContents()
		--lbl:SetDark( true )

-- Add the label to the notification and begin fading
		NotifyPanel:AddItem( lbl )
	end
	timer.Simple(15, function()
		for k, v in pairs(testtable) do
			testtable[k] = nil
		end
	end)
    -- Log to client console
    MsgC(Color(255, 20, 20, 255), "[DarkRP] ", Color(200, 200, 200, 255), txt, "\n")
	surface.PlaySound("buttons/button4.wav") -- ambient/levels/canals/headcrab_canister_open1.wav
end
usermessage.Hook("_Notify", DisplayNotify)

/*local function DrawName( ply )
    --local strSteamID = string.Replace(ply:SteamID(), ":", "_") 
--    local path = "info/" .. strSteamID .. ".txt"
    --ply.tabledesc = util.JSONToTable(file.Read(path))
    if ( !IsValid( ply ) ) then return end
    if ( ply == LocalPlayer() ) then return end -- Don't draw a name when the player is you
    if ( !ply:Alive() ) then return end -- Check if the player is alive

    local Distance = LocalPlayer():GetPos():Distance( ply:GetPos() ) --Get the distance between you and the player

    if ( Distance < 1000 ) then --If the distance is less than 1000 units, it will draw the name

        local offset = Vector( 0, 0, 85 )
        local ang = LocalPlayer():EyeAngles()
        local pos = ply:GetPos() + offset + ang:Up()

        ang:RotateAroundAxis( ang:Forward(), 90 )
        ang:RotateAroundAxis( ang:Right(), 90 )


        cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.25 )
            draw.SimpleText( ply:GetNWString("desc"), "Trebuchet24", 2, 2, Color(255,255,255,255), TEXT_ALIGN_CENTER )
        cam.End3D2D()
    end
end
hook.Add( "PostPlayerDraw", "DrawName", DrawName )*/

local ang, pos, offset, alpha, trace, ent
local Alpha = 255

local function DrawName(ply)

local pos = ply:EyePos()
pos.z = pos.z + 15
pos = pos:ToScreen()
	
local w = 197
local h = 50

local x = pos.x
local y = pos.y

trace = LocalPlayer():GetEyeTrace()
ent = trace.Entity

local offset = Vector( 0, 0, 85 )
local ang = LocalPlayer():EyeAngles()
local pos = ply:GetPos() + offset + ang:Up()

Distance = LocalPlayer():GetPos():Distance(ply:GetPos())

ang:RotateAroundAxis( ang:Forward(), 90 )
ang:RotateAroundAxis( ang:Right(), 90 )

if Distance > 100 or trace.HitPos:Distance(LocalPlayer():GetShootPos()) > 125 then
	alpha = 0
else
	alpha = 150
end

Alpha = Lerp(2 * FrameTime(), Alpha, alpha)

cam.Start3D2D(pos,Angle(0,ang.y,90),0.050)
	draw.SimpleText(ply:GetNWString("desc"),"Trebuchet24",2,2,Color(255,255,255,Alpha),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
cam.End3D2D()

end
hook.Add( "PostPlayerDraw", "DrawName", DrawName )

/*---------------------------------------------------------------------------
Drawing death notices
---------------------------------------------------------------------------*/
function GM:DrawDeathNotice(x, y)
	if not GAMEMODE.Config.showdeaths then return end
	self.BaseClass:DrawDeathNotice(x, y)
end

/*---------------------------------------------------------------------------
Remove some elements from the HUD in favour of the DarkRP HUD
---------------------------------------------------------------------------*/
function GM:HUDShouldDraw(name)
	if name == "CHudHealth" or
		name == "CHudBattery" or
		name == "CHudSuitPower" or
		name == "CHudAmmo" or
		name == "CHudSecondaryAmmo" or
		name == "CHUDCrosshair" or
		(HelpToggled and name == "CHudChat") then
			return false
	else
		return true
	end
end

/*---------------------------------------------------------------------------
Disable players' names popping up when looking at them
---------------------------------------------------------------------------*/
function GM:HUDDrawTargetID()
    return false
end
