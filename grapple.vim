nnoremap <silent> y :<C-U>call MarkAndSetOpfunc()<CR>g@

function! MarkAndSetOpfunc()
    let g:save_cursor = getpos(".")
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
    call setpos('.', g:save_cursor)
endfunction
