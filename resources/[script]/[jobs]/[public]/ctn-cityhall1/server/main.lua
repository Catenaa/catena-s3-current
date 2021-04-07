QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local DrivingSchools = {
    "PAE31194",
    "TRB56419",
    "UNA59325",
    "LWR55470",
    "APJ79416",
    "FUN28030",
}

RegisterServerEvent('ctn-cityhall:server:requestId')
AddEventHandler('ctn-cityhall:server:requestId', function(identityData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local licenses = {
        ["driver"] = true,
        ["business"] = false
    }

    local info = {}
    if identityData.item == "id_card" then
        info.citizenid = Player.PlayerData.citizenid
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.gender = Player.PlayerData.charinfo.gender
        info.nationality = Player.PlayerData.charinfo.nationality
    elseif identityData.item == "driver_license" then
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.birthdate = Player.PlayerData.charinfo.birthdate
        info.type = "A1-A2-A | AM-B | C1-C-CE"
    end

    Player.Functions.AddItem(identityData.item, 1, nil, info)

    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[identityData.item], 'add')
end)

RegisterServerEvent('ctn-cityhall:server:sendDriverTest')
AddEventHandler('ctn-cityhall:server:sendDriverTest', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    for k, v in pairs(DrivingSchools) do 
        local SchoolPlayer = QBCore.Functions.GetPlayerByCitizenId(v)
        if SchoolPlayer ~= nil then 
            TriggerClientEvent("ctn-cityhall:client:sendDriverEmail", SchoolPlayer.PlayerData.source, Player.PlayerData.charinfo)
        else
            local mailData = {
                sender = "Government",
                subject = "Driving lessons",
                message = "Dear,<br /><br />We have just received a message that someone wants to take driving lessons.<br />If you are willing to teach, please contact us:<br />Name: <strong>".. Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. "<br />Phone number: <strong>"..Player.PlayerData.charinfo.phone.."</strong><br/><br/>Sincerely,<br />Los Santos Government",
                button = {}
            }
            TriggerEvent("ctn-phone:server:sendNewEventMail", v, mailData)
        end
    end
    TriggerClientEvent('QBCore:Notify', src, 'An email has been sent to driving schools, you will be contacted automatically', "success", 5000)
end)

RegisterServerEvent('ctn-cityhall:server:ApplyJob')
AddEventHandler('ctn-cityhall:server:ApplyJob', function(job)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local JobInfo = QBCore.Shared.Jobs[job]

    Player.Functions.SetJob(job)

    TriggerClientEvent('QBCore:Notify', src, 'Congratulations with your new job! ('..JobInfo.label..')')
end)

QBCore.Commands.Add("givedriverl", "Give a player driver license", {{"id", "ID of the player"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if IsWhitelistedSchool(Player.PlayerData.citizenid) then
        local SearchedPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        if SearchedPlayer ~= nil then
            local driverLicense = SearchedPlayer.PlayerData.metadata["licences"]["driver"]
            if not driverLicense then
                local licenses = {
                    ["driver"] = true,
                    ["business"] = SearchedPlayer.PlayerData.metadata["licences"]["business"]
                }
                SearchedPlayer.Functions.SetMetaData("licences", licenses)
                TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "You are graduated! Pick up your driver's license at the town hall", "success", 5000)
            else
                TriggerClientEvent('QBCore:Notify', src, "Can't issue driver's license..", "error")
            end
        end
    end
end)

function IsWhitelistedSchool(citizenid)
    local retval = false
    for k, v in pairs(DrivingSchools) do 
        if v == citizenid then
            retval = true
        end
    end
    return retval
end

RegisterServerEvent('ctn-cityhall:server:banPlayer')
AddEventHandler('ctn-cityhall:server:banPlayer', function()
    local src = source
    TriggerClientEvent('chatMessage', -1, "CTN Anti-Cheat", "error", GetPlayerName(src).." has been banned from sending POST Request's ")
    QBCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(src).."', '"..GetPlayerIdentifiers(src)[1].."', '"..GetPlayerIdentifiers(src)[2].."', '"..GetPlayerIdentifiers(src)[3].."', '"..GetPlayerIdentifiers(src)[4].."', 'Abuse localhost:13172 voor POST requests', 2145913200, '"..GetPlayerName(src).."')")
    DropPlayer(src, "This is not how we work huh;). Check our discord for more informatione: https://discord.gg/Gb3qY9b")
end)