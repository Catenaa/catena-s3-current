Config = {}

Config.TestDriveTimer = 1000 * 60 * 2 -- 2m

Config.Locations = {
    ["boss"] = { ['x'] = -31.66366, ['y'] = -1113.505, ['z'] = 26.422349, ['h'] = 85.276741 },
    ["stash"] = { ['x'] = -27.65945, ['y'] = -1104.104, ['z'] = 26.422348, ['h'] = 250.80944 },
 }

Config.CarSpawns = {
	[1] =  { ['x'] = -38.25,['y'] = -1104.18,['z'] = 26.43,['h'] = 14.46, ['info'] = ' Car Spot 1' },
	[2] =  { ['x'] = -36.36,['y'] = -1097.3,['z'] = 26.43,['h'] = 109.4, ['info'] = ' Car Spot 2' },
	[3] =  { ['x'] = -43.11,['y'] = -1095.02,['z'] = 26.43,['h'] = 67.77, ['info'] = ' Car Spot 3' },
	[4] =  { ['x'] = -50.45,['y'] = -1092.66,['z'] = 26.43,['h'] = 116.33, ['info'] = ' Car Spot 4' },
}

Config.CarTable = {
	[1] = {name = "Hakuchou", costs = 40000, model = "hakuchou"}, 
	[2] = {name = "Windsor Drop", costs = 45000, model = "windsor2"},
	[3] = {name = "Specter", costs = 120000, model = "specter"},
	[4] = {name = "Brawler", costs = 99500, model = "brawler"},
}

