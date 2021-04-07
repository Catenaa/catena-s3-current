local QBCore = nil

QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('houseRobberies:removeLockpick')
AddEventHandler('houseRobberies:removeLockpick', function()
 local source = tonumber(source)
 local xPlayer = QBCore.Functions.GetPlayer(source)
 xPlayer.Functions.RemoveItem('advancedlockpick', 1)
 TriggerClientEvent('QBCore:Notify', source, 'The lockpick bent out of shape.', "error")
end)

RegisterServerEvent('houseRobberies:giveMoney')
AddEventHandler('houseRobberies:giveMoney', function()
 local source = tonumber(source)
 local xPlayer = QBCore.Functions.GetPlayer(source)
 local cash = math.random(500, 1200)
 xPlayer.Functions.AddMoney('cash', cash)
 PerformHttpRequest('https://discord.com/api/webhooks/810865883252523069/NnUMh8foPrzDFRW01PQpQuOrd_pHDamngK3Twehe4oz6rNnTKrlruiWedP0hdtVY8ioc', function(err, text, headers) end, 'POST', json.encode({username = "House Robberies Log", content = "__**" .. GetPlayerName(source) .. "**__ Got Money: **" .. cash .. "** **.** "}), { ['Content-Type'] = 'application/json' })
 TriggerClientEvent('QBCore:Notify', source, 'You found $'..cash)
end)

RegisterServerEvent('houseRobberies:searchItem')
AddEventHandler('houseRobberies:searchItem', function()
 local source = tonumber(source)
 local item = {}
 local xPlayer = QBCore.Functions.GetPlayer(source)
 local gotID = {}

 for i=1, math.random(1, 2) do
  item = Config.RobbableItems[math.random(1, #Config.RobbableItems)]
  if math.random(1, 10) >= item.chance then
   if tonumber(item.id) == 0 and not gotID[item.id] then
    gotID[item.id] = true
    xPlayer.Functions.AddMoney('cash', item.quantity)
    PerformHttpRequest('https://discord.com/api/webhooks/810865883252523069/NnUMh8foPrzDFRW01PQpQuOrd_pHDamngK3Twehe4oz6rNnTKrlruiWedP0hdtVY8ioc', function(err, text, headers) end, 'POST', json.encode({username = "House Robberies Log", content = "__**" .. GetPlayerName(source) .. "**__ Found: **" .. item.isWeapon .. "** **.** "}), { ['Content-Type'] = 'application/json' })
    TriggerClientEvent('QBCore:Notify', source, 'You found $'..item.quantity)
   elseif not gotID[item.id] then
    gotID[item.id] = true
    xPlayer.Functions.AddItem(item.id, item.quantity)
    PerformHttpRequest('https://discord.com/api/webhooks/810865883252523069/NnUMh8foPrzDFRW01PQpQuOrd_pHDamngK3Twehe4oz6rNnTKrlruiWedP0hdtVY8ioc', function(err, text, headers) end, 'POST', json.encode({username = "House Robberies Log", content = "__**" .. GetPlayerName(source) .. "**__ Found: **" .. item.id .. "** **.** "}), { ['Content-Type'] = 'application/json' })
    TriggerClientEvent('QBCore:Notify', source, 'Item Added!')
   end
  end
 end
end)

QBCore.Functions.CreateCallback('houserob:checkcops', function(source, cb)
  local currentplayers = QBCore.Functions.GetPlayers()
  local cops = 0

  for i = 1, #currentplayers, 1 do
    local xPlayer = QBCore.Functions.GetPlayer(currentplayers[i])
    if xPlayer.PlayerData.job ~= nil and xPlayer.PlayerData.job.name == "police" then
      cops = cops + 1
    end
  end

  cb(cops)
end)
