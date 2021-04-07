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

isLoggedIn = false
local PlayerGang = {}


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerGang = QBCore.Functions.GetPlayerData().gang
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate')
AddEventHandler('QBCore:Client:OnGangUpdate', function(GangInfo)
    PlayerGang = GangInfo
end)

-- Code
function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-- revenger

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if isLoggedIn and QBCore ~= nil then
            local pos = GetEntityCoords(GetPlayerPed(-1))
            if PlayerGang.name == "revenger" then
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["ogcarspawnrevenger"].coords.x, Config.Locations["ogcarspawnrevenger"].coords.y, Config.Locations["ogcarspawnrevenger"].coords.z, true) < 10.0) then
                    DrawMarker(2, Config.Locations["ogcarspawnrevenger"].coords.x, Config.Locations["ogcarspawnrevenger"].coords.y, Config.Locations["ogcarspawnrevenger"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["ogcarspawnrevenger"].coords.x, Config.Locations["ogcarspawnrevenger"].coords.y, Config.Locations["ogcarspawnrevenger"].coords.z, true) < 1.5) then
                        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                            DrawText3D(Config.Locations["ogcarspawnrevenger"].coords.x, Config.Locations["ogcarspawnrevenger"].coords.y, Config.Locations["ogcarspawnrevenger"].coords.z, "~g~E~w~ - Store The Vehicle")
                        else
                            DrawText3D(Config.Locations["ogcarspawnrevenger"].coords.x, Config.Locations["ogcarspawnrevenger"].coords.y, Config.Locations["ogcarspawnrevenger"].coords.z, "~g~E~w~ - Kharaj A Vehicle")
                        end
                        if IsControlJustReleased(0, Keys["E"]) then
                            if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
                            else
                                ogVehicleSpawnrevenger()
                                Menu.hidden = not Menu.hidden
                            end
                        end
                        Menu.renderGUI()
                    end 
                end
            else
                Citizen.Wait(2500)
            end
        else
            Citizen.Wait(2500)
        end
    end
end)


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if isLoggedIn and QBCore ~= nil then
            local pos = GetEntityCoords(GetPlayerPed(-1))
            if PlayerGang.name == "revenger" then
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["stashrevenger"].coords.x, Config.Locations["stashrevenger"].coords.y, Config.Locations["stashrevenger"].coords.z, true) < 10.0) then
                    DrawMarker(2, Config.Locations["stashrevenger"].coords.x, Config.Locations["stashrevenger"].coords.y, Config.Locations["stashrevenger"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["stashrevenger"].coords.x, Config.Locations["stashrevenger"].coords.y, Config.Locations["stashrevenger"].coords.z, true) < 1.5) then
                            DrawText3D(Config.Locations["stashrevenger"].coords.x, Config.Locations["stashrevenger"].coords.y, Config.Locations["stashrevenger"].coords.z, "~g~E~w~ - Use The Stash Here ")
                        if IsControlJustReleased(0, Keys["E"]) then
                            print('nonce')
                            TriggerServerEvent("inventory:server:OpenInventory", "stash", "revengertash", {
                                maxweight = 4000000,
                                slots = 500,
                            })
                            TriggerEvent("inventory:client:SetCurrentStash", "revengertash")
                            end
                        end
                end
            else
                Citizen.Wait(2500)
            end
        else
            Citizen.Wait(2500)
        end
    end
end)

----bratva-----

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if isLoggedIn and QBCore ~= nil then
            local pos = GetEntityCoords(GetPlayerPed(-1))
            if PlayerGang.name == "bratva" then
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["ogcarspawnbratva"].coords.x, Config.Locations["ogcarspawnbratva"].coords.y, Config.Locations["ogcarspawnbratva"].coords.z, true) < 10.0) then
                    DrawMarker(2, Config.Locations["ogcarspawnbratva"].coords.x, Config.Locations["ogcarspawnbratva"].coords.y, Config.Locations["ogcarspawnbratva"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["ogcarspawnbratva"].coords.x, Config.Locations["ogcarspawnbratva"].coords.y, Config.Locations["ogcarspawnbratva"].coords.z, true) < 1.5) then
                        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                            DrawText3D(Config.Locations["ogcarspawnbratva"].coords.x, Config.Locations["ogcarspawnbratva"].coords.y, Config.Locations["ogcarspawnbratva"].coords.z, "~g~E~w~ - Store The Vehicle")
                        else
                            DrawText3D(Config.Locations["ogcarspawnbratva"].coords.x, Config.Locations["ogcarspawnbratva"].coords.y, Config.Locations["ogcarspawnbratva"].coords.z, "~g~E~w~ - Remove A Vehicle")
                        end
                        if IsControlJustReleased(0, Keys["E"]) then
                            if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
                            else
                                ogVehicleSpawnbratva()
                                Menu.hidden = not Menu.hidden
                            end
                        end
                        Menu.renderGUI()
                    end 
                end
            else
                Citizen.Wait(2500)
            end
        else
            Citizen.Wait(2500)
        end
    end
