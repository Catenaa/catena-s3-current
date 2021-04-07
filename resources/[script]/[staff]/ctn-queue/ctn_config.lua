Config = {}

local Prefix = "[CatenaRP] "
Config.DiscordServerID = 488314532020879370
Config.DiscordBotToken = "NjkxODUwODkzNzA0MDM2Mzgz.Xnl-Ww.aDM3zNrHYqXGtk3xyj81bfPBHuI"
Config.ApiLink = "http://realistic-life.co.il/api/queue.php/"
Config.ApiKey = "5166546A576E5A7234743777217A25432A462D4A614E645267556B5870"
Config.maxServerSlots = 128
Config.Roles = {
	Staff = {
		roleID = "704096073635070093",
		points = 30,
		name = "Staff"
	},

	DonatorTier1 = {
		roleID = "586058970964295713",
		points = 15,
		name = "Nitro 🏆"
	},

	DonatorTier2 = {
		roleID = "729148432249520168",
		points = 25,
		name = "Platinium☄️"
	},

	DonatorTier3 = {
		roleID = "719916676736483415",
		points = 35,
		name = "Diamond💎"
	},

	Developer = {
		roleID = "748972440138547341",
		points = 200,
		name = "Lead  Dev"
	},
	
	Prio = {
		roleID = "729255190183542836",
		points = 100,
		name = "Developer"
	},

	Managment = {
		roleID = "729712423690567760",
		points = 200,
		name = "Founder"
	},

	Livestreaming = {
		roleID = "750150446454276248",
		points = 5,
		name = "Streamer 🎥"
	}
}

Config.Colors = {
	"accent",
	"good",
	"warning",
	"attention",
}

Config.Verifiying = Prefix .. "Please wait, Downloading content from CatenaRP database."
Config.VerifiyingLauncher = Prefix .. "Please wait, Verifiying you entered through the launcher."
Config.VerifiyingDiscord = Prefix .. "Please wait, Verifiying your Discord ID."
Config.VerifiyingSteam = Prefix .. "Please wait, Verifiying your Steam."
Config.VerifiyingQueue = Prefix .. "Please wait, Adding you to the queue."

Config.NotWhitelisted = Prefix .. "Sorry, You are not whitelisted for our server."
Config.NoDiscord = Prefix .. "Please make sure your Discord is open."
Config.NoSteam = Prefix .. "Please make sure your Steam is open."
Config.NoLauncher = Prefix .. "The server can only be accessed through its launcher."
Config.Blacklisted = Prefix .. "You're blacklisted from the server, fuck off please."

Config.Welcome = Prefix .. "Welcome Sir."
Config.Error = Prefix .. "Error, Please try again later."