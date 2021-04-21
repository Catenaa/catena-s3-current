QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)


RegisterServerEvent('ctn-blackmarket:makeorder')
AddEventHandler('ctn-blackmarket:makeorder', function(data)
    local src = source
    local ply = QBCore.GetPlayer(src)
    local bankamount = ply.PlayerData.money["bank"]
    local price = tonumber(data.price)
    if bankamount >= price and price > 0 then
      ply.RemoveMoney('bank', price, "Blackmarket Receipt")
      TriggerEvent("ctn-log:server:CreateLog", "blackmarket", "Bought", "red", "**"..GetPlayerName(src) .. "** has been purchase a **"..data.item.."** for - **" .. data.price .. "**")
      ply.AddItem(data.item, data.amount)
      TriggerClientEvent('QBCore:Notify', src, 'You Order ('.. data.item .. ') for - ' .. price, 'success')
    else
      TriggerClientEvent('QBCore:Notify', src, 'You don\'t have enough money on your bank..', 'error')
    end
end)
