  local blips = {
  {title="Vanilla Unicorn", colour=8, id=121, x = 128.70, y = -1298.43, z = 29.23}, -- Vanilla Unicorn
  {title="Sama9aho Shop", colour=4, id=527, x = 21.62427, y = -1106.598, z = 29.79703},
  {title="Real Estate Agency", colour=1, id=375, x = -117.16, y = -606.02, z = 36.28}, -- Real Estate Agency
  {title="Store robbery", colour=66, id=154, x = -1222.03, y = -908.32, z = 12.32},
  {title="Store robbery", colour=66, id=154, x = -706.08, y = -915.42, z = 19.21},
  {title="Store robbery", colour=66, id=154, x = 24.47, y = -1344.99, z = 29.49},
  {title="Store robbery", colour=66, id=154, x = 1134.15, y = -982.53, z = 46.41},
}

Citizen.CreateThread(function()
      for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.5)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)