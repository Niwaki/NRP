include("shared.lua")
function ENT:Initialize()
end

function ENT:DrawTranslucent()
	self:Draw();
end;

function ENT:BuildBonePositions(NumBones, NumPhysBones)
end;
 
function ENT:SetRagdollBones(bIn)
	self.m_bRagdollSetup = bIn;
end;

function ENT:DoRagdollBone(PhysBoneNum, BoneNum)
	--self:SetBonePosition( BoneNum, Pos, Angle )
end;
net.Receive("sfw", function()
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetSkin('DarkRP')
	--PlayPanel:Center();
	DermaPanel:SetPos(( ScrW()/2), ScrH()/6 )
	DermaPanel:SetSize( ScrW()/3, ScrH() -150 );
	DermaPanel:SetTitle( 'Ваш инвентарь' );
	DermaPanel:SetDraggable( false );
	DermaPanel:MakePopup();
	--DermaPanel:SetBackgroundBlur( true );
	local max_inv = vgui.Create( 'DProgress' , DermaPanel )
	max_inv:Dock( TOP );
    max_inv:SetFraction( maximum/10 );
	local StrokePanelInv = vgui.Create( 'DPropertySheet', DermaPanel )
	StrokePanelInv:Dock( FILL );
	local StorageInvPanel = vgui.Create( 'DPanel', StrokePanelInv )
local category_inv_storage = vgui.Create( 'DCollapsibleCategory', StorageInvPanel )
	category_inv_storage:Dock( TOP );
	category_inv_storage:SetLabel( 'Предметы' );
	for k, v in pairs(cl_ent) do
		local panelgovno = vgui.Create("DPanel", category_inv_storage)
	panelgovno:Dock(TOP)
	panelgovno:SetTall( 38 );
	local label = vgui.Create("DLabel", panelgovno)
	label:SetText(item[v].name.." | ".."Описание: "..item[v].desc)
	label:SizeToContents()
	label:SetDark( 1 );
	label:SetPos(50, 10)
	local model = vgui.Create("SpawnIcon", panelgovno)
	model:SetSize( 35, 35 );
	model:SetPos( 5, 3 );
	model:SetModel(item[v].model );
		local buttonq = vgui.Create( "DButton", panelgovno )
		buttonq:SetPos( ScrW()/4, 0 )
		buttonq:SetVisible( true )
		buttonq:SetText("Передать")
		function buttonq:DoClick()
			if(max2<=20) then
			net.Start("op")
			net.WriteFloat(k)
			net.WriteString(v)
			net.SendToServer()
			cl_ent[k] = nil
			buttonq:Remove()
			maximum = maximum - 1
			end
		end	
	end
	local category_inv_storages = vgui.Create( 'DCollapsibleCategory', StorageInvPanel )
	category_inv_storages:Dock( TOP );
	category_inv_storages:SetLabel( 'Оружие' );
	for k, v in pairs(cl_weps) do
		print(v, k)
		local panelgovno = vgui.Create("DPanel", category_inv_storages)
	panelgovno:Dock(TOP)
	panelgovno:SetTall( 38 );
	local label = vgui.Create("DLabel", panelgovno)
	label:SetText(tabl[v].name.." | ".."Описание: "..tabl[v].desc)
	label:SizeToContents()
	label:SetDark( 1 );
	label:SetPos(50, 10)
	local model = vgui.Create("SpawnIcon", panelgovno)
	model:SetSize( 35, 35 );
	model:SetPos( 5, 3 );
	model:SetModel( tabl[v].model );
		local button = vgui.Create( "DButton", panelgovno )
		button:SetPos( ScrW()/4, 0 )
		button:SetVisible( true )
		button:SetText( "Передать" )
		function button:DoClick(self)
			if(max2<=20) then
			net.Start("html")
			net.WriteFloat(k)
			net.WriteString(v)
			net.SendToServer()
			cl_weps[k] = nil
			button:Remove()
			maximum = maximum - 1
			end
		end
	end
	local category_inv_storages2= vgui.Create( 'DCollapsibleCategory', StorageInvPanel )
	category_inv_storages2:Dock( TOP );
	category_inv_storages2:SetLabel( 'Ящики' );
	for k, v in pairs(cl_ships) do
		local panelgovno = vgui.Create("DPanel", category_inv_storages2)
	panelgovno:Dock(TOP)
	panelgovno:SetTall( 38 );
	local label = vgui.Create("DLabel", panelgovno)
	label:SetText(CustomShipments[v.cont].name.." | ".."Колличество: "..v.count.."x")
	label:SizeToContents()
	label:SetDark( 1 );
	label:SetPos(50, 10)
	local model = vgui.Create("SpawnIcon", panelgovno)
	model:SetSize( 35, 35 );
	model:SetPos( 5, 3 );
	model:SetModel( "models/Items/item_item_crate.mdl" );
		local button2 = vgui.Create( "DButton", panelgovno )
		button2:SetPos( ScrW()/4, 0)
		button2:SetVisible( true )
		button2:SetText("Передать")
		function button2:DoClick()
			if(max2<=20) then
			net.Start("Cpp")
			net.WriteFloat(k)
			net.SendToServer()
			cl_ships[k] = nil 
			button2:Remove()
			maximum = maximum - 2
			end
		end
	end
	local category_inv_storages3 = vgui.Create( 'DCollapsibleCategory', StorageInvPanel )
	category_inv_storages3:Dock( TOP );
	category_inv_storages3:SetLabel( 'Детали' );
	for k, v in pairs( cl_test ) do
	local panelgovno2 = vgui.Create("DPanel", category_inv_storages3) 
	panelgovno2:Dock(TOP)
	panelgovno2:SetTall( 38 );
	local labeld = vgui.Create("DLabel", panelgovno2)
	labeld:SetText(test[k].name.." | ".."Колличество: "..v.."x".." | ".."Описание: "..test[k].desc)
	labeld:SizeToContents()
	labeld:SetDark( 1 );
	labeld:SetPos(50, 10)
	local model = vgui.Create("SpawnIcon", panelgovno2)
	model:SetSize( 35, 35 );
	model:SetPos( 5, 3 );
	model:SetModel( test[k].model );
	local buh = vgui.Create( 'DButton', panelgovno2  )
    buh:SetPos(ScrW()/4, 0)
	buh:SetText( "Передать" );
	function buh:DoClick()
		net.Start("throwdetails")
		net.WriteString(k)
		net.SendToServer()
		panelgovno2:Remove()
		v = nil
	end
end;
StrokePanelInv:AddSheet( 'Инвентарь', StorageInvPanel, 'icon16/wrench.png');
--
	local DermaPan = vgui.Create( "DFrame" )
	DermaPan:SetPos( (ScrW())/6, ScrH()/6 )
	DermaPan:SetSize(ScrW()/3, ScrH() -150);
	DermaPan:SetTitle( 'Игровое хранилище' );
	DermaPan:SetDraggable( false );
	DermaPan:SetSkin('DarkRP')
	DermaPan:MakePopup();
	--DermaPan:SetBackgroundBlur( true );
	local max_inv = vgui.Create( 'DProgress' , DermaPan )
	max_inv:Dock( TOP );
    max_inv:SetFraction( max2/10);
	local DLabel = vgui.Create( "DLabel", max_inv )
	DLabel:SetPos( 40, 40 )
	DLabel:SetText( "Hello, world!" )
	local StrokePanel = vgui.Create( 'DPropertySheet', DermaPan )
	StrokePanel:Dock( FILL );
	local StoragePanel = vgui.Create( 'DPanel', StrokePanel )
		local category_storagep = vgui.Create( 'DCollapsibleCategory', StoragePanel )
	category_storagep:Dock( TOP );
	category_storagep:SetLabel( 'Предеметы' );
	for k, v in pairs(cl_stent ) do
		local panelgovno = vgui.Create("DPanel", category_storagep)
		panelgovno:Dock(TOP)
		panelgovno:SetTall( 38 );
		local label = vgui.Create("DLabel", panelgovno)
		label:SetText(item[v].name.." | ".."Описание: "..item[v].desc)
	label:SizeToContents()
	label:SetDark( 1 );
	label:SetPos(50, 10)
	local model = vgui.Create("SpawnIcon", panelgovno)
	model:SetSize( 35, 35 );
	model:SetPos( 5, 3 );
	model:SetModel( item[v].model);
		local buttonj= vgui.Create( "DButton",panelgovno )
		buttonj:SetPos( ScrW()/4, 0 )
		buttonj:SetVisible( true )
		buttonj:SetText("Забрать")
		function buttonj:DoClick()
			if(maximum<=10) then
			buttonj:Remove()
			net.Start("sql")
			net.WriteFloat(k)
			net.SendToServer()
			cl_storage[k] = nil
			maximum = maximum + 2
			end
		end
	end
		local category_storagee = vgui.Create( 'DCollapsibleCategory', StoragePanel )
	category_storagee:Dock( TOP );
	category_storagee:SetLabel( 'Оружие' );
	for k, v in pairs(cl_stweps) do
		local panelgovno = vgui.Create("DPanel", category_storagee)
		panelgovno:Dock(TOP)
		panelgovno:SetTall( 38 );
		local label = vgui.Create("DLabel", panelgovno)
		label:SetText(tabl[v].name.." | ".."Описание: "..tabl[v].desc)
	label:SizeToContents()
	label:SetDark( 1 );
	label:SetPos(50, 10)
	local model = vgui.Create("SpawnIcon", panelgovno)
	model:SetSize( 35, 35 );
	model:SetPos( 5, 3 );
	model:SetModel( tabl[v].model );
		local buttonh = vgui.Create( "DButton", panelgovno )
		buttonh:SetPos( ScrW()/4, 0 )
		buttonh:SetVisible( true )
		buttonh:SetText("Забрать")
		function buttonh:DoClick()
			if(maximum<=10) then
			buttonh:Remove()
			net.Start("php")
			net.WriteFloat(k)
			net.SendToServer()
			cl_stweps[k] = nil
			maximum = maximum +1
			end
		end
	end
		local category_storaged = vgui.Create( 'DCollapsibleCategory', StoragePanel )
	category_storaged:Dock( TOP );
	category_storaged:SetLabel( 'Ящики' );
	for k, v in pairs(cl_storage) do
		local panelgovno = vgui.Create("DPanel", category_storaged)
	panelgovno:Dock(TOP)
	panelgovno:SetTall( 38 );
	local label = vgui.Create("DLabel", panelgovno)
	label:SetText(CustomShipments[v.cont].name.." | ".."Колличество: "..v.count.."x")
	label:SizeToContents()
	label:SetDark( 1 );
	label:SetPos(50, 10)
	local model = vgui.Create("SpawnIcon", panelgovno)
	model:SetSize( 35, 35 );
	model:SetPos( 5, 3 );
	model:SetModel( "models/Items/item_item_crate.mdl" );
		local button3 = vgui.Create( "DButton",panelgovno )
		button3:SetPos( ScrW()/4, 0 )
		button3:SetVisible( true )
		button3:SetText("Забрать")
		function button3:DoClick()
			if(maximum<= 10) then
			net.Start("js")
			net.WriteFloat(k)
			net.SendToServer()
			cl_stent[k] = nil
			button3:Remove()
			maximum = maximum + 1
			end
		end
	end
local category_other = vgui.Create( 'DCollapsibleCategory', StoragePanel )
	category_other:Dock( TOP );
	category_other:SetLabel( 'Детали' );
for k, v in pairs( cl_details ) do
	local panelgovno2 = vgui.Create("DPanel", category_other) 
	panelgovno2:Dock(TOP)
	panelgovno2:SetTall( 38 );
	local labeld = vgui.Create("DLabel", panelgovno2)
	labeld:SetText(test[k].name.." | ".."Колличество: "..v.."x".." | ".."Описание: "..test[k].desc)
	labeld:SizeToContents()
	labeld:SetDark( 1 );
	labeld:SetPos(50, 10)
	local model = vgui.Create("SpawnIcon", panelgovno2)
	model:SetSize( 35, 35 );
	model:SetPos( 5, 3 );
	model:SetModel( test[k].model );
	local buh = vgui.Create( 'DButton', panelgovno2  )
    buh:SetPos(ScrW()/4, 0)
	buh:SetText( "Забрать" );
	function buh:DoClick()
		--if(maximum<= 10) then
		net.Start("givedetails")
		net.WriteString(k)
		net.SendToServer()
		panelgovno2:Remove()
		v = nil
		--maximum = maximum + 1
		end
	end
	
	StrokePanel:AddSheet( 'Хранилище', StoragePanel, 'icon16/wrench.png');
end)