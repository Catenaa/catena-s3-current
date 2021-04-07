QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local PaymentTax = 15
local Bail = {}

RegisterServerEvent('ctn-tow:server:DoBail')
AddEventHandler('ctn-tow:server:DoBail', function(bool, vehInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if bool then
        if Player.PlayerData.money.cash >= Config.BailPrice then
            Bail[Player.PlayerData.citizenid] = Config.BailPrice
            Player.Functions.RemoveMoney('cash', Config.BailPrice, "tow-paid-bail")
            TriggerClientEvent('QBCore:Notify', src, 'You have paid the deposit of 1000, -', 'success')
            TriggerClientEvent('ctn-tow:client:SpawnVehicle', src, vehInfo)
        elseif Player.PlayerData.money.bank >= Config.BailPrice then
            Bail[Player.PlayerData.citizenid] = Config.BailPrice
            Player.Functions.RemoveMoney('bank', Config.BailPrice, "tow-paid-bail")
            TriggerClientEvent('QBCore:Notify', src, 'You have paid the deposit of 1000, -', 'success')
            TriggerClientEvent('ctn-tow:client:SpawnVehicle', src, vehInfo)
        else
            TriggerClientEvent('QBCore:Notify', src, 'You do not have enough cash, the deposit is 1000, -', 'error')
        end
    else
        if Bail[Player.PlayerData.citizenid] ~= nil then
            Player.Functions.AddMoney('cash', Bail[Player.PlayerData.citizenid], "tow-bail-paid")
            Bail[Player.PlayerData.citizenid] = nil
            TriggerClientEvent('QBCore:Notify', src, 'You have received the deposit of 1000, - back', 'success')
        end
    end
end)

RegisterNetEvent('ctn-tow:server:11101110')
AddEventHandler('ctn-tow:server:11101110', function(drops)
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
    local drops = tonumber(drops)
    local bonus = 0
    local DropPrice = math.random(450, 700)
    if drops > 5 then 
        bonus = math.ceil((DropPrice / 100) * 5)
    elseif drops > 10 then
        bonus = math.ceil((DropPrice / 100) * 7)
    elseif drops > 15 then
        bonus = math.ceil((DropPrice / 100) * 10)
    elseif drops > 20 then
        bonus = math.ceil((DropPrice / 100) * 12)
    end
    local price = (DropPrice * drops) + bonus
    local taxAmount = math.ceil((price / 100) * PaymentTax)
    local payment = price - taxAmount

    Player.Functions.AddJobReputation(1)
    Player.Functions.AddMoney("bank", payment, "tow-salary")
    TriggerClientEvent('chatMessage', source, "BAAN", "warning", "You received your salary from: €"..payment..", gross: €"..price.." (with €"..bonus.." bonus) and €"..taxAmount.." tax ("..PaymentTax.."%)")
end)

QBCore.Commands.Add("npc", "Toggle npc missions", {}, false, function(source, args)
	TriggerClientEvent("jobs:client:ToggleNpc", source)
end)

QBCore.Commands.Add("tow", "Place a car on the back of your flatbed", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "tow" then
        TriggerClientEvent("ctn-tow:client:TowVehicle", source)
    end
end)

