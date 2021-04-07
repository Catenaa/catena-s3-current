QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('CrashTackle')
AddEventHandler('CrashTackle', function(playerId)
	TriggerClientEvent("playerTackled", playerId)
end)

RegisterServerEvent('undragTarget')
AddEventHandler('undragTarget', function(playerId)
	TriggerClientEvent("undragPlayer", playerId, source)
end)

RegisterServerEvent('dragTarget')
AddEventHandler('dragTarget', function(playerId)
	TriggerClientEvent("dragPlayer", playerId, source)
end)

RegisterServerEvent("ctn-carry:beingCarried")
AddEventHandler("ctn-carry:beingCarried", function(beingCarried)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	TriggerClientEvent("ctn-carry:beingCarried", src, beingCarried)
	Player.Functions.SetMetaData('incarry', beingCarried)
end)