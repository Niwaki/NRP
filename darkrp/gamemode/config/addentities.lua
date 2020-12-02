DarkRP.createEntity("Стенд", {
    ent = "gmp_trader_cabinet_slot",
    model = "models/hunter/plates/plate025.mdl",
    price = 150,
    max = 15,
    cmd = "buygmptrader",
	allowed = {TEAM_COOK, TEAM_GUN}
})

DarkRP.createEntity("Вывеска", {
    ent = "gmp_holo_signboard",
    model = "models/maxofs2d/hover_plate.mdl",
    price = 100,
    max = 15,
    cmd = "buygmpsingboard"
})

DarkRP.createEntity("Печь", {
    ent = "gmp_foods_stove",
    model = "models/props_c17/furnitureStove001a.mdl",
    price = 250,
    max = 2,
    cmd = "buygmpstove",
	allowed = {TEAM_COOK}
})

DarkRP.createEntity("Мука", {
    ent = "gmp_foods_flour",
    model = "models/props_junk/garbage_bag001a.mdl",
    price = 50,
    max = 15,
    cmd = "buygmpflour",
	allowed = {TEAM_COOK}
})

DarkRP.createCategory{
    name = "Other",
    categorises = "entities",
    startExpanded = true,
    color = Color(0, 107, 0, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 255,
}

DarkRP.createCategory{
    name = "Other",
    categorises = "shipments",
    startExpanded = true,
    color = Color(0, 107, 0, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 255,
}
-- models/props_junk/wood_crate001a.mdl
DarkRP.createShipment("IMI Desert Eagle", {
	model = "models/props_junk/wood_crate001a.mdl",
	entity = "fas2_deagle",
	price = 72000,
	amount = 5,
	seperate = false,
	pricesep = nil,
	noship = false,
	allowed = {TEAM_GUN}
})

DarkRP.createShipment("P226", {
	model = "models/props_junk/wood_crate001a.mdl",
	entity = "fas2_p226",
	price = 46000,
	amount = 5,
	seperate = false,
	pricesep = nil,
	noship = false,
	allowed = {TEAM_GUN}
})

DarkRP.createShipment("G36C", {
	model = "models/props_junk/wood_crate001a.mdl",
	entity = "fas2_g36c",
	price = 54000,
	amount = 5,
	seperate = false,
	pricesep = nil,
	noship = false,
	allowed = {TEAM_GUN}
})

DarkRP.createShipment("IMI Galil", {
	model = "models/props_junk/wood_crate001a.mdl",
	entity = "fas2_galil",
	price = 55000,
	amount = 5,
	seperate = false,
	pricesep = nil,
	noship = false,
	allowed = {TEAM_GUN}
})

DarkRP.createShipment("M11A1", {
	model = "models/props_junk/wood_crate001a.mdl",
	entity = "fas2_mac11",
	price = 70000,
	amount = 5,
	seperate = false,
	pricesep = nil,
	noship = false,
	allowed = {TEAM_GUN}
})

DarkRP.createShipment("AK-74", {
	model = "models/props_junk/wood_crate001a.mdl",
	entity = "fas2_ak74",
	price = 120000,
	amount = 5,
	seperate = false,
	pricesep = nil,
	noship = false,
	allowed = {TEAM_GUN}
})

DarkRP.createShipment("MP5A5", {
	model = "models/props_junk/wood_crate001a.mdl",
	entity = "fas2_mp5a5",
	price = 62400,
	amount = 5,
	seperate = false,
	pricesep = nil,
	noship = false,
	allowed = {TEAM_GUN}
})

DarkRP.createShipment("M67", {
	model = "models/props_junk/wood_crate001a.mdl",
	entity = "fas2_m67",
	price = 70000,
	amount = 5,
	seperate = false,
	pricesep = nil,
	noship = false,
	allowed = {TEAM_GUN}
})

DarkRP.createShipment("M4A1", {
	model = "models/props_junk/wood_crate001a.mdl",
	entity = "fas2_m4a1",
	price = 150000,
	amount = 5,
	seperate = false,
	pricesep = nil,
	noship = false,
	allowed = {TEAM_GUN}
})

DarkRP.createShipment("M21", {
	model = "models/props_junk/wood_crate001a.mdl",
	entity = "fas2_m21",
	price = 95000,
	amount = 5,
	seperate = false,
	pricesep = nil,
	noship = false,
	allowed = {TEAM_GUN}
})

DarkRP.createShipment("M14", {
	model = "models/props_junk/wood_crate001a.mdl",
	entity = "fas2_m14",
	price = 100000,
	amount = 5,
	seperate = false,
	pricesep = nil,
	noship = false,
	allowed = {TEAM_GUN}
})

DarkRP.createShipment("G3A3", {
	model = "models/props_junk/wood_crate001a.mdl",
	entity = "fas2_g3",
	price = 110000,
	amount = 5,
	seperate = false,
	pricesep = nil,
	noship = false,
	allowed = {TEAM_GUN}
})

DarkRP.createShipment("AN-94", {
	model = "models/props_junk/wood_crate001a.mdl",
	entity = "fas2_an94",
	price = 95000,
	amount = 5,
	seperate = false,
	pricesep = nil,
	noship = false,
	allowed = {TEAM_GUN}
})

DarkRP.createShipment("Remington 870", {
	model = "models/props_junk/wood_crate001a.mdl",
	entity = "fas2_rem870",
	price = 180000,
	amount = 5,
	seperate = false,
	pricesep = nil,
	noship = false,
	allowed = {TEAM_GUN}
})

DarkRP.createShipment("Machete", {
	model = "models/props_junk/wood_crate001a.mdl",
	entity = "fas2_machete",
	price = 15000,
	amount = 10,
	seperate = false,
	pricesep = nil,
	noship = false,
	allowed = {TEAM_GUN}
})

DarkRP.createCategory{
    name = "Rifles",
    categorises = "shipments",
    startExpanded = true,
    color = Color(0, 107, 0, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 100,
}

DarkRP.createCategory{
    name = "Shotguns",
    categorises = "shipments",
    startExpanded = true,
    color = Color(0, 107, 0, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 101,
}

DarkRP.createCategory{
    name = "Snipers",
    categorises = "shipments",
    startExpanded = true,
    color = Color(0, 107, 0, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 102,
}

DarkRP.createCategory{
    name = "Pistols",
    categorises = "weapons",
    startExpanded = true,
    color = Color(0, 107, 0, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 100,
}

DarkRP.createCategory{
    name = "Other",
    categorises = "weapons",
    startExpanded = true,
    color = Color(0, 107, 0, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 255,
}

DarkRP.createCategory{
    name = "Other",
    categorises = "vehicles",
    startExpanded = true,
    color = Color(0, 107, 0, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 255,
}
