QBCore = nil
local display = false

CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Wait(5)
    end
end)

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

local coords =


RegisterNUICallback("order", function(data)
    print(data.item.. " : " ..data.amount.. ": $ " ..data.price)
    TriggerServerEvent('ctn-blackmarket:makeorder', data)
end)


-- ITEM USABLE

RegisterNUICallback("exit", function(data)
    open(false)
end)

function open(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end


RegisterCommand('blackmarket', function()
    open(true)

end)
CreateThread(function()
    while display do
        Wait(0)
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)

RegisterCommand('gold', function()
    knockDoorAnim()
end)

function knockDoorAnim()
    local knockAnimLib = "timetable@jimmy@doorknock@"
    local knockAnim = "knockdoor_idle"
    local PlayerPed = GetPlayerPed(-1)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "knock_door", 0.2)
    Wait(100)
    while (not HasAnimDictLoaded(knockAnimLib)) do
        RequestAnimDict(knockAnimLib)
        Wait(100)
    end
    TaskPlayAnim(PlayerPed, knockAnimLib, knockAnim, 3.0, 3.0, -1, 1, 0, false, false, false )
    Wait(3500)
    TaskPlayAnim(PlayerPed, knockAnimLib, "exit", 3.0, 3.0, -1, 1, 0, false, false, false)
    Wait(1000)
    open(true)
end


local ped = PlayerPedId()


CreateThread(function()
    while true do
        local Pos = GetEntityCoords(ped)
        local distance = #(vector3(1315.0535888672,-1684.9399414062,58.232936859131) - vector3(Pos))
        if distance < 3 then
            DrawText3D(1315.0535888672,-1684.9399414062,58.232936859131, '~g~E~s~ - To Open BlackMarket')
            if IsControlJustPressed(0, 38) then
                knockDoorAnim()
            end
        end
        Wait(5)
    end
end)