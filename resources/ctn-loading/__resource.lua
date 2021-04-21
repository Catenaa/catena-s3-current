resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

-- Tell server we will close the loading screen resource ourselfs
loadscreen_manual_shutdown "yes"
-- Client Script
client_script "client.lua"

files {
    'video.webm',
    'index.html',
    'keks.css',
    'testaac.mp4'
}

loadscreen 'index.html'