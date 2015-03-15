nnoremap <silent> y  :<C-U>call grapple#hook('y')<CR>g@
nnoremap <silent> d  :<C-U>call grapple#hook('d')<CR>g@
nnoremap <silent> cx :<C-U>call grapple#hook('X')<CR>g@

nnoremap yy y_
nnoremap dd d_

function! grapple#hook(operator)
    call grapple#clear()

    let s:operator = a:operator
    let s:cursorBefore = getpos(".")

    set opfunc=grapple#operate
    " echom 'hook' string(s:)
endfunction

" delete all script local variables
function grapple#clear()
    for key in keys(s:)
        call remove(s:, key)
    endfor
endfunction

function! grapple#operate(type, ...)
    let s:startBefore = getpos("'[")
    let s:endBefore = string(getpos("']"))

    if a:type == 'line'
        silent execute "normal! '[V']"
    elseif a:type == 'block'
        silent execute "normal! `[\<C-V>`]"
    else
        silent execute "normal! `[v`]"
    endif

    silent execute "normal " . s:operator

    let s:startAfter = string(getpos("'["))
    let s:endAfter = string(getpos("']"))

    " echom 'operate' string(s:)

    " return if no old cursor position is known (after repeat attempt)
    if !exists('s:cursorBefore')
        return
    endif

    " add curswant = col
    call add(s:cursorBefore, s:cursorBefore[2])
    call setpos('.', s:cursorBefore)

    " reset cursor before to avoid jumping to old position when grapple
    " operation attempted to be repeated (currently doesn't work)
    unlet s:cursorBefore
endfunction
