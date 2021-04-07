QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Code

local RentedVehicles = {}

RegisterServerEvent('ctn-vehiclerental:server:SetVehicleRented')
AddEventHandler('ctn-vehiclerental:server:SetVehicleRented', function(plate, bool, vehicleData)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)
    local plyCid = ply.PlayerData.citizenid

    if bool then
        if ply.PlayerData.money.cash >= vehicleData.price then
            ply.Functions.RemoveMoney('cash', vehicleData.price, "vehicle-rentail-bail") 
            RentedVehicles[plyCid] = plate
            TriggerClientEvent('QBCore:Notify', src, 'You have the deposit of €'..vehicleData.price..' paid in cash.', 'success', 3500)
            TriggerClientEvent('ctn-vehiclerental:server:SpawnRentedVehicle', src, plate, vehicleData) 
        elseif ply.PlayerData.money.bank >= vehicleData.price then 
            ply.Functions.RemoveMoney('bank', vehicleData.price, "vehicle-rentail-bail") 
            RentedVehicles[plyCid] = plate
            TriggerClientEvent('QBCore:Notify', src, 'You have the deposit of €'..vehicleData.price..' paid with your bank account.', 'success', 3500)
            TriggerClientEvent('ctn-vehiclerental:server:SpawnRentedVehicle', src, plate, vehicleData) 
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have enough money.', 'error', 3500)
        end
        return
    end
    TriggerClientEvent('QBCore:Notify', src, 'You got back your deposit €'..vehicleData.price..'.', 'success', 3500)
    ply.Functions.AddMoney('cash', vehicleData.price, "vehicle-rentail-bail")
    RentedVehicles[plyCid] = nil
end)




