fx_version 'cerulean'

game 'gta5'

loadscreen_manual_shutdown 'yes'

client_scripts {
    'client/main.lua',
    'client/transition.lua',
    'config/config.lua',
    'config/levels.lua',
}

server_scripts {
    'server/main.lua',
    'config/config.lua',
    'config/levels.lua',
}

ui_page 'web/index.html'

files{
    'web/index.html',
    'web/style.css',
    'web/script.js',
}