resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

shared_script "@nevo-scripts/cl_errorlog.lua"


client_script 'ctn_c.lua'
server_script 'ctn_s.lua'

files {
	"ctn_index.html",
	"ctn_js.js"
}

ui_page {
	'ctn_index.html',
}
