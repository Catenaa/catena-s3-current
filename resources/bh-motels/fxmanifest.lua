fx_version 'adamant'

game 'gta5'


data_file 'DLC_ITYP_REQUEST' 'stream/v_int_shop.ytyp'


files {
    'stream/v_int_shop.ytyp'
}



server_scripts {
    'config/config.lua',
    'server/main.lua',
    'server/clothing.lua',
    'server/inventory.lua',
    'server/bedinventory.lua'
}

client_scripts {
    'config/config.lua',
    'client/main.lua',
    'client/functions.lua'
}
