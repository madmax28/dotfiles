require('onedark').setup {
    style = 'warmer'
}
require('onedark').load()

--  Accentuate CursorLineNr
vim.cmd('highlight! link CursorLineNr WildMenu')
