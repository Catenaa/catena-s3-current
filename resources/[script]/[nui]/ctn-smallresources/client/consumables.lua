local alcoholCount = 0
local onWeed = false

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(10)
        if alcoholCount > 0 then
            Citizen.Wait(1000 * 60 * 15)
            alcoholCount = alcoholCount - 1
        else
            Citizen.Wait(2000)
        end
    end
end)

local Consumeables = {
    ["coffee"] = math.random(25, 50),
    ["latte"] = math.random(20, 40),
    ["capuchino"] = math.random(20, 40),
    ["frappuccino"] = math.random(20, 40),
    ["cocacola"] = math.random(15, 25),
    ["greencow"] = math.random(15, 25),
    ["spirte"] = math.random(15, 25),
    ["slushy"] = math.random(15, 27),
    ["orangeslushy"] = math.random(15, 27),
    ["greenslushy"] = math.random(15, 27),
    ["blueslushy"] = math.random(15, 27),
    ["yellowslushy"] = math.random(15, 27),
    ["taco"] = math.random(25, 50),
    ["fishtaco"] = math.random(20, 40),
    ["torpedo"] = math.random(20, 40),
    ["torta"] = math.random(20, 40),
    ["burrito"] = math.random(20, 40),
    ["eggsbacon"] = math.random(20, 40),
    ["churro"] = math.random(15, 25),
    ["donut"] = math.random(15, 25),
    ["waffle"] = math.random(15, 25),
    ["frenchtoast"] = math.random(15, 25),
    ["fries"] = math.random(20, 35),
    ["wings"] = math.random(20, 40),
    ["hotdog"] = math.random(20, 40),
    ["jailfood"] = math.random(25, 50),
    ["moneyshot"] = math.random(20, 40),
    ["heartstopper"] = math.random(20, 40),
    ["bleederburger"] = math.random(20, 40),
    ["meatfree"] = math.random(20, 40),
    ["fowlburger"] = math.random(20, 40),
    ["icecream"] = math.random(20, 25),
    ["mshake"] = math.random(20, 30),
    ["sandwich"] = math.random(20, 30),
    ["water_bottle"] = math.random(23, 46),
    ["toast"] = math.random(20, 35),
    ["burger"] = math.random(25, 50),
    ["twerks_candy"] = math.random(5, 15),
    ["snikkel_candy"] = math.random(5, 15),
    ["champagne"] = math.random(20, 45),
    ["whitewine"] = math.random(20, 40),
    ["whiskey"] = math.random(10, 25),
    ["beer"] = math.random(10, 25),
    ["tequila"] = math.random(10, 25),
    ["dusche"] = math.random(10, 25),
    ["pinacolada"] = math.random(10, 20),
    ["glasswhiskey"] = math.random(10, 20),
    ["glasswine"] = math.random(10, 20),
    ["glassbeer"] = math.random(10, 20),
    ["bloodymary"] = math.random(10, 20),
    ["glasschampagne"] = math.random(10, 20),
    ["tequilashot"] = math.random(10, 20),
    ["vodka"] = math.random(10, 20),
}

RegisterNetEvent("consumables:client:UseJoint")
AddEventHandler("consumables:client:UseJoint", function()
	SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
    QBCore.Functions.Progressbar("smoke_joint", "Smoking Joint", 2000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("debug", 'Consumables: Joint', 'success')
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["joint"], "remove")
        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            TriggerEvent('animations:client:EmoteCommandStart', {"smoke3"})
        else
            TriggerEvent('animations:client:EmoteCommandStart', {"weed"})
        end
        TriggerEvent("evidence:client:SetStatus", "weedsmell", 300)
		TriggerEvent("stress:timed",2000,"WORLD_HUMAN_SMOKING_POT")
    end)
end)

RegisterNetEvent("client:cigar")
AddEventHandler("client:cigar", function()
		SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
		Citizen.Wait(2000)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["cigar"], "remove")
        TriggerEvent('animations:client:EmoteCommandStart', {"cigar"})
end)

RegisterNetEvent("client:cigarette")
AddEventHandler("client:cigarette", function()
		SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
		Citizen.Wait(2000)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["ciggy"], "remove")
        TriggerEvent('animations:client:EmoteCommandStart', {"smoke"})
end)


