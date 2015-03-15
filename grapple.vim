nnoremap <silent> y  :<C-U>call grapple#hook('y')<CR>g@
nnoremap <silent> d  :<C-U>call grapple#hook('d')<CR>g@
nnoremap <silent> cx :<C-U>call grapple#hook('X')<CR>g@

nnoremap yy y_
nnoremap dd d_

function! grapple#hook(operator)
    let s:operator = a:operator
    let s:cursorBefore = getpos(".")
    set opfunc=grapple#operate
endfunction

function! grapple#operate(type, ...)
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
