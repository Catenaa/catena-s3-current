QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local chicken = vehicleBaseRepairCost

RegisterServerEvent('ctn-bennys:attemptPurchase')
AddEventHandler('ctn-bennys:attemptPurchase', function(type, upgradeLevel)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    if type == "repair" then
        if Player.PlayerData.money.cash >= chicken then
            Player.Functions.RemoveMoney('cash', chicken)
            TriggerClientEvent('ctn-bennys:purchaseSuccessful', source)
        else
            TriggerClientEvent('ctn-bennys:purchaseFailed', source)
        end
    elseif type == "performance" then
        if Player.PlayerData.money.cash >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            TriggerClientEvent('ctn-bennys:purchaseSuccessful', source)
            Player.Functions.RemoveMoney('cash', vehicleCustomisationPrices[type].prices[upgradeLevel])
        else
            TriggerClientEvent('ctn-bennys:purchaseFailed', source)
        end
    else
        if Player.PlayerData.money.cash >= vehicleCustomisationPrices[type].price then
            TriggerClientEvent('ctn-bennys:purchaseSuccessful', source)
            Player.Functions.RemoveMoney('cash', vehicleCustomisationPrices[type].price)
        else
            TriggerClientEvent('ctn-bennys:purchaseFailed', source)
        end
    end
end)

RegisterServerEvent('ctn-bennys:updateRepairCost')
AddEventHandler('ctn-bennys:updateRepairCost', function(cost)
    chicken = cost
end)

RegisterServerEvent("updateVehicle")
AddEventHandler("updateVehicle", function(myCar)
	local src = source
    if IsVehicleOwned(myCar.plate) then
        QBCore.Functions.ExecuteSql(false, "UPDATE `ctnvehicles` SET `props` = '"..json.encode(myCar).."' WHERE `plate` = '"..myCar.plate.."'")
    end
end)

function IsVehicleOwned(plate)
    local retval = false
    QBCore.Functions.ExecuteSql(true, "SELECT * FROM `ctnvehicles` WHERE `plate` = '"..plate.."'", function(result)
        if result[1] ~= nil then
            retval = true
        end
    end)
    return retval
end