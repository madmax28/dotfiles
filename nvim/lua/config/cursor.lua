-- Restore cursor position per buffer
vim.cmd([[
    function! RestoreCursor()
        if line("'\\") <= line("$")
            normal! g`"
            return 1
        endif
    endfunction

    augroup RestoreCursor
        autocmd!
        autocmd BufWinEnter * silent! call RestoreCursor()
    augroup END
]])
