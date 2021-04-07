local gendarmeTimeouts = {}
local policeTimeouts = {}
local emsTimeouts = {}
local gendarmeCalls = {}
local policeCalls = {}
local emsCalls = {}


QBCore.Commands.Add('911g', 'Send emergancy signal to Gendarme.', {{name = 'firstname', help = 'First Name'}, {name = 'lastname', help = 'Last Name'}, {name = 'content', help = 'Message Content'}}, true, function(source, args)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
	if not xPlayer.PlayerData.metadata["ishandcuffed"] then
    if gendarmeTimeouts[src] == nil or gendarmeTimeouts[src] == true then
        CreateThread(function()
            gendarmeTimeouts[src] = false
            Wait(60000)
            gendarmeTimeouts[src] = true
        end)
        local item = xPlayer.Functions.GetItemByName('phone')
        if item ~= nil and item.amount > 0 then
            local id =#gendarmeCalls+1
            gendarmeTimeouts[src] = GetGameTimer()

            local coords = GetEntityCoords(GetPlayerPed(src))
            local name = args[1] .. ' ' .. args[2]
            
            table.remove(args, 1)
            table.remove(args, 1)
            local message = table.concat(args, ' ')

            gendarmeCalls[id] = { name = name, message = message, source = src }

            TriggerClientEvent('ctn-911:client:createBlip', -1, 'gendarme', coords, name, message, id, src)
            TriggerClientEvent('ctn-911:client:justcalled', src)

            TriggerEvent('ctn-logs:server:createLog', 'emergency', 'Command "911"', "Used the command **100**\n**Name:** " .. name .."\n**Message:** " .. message, src)
        else
            TriggerClientEvent('QBCore:Notify', src, "You dont have phone.", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Please wait till your next message.", "error")
		end
	else
		TriggerClientEvent('QBCore:Notify', src, "You cant do that while cuffed!", "error")
	end
end)

QBCore.Commands.Add('911gr', 'Reply to 911 call. (Gendarme Only)', {{name = 'id', help = 'Call #ID'}, {name = 'content', help = 'Message Content'}}, true, function(source, args)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    if xPlayer.PlayerData.job.name == 'gendarme' then
        local item = xPlayer.Functions.GetItemByName('phone')
        if item ~= nil and item.amount > 0 then
            local id = tonumber(args[1])
            table.remove(args, 1)
            local message = table.concat(args, ' ')
            if gendarmeCalls[id] then
                if not gendarmeCalls[id].reply then
                    gendarmeCalls[id].reply = true
                    TriggerClientEvent('ctn-911:client:justcalled', src)
                    TriggerClientEvent('ctn-911:client:reply', -1, 'gendarme', id, message,xPlayer.PlayerData.charinfo.firstname:sub(1,1) .. '. ' .. xPlayer.PlayerData.charinfo.lastname, gendarmeCalls[id].source)
                else
                    TriggerClientEvent('QBCore:Notify', src, "Message already replied.", "error")
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "Invaild call #ID.", "error")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You dont have phone.", "error")
        end
    end
end)


