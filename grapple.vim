nnoremap <silent> y  :<C-U>call MarkAndSetOpfunc('y')<CR>g@
nnoremap <silent> d  :<C-U>call MarkAndSetOpfunc('d')<CR>g@
nnoremap <silent> cx :<C-U>call MarkAndSetOpfunc('X')<CR>g@

nnoremap yy y_
nnoremap dd d_

function! MarkAndSetOpfunc(operator)
    let s:operator = a:operator
    let s:cursorBefore = getpos(".")
    set opfunc=OperateAndJumpBack
endfunction

function! OperateAndJumpBack(type, ...)
    let startBefore = getpos("'[")
    let endBefore = string(getpos("']"))

    if a:type == 'line'
        silent execute "normal! '[V']"
    elseif a:type == 'block'
        silent execute "normal! `[\<C-V>`]"
    else
        silent execute "normal! `[v`]"
    endif

    silent execute "normal " . s:operator

    let startAfter = string(getpos("'["))
    let endAfter = string(getpos("']"))

    " add curswant = col
    call add(s:cursorBefore, s:cursorBefore[2])
    call setpos('.', s:cursorBefore)
endfunction
