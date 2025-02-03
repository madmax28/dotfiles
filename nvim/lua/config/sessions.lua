vim.o.sessionoptions = "blank,sesdir,buffers,help,tabpages,folds"
vim.cmd([[
    function! RestoreSession()
        let l:sessionfile = getcwd() . "/.vimsession"
        if filereadable(l:sessionfile) && !argc()
            execute 'source ' . l:sessionfile
        endif
    endfunction

    function! UpdateSession()
        let l:sessionfile = getcwd() . "/.vimsession"
        if !argc()
            execute 'mksession! ' . l:sessionfile
        endif
    endfunction

    augroup SessionGrp
        autocmd!
        autocmd VimEnter * nested call RestoreSession()
        autocmd VimLeave * nested call UpdateSession()
    augroup END
]])
