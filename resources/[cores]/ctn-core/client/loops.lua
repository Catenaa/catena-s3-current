
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		if NetworkIsSessionStarted() then
			Citizen.Wait(10)
			TriggerServerEvent('QBCore:PlayerJoined')
			return
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if isLoggedIn then
			Citizen.Wait((1000 * 60) * 15)
			TriggerServerEvent("QBCore:ReceivedSalary")
		else
			Citizen.Wait(5000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		if isLoggedIn then
			Citizen.Wait((1000 * 60) * 10)
			TriggerEvent("QBCore:Player:UpdatePlayerData")
			TriggerEvent("debug", 'QBCore: Update Player Data!', 'normal')
		else
			Citizen.Wait(5000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		if isLoggedIn then
			Citizen.Wait(30000)
			TriggerEvent("QBCore:Player:UpdatePlayerPosition")
			TriggerEvent("debug", 'QBCore: Update Player Position!', 'normal')
		else
			Citizen.Wait(5000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(math.random(3000, 5000))
		if isLoggedIn then
			if QBCore.Functions.GetPlayerData().metadata["hunger"] <= 0 or QBCore.Functions.GetPlayerData().metadata["thirst"] <= 0 then
				local ped = GetPlayerPed(-1)
				local currentHealth = GetEntityHealth(ped)

				SetEntityHealth(ped, currentHealth - math.random(5, 10))
			end
		end
	end
end)