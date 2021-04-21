QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('ctn-multicharacter:server:disconnect')
AddEventHandler('ctn-multicharacter:server:disconnect', function()
    local src = source

    DropPlayer(src, "You have disconnected from Catena Roleplay")
end)

RegisterServerEvent('ctn-multicharacter:server:loadUserData')
AddEventHandler('ctn-multicharacter:server:loadUserData', function(cData)
    local src = source
    if QBCore.Player.Login(src, cData.citizenid) then
        print('^2[Catena]^7 '..GetPlayerName(src)..' (Citizen ID: '..cData.citizenid..') has succesfully loaded!')
        QBCore.Commands.Refresh(src)
        loadHouseData()
		--TriggerEvent('QBCore:Server:OnPlayerLoaded')-
        --TriggerClientEvent('QBCore:Client:OnPlayerLoaded', src)
        
        TriggerClientEvent('apartments:client:setupSpawnUI', src, cData)
        TriggerEvent("ctn-logs:server:sendLog", cData.citizenid, "characterloaded", {})
        TriggerEvent("ctn-logs:server:CreateLog", "joinleave", "Loaded", "green", "**".. GetPlayerName(src) .. "** ("..cData.citizenid.." | "..src..") loaded..")
	end
end)

RegisterServerEvent('ctn-multicharacter:server:createCharacter')
AddEventHandler('ctn-multicharacter:server:createCharacter', function(data)
    local src = source
    local newData = {}
    local steamId = GetPlayerIdentifiers(source)[1]
    newData.cid = data.cid
    newData.charinfo = data
    print("creating chgar with  info ",data.cid,data)
    --QBCore.Player.CreateCharacter(src, data)

	exports['ghmattimysql']:execute('SELECT * FROM permissions WHERE steam = @steam', {['@steam'] = steamId}, function(result)
        if (tonumber(data.cid) < 3 and  #result>0) then
            if (result[1].permission == "vip" or result[1].permission == "god") then
                    if QBCore.Player.Login(src, false, newData) then
                    print('^2[Catena]^7 '..GetPlayerName(src)..' has succesfully loaded!')
                    QBCore.Commands.Refresh(src)
                    loadHouseData()

                    TriggerClientEvent("ctn-multicharacter:client:closeNUI", src)
                    TriggerClientEvent('apartments:client:setupSpawnUI', src, newData)
                    GiveStarterItems(src)
                    end
            else
                print(result[1].name,result[1].steam)
                print("NOT VIP trying to have a character slot.")
                    TriggerClientEvent("ctn-multicharacter:client:closeNUI", src)
                    TriggerClientEvent("ctn-multicharacter:client:openNUI", src)
            end
        elseif (tonumber(data.cid) < 4 and  #result>0) then
            if (result[1].permission == "admin") then
                    if QBCore.Player.Login(src, false, newData) then
                    print('^2[Catena]^7 '..GetPlayerName(src)..' has succesfully loaded!')
                    QBCore.Commands.Refresh(src)
                    loadHouseData()

                    TriggerClientEvent("ctn-multicharacter:client:closeNUI", src)
                    TriggerClientEvent('apartments:client:setupSpawnUI', src, newData)
                    GiveStarterItems(src)
                    end
            else
                print(result[1].name,result[1].steam)
                print("NOT VIP trying to have a character slot.")
                    TriggerClientEvent("ctn-multicharacter:client:closeNUI", src)
                    TriggerClientEvent("ctn-multicharacter:client:openNUI", src)
            end
        elseif (tonumber(data.cid) > 1 and  #result>0) then
            if (result[1].permission == "god") then
                    if QBCore.Player.Login(src, false, newData) then
                    print('^2[Catena]^7 '..GetPlayerName(src)..' has succesfully loaded!')
                    QBCore.Commands.Refresh(src)
                    loadHouseData()

                    TriggerClientEvent("ctn-multicharacter:client:closeNUI", src)
                    TriggerClientEvent('apartments:client:setupSpawnUI', src, newData)
                    GiveStarterItems(src)
                    end
            else
                print(result[1].name,result[1].steam)
                print("NOT VIP trying to have a character slot.")
                    TriggerClientEvent("ctn-multicharacter:client:closeNUI", src)
                    TriggerClientEvent("ctn-multicharacter:client:openNUI", src)
            end
        elseif data.cid == "1" then
            if QBCore.Player.Login(src, false, newData) then
                print('^2[Catena]^7 '..GetPlayerName(src)..' has succesfully loaded!')
                QBCore.Commands.Refresh(src)
                loadHouseData()

                TriggerClientEvent("ctn-multicharacter:client:closeNUI", src)
                TriggerClientEvent('apartments:client:setupSpawnUI', src, newData)
                GiveStarterItems(src)
                end		
        else 
           -- print(result[1].permission," NOT a test")     
            print(steamId," NOT VIP trying to have a character slot.")
                TriggerClientEvent("ctn-multicharacter:client:closeNUI", src)
                TriggerClientEvent("ctn-multicharacter:client:openNUI", src)
                TriggerClientEvent('QBCore:Notify', src, "You are not VIP !")
        end       
end)

end)

function GiveStarterItems(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    for k, v in pairs(QBCore.Shared.StarterItems) do
        local info = {}
        if v.item == "id_card" then
            info.citizenid = Player.PlayerData.citizenid
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.gender = Player.PlayerData.charinfo.gender
            info.nationality = Player.PlayerData.charinfo.nationality
        elseif v.item == "driver_license" then
            info.firstname = Player.PlayerData.charinfo.firstname
            info.lastname = Player.PlayerData.charinfo.lastname
            info.birthdate = Player.PlayerData.charinfo.birthdate
            info.type = "A1-A2-A | AM-B | C1-C-CE"
        end
        Player.Functions.AddItem(v.item, 1, false, info)
    end
end

RegisterServerEvent('ctn-multicharacter:server:deleteCharacter')
AddEventHandler('ctn-multicharacter:server:deleteCharacter', function(citizenid)
    local src = source
    QBCore.Player.DeleteCharacter(src, citizenid)
end)

QBCore.Functions.CreateCallback("ctn-multicharacter:server:GetUserCharacters", function(source, cb)
    local steamId = GetPlayerIdentifier(source, 0)

    exports['ghmattimysql']:execute('SELECT * FROM players WHERE steam = @steam', {['@steam'] = steamId}, function(result)
        cb(result)
    end)
end)

QBCore.Functions.CreateCallback("ctn-multicharacter:server:GetServerLogs", function(source, cb)
    exports['ghmattimysql']:execute('SELECT * FROM server_logs', function(result)
        cb(result)
    end)
end)

QBCore.Functions.CreateCallback("test:yeet", function(source, cb)
    local steamId = GetPlayerIdentifiers(source)[1]
    local plyChars = {}
    
    exports['ghmattimysql']:execute('SELECT * FROM players WHERE steam = @steam', {['@steam'] = steamId}, function(result)
        for i = 1, (#result), 1 do
            result[i].charinfo = json.decode(result[i].charinfo)
            result[i].money = json.decode(result[i].money)
            result[i].job = json.decode(result[i].job)

            table.insert(plyChars, result[i])
        end
        cb(plyChars)
    end)
end)

QBCore.Commands.Add("char", "Geef een item aan een speler", {{name="id", help="Speler ID"},{name="item", help="Naam van het item (geen label)"}, {name="amount", help="Aantal items"}}, false, function(source, args)
    QBCore.Player.Logout(source)
    TriggerClientEvent('ctn-multicharacter:client:chooseChar', source)
end, "admin")

QBCore.Commands.Add("closeNUI", "Geef een item aan een speler", {{name="id", help="Speler ID"},{name="item", help="Naam van het item (geen label)"}, {name="amount", help="Aantal items"}}, false, function(source, args)
    TriggerClientEvent('ctn-multicharacter:client:closeNUI', source)
end)

QBCore.Functions.CreateCallback("ctn-multicharacter:server:getSkin", function(source, cb, cid)
    local src = source

    QBCore.Functions.ExecuteSql(false, "SELECT * FROM `playerskins` WHERE `citizenid` = '"..cid.."' AND `active` = 1", function(result)
        if result[1] ~= nil then
            cb(result[1].model, result[1].skin)
        else
            cb(nil)
        end
    end)
end)

function loadHouseData()
    local HouseGarages = {}
    local Houses = {}
	QBCore.Functions.ExecuteSql(false, "SELECT * FROM `houselocations`", function(result)
		if result[1] ~= nil then
			for k, v in pairs(result) do
				local owned = false
				if tonumber(v.owned) == 1 then
					owned = true
				end
				local garage = v.garage ~= nil and json.decode(v.garage) or {}
				Houses[v.name] = {
					coords = json.decode(v.coords),
					owned = v.owned,
					price = v.price,
					locked = true,
					adress = v.label, 
					tier = v.tier,
					garage = garage,
					decorations = {},
				}
				HouseGarages[v.name] = {
					label = v.label,
					takeVehicle = garage,
				}
			end
		end
		TriggerClientEvent("ctn-garages:client:houseGarageConfig", -1, HouseGarages)
		TriggerClientEvent("ctn-houses:client:setHouseConfig", -1, Houses)
	end)
end
