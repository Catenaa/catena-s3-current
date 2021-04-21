QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Code

QBCore.Commands.Add("skin", "Ooohja toch", {}, false, function(source, args)
	TriggerClientEvent("ctn-clothing:client:openMenu", source)
end, "admin")



--QBCore.Commands.Add("pp", "haaa", {}, false, function(source, args)
--	TriggerClientEvent("ctn-clothing:client:popo", source)
--end)

RegisterServerEvent("ctn-clothing:saveSkin")
AddEventHandler('ctn-clothing:saveSkin', function(model, skin)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if model ~= nil and skin ~= nil then 
        QBCore.Functions.ExecuteSql(false, "SELECT * FROM playerskins WHERE citizenid = '"..Player.PlayerData.citizenid.."' AND active = 1", function(result)
            if result[1] ~= nil then
                exports['ghmattimysql']:execute('UPDATE playerskins SET model = @model, skin = @skin, active = @active  WHERE citizenid = @citizenid', {
                    ['@model'] = model,
                    ['@skin'] = skin,
                    ['@active'] = 1,
                    ['@citizenid'] = Player.PlayerData.citizenid
                })
            else
                QBCore.Functions.ExecuteSql(false, "INSERT INTO playerskins (citizenid, model, skin, active) VALUES ('"..Player.PlayerData.citizenid.."', '"..model.."', '"..skin.."', 1)")
            end
        end)
    end
end)

RegisterServerEvent("ctn-clothes:loadPlayerSkin")
AddEventHandler('ctn-clothes:loadPlayerSkin', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    QBCore.Functions.ExecuteSql(false, "SELECT * FROM `playerskins` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."' AND `active` = 1", function(result)
        if result[1] ~= nil then
            TriggerClientEvent("ctn-clothes:loadSkin", src, false, result[1].model, result[1].skin)
        else
            TriggerClientEvent("ctn-clothes:loadSkin", src, true)
        end
    end)
end)

RegisterServerEvent("ctn-clothes:saveOutfit")
AddEventHandler("ctn-clothes:saveOutfit", function(outfitName, model, skinData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if model ~= nil and skinData ~= nil then
        local outfitId = "outfit-"..math.random(1, 10).."-"..math.random(1111, 9999)
        QBCore.Functions.ExecuteSql(false, "INSERT INTO `player_outfits` (`citizenid`, `outfitname`, `model`, `skin`, `outfitId`) VALUES ('"..Player.PlayerData.citizenid.."', '"..outfitName.."', '"..model.."', '"..json.encode(skinData).."', '"..outfitId.."')", function()
            QBCore.Functions.ExecuteSql(false, "SELECT * FROM `player_outfits` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'", function(result)
                if result[1] ~= nil then
                    TriggerClientEvent('ctn-clothing:client:reloadOutfits', src, result)
                else
                    TriggerClientEvent('ctn-clothing:client:reloadOutfits', src, nil)
                end
            end)
        end)
    end
end)

RegisterServerEvent("ctn-clothing:server:removeOutfit")
AddEventHandler("ctn-clothing:server:removeOutfit", function(outfitName, outfitId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    QBCore.Functions.ExecuteSql(false, "DELETE FROM `player_outfits` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."' AND `outfitname` = '"..outfitName.."' AND `outfitId` = '"..outfitId.."'", function()
        QBCore.Functions.ExecuteSql(false, "SELECT * FROM `player_outfits` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'", function(result)
            if result[1] ~= nil then
                TriggerClientEvent('ctn-clothing:client:reloadOutfits', src, result)
            else
                TriggerClientEvent('ctn-clothing:client:reloadOutfits', src, nil)
            end
        end)
    end)
end)

QBCore.Functions.CreateCallback('ctn-clothing:server:getOutfits', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local anusVal = {}

    QBCore.Functions.ExecuteSql(false, "SELECT * FROM `player_outfits` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."'", function(result)
        if result[1] ~= nil then
            for k, v in pairs(result) do
                result[k].skin = json.decode(result[k].skin)
                anusVal[k] = v
            end
            cb(anusVal)
        end
        cb(anusVal)
    end)
end)

RegisterServerEvent('ctn-clothing:print')
AddEventHandler('ctn-clothing:print', function(data)
    print(data)
end)

QBCore.Commands.Add("helm", "Toggle your helmet..", {}, false, function(source, args)
    TriggerClientEvent("ctn-clothing:client:adjustfacewear", source, 1) -- Hat
end)

QBCore.Commands.Add("glasses", "Toggle your glasses..", {}, false, function(source, args)
	TriggerClientEvent("ctn-clothing:client:adjustfacewear", source, 2)
end)

QBCore.Commands.Add("mask", "Toggle your mask..", {}, false, function(source, args)
	TriggerClientEvent("ctn-clothing:client:adjustfacewear", source, 4)
end)