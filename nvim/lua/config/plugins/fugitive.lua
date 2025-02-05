vim.cmd([[function! GitGraph()
    let l:bufdir = expand("%:p:h")
    if stridx(l:bufdir, "fugitive://") == 0
        let l:bufdir = strpart(l:bufdir, strlen("fugitive://"))
    endif

    if isdirectory(l:bufdir)
        let l:curdir = getcwd()
        execute "chdir " . l:bufdir
    endif

    tabnew
    term git graph
    normal a

    if isdirectory(l:bufdir)
        execute "chdir " . l:curdir
    endif
endfunction
]])

vim.keymap.set('n', '<leader>gg', '<Cmd>call GitGraph()<CR>')
vim.keymap.set('n', '<leader>gd', '<Cmd>Gdiff<CR>')
