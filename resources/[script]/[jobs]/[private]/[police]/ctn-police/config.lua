Config = {}

local StringCharset = {}
local NumberCharset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(StringCharset, string.char(i)) end
for i = 97, 122 do table.insert(StringCharset, string.char(i)) end

Config.RandomStr = function(length)
	if length > 0 then
		return Config.RandomStr(length-1) .. StringCharset[math.random(1, #StringCharset)]
	else
		return ''
	end
end

Config.RandomInt = function(length)
	if length > 0 then
		return Config.RandomInt(length-1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

Config.Objects = {
    ["cone"] = {model = `prop_roadcone02a`, freeze = false},
    ["barier"] = {model = `prop_barrier_work06a`, freeze = true},
    ["schotten"] = {model = `prop_snow_sign_road_06g`, freeze = true},
    ["tent"] = {model = `prop_gazebo_03`, freeze = true},
    ["light"] = {model = `prop_worklight_03b`, freeze = true},
    ["chair"] = {model = `prop_chair_08`, freeze = true},
    ["chairs"] = {model = `prop_chair_pile_01`, freeze = true},
    ["table"] = {model = `prop_table_03`, freeze = true},
    ["monitor"] = {model = `des_tvsmash_root`, freeze = true},
}

Config.Locations = {
   ["duty"] = {
       [1] = { ['x'] = 440.40, ['y'] = -975.68, ['z'] = 30.689331, ['h'] = 104.49021 },
       [2] = {x = 1851.42, y = 3690.62, z = 34.28, h = 119.80},
       [3] = {x = -449.811, y = 6012.909, z = 31.815, h = 90.654},
   },  
   ["vest"] = {
    [1] = { ['x'] = 449.90, ['y'] = -990.43, ['z'] = 30.68, ['h'] = 97.53 },
       [2] = { ['x'] = 1842.32, ['y'] = 3689.3, ['z'] = 34.28, ['h'] = 97.53 },
   }, 
   ["vehicle"] = {
       [1] = { ['x'] = 447.0715, ['y'] = -1019.807, ['z'] = 128.5332, ['h'] = 89.524 },
       [2] = {x = 471.13, y = -1024.05, z = 28.17, h = 274.5},
       [3] = {x = 1853.30, y = 3674.85, z = 33.72, h = 215.21},
       [4] = {x = -455.39, y = 6002.02, z = 31.34, h = 87.93},
       [5] = { ['x'] = 1753.7666, ['y'] = 2600.7036, ['z'] = 45.564975, ['h'] = 357.73715 }
   },
   ["stash"] = {
    [1] = { ['x'] = 459.43, ['y'] = -988.952, ['z'] = 30.68, ['h'] = 349.65 },
       [2] = {x = 1840.82, y = 3692.51, z = 34.28, h = 292.75},
       [3] = {x = 1765.33, y = 2589.48, z = 49.71, h = 176.13},
       [4] = {x = 1834.93, y = 2573.00, z = 45.89, h = 179.96},
       [5] = {x = -434.63, y = 6001.63, z = 31.71, h = 316.5, r = 1.0},
   },     
   ["impound"] = {
    [1] = {x = 436.97, y = -1009.77, z = 28.22, h = 90.89},
   }, 
   ["helicopter"] = {
       [1] = {x = 449.168, y = -981.325, z = 43.691, h = 87.234},
       [2] = {x = 1846.12, y = 3633.8, z = 35.37, h = 213.31},
       [3] = {x = -475.43, y = 5988.353, z = 31.716, h = 31.34},
   }, 
   ["boat"] = {
       [1] = {x = -789.27, y = -1486.10, z = 0.26, h = 105.81},
	   [2] = {x = -1613.35, y = -1168.50, z = 0.33, h = 126.32},
	   [3] = {x = 1583.26, y = 3861.79, z = 30.19, h = 68.31},
	   [4] = {x = -723.85, y = 6115.57, z = 0.12, h = 24.24},
   }, 
   ["armory"] = {
    [1] = {['x'] = 455.43, ['y'] = -992.7606, ['z'] = 30.68, ['h'] = 174.5027 },
       [2] = {x = 1850.16, y = 3685.82, z = 34.28, h = 119.59},
       [3] = {x = -436.82, y = 5996.98, z = 31.716, h = 90.654},
   }, 
   ["jail"] = {
       [1] = {x = 1763.79, y = 2591.75, z = 49.71, h = 90.55},
   },   
   ["trash"] = {
    [1] = { ['x'] = 467.08, ['y'] = -989.784, ['z'] = 24.92, ['h'] = 109.713 },
   },     
   ["property"] = {
       [1] = { ['x'] = 458.32, ['y'] = -983.17, ['z'] = 100.68, ['h'] = 157.73 },
   },     
   ["fingerprint"] = {
    [1] = { ['x'] = 479.59, ['y'] = -991.015, ['z'] = 24.266, ['h'] = 16.721 },
       [2] = {x = 1846.0, y = 3693.86, z = 34.28, h = 115.46},
       [3] = {x = -442.38, y = 6011.9, z = 27.98, h = 311.5},
   },
   ["evidence"] = {
    [1] = { ['x'] = 470.48, ['y'] = -988.45, ['z'] = 24.90, ['h'] = 271.602 },
       [2] = {x = -439.09, y = 6003.12, z = 31.84, h = 90.654},
       [3] = {x = 1850.95, y = 3697.38, z = 34.28, h = 90.654},
   },    
   ["evidence2"] = {
    [1] =  { ['x'] = 467.87, ['y'] = -987.66, ['z'] = 24.92, ['h'] = 277.40 },
       [2] = {x = -439.54, y = 6011.42, z = 27.98, h = 44.5, r = 1.0},
   },   
   ["evidence3"] = {
    [1] = {x = 467.675, y = -992.73, z = 992.73, h = 24.92},
       [2] = {x = -439.43, y = 6009.45, z = 27.98, h = 134.5, r = 1.0},
   }, 
   ["csi"] = {
    [1] = { ['x'] = 461.87, ['y'] = -981.33, ['z'] = 100.68, ['h'] = 271.066 },
},       
   ["stations"] = {
       [1] = {label = "Police Station 1", coords = {x = 428.23, y = -984.28, z = 29.76, h = 3.5}},
       [2] = {label = "Gendarmerie", coords = {x = 1856.36, y = 3681.32, z = 34.26, h = 212.73}},
       [3] = {label = "Prison", coords = {x = 1845.903, y = 2585.873, z = 45.672, h = 272.249}},
   },
   ["boss"] = {
        [1] = { ['x'] = 447.99, ['y'] = -973.12, ['z'] = 30.68, ['h'] = 192.33 },
        [2] = { ['x'] = -447.433, ['y'] = 6014.2958, ['z'] = 36.507068, ['h'] = 227.97558 },
        [3] = { ['x'] = 1855.66, y = 3696.68, z = 34.28, ['h'] = 353.00 },
    },
}

Config.ArmoryWhitelist = {
    "AFV00955",
}

Config.Helicopter = "pzulu"
Config.Boat = "predator"

Config.SecurityCameras = {
    hideradar = false,
    cameras = {
        [1] = {label = "Pacific Bank CAM#1", x = 257.45, y = 210.07, z = 109.08, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = false, isOnline = true},
        [2] = {label = "Pacific Bank CAM#2", x = 232.86, y = 221.46, z = 107.83, r = {x = -25.0, y = 0.0, z = -140.91}, canRotate = false, isOnline = true},
        [3] = {label = "Pacific Bank CAM#3", x = 252.27, y = 225.52, z = 103.99, r = {x = -35.0, y = 0.0, z = -74.87}, canRotate = false, isOnline = true},
        [4] = {label = "Limited Ltd Grove St. CAM#1", x = -53.1433, y = -1746.714, z = 31.546, r = {x = -35.0, y = 0.0, z = -168.9182}, canRotate = false, isOnline = true},
        [5] = {label = "Rob's Liqour Prosperity St. CAM#1", x = -1482.9, y = -380.463, z = 42.363, r = {x = -35.0, y = 0.0, z = 79.53281}, canRotate = false, isOnline = true},
        [6] = {label = "Rob's Liqour San Andreas Ave. CAM#1", x = -1224.874, y = -911.094, z = 14.401, r = {x = -35.0, y = 0.0, z = -6.778894}, canRotate = false, isOnline = true},
        [7] = {label = "Limited Ltd Ginger St. CAM#1", x = -718.153, y = -909.211, z = 21.49, r = {x = -35.0, y = 0.0, z = -137.1431}, canRotate = false, isOnline = true},
        [8] = {label = "24/7 Supermarket Innocence Blvd. CAM#1", x = 23.885, y = -1342.441, z = 31.672, r = {x = -35.0, y = 0.0, z = -142.9191}, canRotate = false, isOnline = true},
        [9] = {label = "Rob's Liqour El Rancho Blvd. CAM#1", x = 1133.024, y = -978.712, z = 48.515, r = {x = -35.0, y = 0.0, z = -137.302}, canRotate = false, isOnline = true},
        [10] = {label = "Limited Ltd West Mirror Drive CAM#1", x = 1151.93, y = -320.389, z = 71.33, r = {x = -35.0, y = 0.0, z = -119.4468}, canRotate = false, isOnline = true},
        [11] = {label = "24/7 Supermarket Clinton Ave CAM#1", x = 383.402, y = 328.915, z = 105.541, r = {x = -35.0, y = 0.0, z = 118.585}, canRotate = false, isOnline = true},
        [12] = {label = "Limited Ltd Banham Canyon Dr CAM#1", x = -1832.057, y = 789.389, z = 140.436, r = {x = -35.0, y = 0.0, z = -91.481}, canRotate = false, isOnline = true},
        [13] = {label = "Rob's Liqour Great Ocean Hwy CAM#1", x = -2966.15, y = 387.067, z = 17.393, r = {x = -35.0, y = 0.0, z = 32.92229}, canRotate = false, isOnline = true},
        [14] = {label = "24/7 Supermarket Ineseno Road CAM#1", x = -3046.749, y = 592.491, z = 9.808, r = {x = -35.0, y = 0.0, z = -116.673}, canRotate = false, isOnline = true},
        [15] = {label = "24/7 Supermarket Barbareno Rd. CAM#1", x = -3246.489, y = 1010.408, z = 14.705, r = {x = -35.0, y = 0.0, z = -135.2151}, canRotate = false, isOnline = true},
        [16] = {label = "24/7 Supermarket Route 68 CAM#1", x = 539.773, y = 2664.904, z = 44.056, r = {x = -35.0, y = 0.0, z = -42.947}, canRotate = false, isOnline = true},
        [17] = {label = "Rob's Liqour Route 68 CAM#1", x = 1169.855, y = 2711.493, z = 40.432, r = {x = -35.0, y = 0.0, z = 127.17}, canRotate = false, isOnline = true},
        [18] = {label = "24/7 Supermarket Senora Fwy CAM#1", x = 2673.579, y = 3281.265, z = 57.541, r = {x = -35.0, y = 0.0, z = -80.242}, canRotate = false, isOnline = true},
        [19] = {label = "24/7 Supermarket Alhambra Dr. CAM#1", x = 1966.24, y = 3749.545, z = 34.143, r = {x = -35.0, y = 0.0, z = 163.065}, canRotate = false, isOnline = true},
        [20] = {label = "24/7 Supermarket Senora Fwy CAM#2", x = 1729.522, y = 6419.87, z = 37.262, r = {x = -35.0, y = 0.0, z = -160.089}, canRotate = false, isOnline = true},
        [21] = {label = "Fleeca Bank Hawick Ave CAM#1", x = 309.341, y = -281.439, z = 55.88, r = {x = -35.0, y = 0.0, z = -146.1595}, canRotate = false, isOnline = true},
        [22] = {label = "Fleeca Bank Legion Square CAM#1", x = 144.871, y = -1043.044, z = 31.017, r = {x = -35.0, y = 0.0, z = -143.9796}, canRotate = false, isOnline = true},
        [23] = {label = "Fleeca Bank Hawick Ave CAM#2", x = -355.7643, y = -52.506, z = 50.746, r = {x = -35.0, y = 0.0, z = -143.8711}, canRotate = false, isOnline = true},
        [24] = {label = "Fleeca Bank Del Perro Blvd CAM#1", x = -1214.226, y = -335.86, z = 39.515, r = {x = -35.0, y = 0.0, z = -97.862}, canRotate = false, isOnline = true},
        [25] = {label = "Fleeca Bank Great Ocean Hwy CAM#1", x = -2958.885, y = 478.983, z = 17.406, r = {x = -35.0, y = 0.0, z = -34.69595}, canRotate = false, isOnline = true},
        [26] = {label = "Paleto Bank CAM#1", x = -102.939, y = 6467.668, z = 33.424, r = {x = -35.0, y = 0.0, z = 24.66}, canRotate = false, isOnline = true},
        [27] = {label = "Del Vecchio Liquor Paleto Bay", x = -163.75, y = 6323.45, z = 33.424, r = {x = -35.0, y = 0.0, z = 260.00}, canRotate = false, isOnline = true},
        [28] = {label = "Don's Country Store Paleto Bay CAM#1", x = 166.42, y = 6634.4, z = 33.69, r = {x = -35.0, y = 0.0, z = 32.00}, canRotate = false, isOnline = true},
        [29] = {label = "Don's Country Store Paleto Bay CAM#2", x = 163.74, y = 6644.34, z = 33.69, r = {x = -35.0, y = 0.0, z = 168.00}, canRotate = false, isOnline = true},
        [30] = {label = "Don's Country Store Paleto Bay CAM#3", x = 169.54, y = 6640.89, z = 33.69, r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = false, isOnline = true},
        [31] = {label = "Vangelico CAM#1", x = -627.54, y = -239.74, z = 40.33, r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true},
        [32] = {label = "Vangelico CAM#2", x = -627.51, y = -229.51, z = 40.24, r = {x = -35.0, y = 0.0, z = -95.78}, canRotate = true, isOnline = true},
        [33] = {label = "Vangelico CAM#3", x = -620.3, y = -224.31, z = 40.23, r = {x = -35.0, y = 0.0, z = 165.78}, canRotate = true, isOnline = true},
        [34] = {label = "Vangelico CAM#4", x = -622.57, y = -236.3, z = 40.31, r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true},
    },
}

Config.AmmoLabels = {
    ["AMMO_PISTOL"] = "9x19mm Pistol Ammo",
    ["AMMO_SMG"] = "9x19mm SMG Ammo",
    ["AMMO_RIFLE"] = "7.62x39mm Rifle Ammo",
    ["AMMO_MG"] = "7.92x57mm MG Ammo",
    ["AMMO_SHOTGUN"] = "12 Shotgun shells",
    ["AMMO_SNIPER"] = "Sniper bullet",
}

Config.Radars = {
	{x = -623.44421386719, y = -823.08361816406, z = 25.25704574585, h = 145.0 },
	{x = -652.44421386719, y = -854.08361816406, z = 24.55704574585, h = 325.0 },
	{x = 1623.0114746094, y = 1068.9924316406, z = 80.903594970703, h = 84.0 },
	{x = -2604.8994140625, y = 2996.3391113281, z = 27.528566360474, h = 175.0 },
	{x = 2136.65234375, y = -591.81469726563, z = 94.272926330566, h = 318.0 },
	{x = 2117.5764160156, y = -558.51013183594, z = 95.683128356934, h = 158.0 },
	{x = 406.89505004883, y = -969.06286621094, z = 29.436267852783, h = 33.0 },
	{x = 657.315, y = -218.819, z = 44.06, h = 320.0 },
	{x = 2118.287, y = 6040.027, z = 50.928, h = 172.0 },
	{x = -106.304, y = -1127.5530, z = 30.778, h = 230.0 },
	{x = -823.3688, y = -1146.980, z = 8.0, h = 300.0 },
}

Config.CarItems = {
    [1] = {
        name = "weapon_fireextinguisher",
        amount = 1,
        info = {},
        type = "weapon",
        slot = 1,
    },
}

Config.Items = {
    label = "Police Weapon Safe",
    slots = 17,
    items = {
        [1] = {
            name = "weapon_pistol_mk2",
            price = 0,
            amount = 3,
            info = {
                serie = "",                
                attachments = {
                    {component = "COMPONENT_PISTOL_MK2_CLIP_02", label = "Extended"},
                    {component = "COMPONENT_AT_PI_COMP", label = "Compensator"},
                    {component = "COMPONENT_AT_PI_FLSH_02", label = "Flashlight"},
                    {component = "COMPONENT_AT_PI_RAIL", label = "Scope"},
                }
            },
            type = "weapon",
            slot = 1,
        },
        [2] = {
            name = "weapon_stungun",
            price = 150,
            amount = 3,
            info = {},
            type = "weapon",
            slot = 2,
        },
        [3] = {
            name = "weapon_nightstick",
            price = 0,
            amount = 3,
            info = {},
            type = "weapon",
            slot = 3,
        },
        [4] = {
            name = "weapon_flashlight",
            price = 150,
            amount = 3,
            info = {},
            type = "weapon",
            slot = 4,
        },
        [5] = {
            name = "weapon_fireextinguisher",
            price = 150,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 5,
        },
        [6] = {
            name = "handcuffs",
            price = 0,
            amount = 10,
            info = {},
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "binoculars",
            price = 300,
            amount = 5,
            info = {},
            type = "item",
            slot = 7,
        },
        [8] = {
            name = "diving_gear",
            price = 1000,
            amount = 2,
            info = {},
            type = "item",
            slot = 8,
        }, 
        [9] = {
            name = "parachute",
            price = 250,
            amount = 2,
            info = {},
            type = "item",
            slot = 9,
        }, 
        [10] = {
            name = "heavyarmor",
            price = 100,
            amount = 50,
            info = {},
            type = "item",
            slot = 10,
        },
        [11] = {
            name = "radio",
            price = 350,
            amount = 50,
            info = {},
            type = "item",
            slot = 11,
        },
        [12] = {
            name = "empty_evidence_bag",
            price = 2,
            amount = 25,
            info = {},
            type = "item",
            slot = 12,
        },
        [13] = {
            name = "police_stormram",
            price = 100,
            amount = 10,
            info = {},
            type = "item",
            slot = 13,
        },
        [14] = {
            name = "pistol_ammo",
            price = 0,
            amount = 100,
            info = {},
            type = "item",
           slot = 14,
        },    
        [15] = {
            name = "signalradar",
            price = 0,
            amount = 500,
            info = {},
            type = "item",
            slot = 15,
        },
        [16] = {
            name = "ifak",
            price = 150,
            amount = 100,
            info = {},
            type = "item",
            slot = 16,
        },
        [17] = {
            name = "weapon_combatpistol",
            price = 150,
            amount = 10,
            info = {},
            type = "weapon",
            slot = 17,
        },
    }
}

Config.JailItems = {
    label = "Jail Weapon Safe",
    slots = 1,
    items = {
        [1] = {
            name = "weapon_stungun",
            price = 150,
            amount = 3,
            info = {},
            type = "weapon",
            slot = 1,
        },
        [2] = {
            name = "weapon_nightstick",
            price = 0,
            amount = 3,
            info = {},
            type = "weapon",
            slot = 2,
        },
        [3] = {
            name = "weapon_flashlight",
            price = 150,
            amount = 3,
            info = {},
            type = "weapon",
            slot = 3,
        },
        [4] = {
            name = "handcuffs",
            price = 0,
            amount = 10,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "binoculars",
            price = 300,
            amount = 5,
            info = {},
            type = "item",
            slot = 5,
        },
        [6] = {
            name = "heavyarmor",
            price = 100,
            amount = 50,
            info = {},
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "radio",
            price = 350,
            amount = 50,
            info = {},
            type = "item",
            slot = 7,
		},
        [8] = {
            name = "ifak",
            price = 150,
            amount = 100,
            info = {},
            type = "item",
            slot = 8,
        }
    }
}