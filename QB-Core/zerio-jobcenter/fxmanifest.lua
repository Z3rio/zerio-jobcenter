fx_version "cerulean"
game "gta5"

lua54 "yes"
escrow_ignore {
    "*.lua",
    "**/*.lua"
}

shared_scripts {
    "config.lua"
}
client_scripts {
    "client/main.lua"
}
server_scripts {
    "server/main.lua"
}

files {
    "html/index.html",
    "html/style.css",
    "html/libs/vue.js"
}

ui_page "html/index.html"