end)


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if isLoggedIn and QBCore ~= nil then
            local pos = GetEntityCoords(GetPlayerPed(-1))
            if PlayerGang.name == "bratva" then
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["stashbratva"].coords.x, Config.Locations["stashbratva"].coords.y, Config.Locations["stashbratva"].coords.z, true) < 10.0) then
                    DrawMarker(2, Config.Locations["stashbratva"].coords.x, Config.Locations["stashbratva"].coords.y, Config.Locations["stashbratva"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["stashbratva"].coords.x, Config.Locations["stashbratva"].coords.y, Config.Locations["stashbratva"].coords.z, true) < 1.5) then
                            DrawText3D(Config.Locations["stashbratva"].coords.x, Config.Locations["stashbratva"].coords.y, Config.Locations["stashbratva"].coords.z, "~g~E~w~ - Use The Stash Here ")
                        if IsControlJustReleased(0, Keys["E"]) then
                            TriggerServerEvent("inventory:server:OpenInventory", "stash", "bratvastash", {
                                maxweight = 4000000,
                                slots = 500,
                            })
                            TriggerEvent("inventory:client:SetCurrentStash", "bratvastash")
                            end
                        end
                end
            else
                Citizen.Wait(2500)
            end
        else
            Citizen.Wait(2500)
        end
    end
end)

-------sinaloa Gang-------

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if isLoggedIn and QBCore ~= nil then
            local pos = GetEntityCoords(GetPlayerPed(-1))
            if PlayerGang.name == "sinaloa" then
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["ogcarspawnsinaloa"].coords.x, Config.Locations["ogcarspawnsinaloa"].coords.y, Config.Locations["ogcarspawnsinaloa"].coords.z, true) < 10.0) then
                    DrawMarker(2, Config.Locations["ogcarspawnsinaloa"].coords.x, Config.Locations["ogcarspawnsinaloa"].coords.y, Config.Locations["ogcarspawnsinaloa"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["ogcarspawnsinaloa"].coords.x, Config.Locations["ogcarspawnsinaloa"].coords.y, Config.Locations["ogcarspawnsinaloa"].coords.z, true) < 1.5) then
                        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                            DrawText3D(Config.Locations["ogcarspawnsinaloa"].coords.x, Config.Locations["ogcarspawnsinaloa"].coords.y, Config.Locations["ogcarspawnsinaloa"].coords.z, "~g~E~w~ - Store The Vehicle")
                        else
                            DrawText3D(Config.Locations["ogcarspawnsinaloa"].coords.x, Config.Locations["ogcarspawnsinaloa"].coords.y, Config.Locations["ogcarspawnsinaloa"].coords.z, "~g~E~w~ - Remove A Vehicle")
                        end
                        if IsControlJustReleased(0, Keys["E"]) then
                            if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
                            else
                                ogVehicleSpawnsinaloa()
                                Menu.hidden = not Menu.hidden
                            end
                        end
                        Menu.renderGUI()
                    end 
                end
            else
                Citizen.Wait(2500)
            end
        else
            Citizen.Wait(2500)
        end
    end
end)


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if isLoggedIn and QBCore ~= nil then
            local pos = GetEntityCoords(GetPlayerPed(-1))
            if PlayerGang.name == "sinaloa"  then
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["stashsinaloa"].coords.x, Config.Locations["stashsinaloa"].coords.y, Config.Locations["stashsinaloa"].coords.z, true) < 10.0) then
                    DrawMarker(2, Config.Locations["stashsinaloa"].coords.x, Config.Locations["stashsinaloa"].coords.y, Config.Locations["stashsinaloa"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["stashsinaloa"].coords.x, Config.Locations["stashsinaloa"].coords.y, Config.Locations["stashsinaloa"].coords.z, true) < 1.5) then
                            DrawText3D(Config.Locations["stashsinaloa"].coords.x, Config.Locations["stashsinaloa"].coords.y, Config.Locations["stashsinaloa"].coords.z, "~g~E~w~ - Use The Stash Here ")
                        if IsControlJustReleased(0, Keys["E"]) then
                            TriggerServerEvent("inventory:server:OpenInventory", "stash", "sinaloatash", {
                                maxweight = 4000000,
                                slots = 500,
                            })
                            TriggerEvent("inventory:client:SetCurrentStash", "sinaloatash")
                            end
                        end
                end
            else
                Citizen.Wait(2500)
            end
        else
            Citizen.Wait(2500)
        end
    end
