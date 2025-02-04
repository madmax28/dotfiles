if vim.fn.executable('rg') == 1 then
    vim.o.grepprg = "rg --vimgrep --hidden --glob '!.git'"
end
