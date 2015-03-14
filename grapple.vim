nnoremap <silent> y :<C-U>call MarkAndSetOpfunc()<CR>g@

nnoremap yy y_

function! MarkAndSetOpfunc()
    let s:save_cursor = getpos(".")
    set opfunc=YankAndJumpBack
endfunction

function! YankAndJumpBack(type, ...)
    if a:0
        silent exe "normal! `<" . a:type . "`>y"
    elseif a:type == 'line'
        silent exe "normal! '[V']y"
    elseif a:type == 'block'
        silent exe "normal! `[\<C-V>`]y"
    else
        silent exe "normal! `[v`]y"
    endif
    call setpos('.', s:save_cursor)
endfunction
