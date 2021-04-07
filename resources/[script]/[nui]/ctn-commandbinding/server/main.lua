QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Code

QBCore.Commands.Add("binds", "Open commandbinding menu", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
	TriggerClientEvent("ctn-commandbinding:client:openUI", source)
end)

RegisterServerEvent('ctn-commandbinding:server:setKeyMeta')
AddEventHandler('ctn-commandbinding:server:setKeyMeta', function(keyMeta)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)

    ply.Functions.SetMetaData("commandbinds", keyMeta)
end)