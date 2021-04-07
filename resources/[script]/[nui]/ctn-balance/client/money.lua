QBCore = nil
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if QBCore == nil then
			TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
			Citizen.Wait(200)
		end
	end
end)

RegisterNetEvent("hud:client:ShowMoney")
AddEventHandler("hud:client:ShowMoney", function(amount)
    SendNUIMessage({
        action = "show",
        amount = amount,
    })
end)

RegisterNetEvent("hud:client:OnMoneyChange")
AddEventHandler("hud:client:OnMoneyChange", function(type, amount, isMinus)
    QBCore.Functions.GetPlayerData(function(PlayerData)
        cashAmount = PlayerData.money["cash"]
        bankAmount = PlayerData.money["bank"]
    end)
    
    if QBHud.Money.ShowConstant then
        SendNUIMessage({
            action = "open",
            cash = cashAmount,
            bank = bankAmount,
        })
    else
        SendNUIMessage({
            action = "update",
            cash = cashAmount,
            bank = bankAmount,
            amount = amount,
            minus = isMinus,
            type = type,
        })
    end
end)