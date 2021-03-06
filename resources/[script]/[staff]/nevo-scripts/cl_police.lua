RegisterNetEvent('police:livery')
AddEventHandler('police:livery', function(livery)

    if not IsNearPoliceGarage() then
        return
    end

    local plyPed = PlayerPedId()
    if IsPedInAnyVehicle(plyPed) then
        local vehicle = GetVehiclePedIsIn(PlayerPedId())

        if GetVehicleLiveryCount(vehicle) == -1 then
            TriggerEvent('chatMessage', "SYSTEM", "error", 'Vehicle dont have any liveries')
            return
        end

        if livery and GetVehicleLiveryCount(vehicle) >= livery then
            SetVehicleLivery(vehicle, livery, true)
            return
        else
            TriggerEvent('chatMessage', "Available Liveries", "error", GetVehicleLiveryCount(vehicle))
            return
        end
    
    else
        TriggerEvent('chatMessage', "SYSTEM", "error", 'You have to be in vehicle')
        return
    end
end)

RegisterNetEvent('police:extras')
AddEventHandler('police:extras', function(extra)

    if not IsNearPoliceGarage() then
        return
    end

    local plyPed = PlayerPedId()
    if IsPedInAnyVehicle(plyPed) then
        local vehicle = GetVehiclePedIsIn(PlayerPedId())

        if extra == 'help' then
            local total = 0
            for id = 0, 12 do
                if DoesExtraExist(vehicle, id) then
                    total = total + 1
                end
            end

            TriggerEvent("debug", 'Police: Available Extras ' .. total, 'success')

            TriggerEvent('chatMessage', "Available Extras", "error", total)

            return
        end

        if extra == 'all' then
            for id = 0, 12 do
                if DoesExtraExist(vehicle, id) then
                    SetVehicleExtra(vehicle, id, false)
                end
            end

            TriggerEvent("debug", 'Police: Enable All Extras', 'success')


            return
        end

        if extra == 'remove' then
            for id = 0, 12 do
                if DoesExtraExist(vehicle, id) then
                    SetVehicleExtra(vehicle, id, true)
                end
            end

            TriggerEvent("debug", 'Police: Disable All Extras', 'error')

            return
        end

        if DoesExtraExist(vehicle, extra) then
            if IsVehicleExtraTurnedOn(vehicle, extra)  then
                SetVehicleExtra(vehicle, extra, true)
                TriggerEvent("debug", 'Police: Disable Extra ' .. extra, 'error')
            else
                SetVehicleExtra(vehicle, extra, false)
                TriggerEvent("debug", 'Police: Enable Extra ' .. extra, 'success')
            end
        else
            TriggerEvent('chatMessage', "SYSTEM", "error", 'Invaild Vehicle Extra')
            return
		end

    else
        TriggerEvent('chatMessage', "SYSTEM", "error", 'You have to be in vehicle')
        return
    end
end)

RegisterNetEvent('police:fix')
AddEventHandler('police:fix', function()
    if not IsNearPoliceGarage() then
        return
    end

    if IsPedInAnyVehicle(PlayerPedId()) then
	    local ped = GetPlayerPed(-1)
		local veh = GetVehiclePedIsIn(ped)
        FreezeEntityPosition(veh, true)
		Progressbar(15000,"Fixing Vehicle")
        SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId()))
        TriggerEvent('chatMessage', "SYSTEM", "error", 'Fixed!')
		FreezeEntityPosition(veh, false)
    else
        TriggerEvent('chatMessage', "SYSTEM", "error", 'You have to be in vehicle')
        return
    end
end)

RegisterNetEvent('police:windowtint')
AddEventHandler('police:windowtint', function(num)
    if not IsNearPoliceGarage() then
        return
    end

    if IsPedInAnyVehicle(PlayerPedId()) then
        local props = QBCore.Functions.GetVehicleProperties(GetVehiclePedIsIn(PlayerPedId()))
        props["modEngine"] = 3
        props['windowTint'] = num
        QBCore.Functions.SetVehicleProperties(GetVehiclePedIsIn(PlayerPedId()), props)
        SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId()))
        TriggerEvent('chatMessage', "SYSTEM", "error", 'Installed!')
    else
        TriggerEvent('chatMessage', "SYSTEM", "error", 'You have to be in vehicle')
        return
    end
end)

RegisterNetEvent('police:chatMessage')
AddEventHandler('police:chatMessage', function(data, data2)
    if not QBCore or not QBCore.Functions.GetPlayerData().job or QBCore.Functions.GetPlayerData().job.name ~= 'police' and not QBCore.Functions.GetPlayerData().job.onduty then
        return
    end
    if not QBCore or not QBCore.Functions.GetPlayerData().job or QBCore.Functions.GetPlayerData().job.name ~= 'gendarme' and not QBCore.Functions.GetPlayerData().job.onduty then
        return
    end

    if QBCore.Functions.GetPlayerData().job.name == 'police' then
        TriggerEvent('chatMessage', "Police Chat - "..data, "report", data2)
    elseif QBCore.Functions.GetPlayerData().job.name == 'gendarme' then
        TriggerEvent('chatMessage', "Gendarme Chat - "..data, "report", data2)
    end

end)

