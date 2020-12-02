DarkRP.createAmmoType("buckshot", {
    name = "Дробь",
    model = "models/Items/BoxBuckshot.mdl",
    price = 50,
    amountGiven = 8,
	allowed = {TEAM_GUN}
})

DarkRP.createAmmoType("smg1", {
    name = "7,62 × 39 мм",
    model = "models/Items/BoxMRounds.mdl",
    price = 80,
    amountGiven = 30,
	allowed = {TEAM_GUN}
})

DarkRP.createCategory{
    name = "Other",
    categorises = "ammo",
    startExpanded = true,
    color = Color(0, 107, 0, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 255,
}
