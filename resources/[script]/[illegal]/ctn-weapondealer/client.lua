local PlayerData, OS = nil, nil
local NPC = Config.NPC


Citizen.CreateThread(function()
	while OS == nil do
		TriggerEvent(Config.CoreName.. ':GetObject', function(obj) OS = obj end)
		Citizen.Wait(200)
    end
    
    PlayerData = OS.Functions.GetPlayerData()

    for _, v in pairs(NPC) do
        RequestModel(GetHashKey(v.model))
        while not HasModelLoaded(GetHashKey(v.model)) do
            Wait(5)
        end
        local npc = CreatePed(4, v.model, v.x, v.y, v.z, v.h,  false, true)
        SetPedFleeAttributes(npc, 0, 0)
        SetPedDropsWeaponsWhenDead(npc, false)
        SetPedDiesWhenInjured(npc, false)
        SetEntityInvincible(npc , true)
        FreezeEntityPosition(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        if v.seller then 
            RequestAnimDict("missfbi_s4mop")
            while not HasAnimDictLoaded("missfbi_s4mop") do
                Wait(5)
            end
            TaskPlayAnim(npc, "missfbi_s4mop" ,"guard_idle_a" ,8.0, 1, -1, 49, 0, false, false, false)
        end
    end

    
end)

CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        local coords = GetEntityCoords(plyPed)

        if PlayerData then

            local dealer = Config.Loc

            if (GetDistanceBetweenCoords(coords.x, coords.y, coords.z, dealer.x, dealer.y, dealer.z, true) < 5) then
                 if (GetDistanceBetweenCoords(coords.x, coords.y, coords.z, dealer.x, dealer.y, dealer.z, true) < 1.0) then
                    DrawText3D(dealer.x, dealer.y, dealer.z, Config.text)
                    if IsControlJustReleased(0, 38) then 
                        TriggerServerEvent("inventory:server:OpenInventory", "shop", "dealer", Config.Weapons)
                    end
                end  
            end
        end

        Citizen.Wait(4)
    end
end)


CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        local coords = GetEntityCoords(plyPed)

        if PlayerData then

            local dealer2 = Config.Loc2

            if (GetDistanceBetweenCoords(coords.x, coords.y, coords.z, dealer2.x, dealer2.y, dealer2.z, true) < 5) then
                 if (GetDistanceBetweenCoords(coords.x, coords.y, coords.z, dealer2.x, dealer2.y, dealer2.z, true) < 1.0) then
                    DrawText3D(dealer2.x, dealer2.y, dealer2.z, Config.text)
                    if IsControlJustReleased(0, 38) then 
                        TriggerServerEvent("inventory:server:OpenInventory", "shop", "dealer2", Config.Weapons2)
                    end
                end  
            end
        end

        Citizen.Wait(4)
    end
end)

CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        local coords = GetEntityCoords(plyPed)

        if PlayerData then

            local dealer3 = Config.Loc3

            if (GetDistanceBetweenCoords(coords.x, coords.y, coords.z, dealer3.x, dealer3.y, dealer3.z, true) < 5) then
                 if (GetDistanceBetweenCoords(coords.x, coords.y, coords.z, dealer3.x, dealer3.y, dealer3.z, true) < 1.0) then
                    DrawText3D(dealer3.x, dealer3.y, dealer3.z, Config.text)
                    if IsControlJustReleased(0, 38) then 
                        TriggerServerEvent("inventory:server:OpenInventory", "shop", "dealer3", Config.Weapons3)
                    end
                end  
            end
        end

        Citizen.Wait(4)
    end
end)

CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        local coords = GetEntityCoords(plyPed)

        if PlayerData then

            local dealer4 = Config.Loc4

            if (GetDistanceBetweenCoords(coords.x, coords.y, coords.z, dealer4.x, dealer4.y, dealer4.z, true) < 5) then
                 if (GetDistanceBetweenCoords(coords.x, coords.y, coords.z, dealer4.x, dealer4.y, dealer4.z, true) < 1.0) then
                    DrawText3D(dealer4.x, dealer4.y, dealer4.z, Config.text)
                    if IsControlJustReleased(0, 38) then 
                        TriggerServerEvent("inventory:server:OpenInventory", "shop", "dealer4", Config.Weapons4)
                    end
                end  
            end
        end

        Citizen.Wait(4)
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
    ClearDrawOrigin()
end