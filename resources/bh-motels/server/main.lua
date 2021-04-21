QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('pw-motels:rentRoom')
AddEventHandler('pw-motels:rentRoom', function(room, motel)
 local src = tonumber(source)
 local xPlayer = ESX.GetPlayerFromId(src)
 local ident = xPlayer.getIdentifier()
 MySQL.Async.fetchAll('SELECT * FROM pw_motels WHERE motelid = @motelid AND room = @room', {['@motelid'] = motel, ['@room'] = room}, function(spamCheck)
  MySQL.Async.fetchAll('SELECT * FROM pw_motels WHERE ident = @ident', {['@ident'] = ident}, function(motelowner)
   if tonumber(xPlayer.getBank()) >= tonumber(Config.Complexs[motel].price) then
    if motelowner[1] == nil and spamCheck[1] == nil then
     xPlayer.removeAccountMoney('bank', Config.Complexs[motel].price)
     MySQL.Sync.execute('INSERT INTO pw_motels (ident, motelid, room, days_left) VALUES (@ident, @motel, @room, @days_left)', { ["@ident"] = ident, ["@motel"] = motel, ["@room"] = room, ['@days_left'] = 7})
     TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Rak kriti room '..room..' f Hotel '..Config.Complexs[motel].name, length = 5000})
     TriggerEvent('pw-motels:updateRooms')
    elseif motelowner[1] ~= nil then
     if motelowner[1].days_left <= 3 then
      if Config.Complexs[motel].name == Config.Complexs[tonumber(motelowner[1].motelid)].name then
       xPlayer.removeAccountMoney('bank', Config.Complexs[motel].price)
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'success', text = 'Hotel room '..room..' f '..Config.Complexs[motel].name..' Raha tkhlset b $'..Config.Complexs[motel].price..' 👍', length = 2500})
       MySQL.Sync.execute("UPDATE `pw_motels` SET `days_left` = 7 WHERE ident = @ident", {['@ident'] = ident})
      else
       TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = '3andk ha9 tkoun 3andk room whda f '..Config.Complexs[tonumber(motelowner[1].motelid)].name..' 👍', length = 5000})
      end
     else
      TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 't9der t3awd tkhles lkra mn ba3d 3 ayam fach kriti room 👍 .', length = 2500})
     end
    end
   else
      TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = 'M3andkch flouss fla Bank 🚫 .', length = 3000})
   end
  end)
 end)
end)

RegisterServerEvent('pw-motels:cancelRoom')
AddEventHandler('pw-motels:cancelRoom', function(room, motel)
 src = source
 local xPlayer = ESX.GetPlayerFromId(src)
 local ident = xPlayer.getIdentifier()
 for k,v in pairs(Config.Rooms) do
  if tostring(room) == tostring(v.roomno) and motel == v.motelid then
   v.lock = true
   v.owner = nil
   v.ident = nil
  end
 end
 MySQL.Sync.execute('DELETE FROM pw_motels WHERE ident = @ident AND motelid = @motel AND room = @room', { ["@ident"] = ident, ["@motel"] = motel, ["@room"] = room})
 TriggerEvent('pw-motels:updateRooms')
end)

RegisterServerEvent('pw-motels:toggleLock')
AddEventHandler('pw-motels:toggleLock', function(motel, room, lock)
    for k,v in pairs(Config.Rooms) do
        if tostring(room) == tostring(v.roomno) and motel == v.motelid then
            v.lock = lock
        end
    end
    TriggerClientEvent('pw-motels:receiveOwners', -1, Config.Rooms)
end)

ESX.RegisterServerCallback('pw-motels:myIdent', function(source, cb)
    src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local ident = xPlayer.getIdentifier()
    cb(ident)
end)


ESX.RegisterServerCallback('motels:mycash', function(source, cb)
    src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local ident = xPlayer.getBank()
    cb(ident)
end)

RegisterServerEvent('pw-motels:updateRooms')
AddEventHandler('pw-motels:updateRooms', function(source)
    MySQL.Async.fetchAll('SELECT * FROM pw_motels', {}, function(owners)
        for i=1, #owners, 1 do
            local motel = owners[i].motelid
            local room = owners[i].room
            local owner = owners[i].ident
            for k,v in pairs(Config.Rooms) do
                if owners[i].room == tostring(v.roomno) and owners[i].motelid == v.motelid then
                    local xPlayer = ESX.GetPlayerFromIdentifier(owner)
                    if xPlayer then
                        -- Set as Rented, and allocate the users ServerID so they can access it.
                        v.owner = xPlayer.source
                        v.ident = owner
                    else
                        -- Set as Ident so the Motel Room Appears as Rented to Other Players
                        v.owner = owner
                        v.ident = owner
                    end
                end
            end
        end
        TriggerClientEvent('pw-motels:receiveOwners', -1, Config.Rooms)
    end)
end)

