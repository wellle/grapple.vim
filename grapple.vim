nnoremap <silent> y :<C-U>call MarkAndSetOpfunc('y')<CR>g@
nnoremap <silent> d :<C-U>call MarkAndSetOpfunc('d')<CR>g@
nnoremap <silent> cx :<C-U>call MarkAndSetOpfunc('X')<CR>g@

nnoremap yy y_
nnoremap dd d_

function! MarkAndSetOpfunc(operator)
    let s:operator = a:operator
    let s:save_cursor = getpos(".")
    set opfunc=OperateAndJumpBack
endfunction

function! OperateAndJumpBack(type, ...)
    let startBefore = getpos("'[")
    let endBefore = string(getpos("']"))

    if a:type == 'line'
        silent exe "normal! '[V']"
    elseif a:type == 'block'
        silent exe "normal! `[\<C-V>`]"
    else
        silent exe "normal! `[v`]"
    endif

    silent exe "normal " . s:operator

    let startAfter = string(getpos("'["))
    let endAfter = string(getpos("']"))

    call setpos('.', s:save_cursor)
endfunction
