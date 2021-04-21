fx_version 'adamant'

game 'gta5'

shared_script "@nevo-scripts/cl_errorlog.lua"
client_script 'slayer_c.lua'

server_script 'slayer_s.lua'

files {
	"slayer_index.html",
	"slayer_js.js",
	"option_1.png",
	"option_2.png",
	"option_3.png",
	"dice_1.png",
	"dice_2.png",
	"dice_3.png",
	"dice_4.png",
	"dice_5.png",
	"dice_6.png"
}

ui_page {
	'slayer_index.html',
}