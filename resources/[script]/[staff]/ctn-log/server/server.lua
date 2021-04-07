QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
local loggingApi = "https://qbus.onno204.nl/qbus-management/backend/fivem/log"

RegisterServerEvent('ctn-logs:server:CreateLog')
AddEventHandler('ctn-logs:server:CreateLog', function(name, title, color, message, tagEveryone)
    local tag = tagEveryone ~= nil and tagEveryone or false
    local webHook = Config.Webhooks[name] ~= nil and Config.Webhooks[name] or Config.Webhooks["default"]
    local embedData = {
        {
            ["title"] = title,
            ["color"] = Config.Colors[color] ~= nil and Config.Colors[color] or Config.Colors["default"],
            ["footer"] = {
                ["text"] = os.date("%c"),
            },
            ["description"] = message,
        }
    }
    PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = "Catena Logs",embeds = embedData}), { ['Content-Type'] = 'application/json' })
    Citizen.Wait(100)
    if tag then
        PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = "Catena Logs", content = "@everyone"}), { ['Content-Type'] = 'application/json' })
    end
end)

RegisterServerEvent('ctn-logs:server:sendLog')
AddEventHandler('ctn-logs:server:sendLog', function(citizenid, logtype, data)
    local dataString = ""
    data = data ~= nil and data or {}
    for key,value in pairs(data) do 
        if dataString ~= "" then
            dataString = dataString .. "&"
        end
        dataString = dataString .. key .."="..value
    end
    local requestUrl = string.format("%s?citizenid=%s&logtype=%s&%s", loggingApi, citizenid, logtype, dataString)
    requestUrl = string.gsub(requestUrl, ' ', "%%20")
    PerformHttpRequest(requestUrl, function(err, text, headers) end, 'GET', '')
end)

QBCore.Commands.Add("testwebhook", ":)", {}, false, function(source, args)
    TriggerEvent("ctn-logs:server:CreateLog", "default", "TestWebhook", "default", "Triggered **een** test webhook :)")
end, "god")
