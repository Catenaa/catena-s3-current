QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local permissions = {
    ["kick"] = "admin",
    ["ban"] = "admin",
    ["noclip"] = "admin",
    ["kickall"] = "admin",
}

RegisterServerEvent('ctn-admin:server:togglePlayerNoclip')
AddEventHandler('ctn-admin:server:togglePlayerNoclip', function(playerId, reason)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions["noclip"]) then
        TriggerClientEvent("ctn-admin:client:toggleNoclip", playerId)
    end
end)

RegisterServerEvent('ctn-admin:server:killPlayer')
AddEventHandler('ctn-admin:server:killPlayer', function(playerId)
    TriggerClientEvent('hospital:client:KillPlayer', playerId)
end)

RegisterServerEvent('ctn-admin:server:kickPlayer')
AddEventHandler('ctn-admin:server:kickPlayer', function(playerId, reason)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions["kick"]) then
        DropPlayer(playerId, "You have been kicked out of the server:\n"..reason.."\n\n🔸 Check the discord for more informations: https://discord.gg/Gb3qY9b")
    end
end)

RegisterServerEvent('ctn-admin:server:Freeze')
AddEventHandler('ctn-admin:server:Freeze', function(playerId, toggle)
    TriggerClientEvent('ctn-admin:client:Freeze', playerId, toggle)
end)

RegisterServerEvent('ctn-admin:server:serverKick')
AddEventHandler('ctn-admin:server:serverKick', function(reason)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions["kickall"]) then
        for k, v in pairs(QBCore.Functions.GetPlayers()) do
            if v ~= src then 
                DropPlayer(v, "You have been kicked out of the server:\n"..reason.."\n\n🔸 Check the discord for more informations: https://discord.gg/Gb3qY9b")
            end
        end
    end
end)

RegisterServerEvent('ctn-admin:server:banPlayer')
AddEventHandler('ctn-admin:server:banPlayer', function(playerId, time, reason)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions["ban"]) then
        local time = tonumber(time)
        local banTime = tonumber(os.time() + time)
        if banTime > 2147483647 then
            banTime = 2147483647
        end
        local timeTable = os.date("*t", banTime)
        TriggerClientEvent('chatMessage', -1, "BANHAMMER", "error", GetPlayerName(playerId).." is banned for: "..reason)
        QBCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(playerId).."', '"..GetPlayerIdentifiers(playerId)[1].."', '"..GetPlayerIdentifiers(playerId)[2].."', '"..GetPlayerIdentifiers(playerId)[3].."', '"..GetPlayerIdentifiers(playerId)[4].."', '"..reason.."', "..banTime..", '"..GetPlayerName(src).."')")
        DropPlayer(playerId, "You have been banned of the server:\n"..reason.."\n\nBan expire "..timeTable["day"].. "/" .. timeTable["month"] .. "/" .. timeTable["year"] .. " " .. timeTable["hour"].. ":" .. timeTable["min"] .. "\n🔸 Check the discord for more informations: https://discord.gg/Gb3qY9b")
    end
end)

RegisterServerEvent('ctn-admin:server:revivePlayer')
AddEventHandler('ctn-admin:server:revivePlayer', function(target)
	TriggerClientEvent('hospital:client:Revive', target)
end)

QBCore.Commands.Add("announce", "Send a message to everyone", {}, false, function(source, args)
    local msg = table.concat(args, " ")
    for i = 1, 3, 1 do
        TriggerClientEvent('chatMessage', -1, "SYSTEM", "error", msg)
    end
end, "admin")

QBCore.Commands.Add("admin", "Open admin menu", {}, false, function(source, args)
    local group = QBCore.Functions.GetPermission(source)
    --local dealers = exports['ctn-drugs']:GetDealers()
    TriggerClientEvent('ctn-admin:client:openMenu', source, group, dealers)
end, "admin")

QBCore.Commands.Add("report", "Send a report to admins (only when necessary, DO NOT ABUSE IT)", {{name="message", help="Message that you want to send"}}, true, function(source, args)
    local msg = table.concat(args, " ")
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('ctn-admin:client:SendReport', -1, GetPlayerName(source), source, msg)
    TriggerClientEvent('chatMessage', source, "REPORT SENT", "normal", msg)
    TriggerEvent("ctn-logs:server:CreateLog", "report", "Report", "green", "**"..GetPlayerName(source).."** (CitizenID: "..Player.PlayerData.citizenid.." | ID: "..source..") **Report:** " ..msg, false)
    TriggerEvent("ctn-logs:server:sendLog", Player.PlayerData.citizenid, "reportreply", {message=msg})
end)

