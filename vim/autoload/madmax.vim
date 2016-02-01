function! madmax#Init()
    " Include repository in vim's runtimepath
    call s:SetRtp()

    " Make sure the user has a .vim directory
    if !(isdirectory($HOME . "/.vim"))
        call mkdir($HOME . "/.vim")
    endif
endfunction

function! s:SetRtp()
    set rtp&vim
    let l:first = split(&rtp, ',')[0]
    execute 'set rtp-=' . l:first
    execute 'set rtp^=' . g:vimconfig_dir . "/vim"
    execute 'set rtp^=' . l:first
    execute 'set rtp+=' . g:vimconfig_dir . "/vim/after"
endfunction
