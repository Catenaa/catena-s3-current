RegisterServerEvent("ctn-discordconnector:checkPlayer")
AddEventHandler("ctn-discordconnector:checkPlayer", function()
    local donor = ""
    local num = 0
    local num2 = GetNumPlayerIdentifiers(source)
    local source = source
    if GetNumPlayerIdentifiers(source) > 0 then
        local discord = nil
        while num < num2 and not discord do
            local a = GetPlayerIdentifier(source, num)
            if string.find(a, "discord") then discord = a end
            num = num+1
        end
        if discord then
            PerformHttpRequest("https://discordapp.com/api/guilds/488314532020879370/members/"..string.sub(discord, 9), function(err, text, headers) 
                if GetNumPlayerIdentifiers(source) > 0 and json.decode(text) then
                    local member = json.decode(text)
                    local name, dec = "", ""
                    for k, v in pairs(member.user) do
                        if k == "username" then
                            name = v
                        elseif k == "discriminator" then
                            dec = tostring(v)
                        end
                    end
                    donor = name .. "#" .. tostring(dec)
                    TriggerClientEvent("ctn-discordconnector:SavePlayer", source, donor)
                end
            end, "GET", "", {["Content-type"] = "application/json", ["Authorization"] = "Bot ODEzNDA2NjYzMTc5NzYzNzEy.YDO1_A.HWB0vLEx4zTi-wAzqc750qo9NCM"})
        end
    end 
end)