RegisterNetEvent("stress:timed")
AddEventHandler("stress:timed",function(alteredValue,scenario)
	local removedStress = 0
	Wait(1000)

	QBCore.Functions.Notify("Stress is being relieved")
	while true do
		removedStress = removedStress + 100
		if removedStress >= alteredValue then
			break
		end
        local armor = GetPedArmour(PlayerPedId())
        SetPedArmour(PlayerPedId(),armor+3)
		if scenario ~= "None" then
			if not IsPedUsingScenario(PlayerPedId(),scenario) then
				TriggerEvent("animation:cancel")
				break
			end
		end
		Citizen.Wait(1000)
	end
	TriggerServerEvent("server:alterStress",false,removedStress)
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function EquipParachuteAnim()
    loadAnimDict("clothingshirt")        
    TaskPlayAnim(GetPlayerPed(-1), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end

local ParachuteEquiped = false

RegisterNetEvent("consumables:client:UseParachute")
AddEventHandler("consumables:client:UseParachute", function()
    EquipParachuteAnim()
    QBCore.Functions.Progressbar("use_parachute", "Using Parachute", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        local ped = GetPlayerPed(-1)
        TriggerEvent("debug", 'Consumables: Parachute', 'success')
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["parachute"], "remove")
        GiveWeaponToPed(ped, GetHashKey("GADGET_PARACHUTE"), 1, false)
        local ParachuteData = {
            outfitData = {
                ["bag"]   = { item = 7, texture = 0},  -- Nek / Das
            }
        }
        TriggerEvent('ctn-clothing:client:loadOutfit', ParachuteData)
        ParachuteEquiped = true
        TaskPlayAnim(ped, "clothingshirt", "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    end)
end)

RegisterNetEvent("consumables:client:ResetParachute")
AddEventHandler("consumables:client:ResetParachute", function()
    if ParachuteEquiped then 
        EquipParachuteAnim()
        QBCore.Functions.Progressbar("reset_parachute", "Packing Parachute", 40000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            local ped = GetPlayerPed(-1)
            TriggerEvent("debug", 'Consumables: Reset Parachute', 'success')
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["parachute"], "add")
            local ParachuteRemoveData = { 
                outfitData = { 
                    ["bag"] = { item = 0, texture = 0} -- Nek / Das
                }
            }
            TriggerEvent('ctn-clothing:client:loadOutfit', ParachuteRemoveData)
            TaskPlayAnim(ped, "clothingshirt", "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
            TriggerServerEvent("ctn-smallpenis:server:AddParachute")
            ParachuteEquiped = false
        end)
    else
        QBCore.Functions.Notify("You don't have a parachute!", "error")
    end
end)

-- RegisterNetEvent("consumables:client:UseRedSmoke")
-- AddEventHandler("consumables:client:UseRedSmoke", function()
--     if ParachuteEquiped then
--         local ped = GetPlayerPed(-1)
--         SetPlayerParachuteSmokeTrailColor(ped, 255, 0, 0)
--         SetPlayerCanLeaveParachuteSmokeTrail(ped, true)
--         TriggerEvent("inventory:client:Itembox", QBCore.Shared.Items["smoketrailred"], "remove")
--     else
--         QBCore.Functions.Notify("You must have a parachute to activate smoke!", "error")    
--     end
-- end)

RegisterNetEvent("consumables:client:UseArmor")
AddEventHandler("consumables:client:UseArmor", function()
    TriggerServerEvent("QBCore:Server:RemoveItem", "armor", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["armor"], "remove")
    TriggerEvent("debug", 'Consumables: Vest', 'success')
    QBCore.Functions.Progressbar("use_armor", "Armor", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('hospital:server:SetArmor', 75)
        SetPedArmour(GetPlayerPed(-1), 75)
    end)
end)

local currentVest = nil
local currentVestTexture = nil
RegisterNetEvent("consumables:client:UseHeavyArmor")
AddEventHandler("consumables:client:UseHeavyArmor", function()
    local ped = GetPlayerPed(-1)
    local PlayerData = QBCore.Functions.GetPlayerData()
    TriggerServerEvent("QBCore:Server:RemoveItem", "heavyarmor", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["heavyarmor"], "remove")
    TriggerEvent("debug", 'Consumables: Heavy Vest', 'success')

    QBCore.Functions.Progressbar("use_heavyarmor", "Armor", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('hospital:server:SetArmor', 100)
        SetPedArmour(ped, 100)
    end)
end)

RegisterNetEvent("consumables:client:ResetArmor")
AddEventHandler("consumables:client:ResetArmor", function()
    local ped = GetPlayerPed(-1)
    if currentVest ~= nil and currentVestTexture ~= nil then 
        QBCore.Functions.Progressbar("remove_armor", "Removing Armor", 2500, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerEvent("debug", 'Consumables: Reset Vest', 'success')
            SetPedComponentVariation(ped, 9, currentVest, currentVestTexture, 2)
            SetPedArmour(ped, 0)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["heavyarmor"], "add")
            TriggerServerEvent("QBCore:Server:AddItem", "heavyarmor", 1)
        end)
    else
        QBCore.Functions.Notify("You are not wearing a vest..", "error")
    end
end)

RegisterNetEvent("consumables:client:DrinkAlcohol")
AddEventHandler("consumables:client:DrinkAlcohol", function(itemName)
    TriggerEvent('animations:client:EmoteCommandStart', {"drink"})
    QBCore.Functions.Progressbar("snort_coke", "Drinking", math.random(3000, 6000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("destroyProp")
        TriggerEvent("debug", 'Consumables: Alcohol', 'success')
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1)
        print("dg test ",Consumeables[itemName])
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + Consumeables[itemName])
        alcoholCount = alcoholCount + 1
        if alcoholCount > 1 and alcoholCount < 4 then
            TriggerEvent("evidence:client:SetStatus", "alcohol", 200)
        elseif alcoholCount >= 4 then
            TriggerEvent("evidence:client:SetStatus", "heavyalcohol", 200)
        end
        AlcoholEffect()
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

function HealOxy()
    if not healing then
        healing = true
    else
        return
    end
    
    local count = 9
    while count > 0 do
        Citizen.Wait(1000)
        count = count - 1
        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 6) 
    end
    healing = false
end

RegisterNetEvent('consumables:client:oxy')
AddEventHandler('consumables:client:oxy', function()
    QBCore.Functions.Progressbar("use_oxy", "Healing", 2000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mp_suicide",
		anim = "pill",
		flags = 49,
    }, {}, {}, function() -- Done
        TriggerEvent("destroyProp")
        TriggerEvent("debug", 'Consumables: Oxy', 'success')
        StopAnimTask(GetPlayerPed(-1), "mp_suicide", "pill", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "oxy", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["oxy"], "remove")
        ClearPedBloodDamage(PlayerPedId())
		HealOxy()
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Canceled", "error")
    end)
end)

RegisterNetEvent('consumables:client:ifak')
AddEventHandler('consumables:client:ifak', function()
    QBCore.Functions.Progressbar("use_ifak", "Applying IFAK", 2000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "amb@world_human_clipboard@male@idle_a",
		anim = "idle_c",
		flags = 50,
    }, {}, {}, function() -- Done
        StopAnimTask(GetPlayerPed(-1), "amb@world_human_clipboard@male@idle_a", "idle_c", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "ifak", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["ifak"], "remove")
        ClearPedBloodDamage(PlayerPedId())
		HealOxy()
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "amb@world_human_clipboard@male@idle_a", "idle_c", 1.0)
        QBCore.Functions.Notify("Canceled", "error")
    end)
