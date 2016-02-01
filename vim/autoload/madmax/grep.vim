function! madmax#grep#GrepOp(mode)
    " Mode is either 'char', 'block' or 'line'
    " Rescue register a
    let l:a = getreg('a')
    " Yank to register a
    if a:mode ==# 'v'
        normal! `<v`>"ay
    elseif a:mode ==# 'char'
        normal! `[v`]"ay
    else
        return
    endif
    " grep#Grep
    execute "normal! :grep -R " . shellescape(getreg('a')) . " *\<cr>"
    " Restore a
    call setreg( 'a', l:a )
endfunction

function! madmax#grep#Grep()
    let l:args = input("grep ", "-R ", "file")
    if l:args ==# ""
        return
    endif

    echom "== args = " . l:args
    execute "normal! :grep" . l:args . "\<cr>"
    redraw!
endfunction
