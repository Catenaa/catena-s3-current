
QBCore = nil
PlayerGang = {}
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)
        Citizen.Wait(100) 
    end

    while QBCore.Functions.GetPlayerData() == nil do
        Wait(0)
    end

    while QBCore.Functions.GetPlayerData().job == nil do
        Wait(0)
    end

    isLoggedIn = true
    PlayerGang = QBCore.Functions.GetPlayerData().job

end)
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerGang = QBCore.Functions.GetPlayerData().job
end)


RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)


RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerGang = JobInfo
end)
-- taking keys 
local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

-- menu initialisation
local Menu = {}
Menu.GUI = {}
Menu.buttonCount = 0
Menu.selection = 0
Menu.hidden = true
local MenuTitle = "Menu"

isLoggedIn = false


local currentAction = "none"
--- wEAPON FUNCTION no need normally

--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isLoggedIn and PlayerGang.name == "judge" then
            v = Config.Gangs[PlayerGang.name]["Weapons"]

            ped = PlayerPedId()
            pos = GetEntityCoords(ped)
        
            bossdist = #(pos - vector3(v["coords"].x, v["coords"].y, v["coords"].z))
            if bossdist < 5.0 and QBCore.Functions.GetPlayerData().job.isboss then
                DrawMarker(2, v["coords"].x, v["coords"].y, v["coords"].z - 0.2 , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 0, 27, 145, 222, false, false, false, true, false, false, false)

                if bossdist < 1.5 then
                    QBCore.Functions.DrawText3D(v["coords"].x, v["coords"].y, v["coords"].z, "[E] Weapons Menu")
                    currentAction = "weapons"
                elseif bossdist < 2.0 then
                    QBCore.Functions.DrawText3D(v["coords"].x, v["coords"].y, v["coords"].z, "Weapons Menu")
                    currentAction = "none"
                end
            else
                Citizen.Wait(1000)
            end

        else
            Citizen.Wait(2500)
        end
    end
end)--]]


-- Boss actions
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isLoggedIn and PlayerGang.name == "judge" then
            v = Config.Gangs[PlayerGang.name]["Boss"]

            ped = PlayerPedId()
            pos = GetEntityCoords(ped)
        
            bossdist = #(pos - vector3(v["coords"].x, v["coords"].y, v["coords"].z))
            if bossdist < 5.0 and QBCore.Functions.GetPlayerData().job.isboss then
                DrawMarker(2, v["coords"].x, v["coords"].y, v["coords"].z - 0.2 , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 0, 27, 145, 222, false, false, false, true, false, false, false)

                if bossdist < 1.5 then
                    QBCore.Functions.DrawText3D(v["coords"].x, v["coords"].y, v["coords"].z, "[E] Boss Menu")
                    currentAction = "boss"
                elseif bossdist < 2.0 then
                    QBCore.Functions.DrawText3D(v["coords"].x, v["coords"].y, v["coords"].z, "Boss Menu")
                    currentAction = "none"
                end
            else
                Citizen.Wait(1000)
            end

        else
            Citizen.Wait(2500)
        end
    end
end)

--- STASH function
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isLoggedIn and PlayerGang.name == "judge" then
            v = Config.Gangs[PlayerGang.name]["Stash"]

            ped = PlayerPedId()
            pos = GetEntityCoords(ped)

            stashdist = #(pos - vector3(v["coords"].x, v["coords"].y, v["coords"].z))
            if stashdist < 5.0 then
                DrawMarker(2, v["coords"].x, v["coords"].y, v["coords"].z - 0.2 , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 0, 27, 145, 222, false, false, false, true, false, false, false)
                if stashdist < 1.5 then
                    QBCore.Functions.DrawText3D(v["coords"].x, v["coords"].y, v["coords"].z, "[~g~E~w~] - Stash")
                    currentAction = "stash"
                elseif stashdist < 2.0 then
                    QBCore.Functions.DrawText3D(v["coords"].x, v["coords"].y, v["coords"].z, "Stash")
                    currentAction = "none"
                end
            else
                Citizen.Wait(1000)
            end
        else
            Citizen.Wait(2500)
        end
    end
end)

