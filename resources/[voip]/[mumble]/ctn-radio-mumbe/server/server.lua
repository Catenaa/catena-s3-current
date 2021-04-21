QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Code

QBCore.Functions.CreateUseableItem("radio", function(source, item)
  local Player = QBCore.Functions.GetPlayer(source)
  TriggerClientEvent('ctn-radio:use', source)
end)

QBCore.Functions.CreateCallback('ctn-radio:server:GetItem', function(source, cb, item)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player ~= nil then 
    local RadioItem = Player.Functions.GetItemByName(item)
    if RadioItem ~= nil then
      cb(true)
    else
      cb(false)
    end
  else
    cb(false)
  end
end)