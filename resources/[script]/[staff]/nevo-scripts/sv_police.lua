RegisterServerEvent("nevo:ready")
AddEventHandler("nevo:ready", function()
    QBCore.Commands.Add('livery', 'Set vehicle livery (Emergency Only)', {}, false, function(source, args)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local livery = tonumber(args[1])
    
        if Player and (Player.PlayerData.job.name == 'police' or Player.PlayerData.job.name == 'ambulance' or Player.PlayerData.job.name == 'gendarme') then
            if Player then
                if args[1] == nil or args[1] == '' then
                    TriggerClientEvent('chatMessage', src, "Usage", "error", '/livery [Number]')
                else
                    TriggerClientEvent('police:livery', src, livery)
                    TriggerEvent('ctn-logs:server:createLog', 'commands', 'Livery Command', "Used Livery Command " .. args[1], src)
                end
            end
        else
            TriggerClientEvent('chatMessage', src, "SYSTEM", "error", 'This command is for emergency services!')
        end
    end)

    QBCore.Commands.Add('extras', 'Set vehicle Extras (Emergency Only)', {{name="extra", help="all / remove / 1-10"}}, false, function(source, args)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local extra = tonumber(args[1])
    
        if Player and (Player.PlayerData.job.name == 'police' or Player.PlayerData.job.name == 'ambulance' or Player.PlayerData.job.name == 'gendarme') then
            if Player then
                if args[1] == nil or args[1] == '' then
                    TriggerClientEvent('chatMessage', src, "Usage", "error", '/extras [all / remove / 1-10]')
                else
                   TriggerClientEvent('police:extras', src, extra ~= nil and extra or args[1])
                   TriggerEvent('ctn-logs:server:createLog', 'commands', 'Extras Command', "Used Extras Command " .. args[1], src)
                end
            end
        else
            TriggerClientEvent('chatMessage', src, "SYSTEM", "error", 'This command is for emergency services!')
        end   
    end)
    
    QBCore.Commands.Add('fix', 'Fix Vehicle (Emergency Only)', {}, false, function(source, args)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
    
        if Player and (Player.PlayerData.job.name == 'police' or Player.PlayerData.job.name == 'ambulance' or Player.PlayerData.job.name == 'gendarme') then
            TriggerClientEvent('police:fix', src)
        else
            TriggerClientEvent('chatMessage', src, "SYSTEM", "error", 'This command is for emergency services!')
        end
        
    end)

    QBCore.Commands.Add('ptint', 'Set Tint (Emergency Only)', {}, false, function(source, args)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if Player and (Player.PlayerData.job.name == 'police' or Player.PlayerData.job.name == 'gendarme') then
            TriggerClientEvent('police:windowtint', src, tonumber(args[1]))
        else
            TriggerClientEvent('chatMessage', src, "SYSTEM", "error", 'This command is for emergency services!')
        end
        
    end)

    QBCore.Commands.Add('evidence', 'Open Evidence Box (Emergency Only)', {}, false, function(source, args)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
    
        if Player and (Player.PlayerData.job.name == 'police' or Player.PlayerData.job.name == 'gendarme') then
            TriggerClientEvent('police:evidence', src, tonumber(args[1]))
        else
            TriggerClientEvent('chatMessage', src, "SYSTEM", "error", 'This command is for emergency services!')
        end
        
    end)

    QBCore.Commands.Add('sv', 'Spawn Vehicle (/sv help) (Emergency Only)', {}, false, function(source, args)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
    
        if Player and (Player.PlayerData.job.name == 'police') then
            TriggerClientEvent('police:sv', src, args[1])
        elseif Player and (Player.PlayerData.job.name == 'gendarme') then
            TriggerClientEvent('gendarme:sv', src, args[1])
        else
            TriggerClientEvent('chatMessage', src, "SYSTEM", "error", 'This command is for emergency services!')
        end
        
    end)

    QBCore.Commands.Add('pchat', 'Officers Chat', {}, false, function(source, args)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local hasphone = Player.Functions.GetItemByName('phone') ~= nil and true or false
        
        if not Player.PlayerData.metadata["ishandcuffed"] and not Player.PlayerData.metadata["isdead"] then
            if hasphone == true then
                if Player and Player.PlayerData.job.name == 'police' and Player.PlayerData.job.onduty then
                    TriggerClientEvent('police:chatMessage', -1, (Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.metadata.callsign .. ')'), table.concat(args, " "))
                    TriggerClientEvent('ctn-911:client:justcalled', src)
                else
                    TriggerClientEvent('chatMessage', src, "SYSTEM", "error", 'This command is for emergency services!')
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "You dont have a phone!", 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You cant do it while you're dead/cuffed!", 'error')
        end
    end)

    QBCore.Commands.Add('pchatg', 'Officers Chat', {}, false, function(source, args)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local hasphone = Player.Functions.GetItemByName('phone') ~= nil and true or false
        
        if not Player.PlayerData.metadata["ishandcuffed"] and not Player.PlayerData.metadata["isdead"] then
            if hasphone == true then
                if Player and Player.PlayerData.job.name == 'gendarme' and Player.PlayerData.job.onduty then
                    TriggerClientEvent('police:chatMessage', -1, (Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.metadata.callsign .. ')'), table.concat(args, " "))
                    TriggerClientEvent('ctn-911:client:justcalled', src)
                else
                    TriggerClientEvent('chatMessage', src, "SYSTEM", "error", 'This command is for emergency services!')
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "You dont have a phone!", 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You cant do it while you're dead/cuffed!", 'error')
        end
    end)
end)

RegisterServerEvent("police:unmaskGranted")
AddEventHandler("police:unmaskGranted", function(player)
    TriggerClientEvent('police:unmaskAccepted', player)
end)