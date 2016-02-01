function! madmax#sessions#Restore()
    let l:sessionfile = getcwd() . "/.vimsession"
    if filereadable(l:sessionfile) && !argc()
        execute 'source ' . l:sessionfile
    endif
endfunction

function! madmax#sessions#Update()
    let l:sessionfile = getcwd() . "/.vimsession"
    if !argc()
        execute 'mksession! ' . l:sessionfile
    endif
endfunction

