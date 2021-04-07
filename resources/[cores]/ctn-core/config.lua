QBConfig = {}

QBConfig.MaxPlayers = GetConvarInt('sv_maxclients', 64) -- Gets max players from config file, default 32
QBConfig.IdentifierType = "steam" -- Set the identifier type (can be: steam, license)
QBConfig.DefaultSpawn = {x=-1035.71,y=-2731.87,z=12.86,a=0.0}

QBConfig.Money = {}
QBConfig.Money.MoneyTypes = {['cash'] = 2500, ['bank'] = 10000, ['crypto'] = 0 } -- ['type']=startamount - Add or remove money types for your server (for ex. ['blackmoney']=0), remember once added it will not be removed from the database!
QBConfig.Money.DontAllowMinus = {'cash', 'crypto'} -- Money that is not allowed going in minus

QBConfig.Player = {}
QBConfig.Player.MaxWeight = 250000 -- Max weight a player can carry (currently 120kg, written in grams)
QBConfig.Player.MaxInvSlots = 41 -- Max inventory slots for a player
QBConfig.Player.Bloodtypes = {
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
}

QBConfig.Server = {} -- General server config
QBConfig.Server.Opened = true -- Set server closed (no one can join except people with ace permission 'RLadmin.join')
QBConfig.Server.uptime = 0 -- Time the server has been up.
QBConfig.Server.discord = "488314532020879370" -- Discord invite link
QBConfig.Server.PermissionList = {} -- permission list


QBConfig.Server.PermissionList = {} -- permission list
QBConfig.Guildid = "488314532020879370" -- your guild id here
QBConfig.Bottoken = "ODEzNDA2NjYzMTc5NzYzNzEy.YDO1_A.JPV59SbwuRQx1dEIK7ZU-x2n5bc" -- bot token on str
QBConfig.Roleid = "807548304942170153"   ---  
QBConfig.Roleidadmin = "704096073635070093"   ---  