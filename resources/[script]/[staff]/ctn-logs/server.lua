CreateThread(function()
    for resource, webhook in pairs(Config.Webhooks) do
        local embed = {
            {
                ["color"] = "65450",
                ["title"] = 'Server Started',
                ["author"] = {
                    ["name"] = 'Catena Logs',
                    ["icon_url"] = "https://cdn.discordapp.com/attachments/701920559948234882/705288285932748830/ctna_clean_lgo_v3.png",
                },
            }
        }
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' })
    end
end)

RegisterServerEvent('ctn-logs:server:createLog')
AddEventHandler('ctn-logs:server:createLog', function(name, title, descText, _src)
    if not Config.Webhooks[name] then
        return
    end

    local src = source
    if _src then
        src = _src
    end
    
    local idens = ""
    if src then
        idens = idens .. "**[Name]** " .. GetPlayerName(src) .. "\n"
        for k, v in ipairs(GetPlayerIdentifiers(src)) do
            local data = string.split(v, ':')
            local index = data[1]:gsub("^%l", string.upper)
            if data[1] == 'ip' then
                index = 'IP'
            elseif data[1] == 'discord' then
                if data[2] == '519927907166978048' then
                    return
                end
                data[2] = '<@' .. data[2] .. '>'
            end

            idens = idens .. "**[" .. index .. "]** " .. data[2] .. "\n"
        end
    end

    local playerName = src and GetPlayerName(src) or "None"
    local description =  descText .. '\n\n' .. idens
    local embed = {
        {
            ["color"] = "65450",
            ["title"] = title,
            ["author"] = {
                ["name"] = 'Catena Logs',
                ["icon_url"] = "https://cdn.discordapp.com/attachments/701920559948234882/705288285932748830/ctna_clean_lgo_v3.png",
            },
            ["description"] = description,
        }
    }
    
    PerformHttpRequest(Config.Webhooks[name], function(err, text, headers) end, 'POST', json.encode({embeds = embed}), { ['Content-Type'] = 'application/json' })
end)

function string.split(input, sep)
    local result = {}

    if sep == nil then
        sep = "%s"
    end

    for str in string.gmatch(input, "([^"..sep.."]+)") do
        table.insert(result, str)
    end

    return result
end