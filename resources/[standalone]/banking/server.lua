QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Code

local BankStatus = {}

RegisterServerEvent('ctn-banking:server:SetBankClosed')
AddEventHandler('ctn-banking:server:SetBankClosed', function(BankId, bool)
  print(BankId)
  BankStatus[BankId] = bool
  TriggerClientEvent('ctn-banking:client:SetBankClosed', -1, BankId, bool)
end)

RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)
    local bankamount = ply.PlayerData.money["bank"]
    local amount = tonumber(amount)
    if bankamount >= amount and amount > 0 then
      ply.Functions.RemoveMoney('bank', amount, "Bank withdraw")
      TriggerEvent("ctn-log:server:CreateLog", "banking", "Withdraw", "red", "**"..GetPlayerName(src) .. "** has €"..amount.." withdrawn from this bank.")
      ply.Functions.AddMoney('cash', amount, "Bank withdraw")
    else
      TriggerClientEvent('QBCore:Notify', src, 'You do not have enough money in your bank..', 'error')
    end
end)

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)
    local cashamount = ply.PlayerData.money["cash"]
    local amount = tonumber(amount)
    if cashamount >= amount and amount > 0 then
      ply.Functions.RemoveMoney('cash', amount, "Bank depost")
      TriggerEvent("ctn-log:server:CreateLog", "banking", "Deposit", "green", "**"..GetPlayerName(src) .. "** has €"..amount.." Deposit into this bank.")
      ply.Functions.AddMoney('bank', amount, "Bank depost")
    else
      TriggerClientEvent('QBCore:Notify', src, 'You dont have enough money in your pocket..', 'error')
    end
end)

QBCore.Commands.Add("givecash", "Give cash to a person", {{name="id", help="Player ID"},{name="amount", help="Amount of money"}}, true, function(source, args)
  local Player = QBCore.Functions.GetPlayer(source)
  local TargetId = tonumber(args[1])
  local Target = QBCore.Functions.GetPlayer(TargetId)
  local amount = tonumber(args[2])
  
  if Target ~= nil then
    if amount ~= nil then
      if amount > 0 then
        if Player.PlayerData.money.cash >= amount and amount > 0 then
          if TargetId ~= source then
            TriggerClientEvent('banking:client:CheckDistance', source, TargetId, amount)
          else
            TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "You can't give money to yourself.")     
          end
        else
          TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "You don't have enough money.")
        end
      else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "The quantity must be greater than 0.")
      end
    else
      TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Fill in a quantity.")
    end
  else
    TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Person is not in town.")
  end    
end)

RegisterServerEvent('banking:server:giveCash')
AddEventHandler('banking:server:giveCash', function(trgtId, amount)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local Target = QBCore.Functions.GetPlayer(trgtId)

  print(src)
  print(trgtId)

  if src ~= trgtId then
    Player.Functions.RemoveMoney('cash', amount, "Cash given to "..Player.PlayerData.citizenid)
    Target.Functions.AddMoney('cash', amount, "Cash received from "..Target.PlayerData.citizenid)

    TriggerEvent("ctn-log:server:CreateLog", "banking", "Give money", "blue", "**"..GetPlayerName(src) .. "** has €"..amount.." given to **" .. GetPlayerName(trgtId) .. "**")
    
    TriggerClientEvent('QBCore:Notify', trgtId, "You've got €"..amount.." received from "..Player.PlayerData.charinfo.firstname.."!", 'success')
    TriggerClientEvent('QBCore:Notify', src, "You've got €"..amount.." given to "..Target.PlayerData.charinfo.firstname.."!", 'success')
  else
    TriggerEvent("ctn-anticheat:server:banPlayer", "Cheating")
    TriggerEvent("ctn-log:server:CreateLog", "anticheat", "Player banished! (Not really natural, this is a test, duuuhhh)", "red", "** @everyone " ..GetPlayerName(player).. "** has tried to **"..amount.."reveal oneself")  
  end
end)
