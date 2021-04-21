QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Commands.Add('dvall', 'Delete All Vehicles', {}, false, function(source, args)
    TriggerClientEvent("wld:delallveh", -1)
end, 'god')