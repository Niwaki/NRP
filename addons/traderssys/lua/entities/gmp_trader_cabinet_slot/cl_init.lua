include("shared.lua")


	local blur = Material("pp/blurscreen")

	local function DrawBlur( p, a, d )

		local x, y = p:LocalToScreen(0, 0)
		
		surface.SetDrawColor( 255, 255, 255 )
		
		surface.SetMaterial( blur )
		
		for i = 1, d do
		
		
			blur:SetFloat( "$blur", (i / d ) * ( a ) )
			
			blur:Recompute()
			
			render.UpdateScreenEffectTexture()
			
			surface.DrawTexturedRect( x * -1, y * -1, ScrW(), ScrH() )	
			
		end
		
	end


function ENT:CreateSetPriceSett()

if (IsValid(SetWeapPrice)  ) then return end
		
	local SetWeapPrice = vgui.Create( "DFrame" )
		SetWeapPrice:SetTitle( "Test panel" )
		SetWeapPrice:SetSize( 250, 120 )
		SetWeapPrice:Center()	
		SetWeapPrice:SetBackgroundBlur(true)		
		SetWeapPrice:MakePopup()
		SetWeapPrice.Paint = function( self, w, h ) 
			draw.RoundedBox( 0, 0, 0, w, h, Color( 10, 10, 10, 150 ) ) 
			DrawBlur( self, 3, 6 ) 
		end

	local DLabel = vgui.Create( "DLabel", SetWeapPrice )
		DLabel:SetPos( 55, 25 )
		DLabel:SetFont("Trebuchet18")       //Marlett HL2MPTypeDeath
		DLabel:SetTextColor(Color(255,255,255,255))
		DLabel:SetText( "Отображаемая цена" )
		DLabel:SizeToContents(true)		

	local TextEntry1 = vgui.Create( "DTextEntry", SetWeapPrice )
		TextEntry1:SetPos( 10, 50 )
		TextEntry1:SetSize( 75, 25 )
		TextEntry1:SetNumeric(true)
		TextEntry1:SetText( self:GetNWString("WeapPrice", "0"))

	local DermaCheckbox = vgui.Create("DCheckBoxLabel", SetWeapPrice) 
		DermaCheckbox:SetPos(95, 55)                        
		DermaCheckbox:SetText("Зафиксировать модель")                  
		DermaCheckbox:SetValue(self:GetNWInt("CanChangeWeapModel",0))
		DermaCheckbox:SizeToContents()    

	local AcceptButton = vgui.Create("DButton", SetWeapPrice) 
		AcceptButton:SetText( "Сохранить" ) 
		AcceptButton:SetTextColor( Color(255,255,255) )
		AcceptButton:SetPos( 50, 80 )
		AcceptButton:SetSize( 150, 30 )
		AcceptButton.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 55, 55, 55, 250 ) ) 
		end

		AcceptButton.DoClick = function()		
			local ent = LocalPlayer():GetEyeTrace().Entity
			if LocalPlayer():GetPos():Distance(ent:GetPos()) < 200  then
				local checker = 0
				if (DermaCheckbox:GetChecked()) then
					checker = 1
				else
					checker = 0
				end
				RunConsoleCommand("gmp_setPriceSetting", "ZJKXFBJKFJKHWJjwjjwjwejqe312", ent:EntIndex(), TextEntry1:GetText(), checker )
				SetWeapPrice:Close()
			end
		end

end

net.Receive("SetWeapSettings",function() 
	net.ReadEntity():CreateSetPriceSett()
end)




function ENT:Draw() 
	self:DrawModel()


	local pos = self:GetPos()

	local Ang = self:GetAngles()
		Ang:RotateAroundAxis(Ang:Forward(), 90)
		Ang:RotateAroundAxis(Ang:Right(), 90)

	local WeapAng = self:GetAngles()
		WeapAng:RotateAroundAxis(Ang:Right(),90)
		WeapAng:RotateAroundAxis(Ang:Up(),-30)

	if (IsValid(self:GetChildren()[1])) then 
		local ent = self:GetChildren()[1]
		ent:SetAngles(WeapAng)	
		ent:SetPos(pos + Ang:Right() * -3 + Ang:Forward() * -3.5)
	end

	cam.Start3D2D(pos + Ang:Right() * -10 + Ang:Forward() * -22.2 + Ang:Up() * 1, Ang, 1)

		draw.RoundedBox( 1, 10, 10, 25, 4, Color( 50, 50, 50, 200 ) )

	cam.End3D2D()

	cam.Start3D2D(pos + Ang:Right() * -1.5 + Ang:Forward() * -14 + Ang:Up() * 1, Ang, 0.2)

		draw.SimpleText("ЦЕНА:  ","default", 15, 10,Color(255,255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
		draw.SimpleText(self:GetNWString("WeapPrice", "0").."₽","default", 52, 10,Color(255,255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)

	cam.End3D2D()



end