MySQL.ready(function()
    MySQL.Async.fetchAll('SELECT * FROM pw_motels', {}, function(owners)
        for i=1, #owners, 1 do
            local motel = owners[i].motelid
            local room = owners[i].room
            local owner = owners[i].ident
            for k,v in pairs(Config.Rooms) do

               if owners[i].room == tostring(v.roomno) and owners[i].motelid == v.motelid then
                    local xPlayer = ESX.GetPlayerFromIdentifier(owner)
                    if xPlayer then
                        -- Set as Rented, and allocate the users ServerID so they can access it.
                        v.owner = xPlayer.source
                        v.ident = owner
                    else
                        -- Set as Ident so the Motel Room Appears as Rented to Other Players
                        v.owner = owner
                        v.ident = owner
                    end
                end
            end
        end

        TriggerClientEvent('pw-motels:receiveOwners', -1, Config.Rooms)
        forcePush()
    end)

end)

ESX.RegisterServerCallback('pw-motels:checkUserOnline', function(source, cb, motel, room)
    for k,v in pairs(Config.Rooms) do
        if motel == v.motelid and room == v.roomno then
            if v.ident == nil then
                cb(true)
            else
                local xPlayer = ESX.GetPlayerFromIdentifier(v.ident)
                if xPlayer then
                    cb(true)
                else
                    cb(false)
                end
            end
        end
    end
end)


function forcePush()
    TriggerEvent('pw-motels:updateRooms')
    SetTimeout(60000, forcePush)
end


AddEventHandler('hotel:check', function(source)
 Wait(1000)
 local src = tonumber(source)
 local xPlayer = ESX.GetPlayerFromId(src)
 local ident = xPlayer.getIdentifier()
 MySQL.Async.fetchAll('SELECT * FROM pw_motels WHERE ident = @ident', {['@ident'] = ident}, function(motelowner)
  if motelowner[1] ~= nil then
   if motelowner[1].days_left <= 3 then
    if motelowner[1].days_left ~= 1 then
     TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Hotel room '..motelowner[1].room..' F '..Config.Complexs[tonumber(motelowner[1].motelid)].name..' ghathyd lik f '..motelowner[1].days_left..' days. khlsha f reception 👍 .', length = 5500})
    else
     TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = 'Hotel room '..motelowner[1].room..' F '..Config.Complexs[tonumber(motelowner[1].motelid)].name..' ghathyd lik f '..motelowner[1].days_left..' day. khlsha f reception 👍 .', length = 5500})
    end
   end
  end
 end)
end)






























local builtRooms = {}

RegisterServerEvent('hotel:createRoom')
AddEventHandler('hotel:createRoom', function(data)
 local source = tonumber(source)
 if builtRooms[data.id] ~= nil and builtRooms[data.id].id ~= nil then
  builtRooms[data.id].people = builtRooms[data.id].people + 1
  TriggerClientEvent('hotel:sendToRoom', source, builtRooms[data.id])
 else
  builtRooms[data.id] = data
  builtRooms[data.id].people = 1
  TriggerClientEvent('hotel:sendToRoom', source, data)
 end
end)

RegisterServerEvent('hotel:deleteRoom')
AddEventHandler('hotel:deleteRoom', function(id)
 local source = tonumber(source)
 if builtRooms[id].people == 1 then
  TriggerClientEvent('hotel:deleteRoom', source, builtRooms[id])
  builtRooms[id] = nil
 else
  TriggerClientEvent('hotel:deleteRoom', source, builtRooms[id])
  builtRooms[id].people = builtRooms[id].people - 1
 end
end)














































function CronTask(d, h, m)
 MySQL.Async.fetchAll('SELECT * FROM pw_motels', {}, function(res)
  for id,v in pairs(res) do
   if v.days_left > 0 then
    MySQL.Sync.execute("UPDATE `pw_motels` SET `days_left` = days_left-1 WHERE ident = @ident", {['@ident'] = v.ident})
   else
    MySQL.Sync.execute('DELETE FROM pw_motels WHERE ident = @ident AND motelid = @motel AND room = @room', { ["@ident"] = v.ident, ["@motel"] = v.motel, ["@room"] = v.room})
   end
  end
  TriggerEvent('pw-motels:updateRooms')
 end)
end

TriggerEvent('cron:runAt', 22, 00, CronTask)
