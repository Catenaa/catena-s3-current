QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local bedsTaken = {}

RegisterServerEvent('hospital:server:SendToBed')
AddEventHandler('hospital:server:SendToBed', function(bedId, isRevive)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('hospital:client:SendToBed', src, bedId, Config.Locations["beds"][bedId], isRevive)
    TriggerClientEvent('hospital:client:SetBed', -1, bedId, true)

    Player.Functions.RemoveMoney("bank", Config.BillCost, "checkin-at-hospital")
	TriggerEvent("ctn-bossmenu:server:addAccountMoney", "ambulance", 250)
    TriggerClientEvent('hospital:client:SendBillEmail', src, Config.BillCost)
end)

RegisterServerEvent('hospital:server:RespawnAtHospital')
AddEventHandler('hospital:server:RespawnAtHospital', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    for k, v in pairs(Config.Locations["beds"]) do
        TriggerClientEvent('hospital:client:SendToBed', src, k, v, true)
        TriggerClientEvent('hospital:client:SetBed', -1, k, true)
        --Player.Functions.ClearInventory()
        QBCore.Functions.ExecuteSql(true, "UPDATE `players` SET `inventory` = '"..QBCore.EscapeSqli(json.encode({})).."' WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'")
        TriggerClientEvent('QBCore:Notify', src, 'All your belongings have been taken..', 'error')
        return
    end
end)

RegisterServerEvent('hospital:server:LeaveBed')
AddEventHandler('hospital:server:LeaveBed', function(id)
    TriggerClientEvent('hospital:client:SetBed', -1, id, false)
end)

RegisterServerEvent('hospital:server:SetDeathStatus')
AddEventHandler('hospital:server:SetDeathStatus', function(isDead)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player ~= nil then
        Player.Functions.SetMetaData("isdead", isDead)
        TriggerClientEvent("QBCore:client:IsDead", src, bool)
    end
end)

RegisterServerEvent('hospital:server:SetLaststandStatus')
AddEventHandler('hospital:server:SetLaststandStatus', function(bool)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player ~= nil then
        Player.Functions.SetMetaData("inlaststand", bool)
        TriggerClientEvent("QBCore:client:LastStand", src, bool)
    end
end)

RegisterServerEvent('hospital:server:SetArmor')
AddEventHandler('hospital:server:SetArmor', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player ~= nil then
        Player.Functions.SetMetaData("armor", amount)
    end
end)

RegisterServerEvent('hospital:server:TreatWounds')
AddEventHandler('hospital:server:TreatWounds', function(playerId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Patient = QBCore.Functions.GetPlayer(tonumber(playerId))
    if Patient ~= nil then
        TriggerClientEvent("hospital:client:HealInjuries", Patient.PlayerData.source, "full")
    end
end)

RegisterServerEvent('hospital:server:SetDoctor')
AddEventHandler('hospital:server:SetDoctor', function()
    local amount = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "ambulance" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
    TriggerClientEvent("hospital:client:SetDoctorCount", -1, amount)
end)

RegisterServerEvent('hospital:server:RevivePlayer')
AddEventHandler('hospital:server:RevivePlayer', function(playerId, isOldMan)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Patient = QBCore.Functions.GetPlayer(tonumber(playerId))
    if Patient ~= nil then
        TriggerClientEvent('hospital:client:Revive', Patient.PlayerData.source)
        TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + 100)
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + 100)
    end
end)

RegisterServerEvent('hospital:server:SendDoctorAlert')
AddEventHandler('hospital:server:SendDoctorAlert', function()
    local src = source
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "ambulance" and Player.PlayerData.job.onduty) then
			TriggerClientEvent('chat:addMessage', v, {
			template = '<div class="chat-message advert">A doctor is needed at Pillbox Hospital  </div>',
			})
            end
        end
    end
end)

RegisterServerEvent('hospital:server:MakeDeadCall')
AddEventHandler('hospital:server:MakeDeadCall', function(blipSettings, gender, street1, street2)
    local src = source
    local genderstr = "Man"

    if gender == 1 then genderstr = "Woman" end

    TriggerClientEvent("112:client:SendAlert", -1, "A ".. genderstr .." injured in " ..street1 .. " "..street2, blipSettings)
    TriggerClientEvent('dispatch:death', src)
end)

