QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Commands.Add("tow", "Tow a vehicle on the back of your flatbed", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "mechanic" then
        TriggerClientEvent("ctn-tow:client:TowVehicle", source)
    end
end)