Config.Menu = {
    x = 0.14,
    y = 0.15,
    width = 0.12,
    height = 0.03,
    buttons = 10,
    from = 1,
    to = 10,
    scale = 0.29,
    font = 0,
    ["main"] = {
        title = "CATEGORIES",
        name = "main",
        buttons = {
            {name = "Vehicles", description = ""},
            {name = "Motorcycles", description = ""},
            {name = "Cycles", description = ""},
            {name = "Drifts", description = ''},
            {name = "Custom Cars", description = ''},
    
        }
    },
    ["vehicles"] = {
        title = "VEHICLES",
        name = "vehicles",
        buttons = {
            {name = "Job Vehicles", description = ''},
            {name = "Trucks", description = ''},
            {name = "Compacts", description = ''},
            {name = "Coupes", description = ''},
            {name = "Sedans", description = ''},
            {name = "Sports", description = ''},
            {name = "Sports Classics", description = ''},
            {name = "Super", description = ''},
            {name = "Muscle", description = ''},
            {name = "Off-Road", description = ''},
            {name = "SUVs", description = ''},
            {name = "Vans", description = ''},

        }
    },
    ["jobvehicles"] = {
        title = "job vehicles",
        name = "job vehicles",
        buttons = {
            {name = "Taxi Cab", costs = 3000, description = {}, model = "taxi"},
            {name = "News Rumpo", costs = 5000, description = {}, model = "rumpo"},
			{name = "Enduro Delivery", costs = 5000, description = {}, model = "enduro"},
            {name = "Flatbed", costs = 5000, description = {}, model = "flatbed"},
            {name = "Tractor", costs = 6000, description = {}, model = "tractor2"},
            {name = "Taco Truck", costs = 6000, description = {}, model = "taco"},
        }
    },
    ["trucks"] = {
        title = "trucks",
        name = "trucks",
        buttons = {
            {name = "Hauler", costs = 9000, description = {}, model = "hauler"},
            {name = "Mule 3", costs = 11000, description = {}, model = "mule3"},
            {name = "Packer", costs = 13500, description = {}, model = "packer"},
            {name = "Phantom", costs = 14000, description = {}, model = "phantom"},
            {name = "Pounder", costs = 15500, description = {}, model = "pounder"},
        }
    },
    ["customcars"] = {
        title = "custom cars",
        name = "custom cars",
        buttons = {
        }
    },
    ["compacts"] = {
        title = "compacts",
        name = "compacts",
        buttons = {			
            {name = "Blista", costs = 8000, description = {}, model = "blista"},
            {name = "Brioso R/A", costs = 20000, description = {}, model = "brioso"},
            {name = "Issi", costs = 15000, description = {}, model = "issi2"},    
            {name = "Issi Classic", costs = 15000, description = {}, model = "issi3"}, 
        }
    },
    ["coupes"] = {
        title = "coupes",
        name = "coupes",
        buttons = {
            {name = "Exemplar", costs = 55000, description = {}, model = "exemplar"},
            {name = "Sentinel XS", costs = 50000, description = {}, model = "sentinel"},
            {name = "Windsor Drop", costs = 70000, description = {}, model = "windsor2"},
            {name = "Felon", costs = 40000, description = {}, model = "felon"},
            {name = "Felon GT", costs = 40000, description = {}, model = "felon2"},
            {name = "Enus Cognoscenti Cabrio", costs = 40000, description = {}, model = "cogcabrio"},
        }
    },
    ["sports"] = {
        title = "sports",
        name = "sports",
        buttons = {
            {name = "Carbonizzare", costs = 150000, description = {}, model = "carbonizzare"},
            {name = "Feltzer", costs = 135000, description = {}, model = "feltzer2"},
			{name = "Comet", costs = 120000, description = {}, model = "comet2"},
            {name = "9F", costs = 130000, description = {}, model = "ninef"},
            {name = "9F Cabrio", costs = 130000, description = {}, model = "ninef2"},
            {name = "Buffalo S", costs = 40000, description = {}, model = "buffalo2"},
            {name = "Sultan", costs = 90000, description = {}, model = "sultan"},
            {name = "Sultan RS", costs = 200000, description = {}, model = "sultanrs"},
            {name = "Schafter V12", costs = 185000, description = {}, model = "schafter3"},
            --{name = "8F Drafter", costs = 88000, description = {}, model = "drafter"},
            {name = "Specter", costs = 145000, description = {}, model = "specter"},
            {name = "Specter Custom", costs = 180000, description = {}, model = "specter2"},
            {name = "Dominator GTX", costs = 80000, description = {}, model = "dominator3"},
        }
    },
    ["sportsclassics"] = {
        title = "sports classics",
        name = "sportsclassics",
        buttons = {
            {name = "190z", costs = 70000, description = {}, model = "z190"}, -- doomsday Heist , handling done
            {name = "Sintinel Classic", costs = 50000, description = {}, model = "sentinel3"},
            {name = "Comet Retro", costs = 150000, description = {}, model = "comet3"},
            {name = "Infernus Classic", costs = 300000, description = {}, model = "Infernus2"},
            {name = "Jester classic", costs = 85000, description = {}, model = "jester3"},
            {name = "Elegy Retro Custom", costs = 90000, description = {}, model = "elegy"},
        }
    },
    ["super"] = {
        title = "super",
        name = "super",
        buttons = {
            {name = "Voltic", costs = 190000, description = {}, model = "voltic"},
            {name = "Itali GTO", costs = 400000, description = {}, model = "italigto"},
            {name = "Adder", costs = 700000, description = {}, model = "adder"},
            {name = "Infernus", costs = 250000, description = {}, model = "infernus"},
            {name = "Zentorno", costs = 1000000, description = {}, model = "zentorno"},
            {name = "Reaper", costs = 400000, description = {}, model = "Reaper"},
            {name = "Itali GTB Custom", costs = 400000, description = {}, model = "italigtb2"},
            {name = "XA-21", costs = 400000, description = {}, model = "xa21"},
        }
    },
    ["muscle"] = {
        title = "muscle",
        name = "muscle",
        buttons = {
            {name = "Dukes", costs = 17000, description = {}, model = "dukes"},
            {name = "Faction", costs = 20000, description = {}, model = "faction"},
            {name = "Faction Custom", costs = 35000, description = {}, model = "faction2"},
            {name = "Picador", costs = 17000, description = {}, model = "picador"},
            {name = "Vamos", costs = 40000, description = {}, model = "vamos"},
            {name = "Slam Van Custom", costs = 35000, description = {}, model = "slamvan3"},
            {name = "Moonbeam Custom", costs = 35000, description = {}, model = "moonbeam2"},
            {name = "Voodoo Custom", costs = 30000, description = {}, model = "voodoo"},
            {name = "Sabre Turbo Custom", costs = 50000, description = {}, model = "sabregt2"},
            {name = "Ellie", costs = 60000, description = {}, model = "ellie"},
            {name = "Chino Custom", costs = 25000, description = {}, model = "chino2"},
            {name = "Buccaneer Custom", costs = 19000, description = {}, model = "buccaneer2"},
            {name = "Ruiner", costs = 25000, description = {}, model = "ruiner"},

        }
    },
    ["offroad"] = {
        title = "off-road",
        name = "off-road",
        buttons = {
            {name = "Brawler", costs = 100000, description = {}, model = "brawler"},
            {name = "Kamacho", costs = 130000, description = {}, model = "kamacho"}, -- doomsday Heist , handling done
            {name = "Mesa", costs = 30000, description = {}, model = "mesa"},
			{name = "Kalahari", costs = 4000, description = {}, model = "kalahari"},
        }
    },
    ["suvs"] = {
        title = "suvs",
        name = "suvs",
        buttons = {
            {name = "Dubsta", costs = 70000, description = {}, model = "dubsta"},
            {name = "Dubsta", costs = 55000, description = {}, model = "dubsta"},
            {name = "Rocoto", costs = 40000, description = {}, model = "rocoto"},
            {name = "Contender", costs = 150000, description = {}, model = "contender"},
            {name = "Patriot", costs = 35000, description = {}, model = "patriot"},
        }
    },
    ["vans"] = {
        title = "vans",
        name = "vans",
        buttons = {
            --{name = "Bobcat XL", costs = 27000, description = {}, model = "bobcatxl"},
			{name = "Vapid Minivan Custom", costs = 27000, description = {}, model = "minivan2"},
            {name = "Burrito", costs = 50000, description = {}, model = "burrito3"},
            {name = "Gang Burrito", costs = 55000, description = {}, model = "gburrito2"},
			{name = "Pony 2", costs = 50000, description = {}, model = "pony2"},
        }
    },
    ["sedans"] = {
        title = "sedans",
        name = "sedans",
        buttons = {
            {name = "Super Diamond", costs = 75000, description = {}, model = "superd"},
            {name = "Surge (Electric)", costs = 40000, description = {}, model = "surge"},
            {name = "Primo Custom", costs = 30000, description = {}, model = "primo2"},
            {name = "Schafter", costs = 50000, description = {}, model = "schafter2"},
            {name = "Glendale", costs = 30000, description = {}, model = "glendale"},
            {name = "Warrener", costs = 30000, description = {}, model = "warrener"},
            {name = "Washington", costs = 30000, description = {}, model = "Washington"},
            {name = "Cognoscenti 55", costs = 45000, description = {}, model = "cog55"},
        }
    },
    ["motorcycles"] = {
        title = "MOTORCYCLES",
        name = "motorcycles",
        buttons = {
            {name = "Faggio", costs = 3000, description = {}, model = "faggio3"},
            {name = "Daemon", costs = 27000, description = {}, model = "daemon"},
            {name = "Nemesis", costs = 30000, description = {}, model = "nemesis"},
            {name = "Ruffian", costs = 21000, description = {}, model = "ruffian"},
			{name = "Hakuchou", costs = 180000, description = {}, model = "hakuchou"},
			{name = "Sanchez", costs = 35000, description = {}, model = "sanchez"},
        }
    },
    ["cycles"] = {
        title = "cycles",
        name = "cycles",
        buttons = {
            {name = "BMX", costs = 500, description = {}, model = "bmx"},
            {name = "Cruiser", costs = 500, description = {}, model = "cruiser"},
            {name = "Fixter", costs = 700, description = {}, model = "fixter"},
            {name = "Scorcher", costs = 700, description = {}, model = "scorcher"},
            {name = "Pro 1", costs = 2000, description = {}, model = "tribike"},
            {name = "Pro 2", costs = 2000, description = {}, model = "tribike2"},
            {name = "Pro 3", costs = 2000, description = {}, model = "tribike3"},
        }
    },
    ["drifts"] = {
        title = "drifts",
        name = "drifts",
        buttons = {
            
        }
    },
}