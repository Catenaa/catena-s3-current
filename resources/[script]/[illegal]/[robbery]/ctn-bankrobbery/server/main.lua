QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local robberyBusy = false
local timeOut = false
local blackoutActive = false
local usedCameras = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000 * 60 * 10)
        if blackoutActive then
            TriggerEvent("CTN-weathersync:server:toggleBlackout")
            TriggerClientEvent("police:client:EnableAllCameras", -1)
            TriggerClientEvent("CTN-bankrobbery:client:enableAllBankSecurity", -1)
            blackoutActive = false
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000 * 60 * 30)
        TriggerClientEvent("CTN-bankrobbery:client:enableAllBankSecurity", -1)
        TriggerClientEvent("police:client:EnableAllCameras", -1)
    end
end)

RegisterServerEvent('CTN-bankrobbery:server:setBankState')
AddEventHandler('CTN-bankrobbery:server:setBankState', function(bankId, state)
    if bankId == "paleto" then
        if not robberyBusy then
            Config.BigBanks["paleto"]["isOpened"] = state
            TriggerClientEvent('CTN-bankrobbery:client:setBankState', -1, bankId,
                               state)
            TriggerEvent('CTN-scoreboard:server:SetActivityBusy', "bankrobbery",
                         true)
            TriggerEvent('CTN-bankrobbery:server:setTimeout')
        end
    elseif bankId == "pacific" then
        if not robberyBusy then
            Config.BigBanks["pacific"]["isOpened"] = state
            TriggerClientEvent('CTN-bankrobbery:client:setBankState', -1, bankId,
                               state)
            TriggerEvent('CTN-scoreboard:server:SetActivityBusy', "pacific", true)
            TriggerEvent('CTN-bankrobbery:server:setTimeout')
        end
    else
        if not robberyBusy then
            Config.SmallBanks[bankId]["isOpened"] = state
            TriggerClientEvent('CTN-bankrobbery:client:setBankState', -1, bankId,
                               state)
            TriggerEvent('CTN-banking:server:SetBankClosed', bankId, true)
            TriggerEvent('CTN-scoreboard:server:SetActivityBusy', "bankrobbery",
                         true)
            TriggerEvent('CTN-bankrobbery:server:SetSmallbankTimeout', bankId)
        end
    end
    robberyBusy = true
end)

RegisterServerEvent('CTN-bankrobbery:server:setLockerState')
AddEventHandler('CTN-bankrobbery:server:setLockerState',
                function(bankId, lockerId, state, bool)
    if bankId == "paleto" then
        Config.BigBanks["paleto"]["lockers"][lockerId][state] = bool
    elseif bankId == "pacific" then
        Config.BigBanks["pacific"]["lockers"][lockerId][state] = bool
    else
        Config.SmallBanks[bankId]["lockers"][lockerId][state] = bool
    end

    TriggerClientEvent('CTN-bankrobbery:client:setLockerState', -1, bankId,
                       lockerId, state, bool)
end)

RegisterServerEvent('CTN-bankrobbery:server:recieveItem')
AddEventHandler('CTN-bankrobbery:server:recieveItem', function(type, lockerID)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)

    if type == "small" then
        if lockerID == 9 then
            local chance = math.random(1, 100)
            if chance <= 50 then
                if ply.Functions.AddItem('security_card_03', 1) then
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['security_card_03'], "add")
                else
                    TriggerClientEvent('QBCore:Notify', src, "Couldnt add item, you may dont have free space on you.", "error")
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "You couldnt find any card there.", "error")
            end
        else
            if ply.Functions.AddItem('goldbar', math.random(5, 10)) then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], "add")
            else
                TriggerClientEvent('QBCore:Notify', src, "Couldnt add item, you may dont have free space on you.", "error")
            end
        end
    elseif type == "paleto" then
        if lockerID == 9 then
            local chance = math.random(1, 100)
            if chance <= 50 then
                if ply.Functions.AddItem('security_card_02', 1) then
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['security_card_01'], "add")
                    TriggerClientEvent('QBCore:Notify', src, "You found Golden Security Card! [Pacific]", "error")
                else
                    TriggerClientEvent('QBCore:Notify', src, "Couldnt add item, you may dont have free space on you.", "error")
                end
            else
                if ply.Functions.AddItem('security_card_01', 1) then
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['security_card_01'], "add")
                    TriggerClientEvent('QBCore:Notify', src, "You found Pink Security Card! [Paleto]", "error")
                else
                    TriggerClientEvent('QBCore:Notify', src, "Couldnt add item, you may dont have free space on you.", "error")
                end
            end
        else
            if ply.Functions.AddItem('goldbar', math.random(8, 13)) then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['goldbar'], "add")
            else
                TriggerClientEvent('QBCore:Notify', src, "Couldnt add item, you may dont have free space on you.", "error")
            end
        end
    elseif type == "pacific" then
        if ply.Functions.AddItem('markedbills', math.random(1, 3)) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "add")
        else
            TriggerClientEvent('QBCore:Notify', src, "Couldnt add item, you may dont have free space on you.", "error")
        end
    end
