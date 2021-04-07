local QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateUseableItem("empy_contract", function(source, item)
    TriggerClientEvent("startcontract", source)
end)

QBCore.Functions.CreateUseableItem("contract", function(source, item)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if item.info then
        xPlayer.Functions.RemoveItem("contract", item.slot)
        TriggerClientEvent("contract:requestaccept", source, item.info['Amount'],item.info['Information'], item.info['Author'])
    else
        print("[Contracts] No Item Info")
    end
end)

RegisterServerEvent("contract:send")
AddEventHandler("contract:send", function(target, conamount, coninformation)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    if conamount and type(tonumber(conamount)) == 'number' then
        xPlayer.Functions.RemoveItem("empy_contract", 1)
        xPlayer.Functions.AddItem("contract", 1, false, { ['Amount'] = conamount, ["Information"] = coninformation, ["Citizen"] = target, ["Author"] = { cid = xPlayer.PlayerData.citizenid, name = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname } })
    else
        TriggerClientEvent('QBCore:Notify', src, 'Invaild contract amount.', 'error')
    end
end)

RegisterServerEvent("contract:accept")
AddEventHandler("contract:accept", function(price,target,accepted)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    QBCore.Functions.ExecuteSql(true, "SELECT * FROM `players` WHERE `citizenid` = '" .. target.cid .. "'", function(result)
        local xTarget = QBCore.Functions.GetPlayerByCitizenId(target.cid)

        if accepted then
            if xPlayer['PlayerData']['money']['cash'] >= tonumber(price) then
                if xTarget then
                    TriggerClientEvent('QBCore:Notify', xTarget['PlayerData']['source'], 'The citizen accepted your contract and paid $' .. price .. '.')
                end

                xPlayer.Functions.RemoveMoney('cash', price)

                if xTarget then
                    xTarget.Functions.AddMoney('cash',price)
                elseif result[1] then
                    local money = json.decode(result[1].money)
                    money.cash = money.cash + price
                    QBCore.Functions.ExecuteSql(false, 'UPDATE `players` SET `money` = "' .. json.encode(money) .. '" WHERE `citizenid` = "' .. target.cid .. '"')
                end
            else
                if xTarget then
                    TriggerClientEvent('QBCore:Notify', src, 'You dont have enough money.', 'error')
                end
            end
        else
            if xTarget then
                TriggerClientEvent('QBCore:Notify', xTarget['PlayerData']['source'], 'The citizen denied your contract.', 'error')
            end
        end
    end)
end)