QBCore.Functions.CreateCallback('hospital:GetDoctors', function(source, cb)
    local amount = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "ambulance" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
    cb(amount)
end)

QBCore.Commands.Add("status", "Check a person's health (EMS Only)", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "ambulance" then
        TriggerClientEvent("hospital:client:CheckStatus", source)
    else
        TriggerClientEvent('chat:addMessage', source , {
            template = '<div class="chat-message emergency"><b>SYSTEM:</b> {0}</div>',
            args = { "This command is for emergency services!" }
        })
    end
end)

QBCore.Commands.Add("heal", "Help a person's injuries (EMS Only)", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "ambulance" then
        if Player.Functions.GetItemByName('bandage') ~= nil then
            TriggerClientEvent("hospital:client:TreatWounds", source)
        else
            TriggerClientEvent('chat:addMessage', source , {
                template = '<div class="chat-message emergency"><b>SYSTEM:</b> {0}</div>',
                args = { "You dont have bandage!" }
            })
        end
    else
        TriggerClientEvent('chat:addMessage', source , {
            template = '<div class="chat-message emergency"><b>SYSTEM:</b> {0}</div>',
            args = { "This command is for emergency services!" }
        })
    end
end)

QBCore.Commands.Add("revivep", "Help a person up (EMS Only)", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    
    if Player.PlayerData.job.name == "ambulance" then
        if Player.Functions.GetItemByName('medkit') >= 1 then
            TriggerClientEvent("hospital:client:RevivePlayer", source)
            TriggerClientEvent("hospital:client:UseMedkit", source)
        else
            TriggerClientEvent('chat:addMessage', source , {
                template = '<div class="chat-message emergency"><b>SYSTEM:</b> {0}</div>',
                args = { "You dont have medkit!" }
            })
        end
    else
        TriggerClientEvent('chat:addMessage', source , {
            template = '<div class="chat-message emergency"><b>SYSTEM:</b> {0}</div>',
            args = { "This command is for emergency services!" }
        })
    end
end)

QBCore.Commands.Add("revive", "Revive a player or yourself", {{name="id", help="Player ID (may be empty)"}}, false, function(source, args)
    if args[1] ~= nil then
        local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
        if Player ~= nil then
            TriggerClientEvent('hospital:client:Revive', Player.PlayerData.source)
        else
            TriggerClientEvent('chat:addMessage', source , {
                template = '<div class="chat-message emergency"><b>SYSTEM:</b> {0}</div>',
                args = { "Player is not online!" }
            })
        end
    else
        TriggerClientEvent('hospital:client:Revive', source)
    end
end, "admin")

QBCore.Commands.Add("kill", "Kill a player or yourself", {{name="id", help="Player ID (may be empty)"}}, false, function(source, args)
    if args[1] ~= nil then
        local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
        if Player ~= nil then
            TriggerClientEvent('hospital:client:KillPlayer', Player.PlayerData.source)
        else
            TriggerClientEvent('chat:addMessage', source , {
                template = '<div class="chat-message emergency"><b>SYSTEM:</b> {0}</div>',
                args = { "Player is not online!" }
            })
        end
    else
        TriggerClientEvent('hospital:client:KillPlayer', source)
    end
end, "god")

QBCore.Functions.CreateUseableItem("bandage", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("hospital:client:UseBandage", source)
    end
end)

QBCore.Functions.CreateUseableItem("painkillers", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("hospital:client:UsePainkillers", source)
    end
end)

QBCore.Functions.CreateUseableItem("firstaid", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("hospital:client:UseFirstAid", source)
    end
end)

QBCore.Functions.CreateUseableItem("medkit", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent("hospital:client:UseMedkit", source)
    end
end)

RegisterServerEvent('hospital:server:UseFirstAid')
AddEventHandler('hospital:server:UseFirstAid', function(targetId)
    local src = source
    local Target = QBCore.Functions.GetPlayer(targetId)
    if Target ~= nil then
        TriggerClientEvent('hospital:client:CanHelp', targetId, src)
    end
end)

RegisterServerEvent('hospital:server:CanHelp')
AddEventHandler('hospital:server:CanHelp', function(helperId, canHelp)
    local src = source
    if canHelp then
        TriggerClientEvent('hospital:client:HelpPerson', helperId, src)
    else
        TriggerClientEvent('QBCore:Notify', helperId, "You cannot help this person yet..", "error")
    end
end)