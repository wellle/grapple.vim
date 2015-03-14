nnoremap <silent> y :<C-U>call MarkAndSetOpfunc()<CR>g@

nnoremap yy y_

function! MarkAndSetOpfunc()
    let s:save_cursor = getpos(".")
    let s:operator = 'y'
    set opfunc=OperateAndJumpBack
endfunction

function! OperateAndJumpBack(type, ...)
    if a:0
        silent exe "normal! `<" . a:type . "`>" . s:operator
    elseif a:type == 'line'
        silent exe "normal! '[V']" . s:operator
    elseif a:type == 'block'
        silent exe "normal! `[\<C-V>`]" . s:operator
    else
        silent exe "normal! `[v`]" . s:operator
    endif
    call setpos('.', s:save_cursor)
endfunction
