RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

local isJudge = false
local isPolice = false
local isMedic = false
local isDoctor = false
local isNews = false
local isInstructorMode = false
local myJob = "unemployed"
local isHandcuffed = false
local isHandcuffedAndWalking = false
local hasOxygenTankOn = false
local gangNum = 0
local cuffStates = {}

local deadcooldown = false

rootMenuConfig =  {
    {
        id = "policeDeadA",
        displayName = "10-13A",
        icon = "#police-dead",
        functionName = "dispatch:officerDown",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (Data.metadata["isdead"] or Data.metadata["inlaststand"]) and (Data.job.name == 'police' and Data.job.onduty)
        end
    },
    {
        id = "emsDeadA",
        displayName = "10-14A",
        icon = "#ems-dead",
        functionName = "dispatch:emsDown",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (Data.metadata["isdead"] or Data.metadata["inlaststand"]) and (Data.job.name == 'ambulance' and Data.job.onduty)
        end
    },
    {
        id = "general",
        displayName = "General",
        icon = "#globe-europe",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return not Data.metadata["isdead"] and not Data.metadata["inlaststand"]
        end,
        subMenus = {"vehicle:giveKeys", "general:flipveh", "general:hotdog", "general:givenum", "general:getintrunk", "general:cornerselling"}
    },

    {
        id = "house",
        displayName = "House Interaction",
        icon = "#house",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return not Data.metadata["isdead"] and not Data.metadata["inlaststand"]
        end,
        subMenus = {"house:give","house:remove", "house:doorlock", "house:reset", "house:decorate", "house:setstash", "house:setoutift", "house:setlogout"}
    },

    {
        id = "tow",
        displayName = "Tow Actions",
        icon = "#mechanic",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and (Data.job.name == "tow"))
        end,
        subMenus = {"mechanic:impound","tow:towvehicle"} --[[,"tow:checkstatus", "tow:togglenpc"]]--
    },

    {
        id = "cuff",
        displayName = "Cuff Actions",
        icon = "#cuffs",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return not Data.metadata["isdead"] and not Data.metadata["inlaststand"]
        end,
        subMenus = { "cuffing:cuff", "cuffing:steal", 'ems:putinvehicle','ems:unseatvehicle', 'police:drag' }--[[, 'kidnap:person', 'kidnap:trunk']]-- 
    },   

    {
        id = "vehicle",
        displayName = "Vehicle",
        icon = "#vehicle-options",
        functionName = "veh:options",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and IsPedInAnyVehicle(PlayerPedId(), false))
        end
    },

    {
        id = "mechanic",
        displayName = "Mechanic Actions",
        icon = "#mechanic",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and Data.job.name == "mechanic")
        end,
        subMenus = { "mechanic:impound", "mechanic:flatbed" }
    },

    {
        id = "judge",
        displayName = "Judge Actions",
        icon = "judge-actions",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and Data.job.name == "mayor" and Data.job.grade >= 2)
        end,
        subMenus = { 'judge:mdt' }
    },

    {
        id = "taxi",
        displayName = "Taxi Actions",
        icon = "#taxi",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and Data.job.name == "taxi")
        end,
        subMenus = { "taxi:togglemeter", "taxi:npcmission" }
    },

    {
        id = "police",
        displayName = "Police",
        icon = "#police",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "police" and Data.job.onduty))
        end,
        subMenus = {"police:drag", "police:softcuff", "police:cuff", "ems:putinvehicle","ems:unseatvehicle","police:unmask"}
    },

    {
        id = "gendarme",
        displayName = "Gendarme",
        icon = "#police",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "gendarme" and Data.job.onduty))
        end,
        subMenus = {"police:drag", "police:softcuff", "police:cuff", "ems:putinvehicle","ems:unseatvehicle","police:unmask"}
    },

    {
        id = "police-check",
        displayName = "Police Checks",
        icon = "#police-check",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.onduty and Data.job.name == "police"))
        end,
        subMenus = {"police:checkbank", "police:checklicenses","police:checkfines", "police:search" }
    },

    {
        id = "gendarme-check",
        displayName = "Gendarme Checks",
        icon = "#police-check",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.onduty and Data.job.name == "gendarme"))
        end,
        subMenus = {"police:checkbank", "police:checklicenses","police:checkfines", "police:search" }
    },

    {
        id = "objects",
        displayName = "Objects",
        icon = "#objects",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.onduty and (Data.job.name == "police" or Data.job.name == "gendarme")))
        end,
        subMenus = {"objects:barier", "objects:cone", "objects:tent", "objects:spike", "objects:remove"}
    },
    
    {
        id = "objects",
        displayName = "Objects",
        icon = "#objects",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "ambulance" and Data.job.onduty))
        end,
        subMenus = {"ems:bed","ems:wheelchair", "objects:remove", "objects:barier", "objects:cone", "objects:tent"}
    },

    {
        id = "deadblip",
        displayName = "10-11",
        icon = "#police-dead",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (isDead and Data.job ~= nil and (Data.job.name == "police" or Data.job.name == "ambulance"))
        end,
        subMenus = { "esx_outlawalert:deadofficerinprogress"}
    },

    {
        id = "vanilla",
        displayName = "Vanilla",
        icon = "#vanilla",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and Data.job.name == "vanilla")
        end,
        subMenus = { "vanilla:place" }
    },

    {
        id = "news",
        displayName = "News",
        icon = "#news",
        enableMenu =function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and (Data.job.name == "reporter" or Data.job.name == "weaponary"))
        end,
        subMenus = { "news:boom", "news:mic", "news:cam" }
    },

    {
        id = "ems",
        displayName = "EMS",
        icon = "#medic",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and (Data.job ~= nil and Data.job.name == "ambulance" and Data.job.onduty))
        end,
        subMenus = { 'police:drag', "ems:revive", 'ems:heal',  'ems:putinvehicle','ems:unseatvehicle'}
    }
}

