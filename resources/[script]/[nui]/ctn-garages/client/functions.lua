QBCore = nil
local  createdBlips = {}
playerCid = nil
Citizen.CreateThread(function()
    SetNuiFocus(false, false)
    while true do
        Citizen.Wait(10)
        if QBCore == nil then
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            Citizen.Wait(200)
        end
    end
end)

CTNGarages = {}
CTNGarages.Config = {}
CTNGarages.Functions = {
    TriggerNUI = (function(onVehicle, name, data, key)
        if key == 'garages' or key == 'houses' then
            QBCore.Functions.TriggerCallback('ctn-garages:server:getOwnedVehicles', function(vehicles)
                while not vehicles do Wait(0) end
    
                if onVehicle then
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    local vehicleProps = QBCore.Functions.GetVehicleProperties(vehicle)
                    QBCore.Functions.TriggerCallback('ctn-garages:server:isVehicleOwned', function(owned)
                        if owned then
                            SendNUIMessage({
                                open = true,
                                type = "open-garage",
                                key = key,
                                vehicles = vehicles,
                                slots = math.ceil(((#CTNGarages.Functions.GetFreeSlots(name, key) * 100) / #CTNGarages.Config[key][name]['slots'])),
                                garage = name,
                                vehicledata = {true, string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))), CTNGarages.Config[key][name]['payment']}
                            })
                        else
                            SendNUIMessage({
                                open = true,
                                type = "open-garage",
                                key = key,
                                vehicles = vehicles,
                                slots = math.ceil(((#CTNGarages.Functions.GetFreeSlots(name, key) * 100) / #CTNGarages.Config[key][name]['slots'])),
                                garage = name,
                                vehicledata = {false}
                            })
                        end
                    end, GetVehicleNumberPlateText(vehicle))
                else
                    SendNUIMessage({
                        open = true,
                        type = "open-garage",
                        key = key,
                        vehicles = vehicles,
                        slots = math.ceil(((#CTNGarages.Functions.GetFreeSlots(name, key) * 100) / #CTNGarages.Config[key][name]['slots'])),
                        garage = name
                    })
                end
                SetNuiFocus(true, true)
            end, CTNGarages.Functions.GetNearbyVehicles(true), #CTNGarages.Functions.GetFreeSlots(name, key), name, key)
        elseif key == 'impounds' then
            QBCore.Functions.TriggerCallback('ctn-garages:server:hasFines', function(hasfines)
                if hasfines == false then
                    QBCore.Functions.TriggerCallback('ctn-garages:server:getImpoundedVehicles', function(vehicles)
                        while not vehicles do Wait(0) end
            
                        SendNUIMessage({
                            open = true,
                            type = "open-impound",
                            key = key,
                            vehicles = vehicles,
                            impound = name,
                        })
                        SetNuiFocus(true, true)
                    end, name)
                else
                    TriggerEvent('QBCore:Notify', 'You got some unpaid fines! We aren\'t supporting it here!', "error")
                end
            end)
        end
    end),

    GetFreeSlotsOLD = (function(slots)
        local freeSlots = {}
        for key, slot in pairs(slots) do
            if slot[2] == true then
                table.insert(freeSlots, key)
            end
        end
        return freeSlots
    end),

    CreateBlips = function()
        for key, value in pairs(CTNGarages.Config) do
            if key == 'garages' or key == 'impounds' then
                for name, data in pairs(value) do
                    if data['blip']['enable'] == true then
                        local blip = AddBlipForCoord(data['blip']['coords'].x, data['blip']['coords'].y, data['blip']['coords'].z)
                        SetBlipSprite(blip, CTNGarages.Config['settings']['blip'][data['blip']['type']][2])
                        SetBlipDisplay(blip, CTNGarages.Config['settings']['blip'][data['blip']['type']][3])
                        SetBlipScale(blip, CTNGarages.Config['settings']['blip'][data['blip']['type']][4])
                        SetBlipColour(blip, CTNGarages.Config['settings']['blip'][data['blip']['type']][1])
                        SetBlipAsShortRange(blip, true)
                    
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString(name)
                        EndTextCommandSetBlipName(blip)
                    
                        table.insert(createdBlips, blip)
                    end
                end
            elseif key == 'houses' then
                for name, data in pairs(value) do
                    if CTNGarages.Functions.HasHouseAccess(name) == true then
                        local blip = AddBlipForCoord(data['coords'].x, data['coords'].y, data['coords'].z)
                        SetBlipSprite(blip, CTNGarages.Config['settings']['blip']['house'][2])
                        SetBlipDisplay(blip, CTNGarages.Config['settings']['blip']['house'][3])
                        SetBlipScale(blip, CTNGarages.Config['settings']['blip']['house'][4])
                        SetBlipColour(blip, CTNGarages.Config['settings']['blip']['house'][1])
                        SetBlipAsShortRange(blip, true)
                    
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString(name)
                        EndTextCommandSetBlipName(blip)
                    
                        table.insert(createdBlips, blip)
                    end
                end
            end
        end
    end,

    HasHouseAccess = function(house)
        for key, value in pairs(CTNGarages.Config['houses'][house]['access']) do
            if value == playerCid then
                return true
            end
        end

        return false
    end,

    DeleteBlips = function()
        for k, v in pairs(createdBlips) do
            RemoveBlip(v)
        end
    end,

    DrawText3D = (function(vector, text)
        local onScreen, _x,_y = World3dToScreen2d(vector.x, vector.y, vector.z)
        local px,py,pz = table.unpack(GetGameplayCamCoords())
        local scale = 0.30
        if onScreen then
            SetTextScale(scale, scale)
            SetTextFont(4)
            SetTextProportional(1)
            SetTextColour(255, 255, 255, 215)
            SetTextOutline()
            SetTextEntry("STRING")
            SetTextCentre(1)
            AddTextComponentString(text)
            DrawText(_x,_y)
        end
    end),

    GetNearbyVehicles = (function(plates)
        local playerPed = PlayerPedId()
        local nearbyVehicles = QBCore.Functions.GetVehicles()
        local nearbyPlates = {}
        for k, v in pairs(nearbyVehicles) do
            if #(GetEntityCoords(v) - GetEntityCoords(playerPed)) < 10.0 then
                if plates == true then
                    table.insert(nearbyPlates, GetVehicleNumberPlateText(v))
                else
                    table.insert(nearbyPlates, {v, GetVehicleNumberPlateText(v)})
                end
            end
        end
        return nearbyPlates
    end),

    IsSpawnClear = (function(coords, area)
        local vehicles = QBCore.Functions.GetVehicles()
        local vehiclesInArea = {}
    
        for i=1, #vehicles, 1 do
            local vehicleCoords = GetEntityCoords(vehicles[i])
            local distance = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)
    
            if distance <= area then
                table.insert(vehiclesInArea, vehicles[i])
            end
        end
        
        return #vehiclesInArea == 0
    end),

    GetClosestImpound = (function()
        local ped = PlayerPedId()
        local closestImpound = {10000.0}
        for k, v in pairs(CTNGarages.Config['impounds']) do
            local coords = GetEntityCoords(ped)
            local dst = #(v['blip']['coords'] - coords) 
            if dst < closestImpound[1] then
                closestImpound = {dst, v['blip']['coords']}
            end
        end
    
        return closestImpound
    end),
    
    GetClosestGarage = (function()
        local ped = PlayerPedId()
        local closestImpound = {10000.0}
        for k, v in pairs(CTNGarages.Config['garages']) do
            local coords = GetEntityCoords(ped)
            local dst = #(vector3(v['blip']['coords'].x ,v['blip']['coords'].y ,v['blip']['coords'].z) - coords) 
            if dst < closestImpound[1] then
                closestImpound = {dst, k}
            end
        end
    
        return closestImpound
    end),
    
    GetFreeSlots = (function(name, typ)
        local slots = CTNGarages.Config[typ][name]['slots']
        local counter = {}
        for k, v in pairs(slots) do
            if v[2] == true then
                table.insert(counter, k)
            end
        end
        return counter
    end),

    DeletePlayerVehicle = (function(plate)
        local stats = {}
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            stats = {
                ["engine_damage"] = GetVehicleEngineHealth(veh), 
                ["body_damage"] = GetVehicleBodyHealth(veh), 
                ["fuel"] = GetVehicleFuelLevel(veh), 
                ["dirty"] = GetVehicleDirtLevel(veh),
            }
            QBCore.Functions.DeleteVehicle(veh)
        else
            local vehicles = CTNGarages.Functions.GetNearbyVehicles(false)
            for _, vehicle in pairs(vehicles) do
                if vehicle[2] == plate then
                    local veh = vehicle[1]
                    stats = {
                        ["engine_damage"] = GetVehicleEngineHealth(veh), 
                        ["body_damage"] = GetVehicleBodyHealth(veh), 
                        ["fuel"] = GetVehicleFuelLevel(veh), 
                        ["dirty"] = GetVehicleDirtLevel(veh),
                    }
                    QBCore.Functions.DeleteVehicle(veh)
                end
            end
        end
    
        return stats
    end),

    drawTxt = function(x, y, s, ss , text, red, green, blue, alpha)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(s, s)
        SetTextColour(red, green, blue, alpha)
        SetTextDropShadow(0, 0, 0, 0, 255)
        if ss then
            SetTextEdge(1, 0, 0, 0, 255)
        end
        SetTextDropShadow()
        SetTextOutline()
    
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayText(x, y - 1 / 2 - 0.065)
    end,

    playAnim = function()
        local ped = PlayerPedId()
        local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
        local animation = "machinic_loop_mechandplayer"
        if IsPedArmed(ped, 7) then
            SetCurrentPedWeapon(ped, 0xA2719263, true)
        end
    
        if IsEntityPlayingAnim(ped, animDict, animation, 3) then
            ClearPedSecondaryTask(ped)
        else
            CTNGarages.Functions.loadAnimDict(animDict)
            local animLength = GetAnimDuration(animDict, animation)
            TaskPlayAnim(PlayerPedId(), animDict, animation, 1.0, 4.0, animLength, 0, 0, 0, 0, 0)
        end
    end,

    loadAnimDict = function(dict)
        while not HasAnimDictLoaded(dict) do
            RequestAnimDict(dict)
            Citizen.Wait(5)
        end
    end,

    tprint = function(a,b) for c,d in pairs(a)do local e='["'..tostring(c)..'"]'if type(c)~='string'then e='['..c..']'end;local f='"'..tostring(d)..'"'if type(d)=='table'then tprint(d,(b or'')..e)else if type(d)~='string'then f=tostring(d)end;print(type(a)..(b or'')..e..' = '..f)end end end,
}