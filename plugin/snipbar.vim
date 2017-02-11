if exists('g:snipbar_plugin_loaded') || &cp
    finish
endif
let g:snipbar_plugin_loaded = 1

let g:snipbar_plugin_path = expand('<sfile>:p:h')

" A command to call
command! -nargs=0 SnipBar call snipbar#SnipBarListAllSnippets()