QBCore.Commands.Add('911', 'Send emergancy signal to Police.', {{name = 'firstname', help = 'First Name'}, {name = 'lastname', help = 'Last Name'}, {name = 'content', help = 'Message Content'}}, true, function(source, args)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
	if not xPlayer.PlayerData.metadata["ishandcuffed"] then
    if policeTimeouts[src] == nil or policeTimeouts[src] == true then
        CreateThread(function()
            policeTimeouts[src] = false
            Wait(60000)
            policeTimeouts[src] = true
        end)
        local item = xPlayer.Functions.GetItemByName('phone')
        if item ~= nil and item.amount > 0 then
            local id =#policeCalls+1
            policeTimeouts[src] = GetGameTimer()

            local coords = GetEntityCoords(GetPlayerPed(src))
            local name = args[1] .. ' ' .. args[2]
            
            table.remove(args, 1)
            table.remove(args, 1)
            local message = table.concat(args, ' ')

            policeCalls[id] = { name = name, message = message, source = src }

            TriggerClientEvent('ctn-911:client:createBlip', -1, 'police', coords, name, message, id, src)
            TriggerClientEvent('ctn-911:client:justcalled', src)

            TriggerEvent('ctn-logs:server:createLog', 'emergency', 'Command "911"', "Used the command **100**\n**Name:** " .. name .."\n**Message:** " .. message, src)
        else
            TriggerClientEvent('QBCore:Notify', src, "You dont have phone.", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Please wait till your next message.", "error")
		end
	else
		TriggerClientEvent('QBCore:Notify', src, "You cant do that while cuffed!", "error")
	end
end)

QBCore.Commands.Add('911r', 'Reply to 911 call. (Police Only)', {{name = 'id', help = 'Call #ID'}, {name = 'content', help = 'Message Content'}}, true, function(source, args)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    if xPlayer.PlayerData.job.name == 'police' then
        local item = xPlayer.Functions.GetItemByName('phone')
        if item ~= nil and item.amount > 0 then
            local id = tonumber(args[1])
            table.remove(args, 1)
            local message = table.concat(args, ' ')
            if policeCalls[id] then
                if not policeCalls[id].reply then
                    policeCalls[id].reply = true
                    TriggerClientEvent('ctn-911:client:justcalled', src)
                    TriggerClientEvent('ctn-911:client:reply', -1, 'police', id, message,xPlayer.PlayerData.charinfo.firstname:sub(1,1) .. '. ' .. xPlayer.PlayerData.charinfo.lastname, policeCalls[id].source)
                else
                    TriggerClientEvent('QBCore:Notify', src, "Message already replied.", "error")
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "Invaild call #ID.", "error")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You dont have phone.", "error")
        end
    end
end)

QBCore.Commands.Add('910', 'Send emergancy signal to EMS.', {{name = 'firstname', help = 'First Name'}, {name = 'lastname', help = 'Last Name'}, {name = 'content', help = 'Message Content'}}, true, function(source, args)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    if emsTimeouts[src] == nil or emsTimeouts[src] == true then
        CreateThread(function()
            emsTimeouts[src] = false
            Wait(60000)
            emsTimeouts[src] = true
        end)
        local item = xPlayer.Functions.GetItemByName('phone')
        if item ~= nil and item.amount > 0 then
            local id =#emsCalls+1
            emsTimeouts[src] = GetGameTimer()

            local coords = GetEntityCoords(GetPlayerPed(src))
            local name = args[1] .. ' ' .. args[2]

            table.remove(args, 1)
            table.remove(args, 1)
            local message = table.concat(args, ' ')

            emsCalls[id] = { name = name, message = message, source = src }

            TriggerClientEvent('ctn-911:client:createBlip', -1, 'ems', coords, name, message, id, src)
            TriggerClientEvent('ctn-911:client:justcalled', src)

            TriggerEvent('ctn-logs:server:createLog', 'emergency', 'Command "910"', "Used the command **910**\n**Name:** " .. name .."\n**Message:** " .. message, src)
        else
            TriggerClientEvent('QBCore:Notify', src, "You dont have phone.", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Please wait till your next message.", "error")
    end
end)

QBCore.Commands.Add('910r', 'Reply to 910 call. (Police Only)', {{name = 'id', help = 'Call #ID'}, {name = 'content', help = 'Message Content'}}, true, function(source, args)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    if xPlayer.PlayerData.job.name == 'ambulance' then
        local item = xPlayer.Functions.GetItemByName('phone')
        if item ~= nil and item.amount > 0 then
            local id = tonumber(args[1])
            table.remove(args, 1)
            local message = table.concat(args, ' ')
            if emsCalls[id] then
                if not emsCalls[id].reply then
                    emsCalls[id].reply = true
                    TriggerClientEvent('ctn-911:client:justcalled', src)
                    TriggerClientEvent('ctn-911:client:reply', -1, 'ems', id, message,xPlayer.PlayerData.charinfo.firstname:sub(1,1) .. '. ' .. xPlayer.PlayerData.charinfo.lastname, emsCalls[id].source)
                else
                    TriggerClientEvent('QBCore:Notify', src, "Message already replied.", "error")
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "Invaild call #ID.", "error")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You dont have phone.", "error")
        end
    end
end)