RegisterNetEvent('police:evidence')
AddEventHandler('police:evidence', function(box)
    if not CanOpenEvidence() or not box then
        return
    end

    TriggerServerEvent("inventory:server:OpenInventory", "stash", "evidence_" .. box, {
        maxweight = 4000000,
        slots = 500,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "evidence_" .. box)
end)

RegisterNetEvent('police:unmask')
AddEventHandler('police:unmask', function(box)
    if not CanOpenEvidence() or not box then
        return
    end

    TriggerServerEvent("inventory:server:OpenInventory", "stash", "evidence_" .. box, {
        maxweight = 4000000,
        slots = 500,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "evidence_" .. box)
end)

RegisterNetEvent('police:unmask')
AddEventHandler('police:unmask', function()
	local t, distance = GetClosestPlayer()
    if (distance ~= -1 and distance < 5) then

        if not IsPedInVehicle(t,GetVehiclePedIsIn(t, false),false) then
			TriggerServerEvent("police:unmaskGranted", GetPlayerServerId(t))
			AnimSet = "mp_missheist_ornatebank"
			AnimationOn = "stand_cash_in_bag_intro"
			AnimationOff = "stand_cash_in_bag_intro"
			loadAnimDict( AnimSet )
			TaskPlayAnim( PlayerPedId(), AnimSet, AnimationOn, 8.0, -8, -1, 49, 0, 0, 0, 0 )
			Citizen.Wait(500)
			ClearPedTasks(PlayerPedId())						
		end
	else
		TriggerEvent("QBCore:Notify", "No player near you (maybe get closer)!", "error")
	end
end)

RegisterNetEvent('police:unmaskAccepted')
AddEventHandler('police:unmaskAccepted', function()
    TriggerEvent('clothing:setupCommandsData')

    loadAnimDict("missheist_agency2ahelmet")
    TaskPlayAnim(PlayerPedId(), "missheist_agency2ahelmet", "take_off_helmet_stand", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(800)
    SetPedComponentVariation(PlayerPedId(), 1, -1, -1, -1)
    ClearPedProp(PlayerPedId(), 0)
    ClearPedTasks(PlayerPedId())
end)

local PoliceGarages = {
    { ['x'] = 439.5728, ['y'] = -1022.443, ['z'] = 28.63, ['h'] = 89.56 },
    { ['x'] = -459.241, ['y'] = 6002.0151, ['z'] = 31.342147, ['h'] = 200.63348 },
    { ['x'] = -439.5925, ['y'] = 6029.1791, ['z'] = 31.340551, ['h'] = 274.22802 },
    { ['x'] = 1855.5954, ['y'] = 3674.6323, ['z'] = 33.661075, ['h'] = 30.010299 },
    { ['x'] = 1855.0419, ['y'] = 2587.0893, ['z'] = 45.106185, ['h'] = 110.52773 },
}

function IsNearPoliceGarage()
    local plyPed = PlayerPedId()
    local plyCoords = GetEntityCoords(plyPed)

    for k,v in pairs(PoliceGarages) do
        local distance = GetDistanceBetweenCoords(plyCoords.x, plyCoords.y,plyCoords.z, v.x, v.y, v.z)
        if distance < 40 then
            return true
        end
    end

    return false
end

local PoliceEvidence = {
    [1] = { ['x'] = 472.83, ['y'] = -1008.44, ['z'] = 34.21 },
    [2] = {x = -439.09, y = 6003.12, z = 31.84 },
    [3] =  { ['x'] = 472.13, ['y'] = -1005.6, ['z'] = 34.21 },
    [4] = {x = -439.54, y = 6011.42, z = 27.98 },
    [5] = {x = 1855.66, y = 3699.20, z = 34.26 },
    [6] = {x = -439.43, y = 6009.45, z = 27.98 },
}

function CanOpenEvidence()
    local plyPed = PlayerPedId()
    local plyCoords = GetEntityCoords(plyPed)
    local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
    local vehicle = QBCore.Functions.GetClosestVehicle()

    --[[
    if vehicle ~= 0 and vehicle ~= nil then
        local pos = GetEntityCoords(GetPlayerPed(-1))
        local vehpos = GetEntityCoords(vehicle)
        local newpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
        local disatance = GetDistanceBetweenCoords(plyCoords.x, plyCoords.y,plyCoords.z,newpos.x, newpos.y, newpos.z)
        if disatance < 2 then
            return true
        end
    end]]

    for k,v in pairs(PoliceEvidence) do
        local distance = GetDistanceBetweenCoords(plyCoords.x, plyCoords.y,plyCoords.z,v.x, v.y, v.z)
        if distance < 2.5 then
            return true
        end
    end

    return false
end

function isOppositeDir(a,b)
	local result = 0 
	if a < 90 then
		a = 360 + a
	end
	if b < 90 then
		b = 360 + b
	end	
	if a > b then
		result = a - b
	else
		result = b - a
	end
	if result > 110 then
		return true
	else
		return false
	end
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function Progressbar(duration, label)
	local retval = nil
	QBCore.Functions.Progressbar("drugs", label, duration, false, false, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = false,
	}, {}, {}, {}, function()
		retval = true
	end, function()
		retval = false
	end)

	while retval == nil do
		Wait(1)
	end

	return retval
end

function GetClosestPlayer()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(GetPlayerPed(-1))

    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
	end

	return closestPlayer, closestDistance
end

Vehicles = {
    { model = "police5", label = "4X4"},
    { model = "polnspeedo", label = "Stafit"},
}

Vehicles2 = {
    { model = "pranger", label = "Jeep"},
    { model = "polgs350", label = "Lexus"},
    { model = "r1200rtp", label = "Motard"},
    { model = "psp_mbsprinter", label = "Stafit"},
}

RegisterNetEvent('police:sv')
AddEventHandler('police:sv', function(index)

    if not IsNearPoliceGarage() then
        return
    end

    if index == 'help' then
        local str = ""
        local last = true
        for i=1,#Vehicles do
            local vehicle = Vehicles[i]
            if last then
                str = str .. '  '
            else
                str = str .. '  '
            end
            str = str .. i .. '. ' .. vehicle.label.. ' / '
            last = not last
        end

        TriggerEvent('chatMessage', "Police Vehicles", "error", str)
    elseif Vehicles[tonumber(index)] then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local head = GetEntityHeading(ped)
        local radhead = math.rad(head)
        local model = GetHashKey(Vehicles[tonumber(index)]['model'])
        local newpos = {x = pos.x-math.sin(radhead)*3, y = pos.y+math.cos(radhead)*3, z = pos.z}
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(1)
        end
        local veh = CreateVehicle(model, newpos.x, newpos.y, newpos.z, head, true, true)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh), veh)
		SetVehicleExtra(veh, 1, true)
        SetVehicleExtra(veh, 2, true)
		SetVehicleExtra(veh, 3, true)
		SetVehicleExtra(veh, 4, true)
		SetVehicleExtra(veh, 5, true)
		SetVehicleExtra(veh, 6, true)
		SetVehicleExtra(veh, 7, true)
		SetVehicleExtra(veh, 8, true)
		SetVehicleExtra(veh, 9, true)
		SetVehicleExtra(veh, 10, true)
		SetVehicleExtra(veh, 11, true)
		SetVehicleExtra(veh, 12, true)
		SetVehicleDirtLevel(veh, 0.0)
		WashDecalsFromVehicle(veh, 1.0)
		exports['ctn-hud']:SetFuel(veh, 99)
        SetVehicleEngineOn(veh, true, true)
    end
end)



