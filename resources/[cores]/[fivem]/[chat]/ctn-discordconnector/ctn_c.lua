DiscordName = "Catena"

RegisterNetEvent("ctn-discordconnector:SavePlayer")
AddEventHandler("ctn-discordconnector:SavePlayer", function(discname)
    DiscordName = discname
end)

CreateThread(function()
    TriggerServerEvent("ctn-discordconnector:checkPlayer")
end)

RegisterCommand('refreshname', function()
    TriggerServerEvent("ctn-discordconnector:checkPlayer")
end)

RegisterCommand('ooc', function(source, args, rawCommand)
	local msg = rawCommand:sub(4)
	TriggerServerEvent('ctn-chat:sendOocGlobally', DiscordName, msg)
end, false)

RegisterCommand('ac', function(source, args, rawCommand)
	local msg = rawCommand:sub(4)
	TriggerServerEvent('ctncha:adminchatpermmision', DiscordName, msg)
end, false)