--- Vehicle spawner
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isLoggedIn and PlayerGang.name == "judge" then
            v = Config.Gangs[PlayerGang.name]["VehicleSpawner"]
            ped = PlayerPedId()
            pos = GetEntityCoords(ped)

            vehdist = #(pos - vector3(v["coords"].x, v["coords"].y, v["coords"].z))

            if vehdist < 5.0 then
                DrawMarker(2, v["coords"].x, v["coords"].y, v["coords"].z - 0.2 , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                if vehdist < 1.5 then
                    QBCore.Functions.DrawText3D(v["coords"].x, v["coords"].y, v["coords"].z, "[~g~E~w~] - Garage")
                    currentAction = "garage"
                elseif vehdist < 2.0 then
                    QBCore.Functions.DrawText3D(v["coords"].x, v["coords"].y, v["coords"].z, "Garage")
                    currentAction = "none"
                end
                Menu.renderGUI()
            else
                Citizen.Wait(1000)
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

--- DUNNO WHAT THIS IS FOR

RegisterCommand("+GangInteract3", function()
    if currentAction == "stash" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", PlayerGang.name.."stash", {
            maxweight = 4000000,
            slots = 500,
        })
        TriggerEvent("inventory:client:SetCurrentStash", PlayerGang.name.."stash")
    elseif currentAction == "garage" then
        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(-1)))
        else
            MenuTitle = "Garage"
            ClearMenu()
            Menu.addButton("Vehicle", "VehicleList", nil)
            Menu.addButton("Close menu", "closeMenuFull", nil) 
            Menu.hidden = not Menu.hidden
        end
    elseif currentAction == "boss" then
        TriggerServerEvent("ctn-bossmenu:server:openMenu")
    elseif currentAction == "weapons" then
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "police", Config.Gangs[PlayerGang.name]["Weapons"])
    end
end, false)
TriggerEvent("chat:removeSuggestion", "/+GangInteract3")
TriggerEvent("chat:removeSuggestion", "/-GangInteract3")

RegisterKeyMapping("+GangInteract3", "Interaction for gang script", "keyboard", "e")

--- useful functions
function GangGarage()
    MenuTitle = "Garage"
    print("i'm in ")
    ClearMenu()
    Menu.addButton("Vehicle", "VehicleList", nil)
    Menu.addButton("Close menu", "closeMenuFull", nil) 
end

function VehicleList(isDown)
    MenuTitle = "Vehicle:"
    ClearMenu()
    Vehicles = Config.Gangs[PlayerGang.name]["VehicleSpawner"]["vehicles"]
    for k, v in pairs(Vehicles) do
        Menu.addButton(Vehicles[k], "TakeOutVehicle", k, "Garage", " Engine: 100%", " Body: 100%", " Fuel: 100%")
    end
        
    Menu.addButton("Return", "GangGarage",nil)
end

function TakeOutVehicle(vehicleInfo)
    QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
        local v = Config.Gangs[PlayerGang.name]["VehicleSpawner"]
        local coords = v.coords
        local primary = v["colours"]["primary"]
        local secondary = v["colours"]["secondary"]
        SetVehicleCustomPrimaryColour(veh, primary.r, primary.g, primary.b)
        SetVehicleCustomSecondaryColour(veh, secondary.r, secondary.g, secondary.b)
        SetEntityHeading(veh, coords.h)
        exports['ctn-hud']:SetFuel(veh, 100.0)
        closeMenuFull()
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh), veh)
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end

function closeMenuFull()
    Menu.hidden = true
    ClearMenu()
end

function SetWeaponSeries()
    for k, v in pairs(Config.Gangs[PlayerGang.name]["Weapons"].items) do
        if k < 6 then
            Config.Gangs[PlayerGang.name]["Weapons"].items[k].info.serie = tostring(Config.RandomInt(2) .. Config.RandomStr(3) .. Config.RandomInt(1) .. Config.RandomStr(2) .. Config.RandomInt(3) .. Config.RandomStr(4))
        end
    end
end

--- bLIP dyal mahkama

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(98.3, -931.0, 29)
	SetBlipSprite(blip, 304)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.6)
	SetBlipAsShortRange(blip, true)
	SetBlipColour(blip, 5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Justice")
    EndTextCommandSetBlipName(blip)
end)

--- LAwyer license

RegisterNetEvent("ctn-justice:client:showLawyerLicense")
AddEventHandler("ctn-justice:client:showLawyerLicense", function(sourceId, data)
    local sourcePos = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(sourceId)), false)
    local pos = GetEntityCoords(GetPlayerPed(-1), false)
    if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, sourcePos.x, sourcePos.y, sourcePos.z, true) < 2.0) then
        TriggerEvent('chat:addMessage', {
            template = '<div class="chat-message advert"><div class="chat-message-body"><strong>{0}:</strong><br><br> <strong>Pas-ID:</strong> {1} <br><strong>Firstname:</strong> {2} <br><strong>Lastname:</strong> {3} <br><strong>BSN:</strong> {4} </div></div>',
            args = {'Advocatenpas', data.id, data.firstname, data.lastname, data.citizenid}
        })
    end
end)

---- DUNNO WHAT TF DOES !THIS DRAW

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end








function Menu.addButton(name, func,args,extra,damages,bodydamages,fuel)

    local yoffset = 0.25
    local xoffset = 0.3
    local xmin = 0.0
    local xmax = 0.15
    local ymin = 0.03
    local ymax = 0.03
    Menu.GUI[Menu.buttonCount+1] = {}
    if extra ~= nil then
        Menu.GUI[Menu.buttonCount+1]["extra"] = extra
    end
    if damages ~= nil then
        Menu.GUI[Menu.buttonCount+1]["damages"] = damages
        Menu.GUI[Menu.buttonCount+1]["bodydamages"] = bodydamages
        Menu.GUI[Menu.buttonCount+1]["fuel"] = fuel
    end


    Menu.GUI[Menu.buttonCount+1]["name"] = name
    Menu.GUI[Menu.buttonCount+1]["func"] = func
    Menu.GUI[Menu.buttonCount+1]["args"] = args
    Menu.GUI[Menu.buttonCount+1]["active"] = false
    Menu.GUI[Menu.buttonCount+1]["xmin"] = xmin
    Menu.GUI[Menu.buttonCount+1]["ymin"] = ymin * (Menu.buttonCount + 0.01) +yoffset
    Menu.GUI[Menu.buttonCount+1]["xmax"] = xmax 
    Menu.GUI[Menu.buttonCount+1]["ymax"] = ymax 
    Menu.buttonCount = Menu.buttonCount+1
