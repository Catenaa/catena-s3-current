local isOpened = false
RegisterNetEvent('ctn-emsActives:client:createNUI')
AddEventHandler('ctn-emsActives:client:createNUI', function(data, draggable)
    local html = ""
    
    for _, cop in pairs(data) do
        html = html .. "<span style=\"position: relative; top: 7.5px; font-size: 15px; color: white; font-family: heebo; padding-right: 10px; padding-left: 10px; padding-bottom: 10px;\">"
        local dutyLogo = cop.onduty == true and "<i style=\"color: rgb(25, 212, 0)\" class=\"fas fa-bullseye fa-lg\"></i>" or "<i style=\"color: rgb(232, 8, 0)\" class=\"fas fa-bullseye fa-lg\"></i>" 
        html = html .. dutyLogo .. '<span style=\"margin-left: 5px\">' .. cop.name .. ' (' .. (cop.grade ~= nil and cop.grade or 'Regular') .. ')</span>'
        html = html .. '<span style=\"margin-left: 5px; background-color: rgba(0, 98, 245, 0.75); padding-left: 7px; padding-right: 7px; border-radius: 5px;\">' .. cop.callsign .. '</span></span></br>'
    end
    
    SendNUIMessage({
        type = 'update-title',
        data = "Active Paramedics",
    })

    if draggable == 2 then
        isOpened = not isOpened
        SetNuiFocus(false, false)
        SendNUIMessage({
            type = 'police-actives',
            data = html,
            close = isOpened
        })
        TriggerEvent("debug", 'EMS Actives: ' .. (isOpened and 'Open UI' or 'Close UI'), (isOpened and 'success' or 'error'))
    elseif draggable > 0 then
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = 'police-actives',
            data = html,
            drag = draggable
        })
    else
        SetNuiFocus(false, false)
        SendNUIMessage({
            type = 'police-actives',
            data = html,
            drag = draggable
        })
    end
end)

RegisterNUICallback('closeUI', function()
    SetNuiFocus(false, false)
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate")
AddEventHandler("QBCore:Client:OnJobUpdate", function(JobInfo)
    TriggerServerEvent('ctn-emsActives:server:updateParamedics')

    if isOpened and JobInfo.name ~= 'ambulance' then
        SendNUIMessage({
            type = 'close',
        })
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent('ctn-emsActives:server:updateParamedics')
end)

RegisterNetEvent('QBCore:Client:SetDuty')
AddEventHandler('QBCore:Client:SetDuty', function(duty)
    TriggerServerEvent('ctn-emsActives:server:updateParamedics')

    if isOpened and not duty then
        SendNUIMessage({
            type = 'close',
        })
    end
end)

RegisterNetEvent('ctn-emsActives:client:updateParamedics')
AddEventHandler('ctn-emsActives:client:updateParamedics', function(data)
    if not QBCore or not QBCore.Functions.GetPlayerData().job or QBCore.Functions.GetPlayerData().job.name ~= 'ambulance' then
        return
    end

    local html = ""
    
    for _, cop in pairs(data) do
        html = html .. "<span style=\"position: relative; top: 7.5px; font-size: 15px; color: white; font-family: heebo; padding-right: 10px; padding-left: 10px; padding-bottom: 10px;\">"
        local dutyLogo = cop.onduty == true and "<i style=\"color: rgb(25, 212, 0)\" class=\"fas fa-bullseye fa-lg\"></i>" or "<i style=\"color: rgb(232, 8, 0)\" class=\"fas fa-bullseye fa-lg\"></i>" 
        html = html .. dutyLogo .. '<span style=\"margin-left: 5px\">' .. cop.name .. ' (' .. (cop.grade ~= nil and cop.grade or 'No Grades') .. ')</span>'
        html = html .. '<span style=\"margin-left: 5px; background-color: rgba(0, 98, 245, 0.75); padding-left: 7px; padding-right: 7px; border-radius: 5px;\">' .. cop.callsign .. '</span></span></br>'
    end

    SendNUIMessage({
        type = 'update-officers',
        data = html,
    })

    TriggerEvent("debug", 'Police Actives: Refresh', 'success')
end)