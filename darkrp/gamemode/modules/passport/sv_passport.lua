util.AddNetworkString("showpass")
function sendPassport(traceply, ply)
	net.Start("showpass")
	net.WriteEntity(ply)
	net.Send(traceply)
end
function showPassport(ply, args)
	local traceply = ply:GetEyeTrace().Entity
	sendPassport(traceply, ply)
end
DarkRP.defineChatCommand("showpassport", showPassport)