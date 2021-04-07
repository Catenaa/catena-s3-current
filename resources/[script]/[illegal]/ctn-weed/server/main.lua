QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local playersProcessingCannabis = {}

RegisterServerEvent('xd-weed:pickedUpCannabis')
AddEventHandler('xd-weed:pickedUpCannabis', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local cime = math.random(1,5)

	  if TriggerClientEvent("QBCore:Notify", src, "Picked up some Cannabis!!", "Success", 8000) then
		  Player.Functions.AddItem('cannabis', cime) ---- change this shit 
		  TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cannabis'], "add")
	  end
  end)

DrugsList = {
    "empty_weed_bag",
    "cannabis",
}

  QBCore.Functions.CreateCallback('xd-weed:getdrugs', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

        local item = Player.Functions.GetItemByName("empty_weed_bag")
		local item2 = Player.Functions.GetItemByName("cannabis")

        if item ~= nil and item2 ~= nil then
            cb(true)
		else
			cb(nil)
        end
end)

RegisterServerEvent('xd-weed:processCannabis')
AddEventHandler('xd-weed:processCannabis', function()
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)
		Player.Functions.AddItem('joint', 1)-----change this
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['joint'], "add")
		TriggerClientEvent('QBCore:Notify', src, 'Joint Processed successfully', "success")                                                                         				
end)

RegisterServerEvent('xd-weed:processCannabis')
AddEventHandler('xd-weed:processCannabis', function()
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)

		Player.Functions.RemoveItem('empty_weed_bag', 1) ---- change this shit 
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['empty_weed_bag'], "remove")         
                                                                      				
end)

RegisterServerEvent('xd-weed:processCannabis')
AddEventHandler('xd-weed:processCannabis', function()
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)
		
		Player.Functions.RemoveItem('cannabis', 1) ---- change this shit 
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cannabis'], "remove")                                                                     				
end)


function CancelProcessing(playerId)
	if playersProcessingCannabis[playerId] then
		ClearTimeout(playersProcessingCannabis[playerId])
		playersProcessingCannabis[playerId] = nil
	end
end

RegisterServerEvent('xd-weed:cancelProcessing')
AddEventHandler('xd-weed:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('QBCore:playerDropped', function(playerId, reason)
	CancelProcessing(playerId)
end)

RegisterServerEvent('xd-weed:onPlayerDeath')
AddEventHandler('xd-weed:onPlayerDeath', function(data)
	local src = source
	CancelProcessing(src)
end)

QBCore.Functions.CreateCallback('weed:process', function(source, cb)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	 
	if Player.PlayerData.item ~= nil and next(Player.PlayerData.items) ~= nil then
		for k, v in pairs(Player.PlayerData.items) do
		    if Player.Playerdata.items[k] ~= nil then
				if Player.Playerdata.items[k].name == "cannabis" then
					cb(true)
			    else
					TriggerClientEvent("QBCore:Notify", src, "You do not have any Cannabis", "error", 10000)
					cb(false)
				end
	        end
		end	
	end
end)