QBCore.Commands.Add("staffchat", "Send message to all staff", {{name="message", help="Message that you want to send"}}, true, function(source, args)
    local msg = table.concat(args, " ")

    TriggerClientEvent('ctn-admin:client:SendStaffChat', -1, GetPlayerName(source), msg)
end, "admin")

QBCore.Commands.Add("givenuifocus", "Give nui focus", {{name="id", help="Player ID"}, {name="focus", help="Toggle focus on/off"}, {name="mouse", help="Toggle mouse on/off"}}, true, function(source, args)
    local playerid = tonumber(args[1])
    local focus = args[2]
    local mouse = args[3]

    TriggerClientEvent('ctn-admin:client:GiveNuiFocus', playerid, focus, mouse)
end, "admin")

QBCore.Commands.Add("s", "Send message to all staff", {{name="message", help="Message that you want to send"}}, true, function(source, args)
    local msg = table.concat(args, " ")

    TriggerClientEvent('ctn-admin:client:SendStaffChat', -1, GetPlayerName(source), msg)
end, "admin")

QBCore.Commands.Add("warn", "Warn someone", {{name="ID", help="Player ID"}, {name="Reason", help="Reason"}}, true, function(source, args)
    local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local senderPlayer = QBCore.Functions.GetPlayer(source)
    table.remove(args, 1)
    local msg = table.concat(args, " ")

    local myName = senderPlayer.PlayerData.name

    local warnId = "WARN-"..math.random(1111, 9999)

    if targetPlayer ~= nil then
        TriggerClientEvent('chatMessage', targetPlayer.PlayerData.source, "SYSTEM", "error", "U have been warned for: "..GetPlayerName(source)..", Reason: "..msg)
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "The player "..GetPlayerName(targetPlayer.PlayerData.source).." warned for: "..msg)
        QBCore.Functions.ExecuteSql(false, "INSERT INTO `player_warns` (`senderIdentifier`, `targetIdentifier`, `reason`, `warnId`) VALUES ('"..senderPlayer.PlayerData.steam.."', '"..targetPlayer.PlayerData.steam.."', '"..msg.."', '"..warnId.."')")
    else
        TriggerClientEvent('QBCore:Notify', source, 'This person is not in the city of #YOLO, hmm I am '..myName..' and i smell bad', 'error')
    end 
end, "admin")

QBCore.Commands.Add("checkwarns", "Give a person a warning", {{name="ID", help="Player ID"}, {name="Warning", help="Number of warns (1, 2 of 3 etc..)"}}, false, function(source, args)
    if args[2] == nil then
        local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        QBCore.Functions.ExecuteSql(false, "SELECT * FROM `player_warns` WHERE `targetIdentifier` = '"..targetPlayer.PlayerData.steam.."'", function(result)
            TriggerClientEvent('chatMessage', source, "SYSTEM", "warning", targetPlayer.PlayerData.name.." heeft "..tablelength(result).." waarschuwingen!")
        end)
    else
        local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))

        QBCore.Functions.ExecuteSql(false, "SELECT * FROM `player_warns` WHERE `targetIdentifier` = '"..targetPlayer.PlayerData.steam.."'", function(warnings)
            local selectedWarning = tonumber(args[2])

            if warnings[selectedWarning] ~= nil then
                local sender = QBCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)

                TriggerClientEvent('chatMessage', source, "SYSTEM", "warning", targetPlayer.PlayerData.name.." has been warned by "..sender.PlayerData.name..", Reason: "..warnings[selectedWarning].reason)
            end
        end)
    end
end, "admin")

