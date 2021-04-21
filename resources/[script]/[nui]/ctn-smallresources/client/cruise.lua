local cruiseOn = false
local Speed = 0.0
local cruiseSpeed = 0.0
local lastVehicle = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(7)
        if IsPedInAnyVehicle(GetPlayerPed(-1)) then
            Speed = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1)))

            if IsControlJustReleased(0, Keys["Z"]) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1)), -1) == GetPlayerPed(-1) then 
                if IsPedInAnyVehicle(GetPlayerPed(-1)) then
                    cruiseSpeed = Speed
                    if cruiseOn then
                        QBCore.Functions.Notify("Cruise Deactivated")
                    else
                        QBCore.Functions.Notify("Cruise Activated")
                    end
                    TriggerEvent("seatbelt:client:ToggleCruise")
                end
            end
        elseif lastVehicle ~= nil then
            local maxSpeed = GetVehicleHandlingFloat(lastVehicle,"CHandlingData","fInitialDriveMaxFlatVel")
            SetEntityMaxSpeed(lastVehicle, maxSpeed)
            lastVehicle = nil
            Citizen.Wait(1500)
        end
    end
end)

RegisterNetEvent("seatbelt:client:ToggleCruise")
AddEventHandler("seatbelt:client:ToggleCruise", function()
    cruiseOn = not cruiseOn
    local maxSpeed = cruiseOn and cruiseSpeed or GetVehicleHandlingFloat(GetVehiclePedIsIn(GetPlayerPed(-1), false),"CHandlingData","fInitialDriveMaxFlatVel")
    SetEntityMaxSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), maxSpeed)
    lastVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
end)

local button = 311

Citizen.CreateThread(function()
    while true do

        Citizen.Wait(0)
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

        if (IsControlJustReleased(0, button) or IsDisabledControlJustReleased(0, button)) and vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
            toggleEngine()
        end
    end
end)

function toggleEngine()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= nil and vehicle ~= 0 then

        if (GetPedInVehicleSeat(vehicle, -1) == GetPlayerPed(-1)) then

            if IsVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false)) then
                SetVehicleEngineOn(vehicle, false, false, true)
                QBCore.Functions.Notify("Engine Halted")
            else
                SetVehicleEngineOn(vehicle, true, false, true)
                QBCore.Functions.Notify("Engine Started")
            end
        end
    end
end