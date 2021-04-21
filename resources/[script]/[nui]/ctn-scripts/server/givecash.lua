QBCore.Commands.Add('givecash', 'Give cash to player.', {{name = 'id', help = 'Player ID'}, {name = 'amount', help = 'Amount'}}, true, function(source, args)
    local src = source
	local id = tonumber(args[1])
	local amount = math.ceil(tonumber(args[2]))
    
	if id and amount then
		local xPlayer = QBCore.Functions.GetPlayer(src)
		local xReciv = QBCore.Functions.GetPlayer(id)
		
		if xReciv and xPlayer then
			if not xPlayer.PlayerData.metadata["isdead"] then
				local distance = xPlayer.PlayerData.metadata["inlaststand"] and 3.0 or 10.0
				if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(id))) < distance then
					if xPlayer.Functions.RemoveMoney('cash', amount) then
						if xReciv.Functions.AddMoney('cash', amount) then
							TriggerClientEvent('QBCore:Notify', src, "Success fully gave to ID " .. tostring(id) .. ' ' .. tostring(amount) .. '$.', "success")
							TriggerClientEvent('QBCore:Notify', id, "Success recived gave " .. tostring(amount) .. '$ from ID ' .. tostring(src), "success")
							TriggerClientEvent("payanimation", src)
						else
							TriggerClientEvent('QBCore:Notify', src, "Could not give item to the given id.", "error")
						end
					else
						TriggerClientEvent('QBCore:Notify', src, "You don\'t have this amount.", "error")
					end
				else
					TriggerClientEvent('QBCore:Notify', src, "You are too far away lmfao.", "error")
				end
			else
				TriggerClientEvent('QBCore:Notify', src, "You are dead LOL.", "error")
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "Wrong ID.", "error")
		end
	else
		TriggerClientEvent('QBCore:Notify', src, "Usage /givecash [ID] [AMOUNT]", "error")
	end
end)

QBCore.Commands.Add('checkfines', 'Check player fines (Emergancy Only).', {{name = 'id', help = 'Player ID'}}, true, function(source, args)
    local src = source
    local id = tonumber(args[1])
	if id then
		local xPlayer = QBCore.Functions.GetPlayer(id)
		local xO = QBCore.Functions.GetPlayer(src)
        
        if xPlayer and xO and (xO.PlayerData.job.name == 'police' or xO.PlayerData.job.name == 'gendarme') then
			local distance = xPlayer.PlayerData.metadata["inlaststand"] and 3.0 or 10.0
			if #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(id))) < distance then
				QBCore.Functions.ExecuteSql(false, "SELECT * FROM `phone_invoices` WHERE `citizenid` = '" .. xPlayer.PlayerData.citizenid .. "'", function(result)
                    if result[1] ~= nil then
                        TriggerClientEvent('QBCore:Notify', src, "This person has " .. #result .. " unpaid fines.", "success")
                    else
                        TriggerClientEvent('QBCore:Notify', src, "This person has no unpaid fines.", "success")
                    end
                end)
			else
				TriggerClientEvent('QBCore:Notify', src, "You are too far away.", "error")
			end
		else
			TriggerClientEvent('QBCore:Notify', src, "This command is for officers only!", "error")
		end
	else
		TriggerClientEvent('QBCore:Notify', src, "Wrong ID.", "error")
	end
end)