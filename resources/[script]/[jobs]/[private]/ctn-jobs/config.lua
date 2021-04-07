Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

Config = Config or {}

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

Config.Gangs = {
    ["state"] = {
        ["VehicleSpawner"] = {
            label = "Car Spawn",
            secondcoord = true,
            coords = {x =-1531.97, y = 82.58, z = 56.74, h =324.12},
            coords2 = {x =229.57, y = -367.74, z = 44.16, h =248.12},
            ["colours"] = {
                ["primary"] = {
                    r = 0,
                    g = 0, 
                    b = 0
                },
                ["secondary"] = { 
                    r = 0,
                    b = 0, 
                    g = 0
                },
            },
            ["vehicles"] = {
                ["cognoscenti2"] = "Cognoscenti (Blindee)",
                ["schafter6"] = "Schafter LWB (blindée)",
                ["stafford"] = "Stafford",
                ["baller6"] = "Baller LE LWB ",
                ["ucballer"] = "SUV du FBI",
                ["polschafter3"] = "Voiture du FBI",
                ["onebeast"] = "President",
                ["XLS2"] = "XLS (blindée)",
            }
        },
        ["Stash"] = {
            label = "State Stash",
            coords = {x = -1506.51, y = 104.51, z = 52.24},
        },
        ["Boss"] = {
            coords = {x = -1496.95, y = 127.74, z = 55.66},
        },
        ["Weapons"] = {
            label = "State Weapon Safe",
            slots = 17,
            coords = {x = -1502.01, y = 118.67, z = 55.66},
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
                    name = "handcuffs",
                    price = 0,
                    amount = 10,
                    info = {},
                    type = "item",
                    slot = 5,
                },
                [6] = {
                    name = "binoculars",
                    price = 300,
                    amount = 5,
                    info = {},
                    type = "item",
                    slot = 6,
                },
                [7] = {
                    name = "diving_gear",
                    price = 1000,
                    amount = 2,
                    info = {},
                    type = "item",
                    slot = 7,
                }, 
                [8] = {
                    name = "parachute",
                    price = 250,
                    amount = 2,
                    info = {},
                    type = "item",
                    slot = 8,
                }, 
                [9] = {
                    name = "heavyarmor",
                    price = 100,
                    amount = 50,
                    info = {},
                    type = "item",
                    slot = 9,
                },
                [10] = {
                    name = "radio",
                    price = 350,
                    amount = 50,
                    info = {},
                    type = "item",
                    slot = 10,
                },
                [11] = {
                    name = "pistol_ammo",
                    price = 0,
                    amount = 100,
                    info = {},
                    type = "item",
                   slot = 11,
                },    
            }
        }
    },
    ["judge"] = {
        ["VehicleSpawner"] = {
            label = "Car Spawn",
            secondcoord = false,
            coords = {x =114.88, y = -938.8, z = 29.81, h =160.0},
            ["colours"] = {
                ["primary"] = {
                    r = 0,
                    g = 0, 
                    b = 0
                },
                ["secondary"] = { 
                    r = 0,
                    b = 0, 
                    g = 0
                },
            },
            ["vehicles"] = {
                ["XLS2"] = "XLS (blindée)",
            }
        },
        ["Stash"] = {
            label = "Judge Stash",
            coords = {x = 97.18, y = -938.1, z = 29.85},
        },
        ["Boss"] = {
            coords = {x = 76.85, y = -921.511, z = 29.85},
        },
        ["Weapons"] = {
            label = "Judge Weapon Safe",
            slots = 17,
            coords = {x = -1502.01, y = 118.67, z = 55.66},
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
                    name = "handcuffs",
                    price = 0,
                    amount = 10,
                    info = {},
                    type = "item",
                    slot = 5,
                },
                [6] = {
                    name = "binoculars",
                    price = 300,
                    amount = 5,
                    info = {},
                    type = "item",
                    slot = 6,
                },
                [7] = {
                    name = "diving_gear",
                    price = 1000,
                    amount = 2,
                    info = {},
                    type = "item",
                    slot = 7,
                }, 
                [8] = {
                    name = "parachute",
                    price = 250,
                    amount = 2,
                    info = {},
                    type = "item",
                    slot = 8,
                }, 
                [9] = {
                    name = "heavyarmor",
                    price = 100,
                    amount = 50,
                    info = {},
                    type = "item",
                    slot = 9,
                },
                [10] = {
                    name = "radio",
                    price = 350,
                    amount = 50,
                    info = {},
                    type = "item",
                    slot = 10,
                },
                [11] = {
                    name = "pistol_ammo",
                    price = 0,
                    amount = 100,
                    info = {},
                    type = "item",
                   slot = 11,
                },    
            }
        }
    },

    ["sama9aho"] = {
        ["VehicleSpawner"] = {
            label = "Car Spawn",
            secondcoord = false,
            coords = {x =13.1, y = -1123.8, z = 10028.81, h =160.0},
            ["colours"] = {
                ["primary"] = {
                    r = 0,
                    g = 0, 
                    b = 0
                },
                ["secondary"] = { 
                    r = 0,
                    b = 0, 
                    g = 0
                },
            },
            ["vehicles"] = {
               -- ["XLS2"] = "XLS (blindée)",
            }
        },
        ["Stash"] = {
            label = "SAMA9AHO Stash",
            coords = {x = 5.01, y = -1109.61, z = 29.79},
        },
        ["Boss"] = {
            coords ={x = 23.74, y = -1105.96, z = 29.79},
        },
        ["Weapons"] = {
            label = "- Weapon Safe",
            slots = 0,
            coords = {x = -1502.01, y = 118.67, z = 55.66},
            items = {
                [1] = {

                },
            }
        }
    }

    ,
    
    ["bank"] = {
        ["VehicleSpawner"] = {
            label = "Bank Spawn",
            secondcoord = false,
            coords = {x =232.05, y = 199.55, z = 105.23, h = 66.65},
            ["colours"] = {
                ["primary"] = {
                    r = 0,
                    g = 0, 
                    b = 0
                },
                ["secondary"] = { 
                    r = 0,
                    b = 0, 
                    g = 0
                },
            },
            ["vehicles"] = {
                ["XLS2"] = "XLS (blindée)",
            }
        },
        ["Stash"] = {
            label = "Bank Stash",
            coords = {x = 249.09, y = 230.62, z = 106.28},
        },
        ["Boss"] = {
            coords = {x = 261.52, y = 204.78, z = 110.28},
        },
        ["Weapons"] = {
            label = "- Weapon Safe",
            slots = 0,
            coords = {x = -1502.01, y = 118.67, z = 5555.66},
            items = {
                [1] = {

                },
            }
        }
    },
    
    ["tequilala"] = {
        ["VehicleSpawner"] = {
            label = "- Spawn",
            secondcoord = false,
            coords = {x =232.05, y = 199.55, z = 105.23, h = 66.65},
            ["colours"] = {
                ["primary"] = {
                    r = 0,
                    g = 0, 
                    b = 0
                },
                ["secondary"] = { 
                    r = 0,
                    b = 0, 
                    g = 0
                },
            },
            ["vehicles"] = {
                ["XLS2"] = "XLS (blindée)",
            }
        },
        ["Stash"] = {
            label = "Tekilala Stash",
            coords = {x = -574.07, y = 292.96, z = 79.17},
        },
        ["Boss"] = {
            coords = {x = -576.76, y = 286.73, z = 79.17},
        },
        ["Weapons"] = {
            label = "- Weapon Safe",
            slots = 0,
            coords = {x = -1502.01, y = 118.67, z = 5555.66},
            items = {
                [1] = {

                },
            }
        }
    }


}