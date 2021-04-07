local QBCore = nil

TriggerEvent("QBCore:GetObject", function(library)
    QBCore = library
end)

RegisterServerEvent('mechanic:sv:removeCash')
AddEventHandler('mechanic:sv:removeCash', function(amount)
	local src = source

    amount = tonumber(amount)
    if (not amount or amount <= 0) then return end
    
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if (xPlayer) then
        xPlayer.Functions.RemoveMoney('cash', amount)
    end
end)