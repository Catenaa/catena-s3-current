----------------Converted by uNwinD#2439------------------


QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('qb-methcar:start')
AddEventHandler('qb-methcar:start', function()
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	
	if xPlayer.Functions.GetItemByName('acetone').amount >= 5 and xPlayer.Functions.GetItemByName('lithium').amount >= 2 and xPlayer.Functions.GetItemByName('methlab').amount >= 1 then
		if xPlayer.Functions.GetItemByName('meth').amount >= 30 then
			TriggerClientEvent('QBCore:Notify', _source, "Negalite daugiau tureti amfetamino inventoriuje")
		else
			TriggerClientEvent('qb-methcar:startprod', _source)
			xPlayer.Functions.RemoveItem('acetone', 5)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['methlab'], "remove")
			xPlayer.Functions.RemoveItem('lithium', 2)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['methlab'], "remove")
		end	
	else
		TriggerClientEvent('QBCore:Notify', _source, "Neturite visu reikalingu priemaišu")
	end
end)


RegisterServerEvent('qb-methcar:stopf')
AddEventHandler('qb-methcar:stopf', function(id)
	local _source = source
		local xPlayers = QBCore.Functions.GetPlayers()
		local xPlayer = QBCore.Functions.GetPlayer(_source)
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('qb-methcar:stopfreeze', xPlayers[i], id)
	end
end)


RegisterServerEvent('qb-methcar:make')
AddEventHandler('qb-methcar:make', function(posx,posy,posz)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)

	if xPlayer.Functions.GetItemByName('meth').amount >= 1 then
	
		local xPlayers = QBCore.Functions.GetPlayers()
		for i=1, #xPlayers, 1 do
			TriggerClientEvent('qb-methcar:smoke',xPlayers[i],posx,posy,posz, 'a') 
		end	
	else
		TriggerClientEvent('qb-methcar:stop', _source)
	end
end)


RegisterServerEvent('qb-methcar:finish')
AddEventHandler('qb-methcar:finish', function(qualtiy)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	print(qualtiy)
	local rnd = math.random(-5, 5)
	xPlayer.Functions.AddItem('meth', math.floor(qualtiy / 2) + rnd)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['meth'], "add")
end)


RegisterServerEvent('qb-methcar:blow')
AddEventHandler('qb-methcar:blow', function(posx, posy, posz)
	local _source = source
	local xPlayers = QBCore.Functions.GetPlayers()
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('qb-methcar:blowup', xPlayers[i],posx, posy, posz)
	end
	xPlayer.Functions.RemoveItem('methlab', 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['methlab'], "remove")
end)