RegisterNetEvent('gendarme:sv')
AddEventHandler('gendarme:sv', function(index)

    if not IsNearPoliceGarage() then
        return
    end

    if index == 'help' then
        local str = ""
        local last = true
        for i=1,#Vehicles do
            local vehicle = Vehicles2[i]
            if last then
                str = str .. '  '
            else
                str = str .. '  '
            end
            str = str .. i .. '. ' .. vehicle.label.. ' / '
            last = not last
        end

        TriggerEvent('chatMessage', "Gendarme Vehicles", "error", str)
    elseif Vehicles2[tonumber(index)] then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local head = GetEntityHeading(ped)
        local radhead = math.rad(head)
        local model = GetHashKey(Vehicles2[tonumber(index)]['model'])
        local newpos = {x = pos.x-math.sin(radhead)*3, y = pos.y+math.cos(radhead)*3, z = pos.z}
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(1)
        end
        local veh = CreateVehicle(model, newpos.x, newpos.y, newpos.z, head, true, true)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh), veh)
		SetVehicleExtra(veh, 1, true)
        SetVehicleExtra(veh, 2, true)
		SetVehicleExtra(veh, 3, true)
		SetVehicleExtra(veh, 4, true)
		SetVehicleExtra(veh, 5, true)
		SetVehicleExtra(veh, 6, true)
		SetVehicleExtra(veh, 7, true)
		SetVehicleExtra(veh, 8, true)
		SetVehicleExtra(veh, 9, true)
		SetVehicleExtra(veh, 10, true)
		SetVehicleExtra(veh, 11, true)
		SetVehicleExtra(veh, 12, true)
		SetVehicleDirtLevel(veh, 0.0)
		WashDecalsFromVehicle(veh, 1.0)
		exports['ctn-hud']:SetFuel(veh, 99)
        SetVehicleEngineOn(veh, true, true)
    end
end)