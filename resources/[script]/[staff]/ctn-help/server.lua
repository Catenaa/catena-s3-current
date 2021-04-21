
QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)




RegisterCommand('helpc', function(source, args, rawCommand) 
	TriggerClientEvent('ctn_help:start', source)
end, false)


---------invio ID
RegisterServerEvent('id:server:Player')
AddEventHandler('id:server:Player', function()
    local src = source
   
	TriggerClientEvent('sho:client:id', src, src)

end)
