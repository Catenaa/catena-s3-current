local emitters = {
	
  "se_walk_radio_d_picked",
}

Citizen.CreateThread(function()
  for i = 1, #emitters do
    SetStaticEmitterEnabled(emitters[i], false)
  end
end)

Citizen.CreateThread(function()


  RequestIpl("gabz_import_milo_")
  
    interiorID = GetInteriorAtCoords(941.00840000, -972.66450000, 39.14678000)
    
    
  if IsValidInterior(interiorID) then
    --EnableInteriorProp(interiorID, "basic_style_set")
    --EnableInteriorProp(interiorID, "urban_style_set")		
    EnableInteriorProp(interiorID, "branded_style_set")
    EnableInteriorProp(interiorID, "car_floor_hatch")
    
    RefreshInterior(interiorID)
    
  end
    
end)

Citizen.CreateThread(function()
  SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0) -- Level 0
  SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 1
  SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0) -- Level 2
  SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0) -- Level 3
  SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0) -- Level 4
end)

Citizen.CreateThread(function()
  while true do
  Citizen.Wait(1)
  if IsPedOnFoot(GetPlayerPed(-1)) then 
    SetRadarZoom(1100)
  elseif IsPedInAnyVehicle(GetPlayerPed(-1), true) then
    SetRadarZoom(1100)
  end
  end
end)