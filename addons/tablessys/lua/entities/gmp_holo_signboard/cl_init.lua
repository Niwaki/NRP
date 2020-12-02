include("shared.lua")



function ENT:OnRemove()
	//SafeRemoveEntity(self.ClockBase)
end

local DrawDistance = 700


surface.CreateFont( "GMP_TitleFontN1", {
	font = "Impact",
	extended = false,
	size = 50,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "GMP_TitleFontN2", {
	font = "Arial Black",
	extended = false,
	size = 50,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )


local cos,sin,rad,round = math.cos,math.sin,math.rad,math.Round
local mat = Material("phoenix_storms/glass")
local matBase = Material("effects/splashwake1")
local matBeam = Material( "effects/lamp_beam" )

function ENT:Draw()
	self:DrawModel()
local dist = self:GetPos():Distance( LocalPlayer():GetShootPos() )

	if dist <= DrawDistance then
		if ( halo.RenderedEntity() == self ) then return end


		local a = self:GetAngles()
		local b = Angle(180,EyeAngles().y + 90,-a.p  - 180)
		local col = Color(self:GetNWInt("ForwColorR",255),self:GetNWInt("ForwColorG",255),self:GetNWInt("ForwColorB",255))
		local beamColor = Color(self:GetNWInt("BackColorR",255),self:GetNWInt("BackColorG",255),self:GetNWInt("BackColorB",255)) 
		local ang
		if (self:GetNWInt("TextMoving", 0) == 0) then 
			ang = a 
		else
			ang = b
		end

		cam.Start3D2D(self:LocalToWorld(Vector(0,0,1.4)),self:GetAngles(),0.1)
			surface.SetDrawColor(beamColor)
			surface.SetMaterial(matBase)
			surface.DrawTexturedRectRotated(0,0,100,100,SysTime() * 10)
			surface.DrawTexturedRectRotated(0,0,100,100,SysTime() * -12)

		cam.End3D2D()

		render.SetMaterial(matBeam)
		render.DrawBeam( self:LocalToWorld(Vector(0,0,0)), self:LocalToWorld(Vector(0,0,15)), 18 - math.random(1), 0, 0.9, beamColor )
		local TextSize = self:GetNWFloat("TextSize",0.5)
		cam.Start3D2D(self:LocalToWorld(Vector(0,0,7)), ang, TextSize)

				surface.SetTextColor(col)
				surface.SetFont(self:GetNWString("TextFont","GMP_TitleFontN2"))
				local text = self:GetNWString("Text","Надпись.")
				local text_length = surface.GetTextSize(text)

				surface.SetTextPos(-text_length / 2,-30)
				surface.DrawText(text)

		cam.End3D2D()
	end
end

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



net.Receive( "ImageSet", function( len )
	local ent = net.ReadEntity()
	if (IsValid(CustomTableMenu)  ) then return end
			local CustomTableMenu = vgui.Create( "DFrame" )
			CustomTableMenu:SetTitle( "Test panel" )
			CustomTableMenu:SetSize( 500,600 )
			CustomTableMenu:Center()	
			CustomTableMenu:SetBackgroundBlur(false)		
			CustomTableMenu:MakePopup()
			CustomTableMenu.Paint = function(self, w, h)
				draw.RoundedBox( 0, 0, 0, w, h, Color( 10, 10, 10, 150 ) ) 
				DrawBlur( self, 3, 6 ) 
			end

	
			local DLabel = vgui.Create( "DLabel", CustomTableMenu )
				DLabel:SetPos( 55, 25 )
				DLabel:SetFont("Trebuchet18")
				DLabel:SetTextColor(Color(255,255,255,255))
				DLabel:SetText( "Изменить цвет текста" )
				DLabel:SizeToContents(true)

			local ColorPickerForw = vgui.Create( "DColorMixer", CustomTableMenu )
				ColorPickerForw:SetSize( 200, 200 )
				ColorPickerForw:SetPos(30, 50)
				ColorPickerForw:SetPalette( true )
				ColorPickerForw:SetAlphaBar( true ) 
				ColorPickerForw:SetWangs( true )
				ColorPickerForw:SetColor( Color(ent:GetNWInt("ForwColorR",255),ent:GetNWInt("ForwColorG",255),ent:GetNWInt("ForwColorB",255)) )

			local DLabel = vgui.Create( "DLabel", CustomTableMenu )
				DLabel:SetPos( 295, 25 )
				DLabel:SetFont("Trebuchet18")
				DLabel:SetTextColor(Color(255,255,255,255))
				DLabel:SetText( "Изменить цвет задника" )
				DLabel:SizeToContents(true)

			local ColorPickerBack = vgui.Create( "DColorMixer", CustomTableMenu )
				ColorPickerBack:SetSize( 200, 200 )
				ColorPickerBack:SetPos(270, 50)
				ColorPickerBack:SetPalette( true )
				ColorPickerBack:SetAlphaBar( true ) 
				ColorPickerBack:SetWangs( true )
				ColorPickerBack:SetColor( Color(ent:GetNWInt("BackColorR",255),ent:GetNWInt("BackColorG",255),ent:GetNWInt("BackColorB",255)) )


			local DLabel = vgui.Create( "DLabel", CustomTableMenu )
				DLabel:SetPos( 180, 275 )
				DLabel:SetFont("Trebuchet18")       //Marlett HL2MPTypeDeath
				DLabel:SetTextColor(Color(255,255,255,255))
				DLabel:SetText( "Текст таблички (Макс. 40 символов)" )
				DLabel:SizeToContents(true)

			local TextEntry1 = vgui.Create( "DTextEntry", CustomTableMenu )
				TextEntry1:SetPos( 100, 300 )
				TextEntry1:SetSize( 275, 25 )
				TextEntry1:SetText(ent:GetNWString("Text","Надпись."))

			local cbox = vgui.Create("DComboBox", CustomTableMenu)
				cbox:SetPos(100, 360)
				cbox:SetSize(275, 25)

				cbox:SetValue(ent:GetNWString("TextFont","GMP_TitleFontN1"))

				cbox:AddChoice("default")
				cbox:AddChoice("GMP_TitleFontN1")
				cbox:AddChoice("GMP_TitleFontN2")

				cbox:AddChoice("DebugFixed")
				cbox:AddChoice("DebugFixedSmall")
				cbox:AddChoice("Trebuchet18")
				cbox:AddChoice("Trebuchet24")



				cbox:AddChoice("HudHintTextLarge")
				cbox:AddChoice("HudHintTextSmall")
				cbox:AddChoice("CenterPrintText")
				cbox:AddChoice("HudSelectionText")
				cbox:AddChoice("CloseCaption_Normal")

				cbox:AddChoice("CloseCaption_Bold")
				cbox:AddChoice("CloseCaption_BoldItalic")
				cbox:AddChoice("ChatFont")
				cbox:AddChoice("TargetID")
				cbox:AddChoice("TargetIDSmall")

				cbox:AddChoice("BudgetLabel")
				cbox:AddChoice("DermaDefault")
				cbox:AddChoice("DermaDefaultBold")
				cbox:AddChoice("DermaLarge")
			
			local DLabel = vgui.Create( "DLabel", CustomTableMenu )
				DLabel:SetPos( 90, 400 )
				DLabel:SetFont(cbox:GetValue())
				DLabel:SetTextColor(Color(255,255,255,255))
				DLabel:SetText( "Пример шрифта" )
				DLabel.Paint = function(slf, w, h)
					slf:SetFont(cbox:GetValue())
					slf:SizeToContents(true)
				end


			local DermaCheckbox = vgui.Create("DCheckBoxLabel", CustomTableMenu) 
				DermaCheckbox:SetPos(25, 278)                        
				DermaCheckbox:SetText("Подвижный текст")                  
				DermaCheckbox:SetValue(ent:GetNWInt("TextMoving",0))
				DermaCheckbox:SizeToContents()    


			local NumSliderThingy = vgui.Create( "DNumSlider", CustomTableMenu )
				NumSliderThingy:SetPos( 100,490 )
				NumSliderThingy:SetSize( 300, 20 ) 
				NumSliderThingy:SetText( "Размер текста" )
				NumSliderThingy:SetMin( 0 )
				NumSliderThingy:SetMax( 0.5 ) 
				NumSliderThingy:SetDecimals( 2 ) 
				NumSliderThingy:SetValue(ent:GetNWString("TextSize",0.5))


			local AcceptButton = vgui.Create("DButton", CustomTableMenu) 
				AcceptButton:SetText( "Сохранить настройки" ) 
				AcceptButton:SetTextColor( Color(255,255,255) )
				AcceptButton:SetPos( 150, 550 )
				AcceptButton:SetSize( 150, 30 )
				AcceptButton.Paint = function( self, w, h )
					draw.RoundedBox( 0, 0, 0, w, h, Color( 25, 25, 25, 250 ) ) 
				end
				AcceptButton.DoClick = function()
					if (string.len(TextEntry1:GetText()) > 40) then return end
					local ent = LocalPlayer():GetEyeTrace().Entity
					if LocalPlayer():GetPos():Distance(ent:GetPos()) < 200  then
						local ColorToSendBack = ColorPickerBack:GetColor()
						local ColorToSendForw = ColorPickerForw:GetColor()
						local checker = 0
						if (DermaCheckbox:GetChecked()) then
							checker = 1
						else
							checker = 0
						end
						RunConsoleCommand("gmp_settableText", "sedjkfgdjkewfuijhwer124sak", ent:EntIndex(), ColorToSendBack.r, ColorToSendBack.g, ColorToSendBack.b, ColorToSendForw.r, ColorToSendForw.g, ColorToSendForw.b, TextEntry1:GetText(),  cbox:GetValue(), NumSliderThingy:GetValue(), checker )
						print(checker)
						CustomTableMenu:Close()
					end
				end
end )