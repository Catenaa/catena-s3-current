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
local started = false
local displayed = false
local progress = 0
local CurrentVehicle 
local pause = false
local selection = 0
local quality = 0
QBCore = nil

local LastCar

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(10)
        if QBCore == nil then
            TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)

RegisterNetEvent('qb-methcar:stop')
AddEventHandler('qb-methcar:stop', function()
	started = false
	DisplayHelpText("~r~Gaminimo procesas sustabdytas...")
	FreezeEntityPosition(LastCar, false)
end)
RegisterNetEvent('qb-methcar:stopfreeze')
AddEventHandler('qb-methcar:stopfreeze', function(id)
	FreezeEntityPosition(id, false)
end)

RegisterNUICallback('Notify', function(data, cb)
    QBCore.Functions.Notify(data.message, data.type)
end)

RegisterNetEvent('qb-methcar:startprod')
AddEventHandler('qb-methcar:startprod', function()
	DisplayHelpText("~g~Pradedama gaminti")
	started = true
	FreezeEntityPosition(CurrentVehicle,true)
	displayed = false
	print('Started Amfetamino gaminimo procesas')
	QBCore.Functions.Notify("Amfetamino gaminimo procesas pradedamas!")
	SetPedIntoVehicle(GetPlayerPed(-1), CurrentVehicle, 3)
	SetVehicleDoorOpen(CurrentVehicle, 2)
end)

RegisterNetEvent('qb-methcar:blowup')
AddEventHandler('qb-methcar:blowup', function(posx, posy, posz)
	AddExplosion(posx, posy, posz + 2,23, 20.0, true, false, 1.0, true)
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Citizen.Wait(1)
		end
	end
	SetPtfxAssetNextCall("core")
	local fire = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", posx, posy, posz-0.8 , 0.0, 0.0, 0.0, 0.8, false, false, false, false)
	Citizen.Wait(6000)
	StopParticleFxLooped(fire, 0)
	
end)


