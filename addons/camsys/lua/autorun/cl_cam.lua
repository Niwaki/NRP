local function ActiveCalcView( ply, pos, angles, fov )

	local frameTime = FrameTime();
	
		local approachTime = frameTime * 2;
		local curTime = UnPredictedCurTime();
		local info = {speed = 1, yaw = 0.5, roll = 0.1};
		
		if ( !HeadbobAngle ) then
			HeadbobAngle = 0;
		end;
		
		if ( !HeadbobInfo ) then
			HeadbobInfo = info; 
		end;
		
		HeadbobInfo.yaw = math.Approach(HeadbobInfo.yaw, info.yaw, approachTime);
		HeadbobInfo.roll = math.Approach(HeadbobInfo.roll, info.roll, approachTime);
		HeadbobInfo.speed = math.Approach(HeadbobInfo.speed, info.speed, approachTime);
		HeadbobAngle = HeadbobAngle + (HeadbobInfo.speed * frameTime);
		
		local yawAngle = math.sin(HeadbobAngle);
		local rollAngle = math.cos(HeadbobAngle);
		
		angles.y = angles.y + (yawAngle * HeadbobInfo.yaw);
		angles.r = angles.r + (rollAngle * HeadbobInfo.roll);

		local velocity = ply:GetVelocity();
		local eyeAngles = ply:EyeAngles();
		
		if (!VelSmooth) then VelSmooth = 0; end;
		if (!WalkTimer) then WalkTimer = 0; end;
		if (!LastStrafeRoll) then LastStrafeRoll = 0; end;
		
		VelSmooth = math.Clamp(VelSmooth * 0.9 + velocity:Length() * 0.1, 0, 700)
		WalkTimer = WalkTimer + VelSmooth * frameTime * 0.05
		
		LastStrafeRoll = (LastStrafeRoll * 3) + (eyeAngles:Right():DotProduct(velocity) * 0.0001 * VelSmooth * 0.3);
		LastStrafeRoll = LastStrafeRoll * 0.25;
		angles.r = angles.r + LastStrafeRoll;
		
		if (ply:GetGroundEntity() != NULL) then
			angles.p = angles.p + math.cos(WalkTimer * 0.5) * VelSmooth * 0.000002 * VelSmooth;
			angles.r = angles.r + math.sin(WalkTimer) * VelSmooth * 0.000002 * VelSmooth;
			angles.y = angles.y + math.cos(WalkTimer) * VelSmooth * 0.000002 * VelSmooth;
		end;
		
		velocity = LocalPlayer():GetVelocity().z;
		
		if (velocity <= -1000 and LocalPlayer():GetMoveType() == MOVETYPE_WALK) then
			angles.p = angles.p + math.sin(UnPredictedCurTime()) * math.abs((velocity + 1000) - 16);
		end;
	
	local view = {};
	//local weapon = gc.Client:GetActiveWeapon();
	local changedAngles = (view.vm_angles != nil);
	local changedOrigin = (view.vm_origin != nil);
	
	if (!changedAngles) then
		-- Thanks to BlackOps7799 for this open source example.
		
		if (!SmoothViewAngle) then
			SmoothViewAngle = angles;
		else
			SmoothViewAngle = LerpAngle(RealFrameTime() * 16, SmoothViewAngle, angles);
		end;
		
		view.angles = SmoothViewAngle;
		view.vm_origin = origin;
		view.vm_angles = angles;
	end;
	
	//plugin:Call("CalcViewAdjustTable", view);
	
	return view;
end

hook.Add( "CalcView", "OverrideStandartView", ActiveCalcView )


local VIGNETTE_OVERLAY = Material("vintage/vgui/vignette.png");
local VIGNETTE_OVERLAY_EXIST = VIGNETTE_OVERLAY_EXIST or false;


hook.Add( "HUDPaint", "PaintVignete", function()

if ( VIGNETTE_OVERLAY_EXIST ) then
		if (!VignetteAlpha) then
			VignetteAlpha = 150; 
			VignetteAlphaDelta = VignetteAlpha;
		end;
   
		local data = {};
			data.start = LocalPlayer():GetShootPos();
			data.endpos = data.start + (LocalPlayer():GetUp() * 512);
			data.filder = LocalPlayer();
		local trace = util.TraceLine(data);

		VignetteAlpha = (!trace.HitWorld and !trace.HitNonWorld) and 150 or 255;
		VignetteAlphaDelta = math.Approach(VignetteAlphaDelta, VignetteAlpha, FrameTime() * 70);

		local scrW, scrH = ScrW(), ScrH();

		surface.SetDrawColor(0, 0, 0, VignetteAlphaDelta);
		surface.SetMaterial(VIGNETTE_OVERLAY);
		surface.DrawTexturedRect(0, 0, scrW, scrH);
	end;

end )

hook.Add( "InitPostEntity", "CheckVignetteExist", function()
	timer.Simple(1, function()
		VIGNETTE_OVERLAY_EXIST = file.Exists( "materials/vintage/vgui/vignette.png", "GAME" ) ;
	end);
end )