QBCore.Commands.Add("removewarn", "Remove warns of someone", {{name="ID", help="Player ID"}, {name="Warning", help="Number of warns (1, 2 of 3 etc..)"}}, true, function(source, args)
    local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))

    QBCore.Functions.ExecuteSql(false, "SELECT * FROM `player_warns` WHERE `targetIdentifier` = '"..targetPlayer.PlayerData.steam.."'", function(warnings)
        local selectedWarning = tonumber(args[2])

        if warnings[selectedWarning] ~= nil then
            local sender = QBCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)

            TriggerClientEvent('chatMessage', source, "SYSTEM", "warning", "The warn ("..selectedWarning..") has been removed, Reason: "..warnings[selectedWarning].reason)
            QBCore.Functions.ExecuteSql(false, "DELETE FROM `player_warns` WHERE `warnId` = '"..warnings[selectedWarning].warnId.."'")
        end
    end)
end, "admin")

function tablelength(table)
    local count = 0
    for _ in pairs(table) do 
        count = count + 1 
    end
    return count
end

QBCore.Commands.Add("reportr", "Reply to a report", {}, false, function(source, args)
    local playerId = tonumber(args[1])
    table.remove(args, 1)
    local msg = table.concat(args, " ")
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    local Player = QBCore.Functions.GetPlayer(source)
    if OtherPlayer ~= nil then
        TriggerClientEvent('chatMessage', playerId, "ADMIN - "..GetPlayerName(source), "warning", msg)
        TriggerClientEvent('QBCore:Notify', source, "Response sent")
        TriggerEvent("ctn-logs:server:sendLog", Player.PlayerData.citizenid, "reportreply", {otherCitizenId=OtherPlayer.PlayerData.citizenid, message=msg})
        for k, v in pairs(QBCore.Functions.GetPlayers()) do
            if QBCore.Functions.HasPermission(v, "admin") then
                if QBCore.Functions.IsOptin(v) then
                    TriggerClientEvent('chatMessage', v, "ReportReply("..source..") - "..GetPlayerName(source), "warning", msg)
                    TriggerEvent("ctn-logs:server:CreateLog", "report", "Report Reply", "red", "**"..GetPlayerName(source).."** answered to: **"..OtherPlayer.PlayerData.name.. " **(ID: "..OtherPlayer.PlayerData.source..") **Message:** " ..msg, false)
                end
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "Player is not online", "error")
    end
end, "admin")

QBCore.Commands.Add("setmodel", "Change into a model of your choice..", {{name="model", help="Name of the model"}, {name="id", help="Id of the player"}}, false, function(source, args)
    local model = args[1]
    local target = tonumber(args[2])

    if model ~= nil or model ~= "" then
        if target == nil then
            TriggerClientEvent('ctn-admin:client:SetModel', source, tostring(model))
        else
            local Trgt = QBCore.Functions.GetPlayer(target)
            if Trgt ~= nil then
                TriggerClientEvent('ctn-admin:client:SetModel', target, tostring(model))
            else
                TriggerClientEvent('QBCore:Notify', source, "This person is not in town yeet..", "error")
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "You have not provided a Model..", "error")
    end
end, "admin")

QBCore.Commands.Add("setspeed", "Setspeed..", {}, false, function(source, args)
    local speed = args[1]

    if speed ~= nil then
        TriggerClientEvent('ctn-admin:client:SetSpeed', source, tostring(speed))
    else
        TriggerClientEvent('QBCore:Notify', source, "You did not specify Speed ​​.. (`fast` for super-run,`normal` for normal)", "error")
    end
end, "admin")


QBCore.Commands.Add("admincar", "Place vehicle in your garage", {}, false, function(source, args)
    local ply = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('ctn-admin:client:SaveCar', source)
end, "admin")

