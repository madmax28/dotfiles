require('cyberdream').setup {
    variant = 'dark',
}
vim.cmd('colorscheme cyberdream')

--  Accentuate CursorLineNr
vim.cmd('highlight! link CursorLineNr WildMenu')
