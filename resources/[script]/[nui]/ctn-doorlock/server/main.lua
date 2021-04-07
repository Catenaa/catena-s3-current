QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local doorInfo = {}

RegisterServerEvent('ctn-doorlock:server:setupDoors')
AddEventHandler('ctn-doorlock:server:setupDoors', function()
	local src = source
	TriggerClientEvent("ctn-doorlock:client:setDoors", QB.Doors)
end)

RegisterServerEvent('ctn-doorlock:server:updateState')
AddEventHandler('ctn-doorlock:server:updateState', function(doorID, state)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	
	QB.Doors[doorID].locked = state

	TriggerClientEvent('ctn-doorlock:client:setState', -1, doorID, state)
end)