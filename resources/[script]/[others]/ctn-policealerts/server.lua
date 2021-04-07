QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Code

RegisterNetEvent('ctn-policealerts:server:AddPoliceAlert')
AddEventHandler('ctn-policealerts:server:AddPoliceAlert', function(data, forBoth)
    forBoth = forBoth ~= nil and forBoth or false
    TriggerClientEvent('ctn-policealerts:client:AddPoliceAlert', -1, data, forBoth)
end)