Config = {}

Config.Keys = {
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

Config.Products = {
    ["normal"] = {
        [1] = {
            name = "toast",
            price = 5,
            amount = 200,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "water_bottle",
            price = 5,
            amount = 200,
            info = {},
            type = "item",
            slot = 2,
        },
    },
    ["diving"] = {
        [1] = {
            name = "jerry_can",
            price = 250,
            amount = 200,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "diving_gear",
            price = 2500,
            amount = 200,
            info = {},
            type = "item",
            slot = 2,
        },
    },
    ["hardware"] = {
        [1] = {
            name = "phone",
            price = 400,
            amount = 200,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "radio",
            price = 500,
            amount = 200,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "binoculars",
            price = 300,
            amount = 50,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "fitbit",
            price = 100,
            amount = 150,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "lockpick",
            price = 250,
            amount = 100,
            info = {},
            type = "item",
            slot = 5,
        },
        [6] = {
            name = "screwdriverset",
            price = 300,
            amount = 50,
            info = {},
            type = "item",
            slot = 6,
        },
    },   
    ["gsgasoline"] = {
        [1] = {
            name = "toast",
            price = 5,
            amount = 200,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "water_bottle",
            price = 5,
            amount = 200,
            info = {},
            type = "item",
            slot = 2,
        },
    },
    ["coffeeshop"] = {
        [1] = {
            name = "weed_nutrition",
            price = 25,
            amount = 1000,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "hqscale",
            price = 500,
            amount = 10,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "empty_weed_bag",
            price = 2,
            amount = 1000,
            info = {},
            type = "item",
            slot = 3,
        },
    },     
}

Config.Locations = {
    ["diving"] = {
        ["label"] = "Diving Shop",
        ["type"] = "diving",
        ["coords"] = {
            [1] = {
                ["x"] = -1686.9,
                ["y"] = -1072.23,
                ["z"] = 13.15,
            },
        },
        ["products"] = Config.Products["diving"],
    },
    ["gsgasoline"] = {
        ["label"] = "Grove Street Gasoline",
        ["type"] = "gsgasoline",
        ["coords"] = {
            [1] = {
                ["x"] = -46.99,
                ["y"] = -1759.48,
                ["z"] = 29.42,
            },
        },
        ["products"] = Config.Products["gsgasoline"],
    },
    ["robsliquor"] = {
        ["label"] = "Rob's Liqour",
        ["type"] = "normal",
        ["coords"] = {
            [1] = {
                ["x"] = -1222.77,
                ["y"] = -907.19,
                ["z"] = 12.32,
            },
        },
        ["products"] = Config.Products["normal"],
    },
    ["ltdgasoline2"] = {
        ["label"] = "LTD Gasoline",
        ["type"] = "normal",
        ["coords"] = {
            [1] = {
                ["x"] = -707.41,
                ["y"] = -912.83,
                ["z"] = 19.21,
            },
            [2] = {
                ["x"] = -707.32,
                ["y"] = -914.65,
                ["z"] = 19.21,
            }
        },
        ["products"] = Config.Products["normal"],
    },
    ["robsliquor2"] = {
        ["label"] = "Rob's Liqour",
        ["type"] = "normal",
        ["coords"] = {
            [1] = {
                ["x"] = -1487.7,
                ["y"] = -378.53,
                ["z"] = 40.16,
            },
        },
        ["products"] = Config.Products["normal"],
    },
    ["ltdgasoline3"] = {
        ["label"] = "LTD Gasoline",
        ["type"] = "normal",
        ["coords"] = {
            [1] = {
                ["x"] = -1820.33,
                ["y"] = 792.66,
                ["z"] = 138.1,
            },
            [2] = {
                ["x"] = -1821.55,
                ["y"] = 793.98,
                ["z"] = 138.1,
            }
        },
        ["products"] = Config.Products["normal"],
    },
    ["robsliquor3"] = {
        ["label"] = "Rob's Liqour",
        ["type"] = "normal",
        ["coords"] = {
            [1] = {
                ["x"] = -2967.79,
                ["y"] = 391.64,
                ["z"] = 15.04,
            },
        },
        ["products"] = Config.Products["normal"],
    },
    ["247supermarket2"] = {
        ["label"] = "24/7 Supermarket",
        ["type"] = "normal",
        ["coords"] = {
            [1] = {
                ["x"] = -3038.71,
                ["y"] = 585.9,
                ["z"] = 7.9,
            },
            [2] = {
                ["x"] = -3041.04,
                ["y"] = 585.11,
                ["z"] = 7.9,
            }
        },
        ["products"] = Config.Products["normal"],
    },
    ["247supermarket3"] = {
        ["label"] = "24/7 Supermarket",
        ["type"] = "normal",
        ["coords"] = {
            [1] = {
                ["x"] = -3241.47,
                ["y"] = 1001.14,
                ["z"] = 12.83,
            },
            [2] = {
                ["x"] = -3243.98,
                ["y"] = 1001.35,
                ["z"] = 12.83,
            }
        },
        ["products"] = Config.Products["normal"],
    },
    ["247supermarket4"] = {
        ["label"] = "24/7 Supermarket",
        ["type"] = "normal",
        ["coords"] = {
            [1] = {
                ["x"] = 1728.66,
                ["y"] = 6414.16,
                ["z"] = 35.03,
            },
            [2] = {
                ["x"] = 1729.72,
                ["y"] = 6416.27,
                ["z"] = 35.03,
            }
        },
        ["products"] = Config.Products["normal"],
    },
    ["247supermarket5"] = {
        ["label"] = "24/7 Supermarket",
        ["type"] = "normal",
        ["coords"] = {
            [1] = {
                ["x"] = 1697.99,
                ["y"] = 4924.4,
                ["z"] = 42.06,
            },
            [2] = {
                ["x"] = 1699.44,
                ["y"] = 4923.47,
                ["z"] = 42.06,
            }
        },
        ["products"] = Config.Products["normal"],
    },
    ["247supermarket6"] = {
        ["label"] = "24/7 Supermarket",
        ["type"] = "normal",
        ["coords"] = {
            [1] = {
                ["x"] = 1961.48,
                ["y"] = 3739.96,
                ["z"] = 32.34,
            },
            [2] = {
                ["x"] = 1960.22,
                ["y"] = 3742.12,
                ["z"] = 32.34,
            }
        },
        ["products"] = Config.Products["normal"],
    },
    ["robsliquor4"] = {
        ["label"] = "Rob's Liqour",
        ["type"] = "normal",
        ["coords"] = {
            [1] = {
                ["x"] = 1165.28,
                ["y"] = 2709.4,
                ["z"] = 38.15,
            },
        },
        ["products"] = Config.Products["normal"],
    },
    ["247supermarket7"] = {
        ["label"] = "24/7 Supermarket",
        ["type"] = "normal",
        ["coords"] = {
            [1] = {
                ["x"] = 547.79,
                ["y"] = 2671.79,
                ["z"] = 42.15,
            },
            [2] = {
                ["x"] = 548.1,
                ["y"] = 2669.38,
                ["z"] = 42.15,
            }
        },
        ["products"] = Config.Products["normal"],
    },
    ["247supermarket8"] = {
        ["label"] = "24/7 Supermarket",
        ["type"] = "normal",
        ["coords"] = {
            [1] = {
                ["x"] = 2679.25,
                ["y"] = 3280.12,
                ["z"] = 55.24,
            },
            [2] = {
                ["x"] = 2677.13,
                ["y"] = 3281.38,
                ["z"] = 55.24,
            }
        },
        ["products"] = Config.Products["normal"],
    },
    ["247supermarket9"] = {
        ["label"] = "24/7 Supermarket",
        ["type"] = "normal",
        ["coords"] = {
            [1] = {
                ["x"] = 2557.94,
                ["y"] = 382.05,
                ["z"] = 108.62,
            },
            [2] = {
                ["x"] = 2555.53,
                ["y"] = 382.18,
                ["z"] = 108.62,
            }
        },
        ["products"] = Config.Products["normal"],
    },
    ["delvecchioliquor"] = {
        ["label"] = "Del Vecchio Liquor",
        ["type"] = "normal",
        ["coords"] = {
            [1] = {
                ["x"] = -159.36,
                ["y"] = 6321.59,
                ["z"] = 31.58,
            },
            [2] = {
                ["x"] = -160.66,
                ["y"] = 6322.85,
                ["z"] = 31.58,
            }
        },
        ["products"] = Config.Products["normal"],
    },
    ["donscountrystore"] = {
        ["label"] = "Don's Country Store",
        ["type"] = "normal",
        ["coords"] = {
            [1] = {
                ["x"] = 161.41,
                ["y"] = 6640.78,
                ["z"] = 31.69,
            },
            [2] = {
                ["x"] = 163.04,
                ["y"] = 6642.45,
                ["z"] = 31.70,
            }
        },
        ["products"] = Config.Products["normal"],
    },
    ["ltdgasoline4"] = {
        ["label"] = "LTD Gasoline",
        ["type"] = "normal",
        ["coords"] = {
            [1] = {
                ["x"] = 1163.7,
                ["y"] = -323.92,
                ["z"] = 69.2,
            },
            [2] = {
                ["x"] = 1163.4,
                ["y"] = -322.24,
                ["z"] = 69.2,
            }
        },
        ["products"] = Config.Products["normal"],
    },
    ["robsliquor5"] = {
        ["label"] = "Rob's Liqour",
        ["type"] = "normal",
        ["coords"] = {
            [1] = {
                ["x"] = 1135.66,
                ["y"] = -982.76,
                ["z"] = 46.41,
            },
        },
        ["products"] = Config.Products["normal"],
    },
    ["247supermarket9"] = {
        ["label"] = "24/7 Supermarket",
        ["type"] = "normal",
        ["coords"] = {
            [1] = {
                ["x"] = 373.55,
                ["y"] = 325.56,
                ["z"] = 103.56,
            },
            [2] = {
                ["x"] = 374.29,
                ["y"] = 327.9,
                ["z"] = 103.56,
            }
        },
        ["products"] = Config.Products["normal"],
    },
    ["hardware"] = {
        ["label"] = "Tool Shop",
        ["type"] = "hardware",
        ["coords"] = {
            [1] = {
                ["x"] = 44.83,
                ["y"] = -1748.53,
                ["z"] = 29.54,
            }
        },
        ["products"] = Config.Products["hardware"],
    },
    ["hardware2"] = {
        ["label"] = "Tool Shop",
        ["type"] = "hardware",
        ["coords"] = {
            [1] = {
                ["x"] = 2749.23,
                ["y"] = 3472.33,
                ["z"] = 55.67,
            },
        },
        ["products"] = Config.Products["hardware"],
    }, 
    ["coffeeshop"] = {
        ["label"] = "Smoke Store",
        ["type"] = "hardware",
        ["coords"] = {
            [1] = {
                ["x"] = -1172.43,
                ["y"] = -1572.24,
                ["z"] = 4.66,
            }
        },
        ["products"] = Config.Products["coffeeshop"],
    }, 
}