newSubMenus = {
    ['judge:mdt'] = {
        title = "MDT",
        icon = "#police-mdt",
        functionName = "ctn-menu:police:mdt"
    },

    ['general:flipveh'] = {
        title = "Flip Vehicle",
        icon = "#general-flip-vehicle",
        functionName = "vehicle:flipit"
    },

    ['general:bills'] = {
        title = "Bills",
        icon = "#police-bills",
        functionName = "ctn-menu:general:bills"
    },

    ['general:hotdog'] = {
        title = "Toggle Sale",
        icon = "#hotdog",
        functionName = "ctn-hotdogjob:client:ToggleSell"
    },

    ['general:givenum'] = {
        title = "Provide Contact Details",
        icon = "#givenum",
        functionName = "ctn-phone:client:GiveContactDetails"
    },

    ['general:getintrunk'] = {
        title = "Enter Trunk",
        icon = "#getintrunk",
        functionName = "ctn-trunk:client:GetIn"
    },
	
    ['general:cornerselling'] = {
        title = "Corner Selling",
        icon = "#cornerselling",
        functionName = "ctn-drugs:client:cornerselling"
    },

    ['deadblip:sendBlip'] = {
        title = "10-11 Distress Call",
        icon = "#police-dead",
        functionName = "ctn-menu:senddeadblip"
    },
    --------------------------------------
    
    ['objects:barier'] = {
        title = "Barier",
        icon = "#barier",
        functionName = "police:client:spawnBarier"
    },

    ['objects:cone'] = {
        title = "Cone",
        icon = "#cone",
        functionName = "police:client:spawnCone"
    },

    ['objects:tent'] = {
        title = "Tent",
        icon = "#tent",
        functionName = "police:client:spawnTent"
    },

    ['objects:spike'] = {
        title = "Spike",
        icon = "#spike",
        functionName = "police:client:SpawnSpikeStrip"
    },

    ['objects:remove'] = {
        title = "Remove",
        icon = "#removeobject",
        functionName = "police:client:deleteObject"
    },

    ['ems:bed'] = {
        title = "Bed",
        icon = "#bed",
        functionName = "ctn-mada:client:bed"
    },

    ['ems:wheelchair'] = {
        title = "Wheelchair",
        icon = "#wheelchair",
        functionName = "ctn-mada:client:wheelchair"
    },
    --------------------------------------

    ['house:give'] = {
        title = "Give House Key",
        icon = "#house-givekey",
        functionName = "ctn-houses:client:giveHouseKey"
    },

    ['house:remove'] = {
        title = "Remove House Key",
        icon = "#house-removekey",
        functionName = "ctn-houses:client:removeHouseKey"
    },

    ['house:doorlock'] = {
        title = "Toggle Door lock",
        icon = "#house-doorlock",
        functionName = "ctn-houses:client:toggleDoorlock"
    },

    ['house:reset'] = {
        title = "Reset Home lock",
        icon = "#house-resetlock",
        functionName = "ctn-houses:client:ResetHouse"
    },

    ['house:decorate'] = {
        title = "Decorate house",
        icon = "#house-decorate",
        functionName = "ctn-houses:client:decorate",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return not Data.metadata["isdead"] and not Data.metadata["inlaststand"]
        end,
    },

    ['house:setstash'] = {
        title = "Set Stash",
        icon = "#house-setstash",
        functionName = "ctn-houses:client:setLocation",
        functionParameters =  "setstash"
    },

    ['house:setoutift'] = {
        title = "Outfit Set",
        icon = "#house-setoutift",
        functionName = "ctn-houses:client:setLocation",
        functionParameters =  "setoutift"
    },

    ['house:setlogout'] = {
        title = "Logout",
        icon = "#house-logout",
        functionName = "ctn-houses:client:setLocation",
        functionParameters =  "setlogout"
    },

    --------------------------------------

    ['cuffing:steal'] = {
        title = "Rob Person",
        icon = "#cuffs-steal",
        functionName = "police:client:RobPlayer",
    },
	
    ['kidnap:person'] = {
        title = "Kidnap Person",
        icon = "#cuffs-steal",
        functionName = "police:client:KidnapPlayer",
    },
	
	
    ['kidnap:trunk'] = {
        title = "Kidnap into Trunk",
        icon = "#cuffs-steal",
        functionName = "ctn-trunk:client:KidnapTrunk",
    },

    ['cuffing:cuff'] = {
        title = "Cuff",
        icon = "#cuffs-cuff",
        enableMenu = function()
            local Data = QBCore.Functions.GetPlayerData()
            return (not Data.metadata["isdead"] and not Data.metadata["inlaststand"] and Data.job ~= nil and Data.job.name ~= "gendarme" and Data.job.name ~= "ambulance" and Data.job.name ~= "police" and not IsPedInAnyVehicle(ped, true))
        end,
        functionName = "police:client:CuffPlayerSoft",
    },

    ['vanilla:place'] = {
        title = "Place Stripper",
        icon = "#stripper",
        functionName = "strippers:place",
    },
    
    --------------------------------------
    ['animations:brave'] = {
        title = "Brave",
        icon = "#animation-brave",
        functionName = "AnimSet:Brave"
    },

    ['animations:hurry'] = {
        title = "Hurry",
        icon = "#animation-hurry",
        functionName = "AnimSet:Hurry"
    },

    ['animations:business'] = {
        title = "Business",
        icon = "#animation-business",
        functionName = "AnimSet:Business"
    },

    ['animations:tipsy'] = {
        title = "Tipsy",
        icon = "#animation-tipsy",
        functionName = "AnimSet:Tipsy"
    },

    ['animations:injured'] = {
        title = "Injured",
        icon = "#animation-injured",
        functionName = "AnimSet:Injured"
    },

    ['animations:tough'] = {
        title = "Tough",
        icon = "#animation-tough",
        functionName = "AnimSet:ToughGuy"
    },

    ['animations:sassy'] = {
        title = "Sassy",
        icon = "#animation-sassy",
        functionName = "AnimSet:Sassy"
    },

    ['animations:sad'] = {
        title = "Sad",
        icon = "#animation-sad",
        functionName = "AnimSet:Sad"
    },

    ['animations:posh'] = {
        title = "Posh",
        icon = "#animation-posh",
        functionName = "AnimSet:Posh"
    },

    ['animations:alien'] = {
        title = "Alien",
        icon = "#animation-alien",
        functionName = "AnimSet:Alien"
    },

    ['animations:nonchalant'] = {
        title = "Calm",
        icon = "#animation-nonchalant",
        functionName = "AnimSet:NonChalant"
    },

    ['animations:hobo'] = {
        title = "Hobo",
        icon = "#animation-hobo",
        functionName = "AnimSet:Hobo"
    },

    ['animations:money'] = {
        title = "Money",
        icon = "#animation-money",
        functionName = "AnimSet:Money"
    },

    ['animations:swagger'] = {
        title = "Swagger",
        icon = "#animation-swagger",
        functionName = "AnimSet:Swagger"
    },

    ['animations:shady'] = {
        title = "Shady",
        icon = "#animation-shady",
        functionName = "AnimSet:Shady"
    },

    ['animations:maneater'] = {
        title = "Maneater",
        icon = "#animation-maneater",
        functionName = "AnimSet:ManEater"
    },

    ['animations:chichi'] = {
        title = "Chichi",
        icon = "#animation-chichi",
        functionName = "AnimSet:ChiChi"
    },

    ['animations:default'] = {
        title = "Default",
        icon = "#animation-default",
        functionName = "AnimSet:default"
    },

    ["expressions:angry"] = {
        title="Angry",
        icon="#expressions-angry",
        functionName = "expressions",
        functionParameters =  { "mood_angry_1" }
    },

    ["expressions:drunk"] = {
        title="Drunk",
        icon="#expressions-drunk",
        functionName = "expressions",
        functionParameters =  { "mood_drunk_1" }
    },

    ["expressions:dumb"] = {
        title="Dumb",
        icon="#expressions-dumb",
        functionName = "expressions",
        functionParameters =  { "pose_injured_1" }
    },

    ["expressions:electrocuted"] = {
        title="Electrocuted",
        icon="#expressions-electrocuted",
        functionName = "expressions",
        functionParameters =  { "electrocuted_1" }
    },

    ["expressions:grumpy"] = {
        title="Grumpy",
        icon="#expressions-grumpy",
        functionName = "expressions", 
        functionParameters =  { "mood_drivefast_1" }
    },

    ["expressions:happy"] = {
        title="Happy",
        icon="#expressions-happy",
        functionName = "expressions",
        functionParameters =  { "mood_happy_1" }
    },

    ["expressions:injured"] = {
        title="Injured",
        icon="#expressions-injured",
        functionName = "expressions",
        functionParameters =  { "mood_injured_1" }
    },

    ["expressions:joyful"] = {
        title="Joyful",
        icon="#expressions-joyful",
        functionName = "expressions",
        functionParameters =  { "mood_dancing_low_1" }
    },

    ["expressions:mouthbreather"] = {
        title="Mouthbreather",
        icon="#expressions-mouthbreather",
        functionName = "expressions",
        functionParameters = { "smoking_hold_1" }
    },

    ["expressions:normal"]  = {
        title="Normal",
        icon="#expressions-normal",
        functionName = "expressions:clear"
    },

    ["expressions:oneeye"]  = {
        title="Oneeye",
        icon="#expressions-oneeye",
        functionName = "expressions",
        functionParameters = { "pose_aiming_1" }
    },

    ["expressions:shocked"]  = {
        title="Shocked",
        icon="#expressions-shocked",
        functionName = "expressions",
        functionParameters = { "shocked_1" }
    },

    ["expressions:sleeping"]  = {
        title="Sleeping",
        icon="#expressions-sleeping",
        functionName = "expressions",
        functionParameters = { "dead_1" }
    },

    ["expressions:smug"]  = {
        title="Smug",
        icon="#expressions-smug",
        functionName = "expressions",
        functionParameters = { "mood_smug_1" }
    },

    ["expressions:speculative"]  = {
        title="Speculative",
        icon="#expressions-speculative",
        functionName = "expressions",
        functionParameters = { "mood_aiming_1" }
    },

    ["expressions:stressed"]  = {
        title="Stressed",
        icon="#expressions-stressed",
        functionName = "expressions",
        functionParameters = { "mood_stressed_1" }
    },

    ["expressions:sulking"]  = {
        title="Sulking",
        icon="#expressions-sulking",
        functionName = "expressions",
        functionParameters = { "mood_sulk_1" },
    },

    ["expressions:weird"]  = {
        title="Weird",
        icon="#expressions-weird",
        functionName = "expressions",
        functionParameters = { "effort_2" }
    },

    ["expressions:weird2"]  = {
        title="Weird 2",
        icon="#expressions-weird2",
        functionName = "expressions",
        functionParameters = { "effort_3" }
     },    
    --------------------------------------
    ['vehicle:giveKeys'] = {
        title = "Give Key",
        icon = "#vehicle-givekeys",
        functionName = "vehiclekeys:client:GiveKeys"
    },
    --------------------------------------
    ['police:unmask'] = {
        title = "Remove Mask Hat",
        icon = "#unmask",
        functionName = "police:unmask"
    },

    ['police:checkbank'] = {
        title = "Check Bank",
        icon = "#police-check-bank",
        functionName = "police:client:checkBank"
    },

    ['police:checklicenses'] = {
        title = "Check Licenses",
        icon = "#police-check-licenses",
        functionName = "police:client:checkLicenses"
    },

    ['police:checkfines'] = {
        title = "Check Fines",
        icon = "#police-check-fines",
        functionName = "police:client:checkFines"
    },

    ['police:search'] = {
        title = "Frisk",
        icon = "#police-search",
        functionName = "police:client:SearchPlayer"
    },

    ['police:drag'] = {
        title = "Escort",
        icon = "#general-escort",
        functionName = "police:client:EscortPlayer",
    },
    
    ['police:cuff'] = {
        title = "Cuff",
        icon = "#cuffs-cuff",
        functionName = "police:client:CuffPlayer"
    },

    ['police:softcuff'] = {
        title = "Soft Cuff",
        icon = "#cuffs-cuff",
        functionName = "police:client:CuffPlayerSoft"
    },
	
	--------------------------------------
    ['ems:revive'] = {
        title = "Revive",
        icon = "#ems-revive",
        functionName = "hospital:client:RevivePlayer",
    },

    ['ems:heal'] = {
        title = "Heal",
        icon = "#ems-heal",
        functionName = "hospital:client:TreatWounds",
    },

    ['ems:undrag'] = {
        title = "Drag",
        icon = "#general-escort",
        functionName = "police:client:EscortPlayer"
    },

    ['ems:putinvehicle'] = {
        title = "Seat Vehicle",
        icon = "#general-put-in-veh",
        functionName = "police:client:PutPlayerInVehicle"
    },

    ['ems:unseatvehicle'] = {
        title = "Unseat Nearest",
        icon = "#general-unseat-nearest",
        functionName = "police:client:SetPlayerOutVehicle"
    },
    --------------------------------------
	['news:boom'] = {
        title = "Boom Microphone",
        icon = "#news-boom",
        functionName = "Mic:ToggleBMic"
    },

    ['news:cam'] = {
        title = "Camera",
        icon = "#news-cam",
        functionName = "Cam:ToggleCam"
    },

    ['news:mic'] = {
        title = "Microphone",
        icon = "#news-mic",
        functionName = "Mic:ToggleMic"
    },
    --------------------------------------
    ["taxi:togglemeter"] = {
        title = "Show/Hide Meter",
        icon = "#taxi-togglemeter",
        functionName = "ctn-taxi:client:toggleMeter",
    },

    ["taxi:npcmission"] = {
        title = "Start/Stop Meter",
        icon = "#taxi-power",
        functionName = "ctn-taxi:client:enableMeter",
    },
    --------------------------------------
    ["tow:togglenpc"] = {
        title = "Toggle NPC",
        icon = "#tow-npcmission",
        functionName = "jobs:client:ToggleNpc",
    },
    
    ["tow:towvehicle"] = {
        title = "Hoist Vehicle",
        icon = "#mechanic-flatbed",
        functionName = "ctn-tow:client:TowVehicle",
    },

    ["tow:checkstatus"] = {
        title = "Check Status",
        icon = "#tow-status",
        functionName = "ctn-tow:client:status",
    },

    --------------------------------------
    ["mechanic:impound"] = {
        title = "Impound",
        icon = "#police-jail",
        functionName = "police:client:ImpoundVehicle"
    },

    ["mechanic:flatbed"] = {
        title = "Tow",
        icon = "#mechanic-flatbed",
        functionName = "ctn-mechanic:client:TowVehicle"
    }
}

