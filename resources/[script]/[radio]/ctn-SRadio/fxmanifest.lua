fx_version 'cerulean'
games { 'gta5' }

author 'ℓєσ#1997'
description 'Airpod system by ℓєσ#1997'

client_scripts {
    '@menuv/menuv.lua',
    'client/client.lua',
    'config.lua'
}

server_script 'server/server.lua'

ui_page "html/index.html"

files {
	"html/index.html"
}

dependencies {
    'menuv'
}