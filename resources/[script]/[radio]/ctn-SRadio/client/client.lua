QBCore = nil

Citizen.CreateThread(function()
	while QBCore == nil do
		TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
		Citizen.Wait(0)
	end
end)

local vol = 5 --This is the base volume the music starts playing on, set a value between 0 and 10
local MenuSubTitle = "Catena <3" -- This is the sub-title, change it if you want.
local SRadio = MenuV:CreateMenu('Catena-RADIO', MenuSubTitle, 'centerright', 209, 159, 8, 'size-100', 'default', 'menuv', 'radio_menu', 'native') -- THIS IS THE MENU, DONT TOUCH IT UNLESS YOU KNOW WHAT YOU'RE DOING
local NowPlaying = "Made by Dev Team" -- DONT EDIT, IT WILL FUCK UP THE SCRIPT

RegisterNetEvent("leo-SRadio:Client:TriggerMenu")
AddEventHandler("leo-SRadio:Client:TriggerMenu", function()
	SRadio:ClearItems()
	local volumee = SRadio:AddRange({label = '🔊 Volume', min = 0, max = 10, value = vol, saveOnUpdate = true, description = "Made by Dev Team"  }) -- DONT EDIT, IT WILL FUCK UP THE SCRIPT
	volumee:On('change', function(item, newValue, oldValue)
		TriggerEvent("leo-SRadio:Client:ChangeAirpodsVolume", newValue)
	end)
	QBCore.Functions.TriggerCallback('leo-SRadio:Server:SyncRadios', function(radios)
		if radios ~= nil then
			for k, v in pairs(radios) do
				local station = k
				station = SRadio:AddButton({ icon = v.id, label = '📻 '..v.name, value = v.id, description = NowPlaying}) -- DONT EDIT, IT WILL FUCK UP THE SCRIPT
				station:On('select', function(item)
					if v.url == nil then
						TriggerEvent("leo-SRadio:Client:StopAirpods")
						TriggerEvent("leo-SRadio:Client:ToggleAirpods", false)
						QBCore.Functions.Notify(Config.RadioOffMSG)
						NowPlaying = "Made by Dev Team"
					else
						TriggerEvent("leo-SRadio:Client:PlayAirpods", v.url)
						TriggerEvent("leo-SRadio:Client:ToggleAirpods", true)
						QBCore.Functions.Notify(Config.RadioOnMSG ..v.name)						
						NowPlaying = "Now playing: "..v.name
					end
					SRadio:Close()
					TriggerEvent("leo-SRadio:Client:OpenMenu")
				end)
			end
		end
	end)
end)

RegisterNetEvent("leo-SRadio:Client:PlayAirpods")
AddEventHandler("leo-SRadio:Client:PlayAirpods", function(url)
	SendNUIMessage({
		playradio = true,
		sound = url,
	})
	SendNUIMessage({
		changevolume = true,
		volume = vol/100 -- DONT EDIT, IT WILL FUCK UP THE SCRIPT
	})
end)

RegisterNetEvent("leo-SRadio:Client:ChangeAirpodsVolume")
AddEventHandler("leo-SRadio:Client:ChangeAirpodsVolume", function(newValue)
	local volum = newValue/100 -- DONT EDIT, IT WILL FUCK UP THE SCRIPT
	SendNUIMessage({
		changevolume = true,
		volume = tonumber(volum)
	})
	vol = volum*100 -- DONT EDIT, IT WILL FUCK UP THE SCRIPT
end)

RegisterNetEvent("leo-SRadio:Client:StopAirpods")
AddEventHandler("leo-SRadio:Client:StopAirpods", function()
	SendNUIMessage({
		stopradio = true
	})
end)

RegisterNetEvent("leo-SRadio:Client:ToggleAirpods")
AddEventHandler("leo-SRadio:Client:ToggleAirpods", function(airpods)
	if Config.UseAirpodMod == true then
		local ped = GetPlayerPed(-1)
		if airpods == false then
			ClearPedProp(ped, 2)
		elseif airpods == true then
			SetPedPropIndex(ped, 2, 3, 0, true)
		end
	end
end)

RegisterNetEvent("leo-SRadio:Client:OpenMenu")
AddEventHandler("leo-SRadio:Client:OpenMenu", function()
	TriggerEvent("leo-SRadio:Client:TriggerMenu")
	MenuV:OpenMenu(SRadio)
end)