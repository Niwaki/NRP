local electionList = {}
util.AddNetworkString( "startelection")
util.AddNetworkString( "votinge")

function findMayor()
	local Mayorvar = true
	for k, v in pairs(player.GetAll()) do
		if v:isMayor() then
			return true
		end
	end
end

concommand.Add( "addlinlist", function( ply, cmd, args )
	if (#electionList <= 2 and not table.HasValue(electionList, ply) and not findMayor() and !GetGlobalBool("election")) then
		ply:SetNWString("nullptr", args[1])
		ply.point = 0
		table.insert(electionList, ply)
		DarkRP.notify(ply, 1, 4, "Вы балотировались на выборы")
	end
	if#electionList == 2 then
		SetGlobalBool( "election", true )
		DarkRP.notifyAll(0, 7, "Выборы начинаются!") -- Добавить вы баллотировались на пост Мэра
		timer.Create("startele", 30, 1, function()
			startElection()
		end)
	end
end )

function startElection()
	net.Start("startelection")
	net.WriteTable(electionList)
	net.Send(player.GetAll())
	timer.Simple(60, function()
		endElection()
		//player.GetAll():ChatPrint("Выборы закончились")
	end)
end

function endElection()
	local num = electionList[1].point
	for k, v in pairs(electionList) do
		if electionList[k].point > num then
			num = electionList[k].point 
		end
		//electionList[k] = nil
	end
	for k, v in pairs(electionList) do
		if electionList[k].point == num then
			electionList[k]:SetNWBool("canmar", true)
			DarkRP.notifyAll(0, 7, "Выборы закончились! Победил ".. electionList[k]:GetName()) 
			electionList[k]:changeTeam(TEAM_MAYOR, false)
		end
		electionList[k] = nil
	end
	SetGlobalBool("election", false)
end

net.Receive("votinge", function(len, ply)
	local m = net.ReadFloat()
	electionList[m].point = electionList[m].point + 1
	DarkRP.notify(ply, 1, 4, "Вы проголосовали за "..electionList[m]:GetName())
	--ply:ChatPrint("ууууу"..electionList[m].point) -- Вы проголосовали за ply:Name, кондидата - DU IT
end)