RegisterServerEvent('ctn-admin:server:SaveCar')
AddEventHandler('ctn-admin:server:SaveCar', function(props, stats, hash, model, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    QBCore.Functions.ExecuteSql(false, "SELECT * FROM `ctnvehicles` WHERE `plate` = '"..plate.."'", function(result)
        if result[1] == nil then
            QBCore.Functions.ExecuteSql(false, "INSERT INTO `ctnvehicles` (`citizenid`, `plate`, `model`, `props`, `stats`, `state`) VALUES ('" .. Player.PlayerData.citizenid .. "', '" .. props.plate .. "', '" .. model .. "', '" .. json.encode(props) .. "', '" .. json.encode(stats) .. "', 'unknown')")
            TriggerClientEvent('QBCore:Notify', src, 'The vehicle is now in your name!', 'success', 5000)
        else
            TriggerClientEvent('QBCore:Notify', src, 'This vehicle is already in your garage..', 'error', 3000)
        end
    end)
end)

QBCore.Commands.Add("reporttoggle", "Toggle reports", {}, false, function(source, args)
    QBCore.Functions.ToggleOptin(source)
    if QBCore.Functions.IsOptin(source) then
        TriggerClientEvent('QBCore:Notify', source, "You DO get reports", "success")
    else
        TriggerClientEvent('QBCore:Notify', source, "You havent got reports", "error")
    end
end, "admin")

RegisterCommand("kickall", function(source, args, rawCommand)
    local src = source
    
    if src > 0 then
        local reason = table.concat(args, ' ')
        local Player = QBCore.Functions.GetPlayer(src)

        if QBCore.Functions.HasPermission(src, "god") then
            if args[1] ~= nil then
                for k, v in pairs(QBCore.Functions.GetPlayers()) do
                    local Player = QBCore.Functions.GetPlayer(v)
                    if Player ~= nil then 
                        DropPlayer(Player.PlayerData.source, reason)
                    end
                end
            else
                TriggerClientEvent('chatMessage', src, 'SYSTEM', 'error', 'Provide a reason..')
            end
        else
            TriggerClientEvent('chatMessage', src, 'SYSTEM', 'error', 'You can\'t just do this baby..')
        end
    else
        for k, v in pairs(QBCore.Functions.GetPlayers()) do
            local Player = QBCore.Functions.GetPlayer(v)
            if Player ~= nil then 
                DropPlayer(Player.PlayerData.source, "Server restart, check the discord for more informations! (discord.gg/Gb3qY9b)")
            end
        end
    end
end, false)

RegisterServerEvent('ctn-admin:server:bringTp')
AddEventHandler('ctn-admin:server:bringTp', function(targetId, coords)
    TriggerClientEvent('ctn-admin:client:bringTp', targetId, coords)
end)

QBCore.Functions.CreateCallback('ctn-admin:server:hasPermissions', function(source, cb, group)
    local src = source
    local retval = false

    if QBCore.Functions.HasPermission(src, group) then
        retval = true
    end
    cb(retval)
end)

RegisterServerEvent('ctn-admin:server:setPermissions')
AddEventHandler('ctn-admin:server:setPermissions', function(targetId, group)
    QBCore.Functions.AddPermission(targetId, group.rank)
    TriggerClientEvent('QBCore:Notify', targetId, 'Your permission group is set to '..group.label)
end)

RegisterServerEvent('ctn-admin:server:OpenSkinMenu')
AddEventHandler('ctn-admin:server:OpenSkinMenu', function(targetId)
    TriggerClientEvent("ctn-clothing:client:openMenu", targetId)
end)

RegisterServerEvent('ctn-admin:server:SendReport')
AddEventHandler('ctn-admin:server:SendReport', function(name, targetSrc, msg)
    local src = source
    local Players = QBCore.Functions.GetPlayers()

    if QBCore.Functions.HasPermission(src, "admin") then
        if QBCore.Functions.IsOptin(src) then
            TriggerClientEvent('chatMessage', src, "REPORT - "..name.." ("..targetSrc..")", "report", msg)
        end
    end
end)

RegisterServerEvent('ctn-admin:server:StaffChatMessage')
AddEventHandler('ctn-admin:server:StaffChatMessage', function(name, msg)
    local src = source
    local Players = QBCore.Functions.GetPlayers()

    if QBCore.Functions.HasPermission(src, "admin") then
        if QBCore.Functions.IsOptin(src) then
            TriggerClientEvent('chatMessage', src, "STAFFCHAT - "..name, "error", msg)
        end
    end
end)

QBCore.Commands.Add("setammo", "Staff: Set manual ammo for a weapon.", {{name="amount", help="amount of ammos, ex: 20"}, {name="weapon", help="Name of the weapon,ex: WEAPON_RAILGUN"}}, false, function(source, args)
    local src = source
    local weapon = args[2]
    local amount = tonumber(args[1])

    if weapon ~= nil then
        TriggerClientEvent('ctn-weapons:client:SetWeaponAmmoManual', src, weapon, amount)
    else
        TriggerClientEvent('ctn-weapons:client:SetWeaponAmmoManual', src, "current", amount)
    end
end, 'admin')
