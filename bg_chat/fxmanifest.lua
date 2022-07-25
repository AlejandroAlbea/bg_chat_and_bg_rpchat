fx_version 'adamant'

game 'gta5'

description 'KS_CHAT'

ui_page 'html/index.html'

client_scripts {'@es_extended/locale.lua','clientside/*.lua', 'locales/*.lua', 'configs/*.lua'}

server_scripts {'@es_extended/locale.lua','serverside/*.lua'}

files {

  'html/*.html',

  'html/*.css',

  'html/*.js',

  'html/vendor/*.js',

  'html/vendor/*.css',

  'html/vendor/fonts/*.woff2',

}