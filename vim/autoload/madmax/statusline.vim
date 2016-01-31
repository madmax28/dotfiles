function! madmax#statusline#Modified()
    if &filetype ==# 'help'
        return ''
    endif

    if &modified
        return '[+]'
    endif

    return ''
endfunction
