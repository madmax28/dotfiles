vim.api.nvim_create_autocmd(
    { 'BufRead', 'BufNewFile' },
    {
        pattern = { 'SCons*' },
        callback = function()
            vim.bo.filetype = 'python'
        end,
    }
)
