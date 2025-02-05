if vim.fn.executable('rg') == 1 then
    vim.o.grepprg = "rg --vimgrep --hidden --glob '!.git' --sort=path"
end

vim.cmd([[
    nnoremap <leader>G :grep! -w <c-r><c-w><cr>
]])
