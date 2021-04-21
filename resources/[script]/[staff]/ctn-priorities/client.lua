local cooldown = 0
local ispriority = false
local ishold = false

RegisterCommand("resetpcd", function()
    TriggerServerEvent("cancelcooldown")
end, false)

RegisterNetEvent('UpdateCooldown')
AddEventHandler('UpdateCooldown', function(newCooldown)
    cooldown = newCooldown
end)

RegisterNetEvent('UpdatePriority')
AddEventHandler('UpdatePriority', function(newispriority)
    ispriority = newispriority
end)

RegisterNetEvent('UpdateHold')
AddEventHandler('UpdateHold', function(newishold)
    ishold = newishold
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if ishold == true then
			DrawText2("~r~Catena~s~ Priority Cooldown: ~b~Priorities Are On Hold")
		elseif ispriority == false then
			DrawText2("~r~Catena~s~ Priority Cooldown: ~r~".. cooldown .." ~w~Mins")
		elseif ispriority == true then
			DrawText2("~r~Catena~s~ Priority Cooldown: ~g~Priority In Progress")
		end
	end
end)

	function DrawText2(text)
        SetTextFont(4)
        SetTextProportional(7)
        SetTextScale(0.0, 0.45)
        SetTextColour(255, 255, 255, 255)
        SetTextDropShadow(0, 0, 0, 0,255)
        SetTextEdge(4, 0, 0, 0, 255)
		SetTextOutline()
		SetTextJustification(0)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(0.89, 0.96)
	end
