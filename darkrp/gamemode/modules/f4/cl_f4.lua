Texts = {};
Texts.DarkRPCommand = 'say'
--pointer = 0

--net.Receive("wrtint", function()
--	pointer = net.ReadFloat()
--end)

function RunEntCmd(...)
	local arg = {...}
	
	if Texts.DarkRPCommand:lower():find( 'say' ) then
		arg = table.concat( arg,' ' );
	else
		arg = table.concat(arg,' ');
	end;
	RunConsoleCommand( Texts.DarkRPCommand, '/'..arg );
end;

/*local function reason()
	local fram = vgui.Create( "DFrame" )
	fram:SetSize( 300, 100 )
	fram:Center()
	fram:MakePopup()

	local TextEntry = vgui.Create( "DTextEntry", fram ) -- create the form as a child of frame
	TextEntry:Dock(TOP)
	TextEntry:SetText( "Placeholder Text" )
	TextEntry.OnEnter = function( self )
		chat.AddText( self:GetValue() )	-- print the form's text as server text
	end
end*/

net.Receive( 'bindf4', function()

--maximum = net.ReadFloat() // Fix thix shit// this shit not work fuck off because im coment this my englisg is very horosho

local PlayPanel = vgui.Create( 'DFrame' )
	PlayPanel:SetSize( 700, 800 );
	PlayPanel:SetTitle( 'Игровое меню' );
	PlayPanel:SetDraggable( false );
	PlayPanel:MakePopup();
	PlayPanel:SetSkin("DarkRP")
	PlayPanel:Center();
	--PlayPanel:SetBackgroundBlur( true );
local StrokePanel = vgui.Create( 'DPropertySheet', PlayPanel )
	StrokePanel:Dock( FILL );
--[[ Работы ]]--
local JobsPanel = vgui.Create( 'DPanel', StrokePanel )
	for _, v in  pairs( DarkRP.getCategories()[ 'jobs' ] ) do
		local category_jobs = vgui.Create( 'DCollapsibleCategory', JobsPanel )
			category_jobs:Dock( TOP );
			category_jobs:SetLabel( v.name );
		for _, b in pairs( v.members ) do
		local cat_jobs = vgui.Create( 'DPanel', category_jobs )
			cat_jobs:Dock( TOP );
			cat_jobs:SetTall( 38 );
			
		local description_jobs = vgui.Create( "DLabel",cat_jobs )
			description_jobs:SetPos( 50, 10 );
			description_jobs:SetText( b.name..' | Зарплата: '..b.salary..'§ | Максимум: '..b.max..' | Описание: '..b.description );
			description_jobs:SizeToContents(); 
			description_jobs:SetDark( 1 );

		local model_jobs = vgui.Create( 'SpawnIcon', cat_jobs ) 
			model_jobs:SetSize( 35, 35 );
			model_jobs:SetPos( 5, 3 );
			model_jobs:SetModel( 'models/player/Group01/Male_02.mdl' );
			
		local select_jobs = vgui.Create( 'DButton', cat_jobs )
			select_jobs:SetPos( 600, 5 );
			select_jobs:SetText( 'Выбрать' );
			select_jobs.DoClick = function()
			if b.vote or b.RequiresVote and b.RequiresVote( LocalPlayer(), b.team ) then
				RunConsoleCommand( 'darkrp', 'vote' .. b.command );
			else
				RunConsoleCommand( 'darkrp', b.command );
			end;
		end;
	end;
end;

StrokePanel:AddSheet( 'Работа', JobsPanel, 'icon16/user.png' );
--[[ Магазин ]]--	
local ShopPanel = vgui.Create( 'DPanel', StrokePanel )
local category_shop_ent = vgui.Create( 'DCollapsibleCategory', ShopPanel )
	category_shop_ent:Dock( TOP );
	category_shop_ent:SetLabel( 'Предметы' );	
	
for _, n in pairs( DarkRPEntities ) do
if not n.allowed or (type(n.allowed) == "table" and table.HasValue(n.allowed, LocalPlayer():Team())) and (not n.customCheck or (n.customCheck and n.customCheck(LocalPlayer()))) then
local ent_shop = vgui.Create( 'DPanel', category_shop_ent )
	ent_shop:Dock( TOP );
	ent_shop:SetTall( 38 );
			
local description_shop_ent = vgui.Create( 'DLabel', ent_shop )
	description_shop_ent:SetPos( 50, 10 );
	description_shop_ent:SetText( n.name..' | '.. n.price..'§' );
	description_shop_ent:SizeToContents() ;
	description_shop_ent:SetDark( 1 );

local model_entity = vgui.Create( 'SpawnIcon', ent_shop ) 
	model_entity:SetSize( 35, 35 );
	model_entity:SetPos( 5, 3 );
	model_entity:SetModel( n.model );
				
local buy_entity = vgui.Create( 'DButton', ent_shop )
	buy_entity:SetPos( 600, 5 );
	buy_entity:SetText( 'Купить' );
	buy_entity.DoClick = function()
		RunEntCmd( n.cmd );
	end;
end
end;
local category_shop_wep = vgui.Create( 'DCollapsibleCategory', ShopPanel )
	category_shop_wep:Dock( TOP );
	category_shop_wep:SetLabel( 'Оружие' );
		
for _, l in pairs( CustomShipments ) do
if not l.allowed or (type(l.allowed) == "table" and table.HasValue(l.allowed, LocalPlayer():Team())) and (not l.customCheck or (l.customCheck and l.customCheck(LocalPlayer()))) then
	local wep_shop = vgui.Create( 'DPanel', category_shop_wep )
		wep_shop:Dock( TOP );
		wep_shop:SetTall( 38 );
			
	local description_shop_wep = vgui.Create( 'DLabel', wep_shop )
		description_shop_wep:SetPos( 50, 10 );
		description_shop_wep:SetText( l.name..' | '.. l.price..'§' );
		description_shop_wep:SizeToContents();
		description_shop_wep:SetDark( 1 );

	local model_wep = vgui.Create( 'SpawnIcon', wep_shop )  
		model_wep:SetSize( 35, 35 );
		model_wep:SetPos( 5, 3 );
		model_wep:SetModel( l.model );
						
	local buy_weapons = vgui.Create( 'DButton', wep_shop )
		buy_weapons:SetPos( 600, 5 );
		buy_weapons:SetText( 'Купить' );
		buy_weapons.DoClick = function()
			RunEntCmd( 'buyshipment '..l.name );
		end;
	end;
end;
local category_shop_amm = vgui.Create( 'DCollapsibleCategory', ShopPanel )
	category_shop_amm:Dock( TOP );
	category_shop_amm:SetLabel( 'Патроны' );
for _, o in pairs( GAMEMODE.AmmoTypes ) do 
if not o.allowed or (type(o.allowed) == "table" and table.HasValue(o.allowed, LocalPlayer():Team())) and (not o.customCheck or (o.customCheck and o.customCheck(LocalPlayer()))) then
local amm_shop = vgui.Create( 'DPanel', category_shop_amm )
	amm_shop:Dock( TOP );
	amm_shop:SetTall( 38 );
			
local description_shop_amm = vgui.Create( 'DLabel', amm_shop )
	description_shop_amm:SetPos( 50, 10 );
	description_shop_amm:SetText( o.name..' | '.. o.price..'§' );
	description_shop_amm:SizeToContents();
	description_shop_amm:SetDark( 1 );

local model_amm = vgui.Create( 'SpawnIcon', amm_shop )  
	model_amm:SetSize( 35, 35 );
	model_amm:SetPos( 5, 3 );
	model_amm:SetModel( o.model );
		
local buy_ammo = vgui.Create( 'DButton', amm_shop )
	buy_ammo:SetPos( 600, 5 );
	buy_ammo:SetText( 'Купить' );
	buy_ammo.DoClick = function()
		RunEntCmd( 'buyammo '..o.ammoType );
	end
end
end
StrokePanel:AddSheet( 'Магазин', ShopPanel, 'icon16/cart.png' );
--[[ Крафт ]]--	
local CraftPanel = vgui.Create( 'DPanel', StrokePanel )
local category_craft_ent = vgui.Create( 'DCollapsibleCategory', CraftPanel )
	category_craft_ent:Dock( TOP );
	category_craft_ent:SetLabel( 'Предметы' );
for k, v in pairs(Craft.Item) do
		local wep_craftd = vgui.Create( 'DPanel', category_craft_ent )
		wep_craftd:Dock( TOP );
		wep_craftd:SetTall( 38 );
		local mods = vgui.Create("SpawnIcon", wep_craftd)
		mods:SetSize(35, 35)
		mods:SetPos(5, 3)
		mods:SetModel(v.model)
		local labd = vgui.Create("DLabel", wep_craftd)
		labd:SetPos(50, 10)
		labd:SetText(v.name.." | ".."Описание: "..v.desc)
		labd:SizeToContents();
		labd:SetDark( 1 );
		local butds = vgui.Create("DButton", wep_craftd)
		butds:SetPos(600, 5)
		butds:SetText("Крафт")
		function butds:DoClick()
			net.Start("fuckent")
			net.WriteTable(v.recipe)
			net.WriteString(k)
			net.SendToServer()
	end
end

local category_craft_wep = vgui.Create( 'DCollapsibleCategory', CraftPanel )
	category_craft_wep:Dock( TOP );
	category_craft_wep:SetLabel( 'Оружие' );
	for k, v in pairs(Craft.Weapon) do
		local wep_craft = vgui.Create( 'DPanel', category_craft_wep )
		wep_craft:Dock( TOP );
		wep_craft:SetTall( 38 );
		local mod = vgui.Create("SpawnIcon", wep_craft)
		mod:SetSize(35, 35)
		mod:SetPos(5, 3)
		mod:SetModel(v.model)
		local lab = vgui.Create("DLabel", wep_craft)
		lab:SetPos(50, 10)
		lab:SetText(v.name.." | ".."Описание: "..v.desc)
		lab:SizeToContents();
		lab:SetDark( 1 );
		local butd = vgui.Create("DButton", wep_craft)
		butd:SetPos(600, 5)
		butd:SetText("Крафт")
		function butd:DoClick()
			net.Start("mainf")
			net.WriteTable(v.recipe)
			net.WriteString(k)
			net.SendToServer()
		end
	end
StrokePanel:AddSheet( 'Крафт', CraftPanel, 'icon16/wrench.png');
--[[ Инвентарь ]]--	
local InvPanel = vgui.Create( 'DPanel', StrokePanel )
local max_inv = vgui.Create( 'DProgress' , InvPanel )
	max_inv:Dock( TOP );
    max_inv:SetFraction( maximum/10 );
local category_ent = vgui.Create( 'DCollapsibleCategory', InvPanel )
	category_ent:Dock( TOP );
	category_ent:SetLabel( 'Предметы' );
for k, v in pairs(cl_ent) do
	local panelgovno = vgui.Create("DPanel", category_ent)
	panelgovno:Dock(TOP)
	panelgovno:SetTall( 38 );
	local model = vgui.Create("SpawnIcon", panelgovno)
	model:SetSize( 35, 35 );
	model:SetPos( 5, 3 );
	model:SetModel( item[v].model );
	local label = vgui.Create("DLabel", panelgovno)
	label:SetText(item[v].name.." | ".."Описание: "..item[v].desc)
	label:SizeToContents()
	label:SetPos(50, 10)
	label:SetDark( 1 );
	local ent_inv = vgui.Create( 'DButton', panelgovno )
		ent_inv:SetPos(600, 5)
		ent_inv:SetText("Выкинуть" );
		function ent_inv:DoClick( self )
			ent_inv:Remove();
			net.Start( 'gas' );
			net.WriteFloat( k );
			net.WriteString( v );
			net.SendToServer();
			cl_ent[k] = nil;
		end;
end;
local category_weps = vgui.Create( 'DCollapsibleCategory', InvPanel )
	category_weps:Dock( TOP );
	category_weps:SetLabel( 'Оружиe' );
for k, v in pairs( cl_weps ) do
local panelgovno = vgui.Create("DPanel", category_weps)
	panelgovno:Dock(TOP)
	panelgovno:SetTall( 38 );
	local label = vgui.Create("DLabel", panelgovno)
	label:SetText(tabl[v].name.." | ".."Описание: "..tabl[v].desc)
	label:SizeToContents()
	label:SetPos(50, 10)
	label:SetDark( 1 );
	local model = vgui.Create("SpawnIcon", panelgovno)
	model:SetSize( 35, 35 );
	model:SetPos( 5, 3 );
	model:SetModel( tabl[v].model );
	local usewep_inv = vgui.Create( 'DButton', panelgovno  )
    usewep_inv:SetPos(525, 5)
	usewep_inv:SetText( "Использовать" );
	function usewep_inv:DoClick() 
		net.Start("using")
		net.WriteFloat(k)
		net.WriteString( v );
		net.SendToServer()
		maximum = maximum - 1
		cl_weps[k] = nil
	end
local wep_inv = vgui.Create( 'Button', panelgovno  )
    wep_inv:SetPos(600, 5)
	wep_inv:SetText( "Выкинуть" );
	function wep_inv:DoClick( self )
        wep_inv:Remove();
        net.Start( 'remove');
        net.WriteFloat( k );
        net.WriteString( v );
        net.SendToServer();
        maximum = maximum -1;
        cl_weps[k] = nil;
    end;
end;
local category_other = vgui.Create( 'DCollapsibleCategory', InvPanel )
	category_other:Dock( TOP );
	category_other:SetLabel( 'Детали' );
for k, v in pairs( cl_test ) do
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
    buh:SetPos(600, 5)
	buh:SetText( "Выкинуть" );
	function buh:DoClick()
		net.Start("dropdown")
		net.WriteString(k)
		net.SendToServer()
	end
end;
local category_ship = vgui.Create( 'DCollapsibleCategory', InvPanel )
	category_ship:Dock( TOP );
	category_ship:SetLabel( 'Ящики' );
for k, v in pairs( cl_ships ) do
local panelgovno = vgui.Create("DPanel", category_ship)
	panelgovno:Dock(TOP)
	panelgovno:SetTall( 38 );
	local model = vgui.Create("SpawnIcon", panelgovno)
	model:SetSize( 35, 35 );
	model:SetPos( 5, 3 );
	model:SetModel( "models/Items/item_item_crate.mdl");
	local label = vgui.Create("DLabel", panelgovno)
	label:SetText(CustomShipments[v.cont].name.." | ".."Колличество: "..v.count.."x".." | ".."Описание: ".."Деревянный ящик")
	label:SizeToContents()
	label:SetPos(50, 10)
	label:SetDark( 1 );
local box_inv = vgui.Create( 'DButton', panelgovno )
    box_inv:SetPos(600, 5)
    box_inv:SetText( "Выкинуть");
    function box_inv:DoClick()
        net.Start( 'removeship' );
        net.WriteFloat( k );
        net.SendToServer();
        cl_ships[k] = nil;
        box_inv:Remove();
    end;
end;
StrokePanel:AddSheet( "Инвентарь", InvPanel, "icon16/box.png" );
/*--[[ ОПГ ]]--	
local InvPanel = vgui.Create( 'DPanel', StrokePanel )
local cat_org = vgui.Create( 'DCollapsibleCategory', InvPanel )
	cat_org:Dock( TOP );
	cat_org:SetLabel( 'Создать банду' );
	local cat_org_1 = vgui.Create( 'DPanel', cat_org )
    cat_org_1:Dock( TOP );
    cat_org_1:SetTall( 20 );
	local cat_org_3 = vgui.Create("DTextEntry", cat_org_1)
	cat_org_3:SetMultiline(true)
	--cat_org_3:Dock( TOP );
	cat_org_3:SetText( 'Стоимость 2000§, введите название ОПГ...' )
	cat_org_3:SetPos( 50, 10 )
	cat_org_3:SetSize( 50, 20 );
StrokePanel:AddSheet( "ОПГ", InvPanel, "icon16/group.png" );
--[[ Полиция/Мэр ]]--
local police_of = LocalPlayer():Team()
if LocalPlayer():isCP() then
local PolicePanel = vgui.Create( 'DPanel', StrokePanel )
--[[ Полиция/Граждане ]]--
	if police_of == TEAM_MAYOR or police_of == TEAM_POLICE then
    local police_officer_cit_info = vgui.Create( 'DCollapsibleCategory', PolicePanel )
        police_officer_cit_info:Dock( TOP );
        police_officer_cit_info:SetLabel( 'Граждане FinelyCity' );
	for k, v in pairs( player.GetAll() ) do
		if v:Team()!= TEAM_MAYOR and v:Team()!= TEAM_POLICE then
		--if v:isCP() then
		local city_citizen = vgui.Create( 'DPanel', police_officer_cit_info )
                city_citizen:Dock( TOP );
                city_citizen:SetTall( 38 );
		local city_citizen_description = vgui.Create( 'DLabel', city_citizen )
                city_citizen_description:SetPos( 50, 10 );
                city_citizen_description:SetText( "Ф.И.O: "..v:GetName().." | ".."Должность: "..v:getDarkRPVar("job").." | ".."Лояльность: "..v:GetNWFloat("loyality") .." | ".."РОЗЫСК: ".."Да/Нет" )
                city_citizen_description:SizeToContents(); 
                city_citizen_description:SetDark( 1 );
		local model_cit = vgui.Create( 'SpawnIcon', city_citizen ) 
                model_cit:SetSize( 35, 35 );
				model_cit:SetPos( 5, 3 );
                model_cit:SetModel( v:GetModel() );
		local wasted_cit = vgui.Create( 'DButton', city_citizen )
				wasted_cit:SetPos( 600, 5 );
				wasted_cit:SetText( 'Розыск' );
				--wasted_cit.DoClick = function()
				--	reason()
				--	net.Start("demote_police_officer")
				--	net.WriteEntity(v)
				--	net.SendToServer()
		--end
		end
		end
	end
--[[ Мэр/Сотрудники ]]--
	if police_of == TEAM_MAYOR then
    local police_officer = vgui.Create( 'DCollapsibleCategory', PolicePanel )
        police_officer:Dock( TOP );
        police_officer:SetLabel( 'Список сотрудников' );
     for k, v in pairs( player.GetAll() ) do
        if v:isCP() and v:Team()!= TEAM_MAYOR then
            local police_officers = vgui.Create( 'DPanel', police_officer )
                police_officers:Dock( TOP );
                police_officers:SetTall( 38 );
        
            local police_officers_description = vgui.Create( 'DLabel', police_officers )
                police_officers_description:SetPos( 50, 10 );
                police_officers_description:SetText("Ф.И.O: "..v:GetName().." | ".."Ранг: "..Rangs[v:GetNWInt("rang")].name.." | ".."Лояльность: "..v:GetNWFloat("loyality") );
                police_officers_description:SizeToContents(); 
                police_officers_description:SetDark( 1 );
            
            local model_police_officers = vgui.Create( 'SpawnIcon', police_officers ) 
                model_police_officers:SetSize( 35, 35 );
				model_police_officers:SetPos( 5, 3 );
                model_police_officers:SetModel( v:GetModel() );
				
			local demote_police_officer = vgui.Create( 'DButton', police_officers )
				demote_police_officer:SetPos( 600, 5 );
				demote_police_officer:SetText( 'Уволить' );
				demote_police_officer.DoClick = function()
					net.Start("demote_police_officer")
					net.WriteEntity(v)
					net.SendToServer()
				end
		end
	end
end
--[[ Мэр/Улучшения ]]--
	if police_of == TEAM_MAYOR then
	local police_officer_update = vgui.Create( 'DCollapsibleCategory', PolicePanel )
        police_officer_update:Dock( TOP );
        police_officer_update:SetLabel( 'Управление' );
	local police_officer_point = vgui.Create( 'DPanel', police_officer_update )
        police_officer_point:Dock( TOP );
        police_officer_point:SetTall( 38 );
	local police_officer_point_desc = vgui.Create( 'DLabel', police_officer_point )
        police_officer_point_desc:SetPos( 50, 10 );
        police_officer_point_desc:SetText("Полицейские очки: "..pointer);
        police_officer_point_desc:SizeToContents(); 
        police_officer_point_desc:SetDark( 1 );
	for k, v in pairs( PoliceOfficers.Updates ) do
    local police_officer_update_cat = vgui.Create( 'DPanel', police_officer_update )
                police_officer_update_cat:Dock( TOP );
                police_officer_update_cat:SetTall( 38 );
	local police_officer_update_one = vgui.Create( 'DLabel', police_officer_update_cat )
                police_officer_update_one:SetPos( 50, 10 );
                police_officer_update_one:SetText(v.name.." | ".."Описание: "..v.desc.." | ".."Стоимость: "..v.cost);
                police_officer_update_one:SizeToContents(); 
                police_officer_update_one:SetDark( 1 );
            
            local model_police_one_model = vgui.Create( 'SpawnIcon', police_officer_update_cat ) 
                model_police_one_model:SetSize( 35, 35 );
				model_police_one_model:SetPos( 5, 3 );
                model_police_one_model:SetModel( v.model );
			local model_police_one_button = vgui.Create( 'DButton', police_officer_update_cat )
				model_police_one_button:SetPos( 600, 5 );
				model_police_one_button:SetText( 'Улучшить' );
				model_police_one_button.DoClick = function()
					v.func()
				end
	end
end
StrokePanel:AddSheet( 'Полиция/Мэр', PolicePanel, 'icon16/wrench.png');
end*/
end ); 










