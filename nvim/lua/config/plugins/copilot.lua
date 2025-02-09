require 'copilot'.setup {
    suggestion = {
        auto_trigger = true,
        keymap = {
            accept = '<m-a>',
        },
    },
}

vim.keymap.set('n', '<leader>cp', function() vim.cmd.Copilot('panel') end)
