resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

shared_script "@nevo-scripts/cl_errorlog.lua"

server_scripts {
	"server/consumables.lua",
	"server/dvall.lua",
	"server/hostage.lua",
	"server/main.lua",
	"config.lua",
}

client_scripts {
	"config.lua",
	"client/autopilot.lua",
	"client/binoculars.lua",
	"client/blips.lua",
	"client/consumables.lua",
	"client/crouchprone.lua",
	"client/cruise.lua",
	"client/damage.lua",
	"client/discord.lua",
	"client/dvall.lua",
	"client/entityiter.lua",
	"client/fireworks.lua",
	"client/handsup.lua",
	"client/loops.lua",
	"client/main.lua",
	"client/point.lua",
	"client/recoil.lua",
	--"client/scoreboard.lua",
	"client/tackle.lua",
	"client/teleports.lua",
    "client/vehmod.lua",
	"client/weapdraw.lua",
	"@warmenu/warmenu.lua",
}

exports {
	'HasHarness'
}