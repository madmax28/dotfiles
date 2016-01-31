" (Un)commenting lines
function! madmax#comment#ToggleComment()
    if !exists("b:cString")
        let b:cString = "#"
    endif

    let l:line = getline('.')

    " Ignore indented comments
    if match(l:line, '\v^\s+\V' . b:cString) >= 0
        return
    endif
    " Ignore empty lines
    if match(l:line, '\v^\s*$') >= 0
        return
    endif

    " Do
    if match(l:line, '^\V' . b:cString) >= 0
        " Uncomment
        silent! execute ':s/^\V' . escape(b:cString, '/') . '\v//'
    else
        " Comment
        silent! execute ':s/^/' . escape(b:cString, '/') . '/'
    endif
endfunction

