QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterNetEvent("ctn-rawchicken")
AddEventHandler("ctn-rawchicken", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('alivechicken') ~= nil and Player.Functions.GetItemByName('alivechicken').amount >= Config.AliveToSlaughter then
    Player.Functions.RemoveItem("alivechicken", Config.AliveToSlaughter)
    Player.Functions.AddItem("slaughteredchicken", Config.AliveToSlaughter)
    TriggerClientEvent('QBCore:Notify', src, "You Slaughtered ".. Config.AliveToSlaughter .." Alive Checken")
    else
        TriggerClientEvent('QBCore:Notify', src, "You dont have any Chicken to Slaughter")
    end
end)

RegisterNetEvent("ctn-alivechicken")
AddEventHandler("ctn-alivechicken", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('alivechicken', Config.CatchPerSearch)
    TriggerClientEvent('QBCore:Notify', src, "You got ".. Config.CatchPerSearch .." AliveChicken")
end)

RegisterNetEvent("ctn-packchicken")
AddEventHandler("ctn-packchicken", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('slaughteredchicken') ~= nil and Player.Functions.GetItemByName('slaughteredchicken').amount >= 1 then
    Player.Functions.RemoveItem("slaughteredchicken", 1)
    Player.Functions.AddItem("packedchicken", Config.SlaughterToPack)
    TriggerClientEvent('QBCore:Notify', src, "You got 4 Chicken Pieces")
else
    TriggerClientEvent('QBCore:Notify', src, "You dont have Slaughtered chicken to pack")
end
end)

RegisterNetEvent("ctn-sellchicken")
AddEventHandler("ctn-sellchicken", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName('packedchicken') ~= nil and Player.Functions.GetItemByName('packedchicken').amount >= Config.NumberOfSellOneTime then
    Player.Functions.RemoveItem("packedchicken", Config.NumberOfSellOneTime)
    Player.Functions.AddMoney("cash", Config.SellPrice)
    TriggerClientEvent('QBCore:Notify', src, "You sold ".. Config.NumberOfSellOneTime .." pack of chicken")
    else
        TriggerClientEvent('QBCore:Notify', src, "You Need to have ".. Config.NumberOfSellOneTime .." pack of chicken in order to sell")
    end
end)