function GetPlayers()
    local players = {}

    for i = 0, 128 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local closestPed = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        for index,value in ipairs(players) do
            local target = GetPlayerPed(value)
            if(target ~= ply) then
                local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
                local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
                if(closestDistance == -1 or closestDistance > distance) and not IsPedInAnyVehicle(target, false) then
                    closestPlayer = value
                    closestPed = target
                    closestDistance = distance
                end
            end
        end
        return closestPlayer, closestDistance, closestPed
    end
end

TrunkClasses = {
    [0]  = { allowed = true, x = 0.0, y = -1.5, z = 0.0 }, --Coupes  
    [1]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Sedans  
    [2]  = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --SUVs  
    [3]  = { allowed = true, x = 0.0, y = -1.5, z = 0.0 }, --Coupes  
    [4]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Muscle  
    [5]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Sports Classics  
    [6]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Sports  
    [7]  = { allowed = true, x = 0.0, y = -2.0, z = 0.0 }, --Super  
    [8]  = { allowed = false, x = 0.0, y = -1.0, z = 0.25 }, --Motorcycles  
    [9]  = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Off-road  
    [10] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Industrial  
    [11] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Utility  
    [12] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Vans  
    [13] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Cycles  
    [14] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Boats  
    [15] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Helicopters  
    [16] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Planes  
    [17] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Service  
    [18] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Emergency  
    [19] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Military  
    [20] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Commercial  
    [21] = { allowed = true, x = 0.0, y = -1.0, z = 0.25 }, --Trains  
}