end)

QBCore.Functions.CreateCallback('CTN-bankrobbery:server:isRobberyActive', function(source, cb) cb(robberyBusy) end)
QBCore.Functions.CreateCallback('CTN-bankrobbery:server:GetConfig', function(source, cb) cb(Config) end)

RegisterServerEvent('CTN-bankrobbery:server:setTimeout')
AddEventHandler('CTN-bankrobbery:server:setTimeout', function()
    if not robberyBusy then
        if not timeOut then
            timeOut = true
            Citizen.CreateThread(function()
                Citizen.Wait(30 * (60 * 1000))
                timeOut = false
                robberyBusy = false
                TriggerEvent('CTN-scoreboard:server:SetActivityBusy', "bankrobbery", false)
                TriggerEvent('CTN-scoreboard:server:SetActivityBusy', "pacific", false)

                for k, v in pairs(Config.BigBanks["pacific"]["lockers"]) do
                    Config.BigBanks["pacific"]["lockers"][k]["isBusy"] = false
                    Config.BigBanks["pacific"]["lockers"][k]["isOpened"] = false
                end

                for k, v in pairs(Config.BigBanks["paleto"]["lockers"]) do
                    Config.BigBanks["paleto"]["lockers"][k]["isBusy"] = false
                    Config.BigBanks["paleto"]["lockers"][k]["isOpened"] = false
                end

                TriggerClientEvent('CTN-bankrobbery:client:ClearTimeoutDoors', -1)
                Config.BigBanks["paleto"]["isOpened"] = false
                Config.BigBanks["pacific"]["isOpened"] = false
            end)
        end
    end
end)

RegisterServerEvent('CTN-bankrobbery:server:SetSmallbankTimeout')
AddEventHandler('CTN-bankrobbery:server:SetSmallbankTimeout', function(BankId)
    if not robberyBusy then
        SetTimeout(30 * (60 * 1000), function()
            Config.SmallBanks[BankId]["isOpened"] = false
            for k, v in pairs(Config.SmallBanks[BankId]["lockers"]) do
                Config.SmallBanks[BankId]["lockers"][k]["isOpened"] = false
                Config.SmallBanks[BankId]["lockers"][k]["isBusy"] = false
            end
            timeOut = false
            robberyBusy = false
            usedCameras = {}
            TriggerClientEvent('CTN-bankrobbery:client:ResetFleecaLockers', -1,
                               BankId)
            TriggerEvent('CTN-banking:server:SetBankClosed', BankId, false)
        end)
    end
end)

RegisterServerEvent('CTN-bankrobbery:server:callCops')
AddEventHandler('CTN-bankrobbery:server:callCops', function(type, bank)
    local src = source
    local cameraId = 4
    if type == "small" then
        cameraId = Config.SmallBanks[bank]["camId"]
    elseif type == "paleto" then
        cameraId = Config.BigBanks["paleto"]["camId"]
    elseif type == "pacific" then
        cameraId = math.random(3)
    end

    if not usedCameras[cameraId] then
        usedCameras[cameraId] = true
        TriggerClientEvent("police:camera", -1, cameraId)
    end
end)

RegisterServerEvent('CTN-bankrobbery:server:SetStationStatus')
AddEventHandler('CTN-bankrobbery:server:SetStationStatus', function(key, isHit)
    Config.PowerStations[key].hit = isHit
    TriggerClientEvent("CTN-bankrobbery:client:SetStationStatus", -1, key, isHit)
    if AllStationsHit() then
        TriggerEvent("CTN-weathersync:server:toggleBlackout")
        TriggerClientEvent("police:client:DisableAllCameras", -1)
        TriggerClientEvent("CTN-bankrobbery:client:disableAllBankSecurity", -1)
        blackoutActive = true
    else
        CheckStationHits()
    end
end)

RegisterServerEvent('thermite:StartServerFire')
AddEventHandler('thermite:StartServerFire',
                function(coords, maxChildren, isGasFire)
    TriggerClientEvent("thermite:StartFire", -1, coords, maxChildren, isGasFire)
end)

RegisterServerEvent('thermite:StopFires')
AddEventHandler('thermite:StopFires', function(coords, maxChildren, isGasFire)
    TriggerClientEvent("thermite:StopFires", -1)
end)

