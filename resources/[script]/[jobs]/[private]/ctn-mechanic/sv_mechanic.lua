QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent("ctn-mechanic:attemptPurchase")
AddEventHandler("ctn-mechanic:attemptPurchase", function(cheap, type, upgradeLevel)
    local src = source
    local price = 0

    if vehicleCustomisationPrices[type] and vehicleCustomisationPrices[type].prices and upgradeLevel then
        price = vehicleCustomisationPrices[type].prices[upgradeLevel]
    elseif vehicleCustomisationPrices[type] and vehicleCustomisationPrices[type].price then 
        price = vehicleCustomisationPrices[type].price
    end

    if exports['ctn-bossmenu']:GetAccount("mechanic") >= price then
        TriggerEvent("ctn-bossmenu:server:removeAccountMoney", "mechanic", price)
        TriggerClientEvent("ctn-mechanic:purchaseSuccessful", src)
    else
        TriggerClientEvent("ctn-mechanic:purchaseFailed", src)
    end
end)

RegisterServerEvent("ctn-mechanic:updateVehicle")
AddEventHandler("ctn-mechanic:updateVehicle", function(plate, vehicleMods)
    QBCore.Functions.ExecuteSql(false, "UPDATE `ctnvehicles` SET `props` = '" .. json.encode(vehicleMods) .. "' WHERE `plate` = '" .. plate .. "'")
end)
