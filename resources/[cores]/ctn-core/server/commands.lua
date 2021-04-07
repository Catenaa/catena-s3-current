QBCore.Commands = {}
QBCore.Commands.List = {}

QBCore.Commands.Add = function(name, help, arguments, argsrequired, callback, permission) -- [name] = command name (ex. /givemoney), [help] = help text, [arguments] = arguments that need to be passed (ex. {{name="id", help="ID of a player"}, {name="amount", help="amount of money"}}), [argsrequired] = set arguments required (true or false), [callback] = function(source, args) callback, [permission] = rank or job of a player
	QBCore.Commands.List[name:lower()] = {
		name = name:lower(),
		permission = permission ~= nil and permission:lower() or "user",
		help = help,
		arguments = arguments,
		argsrequired = argsrequired,
		callback = callback,
	}
end

QBCore.Commands.Refresh = function(source)
	local Player = QBCore.Functions.GetPlayer(tonumber(source))
	if Player ~= nil then
		for command, info in pairs(QBCore.Commands.List) do
			if QBCore.Functions.HasPermission(source, "god") or QBCore.Functions.HasPermission(source, QBCore.Commands.List[command].permission) then
				TriggerClientEvent('chat:addSuggestion', source, "/"..command, info.help, info.arguments)
			end
		end

		TriggerClientEvent("normal", source, 'Commands: Refresh', 'success')
	end
end

QBCore.Commands.Add("tp", "Teleport to a player or location", {{name="id/x", help="ID of a player or X position"}, {name="y", help="Y position"}, {name="z", help="Z position"}}, false, function(source, args)
	if (args[1] ~= nil and (args[2] == nil and args[3] == nil)) then
		-- tp to player
		local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
		if Player ~= nil then
			TriggerClientEvent('QBCore:Command:TeleportToPlayer', source, Player.PlayerData.source)
		else
			TriggerClientEvent('chat:addMessage', source, {template = '<div class="chat-message" style="background-color: rgba(48, 48, 48, 0.75);"><b>ADMIN</b> Player is not online!</div>'})
		end
	else
		-- tp to location
		if args[1] ~= nil and args[2] ~= nil and args[3] ~= nil then
			local x = tonumber(args[1])
			local y = tonumber(args[2])
			local z = tonumber(args[3])
			TriggerClientEvent('QBCore:Command:TeleportToCoords', source, x, y, z)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Not every argument has been completed (x, y, z)")
		end
	end

	TriggerEvent('ctn-logs:server:createLog', 'admin', 'Command "tp"', "Used the command **tp**", source)
end, "admin")

