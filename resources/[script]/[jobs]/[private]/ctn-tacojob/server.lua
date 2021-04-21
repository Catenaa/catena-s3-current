QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local jobDeliverys = {}

RegisterServerEvent('ctn-taco:server:readyForDelivery')
AddEventHandler('ctn-taco:server:readyForDelivery', function(job, item)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	local count = xPlayer.Functions.GetItemByName(item).amount

	if count >= 1 then
		xPlayer.Functions.RemoveItem(item, count)
		if jobDeliverys[job] ~= nil then
			jobDeliverys[job].count = jobDeliverys[job].count + count
		else
			jobDeliverys[job] = {}
			jobDeliverys[job].count = count
		end

		TriggerClientEvent('QBCore:Notify', src, "You put " .. tostring(count) .. " bags out for delivery.", "success")
	else
		TriggerClientEvent('QBCore:Notify', src, "You don't have any bags for that.", "error")
	end
end)

RegisterServerEvent('ctn-taco:server:startFromDelivery')
AddEventHandler('ctn-taco:server:startFromDelivery', function(job)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	local count = jobDeliverys[job] ~= nil and jobDeliverys[job].count or 0

	if count >= 1 then
		jobDeliverys[job].count = jobDeliverys[job].count - 1
		xPlayer.Functions.AddItem(Config.Jobs[job]['settings'].bag_item, 1)
		TriggerClientEvent("ctn-taco:client:startDelivery", src, job)
		TriggerClientEvent('QBCore:Notify', src, "You took a bag out to deliver.", "success")
	else
		TriggerClientEvent('QBCore:Notify', src, "There are no deliveries.", "error")
	end
end)

RegisterServerEvent('ctn-taco:server:dropoff')
AddEventHandler('ctn-taco:server:dropoff', function(job)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	local jobitem = Config.Jobs[job]['settings'].bag_item
	local count = xPlayer.Functions.GetItemByName(jobitem).amount

	if count >= 1 then
		local money = math.random(Config.Jobs[job]['settings'].payment[1], Config.Jobs[job]['settings'].payment[2])
		xPlayer.Functions.AddMoney('cash', math.floor(money * 0.65))
		xPlayer.Functions.RemoveItem(jobitem, count)
		TriggerClientEvent('QBCore:Notify', src, "Drop Off Completed", "success")
		TriggerEvent("ctn-bossmenu:server:addAccountMoney", job, math.floor(money * 0.35))
	else
		TriggerClientEvent('QBCore:Notify', src, "Dropoff failed", "error")
	end
end)

RegisterServerEvent('ctn-taco:server:addItem')
AddEventHandler('ctn-taco:server:addItem', function(item, count)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	xPlayer.Functions.AddItem(item, count)

	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
end)

RegisterServerEvent('ctn-taco:server:removeItem')
AddEventHandler('ctn-taco:server:removeItem', function(item, count)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	xPlayer.Functions.RemoveItem(item, count)

	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
end)

QBCore.Functions.CreateCallback('ctn-taco:server:getItemCount', function(source, cb, item, count)
	local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
	local qu = xPlayer.Functions.GetItemByName(item) ~= nil and xPlayer.Functions.GetItemByName(item).amount or 0
    if qu ~= nil and tonumber(qu) >= count then
        cb(true)
    else
        cb(false)
    end
end)