end)

RegisterNetEvent("consumables:client:Cokebaggy")
AddEventHandler("consumables:client:Cokebaggy", function()
    QBCore.Functions.Progressbar("snort_coke", "Coke Gaming", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@nightclub@peds@",
        anim = "missfbi3_party_snort_coke_b_male3",
        flags = 50,
    }, {}, {}, function() -- Done
        TriggerEvent("destroyProp")
        TriggerEvent("debug", 'Consumables: Coke Baggy', 'success')
        StopAnimTask(GetPlayerPed(-1), "anim@amb@nightclub@peds@", "missfbi3_party_snort_coke_b_male3", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "cokebaggy", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["cokebaggy"], "remove")
        TriggerEvent("evidence:client:SetStatus", "widepupils", 200)
        CokeBaggyEffect()
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "anim@amb@nightclub@peds@", "missfbi3_party_snort_coke_b_male3", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent("consumables:client:Crackbaggy")
AddEventHandler("consumables:client:Crackbaggy", function()
    QBCore.Functions.Progressbar("snort_coke", "Smoking Crack", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "switch@trevor@trev_smoking_meth",
        anim = "trev_smoking_meth_loop",
        flags = 49,
    }, {}, {}, function() -- Done
        TriggerEvent("destroyProp")
        TriggerEvent("debug", 'Consumables: Crack Baggy', 'success')
        StopAnimTask(GetPlayerPed(-1), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "crack_baggy", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["crack_baggy"], "remove")
        TriggerEvent("evidence:client:SetStatus", "widepupils", 300)
        CrackBaggyEffect()
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent("consumables:client:methbag")
AddEventHandler("consumables:client:methbag", function()
    local finished = exports["ctn-taskbarskill"]:taskBar(2500,10)
    if (finished == 100) then  
    QBCore.Functions.Progressbar("snort_meth", "💩 Smoking Ass Meth 💩", 1500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "switch@trevor@trev_smoking_meth",
        anim = "trev_smoking_meth_loop",
        flags = 49,
    }, {}, {}, function() -- Done
        TriggerEvent("destroyProp")
        TriggerEvent("debug", 'Consumables: Crack Baggy', 'success')
        StopAnimTask(GetPlayerPed(-1), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "methbag", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["methbag"], "remove")
        TriggerEvent("evidence:client:SetStatus", "widepupils", 300)
		TriggerEvent("evidence:client:SetStatus", "agitated", 300)
        MethBagEffect()
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
		end)
	end
end)

RegisterNetEvent('consumables:client:EcstasyBaggy')
AddEventHandler('consumables:client:EcstasyBaggy', function()
    QBCore.Functions.Progressbar("use_ecstasy", "XTC Madness", 2000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mp_suicide",
		anim = "pill",
		flags = 49,
    }, {}, {}, function() -- Done
        TriggerEvent("destroyProp")
        TriggerEvent("debug", 'Consumables: Ecstasy Baggy', 'success')
        StopAnimTask(GetPlayerPed(-1), "mp_suicide", "pill", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "xtcbaggy", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["xtcbaggy"], "remove")
        EcstasyEffect()
    end, function() -- Cancel
        StopAnimTask(GetPlayerPed(-1), "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent("consumables:client:Eat")
AddEventHandler("consumables:client:Eat", function(itemName)
    TriggerEvent('animations:client:EmoteCommandStart', {"eat"})
    QBCore.Functions.Progressbar("eat_something", "Eating", 2500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("destroyProp")
        TriggerEvent("debug", 'Consumables: ' .. QBCore.Shared.Items[itemName].label, 'success')
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + Consumeables[itemName])
        TriggerServerEvent('ctn-hud:Server:RelieveStress', math.random(2, 4))
    end)
end)

RegisterNetEvent("consumables:client:Drink")
AddEventHandler("consumables:client:Drink", function(itemName)
    TriggerEvent('animations:client:EmoteCommandStart', {"drink"})
    QBCore.Functions.Progressbar("drink_something", "Drinking", 2500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("destroyProp")
        TriggerEvent("debug", 'Consumables: ' .. QBCore.Shared.Items[itemName].label, 'success')
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + Consumeables[itemName])
    end)
end)

function EcstasyEffect()
    local startStamina = 30
    SetFlash(0, 0, 500, 7000, 500)
    while startStamina > 0 do 
        Citizen.Wait(1000)
        startStamina = startStamina - 1
        RestorePlayerStamina(PlayerId(), 1.0)
        if math.random(1, 100) < 51 then
            SetFlash(0, 0, 500, 7000, 500)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
        end
    end

    startStamina = 0
end

function AlcoholEffect()
    local startStamina = 20
    --SetFlash(0, 0, 500, 7000, 500)
    print(alcoholCount)

    if not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") then
        RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK")
        while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
            Citizen.Wait(1)
        end
    end

    SetPedIsDrunk(GetPlayerPed(-1), true)
    ShakeGameplayCam('DRUNK_SHAKE', 3.0)
    SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@VERYDRUNK", true)
    StartScreenEffect("DrugsTrevorClownsFightIn", 3.0, 0)
    StartScreenEffect("DrugsTrevorClownsFight", 3.0, 0)

    while startStamina > 0 do 
        Citizen.Wait(1000)
        startStamina = startStamina - 1
        RestorePlayerStamina(PlayerId(), 1.0)


        if math.random(1, 100) < 51 then
            print("still in")
            --SetFlash(0, 0, 500, 7000, 500)
            Citizen.Wait(2000)
        end

    end

    StartScreenEffect("DrugsTrevorClownsFightOut", 3.0, 0)
    StopScreenEffect("DrugsTrevorClownsFight")
    StopScreenEffect("DrugsTrevorClownsFightIn")
    StopScreenEffect("DrugsTrevorClownsFightOut")

    ShakeGameplayCam('DRUNK_SHAKE', 0.0)
    ResetPedMovementClipset(GetPlayerPed(-1), 1.0)

    startStamina = 0
end



function CrackBaggyEffect()
    local startStamina = 8
    TrevorEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.43)
    while startStamina > 0 do 
        Citizen.Wait(1000)
        if math.random(1, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 100) < 51 then
            TrevorEffect()
        end
    end
    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function MethBagEffect()
    local startStamina = 8
    TrevorEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
    while startStamina > 0 do 
        Citizen.Wait(1000)
        if math.random(5, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(5, 100) < 51 then
            TrevorEffect()
        end
    end
    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function CokeBaggyEffect()
    local startStamina = 8
    AlienEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.4)
    while startStamina > 0 do 
        Citizen.Wait(1000)
        if math.random(5, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(5, 100) < 51 then
            AlienEffect()
        end
    end

    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function AlienEffect()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Citizen.Wait(3000)
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Citizen.Wait(3000) 
	StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
	StopScreenEffect("DrugsMichaelAliensFightIn")
	StopScreenEffect("DrugsMichaelAliensFight")
	StopScreenEffect("DrugsMichaelAliensFightOut")
end

function TrevorEffect()
    StartScreenEffect("DrugsTrevorClownsFightIn", 3.0, 0)
    Citizen.Wait(3000)
    StartScreenEffect("DrugsTrevorClownsFight", 3.0, 0)
    Citizen.Wait(3000)
	StartScreenEffect("DrugsTrevorClownsFightOut", 3.0, 0)
	StopScreenEffect("DrugsTrevorClownsFight")
	StopScreenEffect("DrugsTrevorClownsFightIn")
	StopScreenEffect("DrugsTrevorClownsFightOut")
end

local currentGear = {
    mask = 0,
    tank = 0,
    enabled = false
}

function DeleteGear()
	if currentGear.mask ~= 0 then
        DetachEntity(currentGear.mask, 0, 1)
        DeleteEntity(currentGear.mask)
		currentGear.mask = 0
    end
    
	if currentGear.tank ~= 0 then
        DetachEntity(currentGear.tank, 0, 1)
        DeleteEntity(currentGear.tank)
		currentGear.tank = 0
	end
end

RegisterNetEvent('oxygenmaskclient:UseGear')
AddEventHandler('oxygenmaskclient:UseGear', function(bool)
    if bool then
        GearAnim()
        QBCore.Functions.Progressbar("equip_gear", "Oxygen Tank", 30000, false, true, {}, {}, {}, {}, function() -- Done
            DeleteGear()
            local maskModel = GetHashKey("p_d_scuba_mask_s")
            local tankModel = GetHashKey("p_s_scuba_tank_s")
    
            RequestModel(tankModel)
            while not HasModelLoaded(tankModel) do
                Citizen.Wait(1)
            end
            TankObject = CreateObject(tankModel, 1.0, 1.0, 1.0, 1, 1, 0)
            local bone1 = GetPedBoneIndex(GetPlayerPed(-1), 24818)
            AttachEntityToEntity(TankObject, GetPlayerPed(-1), bone1, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0, 1, 1, 0, 0, 2, 1)
            currentGear.tank = TankObject
    
            RequestModel(maskModel)
            while not HasModelLoaded(maskModel) do
                Citizen.Wait(1)
            end
            
            MaskObject = CreateObject(maskModel, 1.0, 1.0, 1.0, 1, 1, 0)
            local bone2 = GetPedBoneIndex(GetPlayerPed(-1), 12844)
            AttachEntityToEntity(MaskObject, GetPlayerPed(-1), bone2, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0, 1, 1, 0, 0, 2, 1)
            currentGear.mask = MaskObject
    
            SetEnableScuba(GetPlayerPed(-1), true)
            SetPedMaxTimeUnderwater(GetPlayerPed(-1), 2000.00)
            currentGear.enabled = true
            TriggerServerEvent('oxygengear:RemoveGear')
            ClearPedTasks(GetPlayerPed(-1))
			QBCore.Functions.Notify('/divingsuit to take off your diving suit!', 'error')
        end)
    else
        if currentGear.enabled then
            GearAnim()
            QBCore.Functions.Progressbar("remove_gear", "Oxygen Tank", 10000, false, true, {}, {}, {}, {}, function() -- Done
                DeleteGear()

                SetEnableScuba(GetPlayerPed(-1), false)
                SetPedMaxTimeUnderwater(GetPlayerPed(-1), 1.00)
                currentGear.enabled = false
                TriggerServerEvent('oxygengear:GiveBackGear')
                ClearPedTasks(GetPlayerPed(-1))
            end)
        else
            QBCore.Functions.Notify('You are not wearing an oxygen tank.', 'error')
        end
    end
end)

function GearAnim()
    loadAnimDict("clothingshirt")    	
	TaskPlayAnim(GetPlayerPed(-1), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end