function! madmax#util#MakeScratch(name, istemp)
    new
    set buftype=nofile
    exec "file " . a:name
    if a:istemp
        augroup madmax_util_makescratch
            autocmd BufHidden <buffer> bdelete!
        augroup END
    endif
endfunction
