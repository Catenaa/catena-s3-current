QBCore = nil
Timers = {}

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('oxydelivery:server')
AddEventHandler('oxydelivery:server', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Timers[src] and Timers[src]+(1000 * 60 * 30) >= GetGameTimer() then
		TriggerClientEvent("ctn-oxyruns:client:nope", src)
		return
	end

	if Player.PlayerData.money.cash >= Config.StartOxyPayment then
		Timers[src] = GetGameTimer()
		Player.Functions.RemoveMoney("cash", Config.StartOxyPayment)
		TriggerEvent("ctn-bossmenu:server:addAccountMoney", "drugdealer", 2500)
		TriggerClientEvent("oxydelivery:startDealing", src)
		TriggerClientEvent("ctn-oxyruns:client:AcceptBribe", src)
		PerformHttpRequest('WEBHOOK_HERE', function(err, text, headers) end, 'POST', json.encode({username = "Oxy Runs Log", content = "__**" .. GetPlayerName(source) .. "**__ Started Oxy Run"}), { ['Content-Type'] = 'application/json' })
	else
		TriggerClientEvent('QBCore:Notify', src, 'Not enough money.', 'error')
	end
end)

RegisterServerEvent('oxydelivery:receiveBigRewarditem')
AddEventHandler('oxydelivery:receiveBigRewarditem', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.AddItem("security_card_03", 1)
end)

RegisterServerEvent('oxydelivery:receiveoxy')
AddEventHandler('oxydelivery:receiveoxy', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local oxy = math.random(1, 3)

	Player.Functions.AddItem("oxy", oxy)
end)

local DoorLocked = true
RegisterServerEvent('ctn-oxyruns:server:doorState')
AddEventHandler('ctn-oxyruns:server:doorState', function(bool)
	if bool == nil then
		TriggerClientEvent('ctn-oxyruns:client:doorState', source, DoorLocked)
		return
	end

	DoorLocked = bool
	TriggerClientEvent('ctn-oxyruns:client:doorState', -1, DoorLocked)
end)