end)

-------Marabunta Gang-------

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if isLoggedIn and QBCore ~= nil then
            local pos = GetEntityCoords(GetPlayerPed(-1))
            if PlayerGang.name == "marabunta" then
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["ogcarspawnMarabunta"].coords.x, Config.Locations["ogcarspawnMarabunta"].coords.y, Config.Locations["ogcarspawnMarabunta"].coords.z, true) < 10.0) then
                    DrawMarker(2, Config.Locations["ogcarspawnMarabunta"].coords.x, Config.Locations["ogcarspawnMarabunta"].coords.y, Config.Locations["ogcarspawnMarabunta"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["ogcarspawnMarabunta"].coords.x, Config.Locations["ogcarspawnMarabunta"].coords.y, Config.Locations["ogcarspawnMarabunta"].coords.z, true) < 1.5) then
                        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                            DrawText3D(Config.Locations["ogcarspawnMarabunta"].coords.x, Config.Locations["ogcarspawnMarabunta"].coords.y, Config.Locations["ogcarspawnMarabunta"].coords.z, "~g~E~w~ - Store The Vehicle")
                        else
                            DrawText3D(Config.Locations["ogcarspawnMarabunta"].coords.x, Config.Locations["ogcarspawnMarabunta"].coords.y, Config.Locations["ogcarspawnMarabunta"].coords.z, "~g~E~w~ - Remove A Vehicle")
                        end
                        if IsControlJustReleased(0, Keys["E"]) then
                            if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
                            else
                                ogVehicleSpawnMarabunta()
                                Menu.hidden = not Menu.hidden
                            end
                        end
                        Menu.renderGUI()
                    end 
                end
            else
                Citizen.Wait(2500)
            end
        else
            Citizen.Wait(2500)
        end
    end
end)


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if isLoggedIn and QBCore ~= nil then
            local pos = GetEntityCoords(GetPlayerPed(-1))
            if PlayerGang.name == "marabunta" then
                if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["stashMarabunta"].coords.x, Config.Locations["stashMarabunta"].coords.y, Config.Locations["stashMarabunta"].coords.z, true) < 10.0) then
                    DrawMarker(2, Config.Locations["stashMarabunta"].coords.x, Config.Locations["stashMarabunta"].coords.y, Config.Locations["stashMarabunta"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Locations["stashMarabunta"].coords.x, Config.Locations["stashMarabunta"].coords.y, Config.Locations["stashMarabunta"].coords.z, true) < 1.5) then
                            DrawText3D(Config.Locations["stashMarabunta"].coords.x, Config.Locations["stashMarabunta"].coords.y, Config.Locations["stashMarabunta"].coords.z, "~g~E~w~ - Use The Stash Here ")
                        if IsControlJustReleased(0, Keys["E"]) then
                            TriggerServerEvent("inventory:server:OpenInventory", "stash", "Marabuntastash", {
                                maxweight = 4000000,
                                slots = 500,
                            })
                            TriggerEvent("inventory:client:SetCurrentStash", "Marabuntastash")
                            end
                        end
                end
            else
                Citizen.Wait(2500)
            end
        else
            Citizen.Wait(2500)
        end
    end
end)


function ogVehicleSpawnrevenger()
    ped = GetPlayerPed(-1);
    MenuTitle = "Garage"
    ClearMenu()
    Menu.addButton("Vehicle", "VehicleListrevenger", nil)
    Menu.addButton("Close menu", "closeMenuFull", nil) 
end

function ogVehicleSpawnsinaloa()
    ped = GetPlayerPed(-1);
    MenuTitle = "Garage"
    ClearMenu()
    Menu.addButton("Vehicle", "VehicleListsinaloa", nil)
    Menu.addButton("Close menu", "closeMenuFull", nil) 
end

function ogVehicleSpawnMarabunta()
    ped = GetPlayerPed(-1);
    MenuTitle = "Garage"
    ClearMenu()
    Menu.addButton("Vehicle", "VehicleListMarabunta", nil)
    Menu.addButton("Close menu", "closeMenuFull", nil) 
end

function ogVehicleSpawnbratva()
    ped = GetPlayerPed(-1);
    MenuTitle = "Garage"
    ClearMenu()
    Menu.addButton("Vehicle", "VehicleListbratva", nil)
    Menu.addButton("Close menu", "closeMenuFull", nil) 
end


