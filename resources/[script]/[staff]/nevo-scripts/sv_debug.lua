
RegisterServerEvent("nevo:ready")
AddEventHandler("nevo:ready", function()
    QBCore.Commands.Add("dev", "Toggle debug mode", {}, false, function(source, args)
        TriggerClientEvent('debug:toggle', source)
    end, 'god')
end)

RegisterServerEvent('QBCore:Server:OnPlayerLoaded')
AddEventHandler('QBCore:Server:OnPlayerLoaded', function()
    TriggerClientEvent('debug', -1, 'QBCore: ' .. GetPlayerName(source) .. ' (' .. source .. ') Loaded!', 'normal')
end)

AddEventHandler('playerDropped', function(reason)
    TriggerClientEvent('debug', -1, 'QBCore: ' .. GetPlayerName(source) .. ' (' .. source .. ') Dropped! (' .. reason .. ')', 'normal')
end)
