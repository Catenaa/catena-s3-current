QBCore = nil

CreateThread(function()
    if IsDuplicityVersion() then
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
    else
        while QBCore == nil do
            Citizen.Wait(10)
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        end
    end

    print("[leo] Module Ready")
    TriggerEvent("nevo:ready")
end)