RegisterNetEvent('qb-methcar:smoke')
AddEventHandler('qb-methcar:smoke', function(posx, posy, posz, bool)

	if bool == 'a' then

		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("exp_grd_flare", posx, posy, posz + 1.7, 0.0, 0.0, 0.0, 2.0, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.8)
		SetParticleFxLoopedColour(smoke, 0.0, 0.0, 0.0, 0)
		Citizen.Wait(22000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end

end)
RegisterNetEvent('qb-methcar:drugged')
AddEventHandler('qb-methcar:drugged', function()
	SetTimecycleModifier("drug_drive_blend01")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)

	Citizen.Wait(300000)
	ClearTimecycleModifier()
end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		
		playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(GetPlayerPed(-1))
		if IsPedInAnyVehicle(playerPed) then
			
			
			CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId())

			car = GetVehiclePedIsIn(playerPed, false)
			LastCar = GetVehiclePedIsUsing(playerPed)
	
			local model = GetEntityModel(CurrentVehicle)
			local modelName = GetDisplayNameFromVehicleModel(model)
			
			if modelName == 'JOURNEY' and car then
				
					if GetPedInVehicleSeat(car, -1) == playerPed then
						if started == false then
							if displayed == false then
								DisplayHelpText("Spauskite ~INPUT_CONTEXT~ kad pradetumete gaminti")
								displayed = true
							end
						end
						if IsControlJustReleased(0, Keys['E']) then
							if pos.y >= 1000 then
								if IsVehicleSeatFree(CurrentVehicle, 3) then
									TriggerServerEvent('qb-methcar:start')	
									progress = 0
									pause = false
									selection = 0
									quality = 0
									
								else
									DisplayHelpText('~r~Mašina jau užimta')
								end
							else
								QBCore.Functions.Notify("Jus per daug arti miesto, važiuokite i šiaure, arciau kalnu!")
							end
							
							
							

		
						end
					end
					
				
				
			
			end
			
		else

				
				if started then
					started = false
					displayed = false
					TriggerEvent('qb-methcar:stop')
					print('Baigete gaminti narkotikus')
					FreezeEntityPosition(LastCar,false)
				end
		end
		
		if started == true then
			
			if progress < 96 then
				Citizen.Wait(6000)
				if not pause and IsPedInAnyVehicle(playerPed) then
					progress = progress +  1

					QBCore.Functions.Notify("Amfetamino gaminimo procesas: " .. progress .. "%!")
					Citizen.Wait(6000) 
				end

				--
				--   EVENT 1
				--
				if progress > 22 and progress < 24 then
					pause = true
					if selection == 0 then
						QBCore.Functions.Notify("Prakiuro megintuvelis, ka darote?")
						QBCore.Functions.Notify("1. Panaudojate lipnia juosta")
						QBCore.Functions.Notify("2. Paliekate kaip yra")
						QBCore.Functions.Notify("3. Pakeiciate i nauja")
						QBCore.Functions.Notify("Spauskite klaviaturos skaicius")
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						QBCore.Functions.Notify("Šiek tiek padejo")
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						QBCore.Functions.Notify("Megintuvelis sprogo, sugadinote produkcija...")
						TriggerServerEvent('qb-methcar:blow', pos.x, pos.y, pos.z)
						SetVehicleEngineHealth(CurrentVehicle, 0.0)
						quality = 0
						started = false
						displayed = false
						ApplyDamageToPed(GetPlayerPed(-1), 10, false)
						print('Gamybos procesas sustabdytas')
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						QBCore.Functions.Notify("Šaunuolis, taip ir toliau")
						pause = false
						quality = quality + 5
					end
				end
				--
				--   EVENT 5
				--
				if progress > 30 and progress < 32 then
					pause = true
					if selection == 0 then
						QBCore.Functions.Notify("Išpylete acetono ant žemes, ka darote?")	
						QBCore.Functions.Notify("1. Atidarysiu langa")	
						QBCore.Functions.Notify("2. Paliksiu kaip yra")
						QBCore.Functions.Notify("3. Užsidesiu kauke su filtru")
						QBCore.Functions.Notify("Spauskite klaviaturos skaicius")
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						QBCore.Functions.Notify("Atidarete langus")
						quality = quality - 1
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						QBCore.Functions.Notify("Jus prisikvepavote acetono")
						pause = false
						TriggerEvent('qb-methcar:drugged')
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						QBCore.Functions.Notify("Manau, tai yra teisingiausias variantas")
						SetPedPropIndex(playerPed, 1, 26, 7, true)
						pause = false
					end
				end
				--
				--   EVENT 2
				--
				if progress > 38 and progress < 40 then
					pause = true
					if selection == 0 then
						QBCore.Functions.Notify("Amfetaminas kieteja per greitai, ka darote?")
						QBCore.Functions.Notify("1. Padidinate slegi")
						QBCore.Functions.Notify("2. Padidinate temperatura")
						QBCore.Functions.Notify("3. Sumažinate slegi")
						QBCore.Functions.Notify("Spauskite klaviaturos skaicius")
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						QBCore.Functions.Notify("3. Padidinote slegi, bet teko ji sumažinti, nes butu sproges")
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						QBCore.Functions.Notify("3. Temperaturos didinimas padejo...")
						quality = quality + 5
						pause = false
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						QBCore.Functions.Notify("3. Sumažinus slegi padarete dar blogiau negu buvo...")
						pause = false
						quality = quality -4
					end
				end
				--
				--   EVENT 8 - 3
				--
				if progress > 41 and progress < 43 then
					pause = true
					if selection == 0 then
						QBCore.Functions.Notify("Jus netycia ipylete acetono, ka darote?")
						QBCore.Functions.Notify("1. Nieko")
						QBCore.Functions.Notify("2. Bandote išsiurbti su švirkštu")
						QBCore.Functions.Notify("3. Idedate daugiau licio, kad sulygintumete")
						QBCore.Functions.Notify("Spauskite klaviaturos skaicius")
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						QBCore.Functions.Notify("Amfetaminas nekvepia acetonu")
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						QBCore.Functions.Notify("Tai suveike, bet vis tiek per daug")
						pause = false
						quality = quality - 1
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						QBCore.Functions.Notify("Sekmingai išlyginote kiekius")
						pause = false
						quality = quality + 3
					end
				end
				--
				--   EVENT 3
				--
				if progress > 46 and progress < 49 then
					pause = true
					if selection == 0 then
						QBCore.Functions.Notify("Radote spalvos priemaišas, ka darote?")	
						QBCore.Functions.Notify("1. Idedu")	
						QBCore.Functions.Notify("2. Numetu kuo toliau")	
						QBCore.Functions.Notify("3. Išgeriu")
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						QBCore.Functions.Notify("Gera ideja, žmonems patinka spalvos")	
						quality = quality + 4
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						QBCore.Functions.Notify("Tai padariau, nes gali sugadinti skoni")	
						pause = false
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						QBCore.Functions.Notify("Jus šiek tiek apsvaigote, bet viskas gerai")	
						pause = false
					end
				end
				--
				--   EVENT 4
				--
				if progress > 55 and progress < 58 then
					pause = true
					if selection == 0 then
						QBCore.Functions.Notify("Užsikimšo filtas, ka darote?")		
						QBCore.Functions.Notify("1. Išvasau su suspaustu oru")	
						QBCore.Functions.Notify("2. Pakeiciu i nauja filtra")
						QBCore.Functions.Notify("3. Išvalau su dangu šepetuku")
						QBCore.Functions.Notify("Spauskite klaviaturos skaicius")
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						QBCore.Functions.Notify("Suspaustas oras išpyle amfetamina ant jusu")
						quality = quality - 2
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						QBCore.Functions.Notify("Pakeisti yra geriausias pasirinkimas")
						pause = false
						quality = quality + 3
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						QBCore.Functions.Notify("Tai suveike, bet jis vis tiek užsikimšes")
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 5
				--
				if progress > 58 and progress < 60 then
					pause = true
					if selection == 0 then
						QBCore.Functions.Notify("Išpylete acetono buteliuka ant žemes, ka darote?")
						QBCore.Functions.Notify("1. Atidarau langus")
						QBCore.Functions.Notify("2. Nieko")
						QBCore.Functions.Notify("3. Užsidedu kauke su filtru")
						QBCore.Functions.Notify("Spauskite klaviaturos skaicius")
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						QBCore.Functions.Notify("Atidarete langus")
						quality = quality - 1
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						QBCore.Functions.Notify("Jus prisikvepavote acetono")
						pause = false
						TriggerEvent('qb-methcar:drugged')
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						QBCore.Functions.Notify("Manau, tai yra teisingiausias variantas")
						SetPedPropIndex(playerPed, 1, 26, 7, true)
						pause = false
					end
				end
				--
				--   EVENT 1 - 6
				--
				if progress > 63 and progress < 65 then
					pause = true
					if selection == 0 then
						QBCore.Functions.Notify("Prakiuro megintuvelis, ka darote?")	
						QBCore.Functions.Notify("1. Panaudojate lipnia juosta")
						QBCore.Functions.Notify("2. Paliekate kaip yra")
						QBCore.Functions.Notify("3. Pakeiciate i nauja")
						QBCore.Functions.Notify("Spauskite klaviaturos skaicius")
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						QBCore.Functions.Notify("Šiek tiek padejo")
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						QBCore.Functions.Notify("Megintuvelis sprogo, sugadinote produkcija...")
						TriggerServerEvent('qb-methcar:blow', pos.x, pos.y, pos.z)
						SetVehicleEngineHealth(CurrentVehicle, 0.0)
						quality = 0
						started = false
						displayed = false
						ApplyDamageToPed(GetPlayerPed(-1), 10, false)
						print('Gamybos procesas sustabdytas')
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						QBCore.Functions.Notify("Šaunuolis, taip ir toliau")
						pause = false
						quality = quality + 5
					end
				end
				--
				--   EVENT 4 - 7
				--
				if progress > 71 and progress < 73 then
					pause = true
					if selection == 0 then
						QBCore.Functions.Notify("Užsikimšo filtas, ka darote?")		
						QBCore.Functions.Notify("1. Išvasau su suspaustu oru")	
						QBCore.Functions.Notify("2. Pakeiciu i nauja filtra")
						QBCore.Functions.Notify("3. Išvalau su dangu šepetuku")
						QBCore.Functions.Notify("Spauskite klaviaturos skaicius")
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						QBCore.Functions.Notify("Suspaustas oras išpyle amfetamina ant jusu")
						quality = quality - 2
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						QBCore.Functions.Notify("Pakeisti yra geriausias pasirinkimas")
						pause = false
						quality = quality + 3
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						QBCore.Functions.Notify("Tai suveike, bet jis vis tiek užsikimšes")
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 8
				--
				if progress > 76 and progress < 78 then
					pause = true
					if selection == 0 then
						QBCore.Functions.Notify("Jus netycia ipylete acetono, ka darote?")	
						QBCore.Functions.Notify("1. Nieko")
						QBCore.Functions.Notify("2. Bandote išsiurbti su švirkštu")
						QBCore.Functions.Notify("3. Idedate daugiau licio, kad sulygintumete")
						QBCore.Functions.Notify("Spauskite klaviaturos skaicius")
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						QBCore.Functions.Notify("Amfetaminas nekvepia acetonu")
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						QBCore.Functions.Notify("Amfetaminas nekvepia acetonu")
						pause = false
						quality = quality - 1
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						QBCore.Functions.Notify("Sekmingai išlyginote kiekius")
						pause = false
						quality = quality + 3
					end
				end
				--
				--   EVENT 9
				--
				if progress > 82 and progress < 84 then
					pause = true
					if selection == 0 then	
						QBCore.Functions.Notify("Jums darosi karšta, ka darote?")
						QBCore.Functions.Notify("1. Atsidarau artimiausia langa")
						QBCore.Functions.Notify("2. Nieko")
						QBCore.Functions.Notify("3. Atidarau duris ir langus")
						QBCore.Functions.Notify("Spauskite klaviaturos skaicius")
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						QBCore.Functions.Notify("Šaunuolis, taip ir toliau")
						quality = quality + 1
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						QBCore.Functions.Notify("Jus vos neuždusote, bet atidarete langa...")
						pause = false
						quality = quality - 2
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						QBCore.Functions.Notify("Kol atidarinejote amfetaminas pradejo svilti")
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 10
				--
				if progress > 88 and progress < 90 then
					pause = true
					if selection == 0 then
						QBCore.Functions.Notify("Ar norite ideti druskos?")
						QBCore.Functions.Notify("1. Taip!")
						QBCore.Functions.Notify("2. Ne")
						QBCore.Functions.Notify("3. Idesiu ir druskos ir cukraus!")
						QBCore.Functions.Notify("Spauskite klaviaturos skaicius")
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						QBCore.Functions.Notify("Dabar bus gardžiau")
						quality = quality + 1
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						QBCore.Functions.Notify("Darote gera produkta, taip ir toliau")
						pause = false
						quality = quality + 1
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						QBCore.Functions.Notify("Jums nelemta gaminti narkotiku")
						pause = false
						quality = quality - 1
					end
				end
				
				
				
				
				
				
				
				if IsPedInAnyVehicle(playerPed) then
					TriggerServerEvent('qb-methcar:make', pos.x,pos.y,pos.z)
					if pause == false then
						selection = 0
						quality = quality + 1
						progress = progress +  math.random(1, 2)
						QBCore.Functions.Notify("Amfetamino gaminimo procesas: " .. progress .. "%")
					end
				else
					TriggerEvent('qb-methcar:stop')
				end

			else
				TriggerEvent('qb-methcar:stop')
				progress = 100
				QBCore.Functions.Notify("Amfetamino gaminimo procesas: " .. progress .. "%")
				QBCore.Functions.Notify("Gaminimas baigtas")
				TriggerServerEvent('qb-methcar:finish', quality)
				FreezeEntityPosition(LastCar, false)
			end	
			
		end
		
	end
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
			if IsPedInAnyVehicle(GetPlayerPed(-1)) then
			else
				if started then
					started = false
					displayed = false
					TriggerEvent('qb-methcar:stop')
					print('Stopped making drugs')
					FreezeEntityPosition(LastCar,false)
				end		
			end
	end

end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)		
		if pause == true then
			if IsControlJustReleased(0, Keys['1']) then
				selection = 1
				QBCore.Functions.Notify("Pasirinkote skaiciu 1")
			end
			if IsControlJustReleased(0, Keys['2']) then
				selection = 2
				QBCore.Functions.Notify("Pasirinkote skaiciu 2")
			end
			if IsControlJustReleased(0, Keys['3']) then
				selection = 3
				QBCore.Functions.Notify("Pasirinkote skaiciu 3")
			end
		end

	end
end)




