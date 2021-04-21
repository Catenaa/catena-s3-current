QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Code

QBCore.Commands.Add("shuff", "Moving from chair", {}, false, function(source, args)
    TriggerClientEvent('ctn-seatshuff:client:Shuff', source)
end)