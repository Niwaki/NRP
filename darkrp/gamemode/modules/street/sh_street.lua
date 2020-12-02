gang_zones = {}

gang_zones.Zones = {
	{
		vgui_pos = { 580, 0, 210, 466 },
		pos = { Vector( 1368.111572, 1549.903320, 0), Vector(5455.968750, 432.031250, 0) },
		color = Color( 200,54,54 ),
		PrintName = 'Элитный район',
		Price = 100000,
	},
	{
		vgui_pos = { 270, 315, 310, 466-315 },
		pos = { Vector( 68.178123, -47.968750, 0 ), Vector(4999.968750, 366.783844, 0) },
		color = Color( 54,200,54 ),
		PrintName = 'Акварельная',
		Price = 200000,
	},
	{
		vgui_pos = { 270, 315, 310, 466-315 },
		pos = { Vector( 1360.031250, -66.881905, 0 ), Vector(1880.294678, -1082.321045, 0) },
		color = Color( 54,200,54 ),
		PrintName = 'Парковка',
		Price = 200000,
	},
	{
		vgui_pos = { 270, 315, 310, 466-315 },
		pos = { Vector( 52.168278, -2366.250488, 0 ), Vector(-367.968750, 367.968750, 0) },
		color = Color( 54,200,54 ),
		PrintName = 'Злобина',
		Price = 200000,
	},
	{
		vgui_pos = { 270, 315, 310, 466-315 },
		pos = { Vector( 3903.937744, -1527.962158, 0 ), Vector(3233.213135, -23.223490, 0) },
		color = Color( 54,200,54 ),
		PrintName = 'Проспект победы',
		Price = 200000,
	},
	{
		vgui_pos = { 270, 315, 310, 466-315 },
		pos = { Vector( 2992.685791, -1104.031250, 0 ), Vector(-121.969688, -3070.694580, 0) },
		color = Color( 54,200,54 ),
		PrintName = 'Рабочая улица',
		Price = 200000,
	},
}

gang_zones.ZoneData = {}

DarkRP.declareChatCommand({
	command = "gz_buyzone",
	description = "Купить зону",
	delay = 5
})

DarkRP.declareChatCommand({
	command = "gz_sellzone",
	description = "Отказаться от владения зоной",
	delay = 5
})
