local oxygenTank = 25.0
local oxyOn = false
local attachedProp = 0
local attachedProp2 = 0
local lownotify = 0
local toghud = true
local mumbleInfo = 2
local svrId = GetPlayerServerId(PlayerId())

local speed = 0.0
local seatbeltOn = false
local cruiseOn = false
local bleedingPercentage = 0
local hunger = 100
local thirst = 100
Fuel = 0
stress = 0

RegisterCommand('hud', function()
	if toghud then 
		TriggerEvent('hud:toggleui', false)
	else 
		TriggerEvent('hud:toggleui', true)
	end 
end)

RegisterNetEvent('hud:toggleui')
AddEventHandler('hud:toggleui', function(show)
	if show then toghud = true; else toghud = false; end
end)

RegisterNetEvent('mumble:updateMumbleInfo')
AddEventHandler('mumble:updateMumbleInfo', function(mode)
	mumbleInfo = mode
end)

RegisterNetEvent("hud:client:UpdateNeeds")
AddEventHandler("hud:client:UpdateNeeds", function(newHunger, newThirst)
    hunger = newHunger
    thirst = newThirst
end)

--General UI Updates
Citizen.CreateThread(function()
    Citizen.Wait(0)
    while true do
        local player = PlayerPedId()
        local health = (GetEntityHealth(player) - 100)
        local armor = GetPedArmour(player)
		local oxy = oxygenTank
        local talking = false
        
        
        --[[
        local mumbleData = exports["mumble-voip"]:RetrieveMumbleData()

		if mumbleData and mumbleData[svrId] and not mumbleData[svrId].radioActive and NetworkIsPlayerTalking(PlayerId()) then 
			talking = 'normal'
		elseif mumbleData and mumbleData[svrId] and mumbleData[svrId].radioActive then 
			talking = 'radio'
		else 
			talking = false 
        end
        ]]
        -- local iTalking = exports['tokovoip_script']:getPlayerDataS(GetPlayerServerId(PlayerId()), 'radio:talking') ~= nil and exports['tokovoip_script']:getPlayerDataS(GetPlayerServerId(PlayerId()), 'radio:talking') == true and 'radio' or exports['tokovoip_script']:getPlayerDataS(GetPlayerServerId(PlayerId()), "voip:talking") ~= nil and exports['tokovoip_script']:getPlayerDataS(GetPlayerServerId(PlayerId()), "voip:talking") == 1 and 'normal' or false
        
        SendNUIMessage({
            action = 'updateStatusHud',
            show = toghud,
            health = health,
            armour = armor,
			oxygen = oxy,
			mumble = mumbleInfo,
			talking = "s",
		})
		
        Citizen.Wait(200)
    end
end)

--Food Thirst
Citizen.CreateThread(function()
	while true do
        SendNUIMessage({
            action = "updateStatusHud",
            show = toghud,
            hunger = hunger,
            thirst = thirst,
            stress = stress,
        })
        Citizen.Wait(5000)
    end
end)

--[[RegisterCommand("proximity1",function()
    TriggerEvent("bh-hud:client:UpdateVoiceProximity", 1)
end)
RegisterCommand("proximity2",function()
    TriggerEvent("bh-hud:client:UpdateVoiceProximity", 2)
end)
RegisterCommand("proximity3",function()
    TriggerEvent("bh-hud:client:UpdateVoiceProximity", 3)
end)
RegisterCommand("talkingon",function()
    TriggerEvent("bh-hud:client:ProximityActive", true)
end)
RegisterCommand("talkingoff",function()
    TriggerEvent("bh-hud:client:ProximityActive", false)
end)]]


RegisterNetEvent('bh-hud:client:UpdateVoiceProximity')
AddEventHandler('bh-hud:client:UpdateVoiceProximity', function(Proximity)
    SendNUIMessage({
        action = "proximity",
        prox = Proximity
    })
end)

RegisterNetEvent('bh-hud:client:ProximityActive')
AddEventHandler('bh-hud:client:ProximityActive', function(active)
    SendNUIMessage({
        action = "talking",
        IsTalking = active
    })
end)