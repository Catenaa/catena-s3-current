QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

--CODE

local Races = {}
RegisterServerEvent('ctn-streetraces:NewRace')
AddEventHandler('ctn-streetraces:NewRace', function(RaceTable)
    local src = source
    local RaceId = math.random(1000, 9999)
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer.Functions.RemoveMoney('cash', RaceTable.amount, "streetrace-created") then
        Races[RaceId] = RaceTable
        Races[RaceId].creator = GetPlayerIdentifiers(src)[1]
        table.insert(Races[RaceId].joined, GetPlayerIdentifiers(src)[1])
        TriggerClientEvent('ctn-streetraces:SetRace', -1, Races)
        TriggerClientEvent('ctn-streetraces:SetRaceId', src, RaceId)
        TriggerClientEvent('QBCore:Notify', src, "You participate in the race €"..Races[RaceId].amount..",-", 'success')
    end
end)

RegisterServerEvent('ctn-streetraces:RaceWon')
AddEventHandler('ctn-streetraces:RaceWon', function(RaceId)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    xPlayer.Functions.AddMoney('cash', Races[RaceId].pot, "race-won")
    TriggerClientEvent('QBCore:Notify', src, "You have won the race and €"..Races[RaceId].pot..",- ", 'success')
    TriggerClientEvent('ctn-streetraces:SetRace', -1, Races)
    TriggerClientEvent('ctn-streetraces:RaceDone', -1, RaceId, GetPlayerName(src))
end)

RegisterServerEvent('ctn-streetraces:JoinRace')
AddEventHandler('ctn-streetraces:JoinRace', function(RaceId)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local zPlayer = QBCore.Functions.GetPlayer(Races[RaceId].creator)
    if zPlayer ~= nil then
        if xPlayer.PlayerData.money.cash >= Races[RaceId].amount then
            Races[RaceId].pot = Races[RaceId].pot + Races[RaceId].amount
            table.insert(Races[RaceId].joined, GetPlayerIdentifiers(src)[1])
            if xPlayer.Functions.RemoveMoney('cash', Races[RaceId].amount, "streetrace-joined") then
                TriggerClientEvent('ctn-streetraces:SetRace', -1, Races)
                TriggerClientEvent('ctn-streetraces:SetRaceId', src, RaceId)
                TriggerClientEvent('QBCore:Notify', zPlayer.PlayerData.source, GetPlayerName(src).." is joined!", 'primary')
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You don't have enough cash in your pocket!", 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "The one who made the race is offline!", 'error')
        Races[RaceId] = {}
    end
end)

QBCore.Commands.Add("race", "Create a race.", {{name="amount", help="Amount of money to start the race."}}, true, function(source, args)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local amount = tonumber(args[1])
    if GetJoinedRace(GetPlayerIdentifiers(src)[1]) == 0 then
        if xPlayer.PlayerData.money.cash >= amount then
            TriggerClientEvent('ctn-streetraces:CreateRace', src, amount)
        else
            TriggerClientEvent('QBCore:Notify', src, "You don't have enough cash in your pocket!", 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You are already in a race!", 'error')
    end
end)

QBCore.Commands.Add("stoprace", "Stop the race (creator).", {}, false, function(source, args)
    local src = source
    CancelRace(src)
end)

QBCore.Commands.Add("quitrace", "Leave the race. (U will lose your bets!)", {}, false, function(source, args)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local RaceId = GetJoinedRace(GetPlayerIdentifiers(src)[1])
    local zPlayer = QBCore.Functions.GetPlayer(Races[RaceId].creator)
    if RaceId ~= 0 then
        if GetCreatedRace(GetPlayerIdentifiers(src)[1]) ~= RaceId then
            RemoveFromRace(GetPlayerIdentifiers(src)[1])
            TriggerClientEvent('QBCore:Notify', src, "You have stepped out of the race! And you lost your money", 'error')
            TriggerClientEvent('esx:showNotification', zPlayer.PlayerData.source, GetPlayerName(src) .." stepped out of the race!", "red")
        else
            TriggerClientEvent('QBCore:Notify', src, "/stoprace to stop the race!", 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You are not in a race..", 'error')
    end
end)

QBCore.Commands.Add("startrace", "Race beginn", {}, false, function(source, args)
    local src = source
    local RaceId = GetCreatedRace(GetPlayerIdentifiers(src)[1])
    
    if RaceId ~= 0 then
        Races[RaceId].started = true
        TriggerClientEvent('ctn-streetraces:SetRace', -1, Races)
        TriggerClientEvent("ctn-streetraces:StartRace", -1, RaceId)
    else
        TriggerClientEvent('QBCore:Notify', src, "You have not started a race!", 'error')
    end
end)

function CancelRace(source)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local RaceId = GetCreatedRace(GetPlayerIdentifiers(source)[1])

    if RaceId ~= 0 then
        for key, race in pairs(Races) do
            if Races[key] ~= nil and Races[key].creator == xPlayer.PlayerData.steam then
                if not Races[key].started then
                    for _, iden in pairs(Races[key].joined) do
                        local xdPlayer = QBCore.Functions.GetPlayer(iden)
                        xdPlayer.Functions.AddMoney('cash', Races[key].amount, "race-cancelled")
                        TriggerClientEvent('QBCore:Notify', xdPlayer.PlayerData.source, "Race has stopped, you received back €"..Races[key].amount..",- !", 'error')
                        TriggerClientEvent('ctn-streetraces:StopRace', xdPlayer.PlayerData.source)
                        RemoveFromRace(iden)
                    end
                else
                    TriggerClientEvent('QBCore:Notify', xPlayer.PlayerData.source, "The race has already started..", 'error')
                end
                TriggerClientEvent('QBCore:Notify', source, "Race stopped!", 'error')
                Races[key] = nil
            end
        end
        TriggerClientEvent('ctn-streetraces:SetRace', -1, Races)
    else
        TriggerClientEvent('QBCore:Notify', source, "You have not started a race!", 'error')
    end
end

function RemoveFromRace(identifier)
    for key, race in pairs(Races) do
        if Races[key] ~= nil and not Races[key].started then
            for i, iden in pairs(Races[key].joined) do
                if iden == identifier then
                    table.remove(Races[key].joined, i)
                end
            end
        end
    end
end

function GetJoinedRace(identifier)
    for key, race in pairs(Races) do
        if Races[key] ~= nil and not Races[key].started then
            for _, iden in pairs(Races[key].joined) do
                if iden == identifier then
                    return key
                end
            end
        end
    end
    return 0
end

function GetCreatedRace(identifier)
    for key, race in pairs(Races) do
        if Races[key] ~= nil and Races[key].creator == identifier and not Races[key].started then
            return key
        end
    end
    return 0
end