end


function Menu.updateSelection() 
    if IsControlJustPressed(1, Keys["DOWN"]) then 
        if(Menu.selection < Menu.buttonCount -1 ) then
            Menu.selection = Menu.selection +1
        else
            Menu.selection = 0
        end     
        PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    elseif IsControlJustPressed(1, Keys["TOP"]) then
        if(Menu.selection > 0)then
            Menu.selection = Menu.selection -1
        else
            Menu.selection = Menu.buttonCount-1
        end 
        PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    elseif IsControlJustPressed(1, 215) then
        MenuCallFunction(Menu.GUI[Menu.selection +1]["func"], Menu.GUI[Menu.selection +1]["args"])
        PlaySound(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
    end
    local iterator = 0
    for id, settings in ipairs(Menu.GUI) do
        Menu.GUI[id]["active"] = false
        if(iterator == Menu.selection ) then
            Menu.GUI[iterator +1]["active"] = true
        end
        iterator = iterator +1
    end
end

function Menu.renderGUI()
    if not Menu.hidden then
        Menu.renderButtons()
        Menu.updateSelection()
    end
end

function Menu.renderBox(xMin,xMax,yMin,yMax,color1,color2,color3,color4)
    DrawRect(0.7, yMin,0.15, yMax-0.002, color1, color2, color3, color4);
end

function Menu.renderButtons()
    
        local yoffset = 0.5
        local xoffset = 0

        
        
    for id, settings in pairs(Menu.GUI) do
        local screen_w = 0
        local screen_h = 0
        screen_w, screen_h =  GetScreenResolution(0, 0)
        
        boxColor = {38,38,38,199}
        local movetext = 0.0
        if(settings["extra"] == "Garage") then
            boxColor = {44,100,44,200}
        elseif (settings["extra"] == "Impounded") then
            boxColor = {77, 8, 8,155}
        end

        if(settings["active"]) then
            boxColor = {31, 116, 207,155}
        end


        if settings["extra"] ~= nil then

            SetTextFont(4)

            SetTextScale(0.34, 0.34)
            SetTextColour(255, 255, 255, 255)
            SetTextEntry("STRING") 
            AddTextComponentString(settings["name"])
            DrawText(0.63, (settings["ymin"] - 0.012 )) 

            SetTextFont(4)
            SetTextScale(0.26, 0.26)
            SetTextColour(255, 255, 255, 255)
            SetTextEntry("STRING") 
            AddTextComponentString(settings["extra"])
            DrawText(0.730 + movetext, (settings["ymin"] - 0.011 )) 


            SetTextFont(4)
            SetTextScale(0.28, 0.28)
            SetTextColour(11, 11, 11, 255)
            SetTextEntry("STRING") 
            AddTextComponentString(settings["damages"])
            DrawText(0.778, (settings["ymin"] - 0.012 )) 

            SetTextFont(4)
            SetTextScale(0.28, 0.28)
            SetTextColour(11, 11, 11, 255)
            SetTextEntry("STRING") 
            AddTextComponentString(settings["bodydamages"])
            DrawText(0.815, (settings["ymin"] - 0.012 ))  

            SetTextFont(4)
            SetTextScale(0.28, 0.28)
            SetTextColour(11, 11, 11, 255)
            SetTextEntry("STRING") 
            AddTextComponentString(settings["fuel"])
            DrawText(0.854, (settings["ymin"] - 0.012 )) 

            

            DrawRect(0.832, settings["ymin"], 0.11, settings["ymax"]-0.002, 255,255,255,199)
            --Global.DrawRect(x, y, width, height, r, g, b, a)
        else
            SetTextFont(4)
            SetTextScale(0.31, 0.31)
            SetTextColour(255, 255, 255, 255)
            SetTextCentre(true)
            SetTextEntry("STRING") 
            AddTextComponentString(settings["name"])
            DrawText(0.7, (settings["ymin"] - 0.012 )) 

        end




        Menu.renderBox(settings["xmin"] ,settings["xmax"], settings["ymin"], settings["ymax"],boxColor[1],boxColor[2],boxColor[3],boxColor[4])


     end     
end

--------------------------------------------------------------------------------------------------------------------

function ClearMenu()
    --Menu = {}
    Menu.GUI = {}
    Menu.buttonCount = 0
    Menu.selection = 0
end

function MenuCallFunction(fnc, arg)
    _G[fnc](arg)
end