QBCore.Commands.Add("setgroup", "Give permission to someone (god/admin)", {{name="id", help="ID of the player"}, {name="permission", help="Permission level"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	local permission = tostring(args[2]):lower()
	if Player ~= nil then
		QBCore.Functions.AddPermission(Player.PlayerData.source, permission)
	else
		TriggerClientEvent('chat:addMessage', source, {template = '<div class="chat-message" style="background-color: rgba(48, 48, 48, 0.75);"><b>ADMIN</b> Player is not online!</div>'})	
	end

	TriggerEvent('ctn-logs:server:createLog', 'admin', 'Command "setgroup"', "Used the command **setgroup**", source)
end, "god")

QBCore.Commands.Add("removegroup", "Take permission from someone", {{name="id", help="ID of the player"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player ~= nil then
		QBCore.Functions.RemovePermission(Player.PlayerData.source)
	else
		TriggerClientEvent('chat:addMessage', source, {template = '<div class="chat-message" style="background-color: rgba(48, 48, 48, 0.75);"><b>ADMIN</b> Player is not online!</div>'})	
	end

	TriggerEvent('ctn-logs:server:createLog', 'admin', 'Command "removegroup"', "Used the command **removegroup**", source)
end, "god")

QBCore.Commands.Add("car", "Spawn a vehicle", {{name="model", help="Model name of the vehicle"}}, true, function(source, args)
	TriggerClientEvent('QBCore:Command:SpawnVehicle', source, args[1])

	TriggerEvent('ctn-logs:server:createLog', 'admin', 'Command "car"', "Used the command **car**", source)
end, "admin")

QBCore.Commands.Add("debug", "Turn debug mode on / off", {}, false, function(source, args)
	TriggerClientEvent('koil-debug:toggle', source)

	TriggerEvent('ctn-logs:server:createLog', 'admin', 'Command "debug"', "Used the command **debug**", source)
end, "god")

QBCore.Commands.Add("dv", "Delete a vehicle", {}, false, function(source, args)
	TriggerClientEvent('QBCore:Command:DeleteVehicle', source)

	TriggerEvent('ctn-logs:server:createLog', 'admin', 'Command "dv"', "Used the command **dv**", source)
end, "admin")

QBCore.Commands.Add("tpm", "Teleport to a marker", {}, false, function(source, args)
	TriggerClientEvent('QBCore:Command:GoToMarker', source)

	TriggerEvent('ctn-logs:server:createLog', 'admin', 'Command "tpm"', "Used the command **tpm**", source)
end, "admin")

QBCore.Commands.Add("givemoney", "Give money to a player", {{name="id", help="Player ID"},{name="moneytype", help="Type of money (cash, bank, crypto)"}, {name="amount", help="Aantal munnies"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player ~= nil then
		Player.Functions.AddMoney(tostring(args[2]), tonumber(args[3]))
	else
		TriggerClientEvent('chat:addMessage', source, {template = '<div class="chat-message" style="background-color: rgba(48, 48, 48, 0.75);"><b>ADMIN</b> Player is not online!</div>'})
	end

	TriggerEvent('ctn-logs:server:createLog', 'admin', 'Command "givemoney"', "Used the command **givemoney**", source)
end, "god")

QBCore.Commands.Add("setmoney", "Set the money for a player", {{name="id", help="Player ID"},{name="moneytype", help="Type of money (cash, bank, crypto)"}, {name="amount", help="Aantal munnies"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player ~= nil then
		Player.Functions.SetMoney(tostring(args[2]), tonumber(args[3]))
	else
		TriggerClientEvent('chat:addMessage', source, {template = '<div class="chat-message" style="background-color: rgba(48, 48, 48, 0.75);"><b>ADMIN</b> Player is not online!</div>'})
	end

	TriggerEvent('ctn-logs:server:createLog', 'admin', 'Command "setmoney"', "Used the command **setmoney**", source)
end, "god")

QBCore.Commands.Add("setjob", "Set player job", {{name="id", help="Player ID"}, {name="job", help="Job name"}, {name="grade", help="Job grade [Number]"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player ~= nil then
		if not Player.Functions.SetJob(tostring(args[2]), args[3]) then
			TriggerClientEvent('chat:addMessage', source, {template = '<div class="chat-message" style="background-color: rgba(48, 48, 48, 0.75);"><b>ADMIN</b> Invalid job or job grade!</div>'})
		end
	else
		TriggerClientEvent('chat:addMessage', source, {template = '<div class="chat-message" style="background-color: rgba(48, 48, 48, 0.75);"><b>ADMIN</b> Player is not online!</div>'})
	end

	TriggerEvent('ctn-logs:server:createLog', 'admin', 'Command "setjob"', "Used the command **setjob**", source)
end, "admin")


QBCore.Commands.Add("job", "See your job info", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
	local duty = ""
	if Player.PlayerData.job.onduty then
		duty = "On Duty"
	else
		duty = "Off Duty"
	end
	
	local grade = (Player.PlayerData.job.grade ~= nil and Player.PlayerData.job.grade.name ~= nil) and Player.PlayerData.job.grade.name or 'No Grades'
	TriggerClientEvent('chat:addMessage', source, {
        template = '<div class="chat-message" style="background-color: rgba(219, 52, 235, 0.75);"><b>Job Stats</b> Name: {0} [{1}] | {2}</div>',
    	args = { Player.PlayerData.job.label, duty, grade}
	})
end)

QBCore.Commands.Add("setgang", "Give a walk to a player", {{name="id", help="Player ID"}, {name="gang", help="Gang name"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player ~= nil then
		Player.Functions.SetGang(tostring(args[2]))
	else
		TriggerClientEvent('chat:addMessage', source, {template = '<div class="chat-message" style="background-color: rgba(48, 48, 48, 0.75);"><b>ADMIN</b> Player is not online!</div>'})
	end
end, "admin")

QBCore.Commands.Add("gang", "See what your gang is", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)

	if Player.PlayerData.gang.name ~= "geen" then
		TriggerClientEvent('chatMessage', source, "warning", "Gang: "..Player.PlayerData.gang.label)
		--TriggerClientEvent('QBCore:Notify', source, "You're not in a gang!", "error")
	else
		TriggerClientEvent('QBCore:Notify', source, "You're not in a gang!", "error")
		--TriggerClientEvent('chatMessage', source, "SYSTEM", "warning", "Gang: "..Player.PlayerData.gang.label)
	end
end)

QBCore.Commands.Add("clearinv", "Empty the inventory of yourself or a player", {{name="id", help="Player ID"}}, false, function(source, args)
	local playerId = args[1] ~= nil and args[1] or source 
	local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
	if Player ~= nil then
		Player.Functions.ClearInventory()
	else
		TriggerClientEvent('chat:addMessage', source, {template = '<div class="chat-message" style="background-color: rgba(48, 48, 48, 0.75);"><b>ADMIN</b> Player is not online!</div>'})
	end
end, "admin")