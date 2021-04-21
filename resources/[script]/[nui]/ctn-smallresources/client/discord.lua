local sv_maxClients = 128
local sv_players = 0
local q = 0

RegisterNetEvent('ctn-core:client:updatePlayers')
AddEventHandler('ctn-core:client:updatePlayers', function(playerSSs)
    sv_players = #playerSSs

    TriggerEvent("debug", 'QBCore: Update Players Count #' .. sv_players, 'normal')
end)

Citizen.CreateThread(function()
    while true do
		SetDiscordAppId(691850893704036383)
		SetDiscordRichPresenceAsset('catena')
        SetDiscordRichPresenceAssetText('https://discord.gg/Gb3qY9b')
        SetRichPresence('Every Family Has A Story , Welcome To Ours...🧑‍🤝‍🧑')
        Citizen.Wait(35000)
	end
end)