QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateCallback('ctn-drugs:server:cornerselling:getAvailableDrugs', function(source, cb)
    local AvailableDrugs = {}
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

        local item = Player.Functions.GetItemByName('joint')

        if item ~= nil then
            table.insert(AvailableDrugs, {
                item = item.name,
                amount = item.amount,
                label = QBCore.Shared.Items[item.name]["label"]
            })
        end

    if next(AvailableDrugs) ~= nil then
        cb(AvailableDrugs)
    else
        cb(nil)
    end
end)

RegisterServerEvent('ctn-drugs:server:sellCornerDrugs')
AddEventHandler('ctn-drugs:server:sellCornerDrugs', function(item, amount, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local AvailableDrugs = {}

    if Player.Functions.RemoveItem(item, amount) then
        Player.Functions.AddMoney('cash', price, "sold-cornerdrugs")

        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")

            local item = Player.Functions.GetItemByName('joint')

            if item ~= nil then
                table.insert(AvailableDrugs, {
                    item = item.name,
                    amount = item.amount,
                    label = QBCore.Shared.Items[item.name]["label"]
                })
            end

    end

    TriggerClientEvent('ctn-drugs:client:refreshAvailableDrugs', src, AvailableDrugs)
end)

RegisterServerEvent('ctn-drugs:server:robCornerDrugs')
AddEventHandler('ctn-drugs:server:robCornerDrugs', function(item, amount, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local AvailableDrugs = {}

    Player.Functions.RemoveItem(item, amount)

    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")

        local item = Player.Functions.GetItemByName('joint')

        if item ~= nil then
            table.insert(AvailableDrugs, {
                item = item.name,
                amount = item.amount,
                label = QBCore.Shared.Items[item.name]["label"]
            })
        end

    TriggerClientEvent('ctn-drugs:client:refreshAvailableDrugs', src, AvailableDrugs)
end)