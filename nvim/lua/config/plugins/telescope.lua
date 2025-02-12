require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
                ['<C-j>'] = 'select_horizontal',
                ['<C-k>'] = 'select_vertical',
                ['<C-t>'] = 'select_tab',
                ['<C-h>'] = 'which_key'
            },
        },
    },
}
require('telescope').load_extension('fzf')

pcall(require('telescope').load_extension, 'fzf')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>of', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>og', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>ob', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>oh', function()
    builtin.help_tags { fname_width = 200 }
end, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>or', builtin.oldfiles, { desc = 'Telescope recent files' })
vim.keymap.set('n', '<leader>oc', builtin.commands, { desc = 'Telescope commands' })
vim.keymap.set('n', '<leader>o:', builtin.command_history, { desc = 'Telescope command history' })
vim.keymap.set('n', '<leader>o/', builtin.search_history, { desc = 'Telescope search history' })
vim.keymap.set('n', '<leader>om', builtin.man_pages, { desc = 'Telescope man pages' })
vim.keymap.set('n', '<leader>oq', builtin.quickfix, { desc = 'Telescope quickfix' })
vim.keymap.set('n', '<leader>oQ', builtin.quickfixhistory, { desc = 'Telescope quickfix history' })
vim.keymap.set('n', '<leader>oo', builtin.pickers, { desc = 'Telescope pickers' })
vim.keymap.set('n', '<leader>od', builtin.diagnostics, { desc = 'Telescope diagnostics' })
vim.keymap.set('n', '<leader>olc', builtin.lsp_incoming_calls, { desc = 'Telescope LSP incoming calls' })
vim.keymap.set('n', '<leader>olo', builtin.lsp_outgoing_calls, { desc = 'Telescope LSP outgoing calls' })
vim.keymap.set('n', '<leader>olr', builtin.lsp_references, { desc = 'Telescope LSP references' })
vim.keymap.set('n', '<leader>oli', builtin.lsp_implementations, { desc = 'Telescope LSP implementations' })
vim.keymap.set('n', '<leader>old', builtin.lsp_definitions, { desc = 'Telescope LSP definitions' })
vim.keymap.set('n', '<leader>op', builtin.builtin, { desc = 'Telescope builtins' })

vim.keymap.set('n', '<leader>ov', function()
    require 'telescope.builtin'.find_files { cwd = vim.g.dotfiles_rtp }
end)
