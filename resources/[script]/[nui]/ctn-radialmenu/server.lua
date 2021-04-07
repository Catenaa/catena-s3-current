QBCore = nil
TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    

local trunkBusy = {}

RegisterServerEvent('ctn-trunk:server:setTrunkBusy')
AddEventHandler('ctn-trunk:server:setTrunkBusy', function(plate, busy)
    trunkBusy[plate] = busy
end)

QBCore.Functions.CreateCallback('ctn-trunk:server:getTrunkBusy', function(source, cb, plate)
    if trunkBusy[plate] then
        cb(true)
    end
    cb(false)
end)

RegisterServerEvent('ctn-trunk:server:KidnapTrunk')
AddEventHandler('ctn-trunk:server:KidnapTrunk', function(targetId, closestVehicle)
    TriggerClientEvent('ctn-trunk:client:KidnapGetIn', targetId, closestVehicle)
end)

RegisterNetEvent('vehicle:flipit')
AddEventHandler('vehicle:flipit', function()
	TriggerClientEvent('vehicle:flipit')
end)