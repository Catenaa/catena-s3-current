RegisterServerEvent("nevo:ready")
AddEventHandler("nevo:ready", function()
    QBCore.Functions.CreateUseableItem("repairkit", function(source, item)
        TriggerClientEvent("nevo:repairing", source, false)
    end)
    
    QBCore.Functions.CreateUseableItem("advancedrepairkit", function(source, item)
        TriggerClientEvent("nevo:repairing", source, true)
    end)
end)