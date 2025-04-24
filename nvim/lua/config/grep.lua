if vim.fn.executable('rg') == 1 then
    vim.o.grepprg = "rg --vimgrep --hidden --glob '!.git' --glob '!tags' --sort=path"
end

vim.keymap.set('n', '<leader>G', ':grep! -w <c-r><c-w><cr>')