function CheckStationHits()
    if Config.PowerStations[1].hit and Config.PowerStations[2].hit and
        Config.PowerStations[3].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 19, false)
    end
    if Config.PowerStations[3].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 18, false)
        TriggerClientEvent("police:client:SetCamera", -1, 7, false)
    end
    if Config.PowerStations[4].hit and Config.PowerStations[5].hit and
        Config.PowerStations[6].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 4, false)
        TriggerClientEvent("police:client:SetCamera", -1, 8, false)
        TriggerClientEvent("police:client:SetCamera", -1, 5, false)
        TriggerClientEvent("police:client:SetCamera", -1, 6, false)
    end
    if Config.PowerStations[1].hit and Config.PowerStations[2].hit and
        Config.PowerStations[3].hit and Config.PowerStations[4].hit and
        Config.PowerStations[5].hit and Config.PowerStations[6].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 1, false)
        TriggerClientEvent("police:client:SetCamera", -1, 2, false)
        TriggerClientEvent("police:client:SetCamera", -1, 3, false)
    end
    if Config.PowerStations[7].hit and Config.PowerStations[8].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 9, false)
        TriggerClientEvent("police:client:SetCamera", -1, 10, false)
    end
    if Config.PowerStations[9].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 11, false)
        TriggerClientEvent("police:client:SetCamera", -1, 12, false)
        TriggerClientEvent("police:client:SetCamera", -1, 13, false)
    end
    if Config.PowerStations[9].hit and Config.PowerStations[10].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 14, false)
        TriggerClientEvent("police:client:SetCamera", -1, 17, false)
        TriggerClientEvent("police:client:SetCamera", -1, 19, false)
    end
    if Config.PowerStations[7].hit and Config.PowerStations[9].hit and
        Config.PowerStations[10].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 15, false)
        TriggerClientEvent("police:client:SetCamera", -1, 16, false)
    end
    if Config.PowerStations[10].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 20, false)
    end
    if Config.PowerStations[11].hit and Config.PowerStations[1].hit and
        Config.PowerStations[2].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 21, false)
        TriggerClientEvent("CTN-bankrobbery:client:BankSecurity", 1, false)
        TriggerClientEvent("police:client:SetCamera", -1, 22, false)
        TriggerClientEvent("CTN-bankrobbery:client:BankSecurity", 2, false)
    end
    if Config.PowerStations[8].hit and Config.PowerStations[4].hit and
        Config.PowerStations[5].hit and Config.PowerStations[6].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 23, false)
        TriggerClientEvent("CTN-bankrobbery:client:BankSecurity", 3, false)
    end
    if Config.PowerStations[12].hit and Config.PowerStations[13].hit then
        TriggerClientEvent("police:client:SetCamera", -1, 24, false)
        TriggerClientEvent("CTN-bankrobbery:client:BankSecurity", 4, false)
        TriggerClientEvent("police:client:SetCamera", -1, 25, false)
        TriggerClientEvent("CTN-bankrobbery:client:BankSecurity", 5, false)
    end
end

function AllStationsHit()
    local retval = true
    for k, v in pairs(Config.PowerStations) do
        if not Config.PowerStations[k].hit then retval = false end
    end
    return retval
end

QBCore.Functions.CreateUseableItem("electronickit", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName('electronickit') ~= nil then
        TriggerClientEvent("electronickit:UseElectronickit", source)
    else
        TriggerClientEvent('QBCore:Notify', source, "You're missing something to blaze it on", "error")
    end
end)

QBCore.Functions.CreateUseableItem("thermite", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName('lighter') ~= nil then
        TriggerClientEvent("thermite:UseThermite", source)
    else
        TriggerClientEvent('QBCore:Notify', source, "You're missing something to blaze it on", "error")
    end
end)

RegisterServerEvent('fleeca:log')
AddEventHandler('fleeca:log', function()
	local Player = QBCore.Functions.GetPlayer(source)
	
	TriggerClientEvent('fleeca:log')
	FleecaMsg(Player, 'Fleeca Bank Robbery: Item Collected.')
end)

QBCore.Functions.CreateUseableItem("security_card_02", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName('security_card_02') ~= nil then
        TriggerClientEvent("CTN-bankrobbery:UseBankcardB", source)
		PacificMsg(Player, 'Pacific Bank Robbery: Robbery started..')
    end
end)

QBCore.Functions.CreateUseableItem("security_card_01", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName('security_card_01') ~= nil then
        TriggerClientEvent("CTN-bankrobbery:UseBankcardA", source)
		PaletoMsg(Player, 'Paleto Bank Robbery: Robbery started..')
    end
end)

function FleecaMsg(Player, text)
    local playerName = System(Player.getName())
   
    local discord_webhook = Config.FleecaLog
    if discord_webhook == '' then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "Fleeca Bank Robbery Log",
      ["embeds"] = {{
        ["author"] = {
          ["name"] = playerName .. ' - ' .. Player.identifier
        },
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
      }}
    }
    data['embeds'][1]['description'] = text
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end

function PaletoMsg(Player, text)
    local playerName = System(Player.getName())
   
    local discord_webhook = Config.PaletoLog
    if discord_webhook == '' then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "Paleto Bank Robbery Log",
      ["embeds"] = {{
        ["author"] = {
          ["name"] = playerName .. ' - ' .. Player.identifier
        },
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
      }}
    }
    data['embeds'][1]['description'] = text
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end

function PacificMsg(Player, text)
    local playerName = System(Player.getName())
   
    local discord_webhook = Config.PacificLog
    if discord_webhook == '' then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "Pacific Bank Robbery Log",
      ["embeds"] = {{
        ["author"] = {
          ["name"] = playerName .. ' - ' .. Player.identifier
        },
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
      }}
    }
    data['embeds'][1]['description'] = text
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end