function VehicleListrevenger(isDown)
    ped = GetPlayerPed(-1);
    MenuTitle = "Vehicle:"
    ClearMenu()
    for k, v in pairs(Config.Vehicles) do
        Menu.addButton(Config.Vehicles[k], "TakeOutVehiclerevenger", k, "Garage", " Engine: 100%", " Body: 100%", " Fuel: 100%")
    end
        
    Menu.addButton("Return", "ogVehicleSpawnrevenger",nil)
end


function VehicleListsinaloa(isDown)
    ped = GetPlayerPed(-1);
    MenuTitle = "Vehicle:"
    ClearMenu()
    for k, v in pairs(Config.Vehicles) do
        Menu.addButton(Config.Vehicles[k], "TakeOutVehiclesinaloa", k, "Garage", " Engine: 100%", " Body: 100%", " Fuel: 100%")
    end
        
    Menu.addButton("Return", "ogVehicleSpawnsinaloa",nil)
end


function VehicleListMarabunta(isDown)
    ped = GetPlayerPed(-1);
    MenuTitle = "Vehicle:"
    ClearMenu()
    for k, v in pairs(Config.Vehicles) do
        Menu.addButton(Config.Vehicles[k], "TakeOutVehicleMarabunta", k, "Garage", " Engine: 100%", " Body: 100%", " Fuel: 100%")
    end
        
    Menu.addButton("Return", "ogVehicleSpawnMarabunta",nil)
end


function VehicleListbratva(isDown)
    ped = GetPlayerPed(-1);
    MenuTitle = "Vehicle:"
    ClearMenu()
    for k, v in pairs(Config.Vehicles) do
        Menu.addButton(Config.Vehicles[k], "TakeOutVehiclebratva", k, "Garage", " Engine: 100%", " Body: 100%", " Fuel: 100%")
    end
        
    Menu.addButton("Return", "ogVehicleSpawnbratva",nil)
end

function TakeOutVehiclerevenger(vehicleInfo)
    local coords = Config.Locations["ogcarspawnrevenger"].coords
    QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
        SetVehicleNumberPlateText(veh, "OG"..tostring(math.random(1000, 9999)))
        local color = GetIsVehiclePrimaryColourCustom(veh)
        SetVehicleCustomPrimaryColour(veh, 108,11,184)
        SetVehicleCustomSecondaryColour(veh, 108,11,184)
        SetEntityHeading(veh, coords.h)
        exports['ctn-hud']:SetFuel(veh, 100.0)
        closeMenuFull()
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
        CurrentPlate = GetVehicleNumberPlateText(veh)
    end, coords, true)
end

function TakeOutVehiclesinaloa(vehicleInfo)
    local coords = Config.Locations["ogcarspawnsinaloa"].coords
    QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
        SetVehicleNumberPlateText(veh, "OG"..tostring(math.random(1000, 9999)))
        local color = GetIsVehiclePrimaryColourCustom(veh)
        SetVehicleCustomPrimaryColour(veh, 179,176,37)
        SetVehicleCustomSecondaryColour(veh, 0,0,0)
        SetEntityHeading(veh, coords.h)
        exports['ctn-hud']:SetFuel(veh, 100.0)
        closeMenuFull()
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
        CurrentPlate = GetVehicleNumberPlateText(veh)
    end, coords, true)
end

function TakeOutVehiclebratva(vehicleInfo)
    local coords = Config.Locations["ogcarspawnbratva"].coords
    QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
        SetVehicleNumberPlateText(veh, "OG"..tostring(math.random(1000, 9999)))
        local color = GetIsVehiclePrimaryColourCustom(veh)
        SetVehicleCustomPrimaryColour(veh, 0, 50, 0)
        SetVehicleCustomSecondaryColour(veh, 0, 0, 0)
        SetEntityHeading(veh, coords.h)
        exports['ctn-hud']:SetFuel(veh, 100.0)
        closeMenuFull()
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
        CurrentPlate = GetVehicleNumberPlateText(veh)
    end, coords, true)
end

function TakeOutVehicleMarabunta(vehicleInfo)
    local coords = Config.Locations["ogcarspawnMarabunta"].coords
    QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
        SetVehicleNumberPlateText(veh, "OG"..tostring(math.random(1000, 9999)))
        local color = GetIsVehiclePrimaryColourCustom(veh)
        SetVehicleCustomPrimaryColour(veh, 0, 65, 188)
        SetVehicleCustomSecondaryColour(veh, 0, 65, 188)
        SetEntityHeading(veh, coords.h)
        exports['ctn-hud']:SetFuel(veh, 100.0)
        closeMenuFull()
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
        CurrentPlate = GetVehicleNumberPlateText(veh)
    end, coords, true)
end

function closeMenuFull()
    Menu.hidden = true
    currentGarage = nil
    ClearMenu()
end

--End Of The Script

--Released On World Of Scripts By SBRULEZ#6969