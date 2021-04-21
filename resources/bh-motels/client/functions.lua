local PlayerId        = GetPlayerServerId(PlayerId ())

function ClothingMenu(room)

    elements = {}

    table.insert(elements, {label = 'Avaliable Outfits', value = 'player_dressing'})
	table.insert(elements, {label = 'Remove Outfits', value = 'remove_cloth'})

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room', {
		title    = 'Clothing Menu',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'player_dressing' then

			ESX.TriggerServerCallback('pw-motels:getPlayerDressing', function(dressing)
				local elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing', {
					title    = 'Room '..room .. ' - Avaliable Outfits',
					align    = 'top-left',
					elements = elements
				}, function(data2, menu2)
					TriggerEvent('skinchanger:getSkin', function(skin)
						ESX.TriggerServerCallback('pw-motels:getPlayerOutfit', function(clothes)
							exports['mythic_progbar']:Progress({
           name = "openstash2",
           duration = 10000,
           label = 'Rak katlbes ...',
           useWhileDead = false,
           canCancel = false,
           controlDisables = {
             disableMovement = false,
             disableCarMovement = false,
             disableMouse = false,
             disableCombat = true,
           },
           animation = {
               animDict = "clothingtie",
               anim = "try_tie_positive_a",
           },
         }, function(cancelled)
         if not cancelled then
         	 ClearPedTasksImmediately(GetPlayerPed(-1))
                     	TriggerEvent('skinchanger:loadClothes', skin, clothes)
						TriggerEvent('esx_skin:setLastSkin', skin)

						TriggerEvent('skinchanger:getSkin', function(skin)
						TriggerServerEvent('esx_skin:save', skin)
                     exports['mythic_notify']:DoHudText('inform', 'Rak lbsti')
       end)
      end
							end)
						end, data2.current.value)
					end)
				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		elseif data.current.value == 'remove_cloth' then

			ESX.TriggerServerCallback('pw-motels:getPlayerDressing', function(dressing)
				local elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_cloth', {
					title    = 'Room '..room .. ' - Remove Outfits',
					align    = 'top-left',
					elements = elements
				}, function(data2, menu2)
					menu2.close()
					TriggerServerEvent('pw-motels:removeOutfit', data2.current.value)
					ESX.ShowNotification(_U('removed_cloth'))
				end, function(data2, menu2)
					menu2.close()
				end)
			end)
		end

	end, function(data, menu)
		menu.close()
	end)

end


DrawText3D = function(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local scale = 0.35
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
	end
end
