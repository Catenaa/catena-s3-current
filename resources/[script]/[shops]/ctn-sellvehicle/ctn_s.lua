--[[
    BarBaroNN's Sell Vehicles, Made by BarBaroNN#0006.
    All rights reserved.
]]--

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)


QBCore.Functions.CreateCallback('ctn-sellveh:checkOwner', function(source, cb, plate)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local citizenid = xPlayer.PlayerData['citizenid']
    local fixedplate = plate:gsub(" ", "")
    exports['ghmattimysql']:execute("SELECT * FROM `ctnvehicles` WHERE `citizenid` = '" .. citizenid .. "' AND `plate` = '" .. fixedplate .. "'", {}, function(results)
        cb(#results > 0)
    end)
end)

RegisterServerEvent('ctn-sellveh:transferVehicle')
AddEventHandler('ctn-sellveh:transferVehicle', function(plate, sellerID, amount)
    local buyer, seller = source, sellerID
    local xBuyer, xSeller = QBCore.Functions.GetPlayer(buyer), QBCore.Functions.GetPlayer(seller)
    local buyerCitizenID = xBuyer.PlayerData['citizenid']
    local buyerIdentifier = GetPlayerIdentifiers(source)[1]
    local fixedplate = plate:gsub(" ", "")

    xBuyer.Functions.RemoveMoney('cash', amount)
    xSeller.Functions.AddMoney('cash', amount)

    TriggerEvent('ctn-logs:server:createLog', 'sellvehicle', 'Vehicle boughted', "**[Plate]** " .. plate .. ' **[Seller]** ' .. GetPlayerName(sellerID) .. ' **[Price]** ' .. amount, buyer)

    exports['ghmattimysql']:execute("UPDATE `ctnvehicles` SET `citizenid` = '" .. buyerCitizenID .. "' WHERE `plate` = '" .. fixedplate .. "'", {}, function(rows)
        print(rows)
    end)
	
    TriggerClientEvent('QBCore:Notify', seller, 'Someone bought your car!')
end)

QBCore.Functions.CreateCallback('ctn-sellveh:checkMoney', function(source, cb, count)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local money = xPlayer.PlayerData['money']['cash']
    if money ~= nil then
        if money >= count then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

RegisterServerEvent('ctn-sellveh:updateList')
AddEventHandler('ctn-sellveh:updateList', function(plate, name, model, price, vehicle)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('ctn-sellveh:client:updateList', -1, plate, name, model, price, vehicle, tonumber(src), xPlayer.PlayerData['citizenid'])
    TriggerEvent('ctn-logs:server:createLog', 'sellvehicle', 'Vehicle added to the list', "**[Plate]** " .. plate .. ' **[Model]** ' .. model .. ' **[Price]** ' .. price, src)
end)

RegisterServerEvent('ctn-sellveh:removeList')
AddEventHandler('ctn-sellveh:removeList', function(plate, canceled)
    TriggerClientEvent('ctn-sellveh:client:removeList', -1, plate)
    if canceled then
        TriggerEvent('ctn-logs:server:createLog', 'sellvehicle', 'Vehicle removed from the list', "**[Plate]** " .. plate, source)
    end
end)

QBCore.Commands.Add("sellvehicle", "Sell owned vehicle", {{name="price", help="Price to sell"}}, false, function(source, args)
    local price = tonumber(args[1])
    TriggerClientEvent('ctn-sellveh:client:sellvehicle', source, price)
end)