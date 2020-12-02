include("shared.lua");

surface.CreateFont("npStove_Font", 
{
	font = "Tahoma",
	size = 36,
	antialias = true,
	shadow = true
});

function ENT:Initialize()

	--[[ Setup progress array (for lerp) ]]--
	self.progress = {};
	for i = 1, 4, 1 do
		self.progress[i] = 0;
	end

end

function ENT:Draw()

	self:DrawModel();

	local angle = self:GetAngles();

	angle:RotateAroundAxis(angle:Up(), 90);
	angle:RotateAroundAxis(angle:Forward(), 90);
	
	local defX = -25;
	local defY = -20;

	local x = defX - 230;
	local y = defY - 130;

	cam.Start3D2D(self:GetPos() + self:GetForward() * 14.2, angle, 0.1);
		
		--[[ Background ]]--
		--draw.RoundedBox(0, x, y, 500, 300, Color(80, 80, 80, 80));

		--[[ Slots ]]--
		for i = 1, 4, 1 do
			
			--[[ Check slot is not empty ]]--
			if (!self:CheckSlot(i)) then
				continue;
			end
			
			--[[ Get data from slot ]]--
			local name, thaimer, time = self:GetSlot(i);

			--[[ Slot: Background ]]--
			draw.RoundedBox(0, x, y, 500, (300 / 4), Color(255, 255, 255, 80));

			--[[ Slot: Progress ]]--
			local progress = 0 + ((500 - 6) / thaimer) * (thaimer - time + 1);
			self.progress[i] = Lerp(3 * FrameTime(), self.progress[i], progress);
			draw.RoundedBox(0, (x + 3), (y + 3), self.progress[i], (300 / 4) - 6, Color(0, 200, 0, 180));

			--[[ Slot: Name ]]--
			surface.SetFont("npStove_Font");
			local nameW, nameH = surface.GetTextSize(name);
			draw.DrawText(name, "npStove_Font", x + (500 / 2) - (nameW / 2), y + ((300 / 4) / 2) - (nameH / 2), Color(255, 255, 255, 255));

			--[[ New line ]]--
			y = y + 80

		end

	cam.End3D2D();

end

function ENT:CheckSlot(slot)
	if (slot == 1) then
		return self:GetOne();
	elseif (slot == 2) then
		return self:GetTwo();
	elseif (slot == 3) then
		return self:GetThree();
	elseif (slot == 4) then
		return self:GetFour();
	end
end

function ENT:GetSlot(slot)
	if (slot == 1) then
		return self:GetNameOne(), self:GetTimerOne(), self:GetTimeOne();
	elseif (slot == 2) then
		return self:GetNameTwo(), self:GetTimerTwo(), self:GetTimeTwo();
	elseif (slot == 3) then
		return self:GetNameThree(), self:GetTimerThree(), self:GetTimeThree();
	elseif (slot == 4) then
		return self:GetNameFour(), self:GetTimerFour(), self:GetTimeFour();
	end
end

function ENT:Think()

end






