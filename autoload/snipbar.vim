let s:snipbar_buffer = 'snipbar'
let g:snipbar_open = 0

function! snipbar#SnipBarListAllSnippets()
    let s:origin_window = win_getid()

    call s:Scratch()

    if g:snipbar_open == 0
        return
    endif

    call s:SelectWindow(s:origin_window)

    call UltiSnips#SnippetsInCurrentScope(1)
    if len(g:current_ulti_dict_info) == 0
        echo "No snippets for current file"
        call s:Close()
        return
    endif

    call s:SelectWindow(s:snipbar_window)

    call s:WriteSnippets()

    call s:SelectWindow(s:origin_window)
endfunction

function! s:SelectWindow(window)
    call win_gotoid(a:window)
endfunction

function! s:WriteSnippets()
    setl modifiable

    " Clear buffer
    silent %delete _

    for [key, info] in items(g:current_ulti_dict_info)
        exe "syn keyword snippetkey " . key
        exe "syn keyword snippetdescr " . info.description
        call append(line("$"), key)
        call append(line("$"), "    " . info.description)
    endfor
    exe "hi def link snippetkey Identifier"
    exe "hi def link snippetkey Normal"
    setl nomodifiable
endfunction

function! s:Scratch()
    if bufwinnr(s:snipbar_buffer) != -1
        call s:Close()
        return
    endif

    call s:Open()
    return
endfunction

function! s:Open()
    exe 'silent keepalt botright vertical 40split ' . s:snipbar_buffer
    setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted
    setlocal textwidth=0 nolist nowrap winfixwidth nospell nomodifiable
    let s:snipbar_window = win_getid()
    let g:snipbar_open = 1
endfunction

function! s:Close()
    let snipbar_window = bufwinnr(s:snipbar_buffer)
    if snipbar_window == -1
        return
    endif

    if winnr() != snipbar_window
        execute snipbar_window . 'wincmd w'
    endif

    if winnr() == snipbar_window
        close
    endif

    call s:SelectWindow(s:origin_window)

    let g:snipbar_open = 0
endfunction

function! s:Debug(debug)
    exe 'redir >> ' . s:debug_file
    silent echon strftime('%Y-%m-%d %H:%M:%S') . ': ' . a:debug . "\n"
    redir END
endfunction
