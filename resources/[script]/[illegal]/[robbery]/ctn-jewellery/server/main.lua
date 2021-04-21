QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local timeOut = false
local isintimeout = false
local alarmTriggered = false

RegisterServerEvent('ctn-jewellery:server:setVitrineState')
AddEventHandler('ctn-jewellery:server:setVitrineState', function(stateType, state, k)
    Config.Locations[k][stateType] = state
    TriggerClientEvent('ctn-jewellery:client:setVitrineState', -1, stateType, state, k)
end)

RegisterServerEvent('ctn-jewellery:server:vitrineReward')
AddEventHandler('ctn-jewellery:server:vitrineReward', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.AddItem("rolex", math.random(4, 6)) then
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["rolex"], 'add')
		dclog(Player, 'Jewelery Store: Glass deck broke.')
    else
        TriggerClientEvent('QBCore:Notify', src, 'You dont have space on your bag', 'error')
    end
end)

RegisterServerEvent('ctn-jewellery:server:setTimeout')
AddEventHandler('ctn-jewellery:server:setTimeout', function()
    if not timeOut then
        timeOut = true
        Citizen.CreateThread(function()
            Citizen.Wait(Config.Timeout)

            for k, v in pairs(Config.Locations) do
                Config.Locations[k]["isOpened"] = false
                TriggerClientEvent('ctn-jewellery:client:setVitrineState', -1, 'isOpened', false, k)
                TriggerClientEvent('ctn-jewellery:client:setAlertState', -1, false)
                TriggerClientEvent('ctn-jewellery:client:resetCameras', -1)
            end
            timeOut = false
            alarmTriggered = false
        end)
    end
end)

QBCore.Functions.CreateCallback('ctn-jewellery:server:getCops', function(source, cb)
	local amount = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
	end
	cb(amount)
end)

RegisterServerEvent('ctn-jewellery:server:startglobaltimeout')
AddEventHandler('ctn-jewellery:server:startglobaltimeout', function()
    isintimeout = true
    TriggerClientEvent('lkjasdlksa:syncclientnoder', -1, true)
    CreateThread(function()
        Wait(60000 * 120) -- 2 hrs
        isintimeout = false
        TriggerClientEvent('lkjasdlksa:syncclientnoder', -1, false)
    end)
end)

QBCore.Functions.CreateCallback('ctn-jewellery:gettimeoutstatus', function(source, cb)
	cb(isintimeout)
end)

function dclog(Player, text)
    local playerName = System(Player.getName())
   
    local discord_webhook = Config.DiscordWebhook
    if discord_webhook == '' then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "Jewelery Robbery Log",
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