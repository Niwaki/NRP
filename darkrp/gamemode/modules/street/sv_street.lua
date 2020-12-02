util.AddNetworkString('zone_data')

local META = FindMetaTable('Player')


function gang_zones.ExtremeInRangeTechnology( ply, vecmin, vecmax )

    local ppos = ply:GetPos()

    ppos.z = 0

    local v1, v2 = vecmin, vecmax

    OrderVectors(v1,v2)

    return ppos:WithinAABox(v1,v2)

end


timer.Create( 'gz_zonechecker', 1, 0, function()

    for k,ply in ipairs(player.GetAll()) do
        local zx, zy = Vector(4079.968750, -656.031250, 0), Vector(3936.029053, -879.968750, 0)
        if gang_zones.ExtremeInRangeTechnology(ply,zx,zy) and ply:isArrested() then
			ply:unArrest()
			ply:wanted(nil, "Побег", 300)
        end
    end

end)

DarkRP.defineChatCommand( 'gz_sellzone', function( ply, arg )
    ply:SellZone()
end)