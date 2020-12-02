util.AddNetworkString( 'bindf4' )
util.AddNetworkString( 'demote_police_officer' )

hook.Add( 'ShowSpare2', 'f4', function( ply )
	--polices:sendinfo(ply)
	net.Start( 'bindf4' );
	net.Send( ply );
end );

net.Receive( 'demote_police_officer', function()
	local c = net.ReadEntity()
	
	c:changeTeam( TEAM_CITIZEN )
	//polices:set(-2)
end )