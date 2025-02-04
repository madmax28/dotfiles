require 'lspconfig'.clangd.setup {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    on_attach = function()
        vim.keymap.set('n', 'go', '<Cmd>ClangdSwitchSourceHeader<CR>', { buffer = true })
    end
}
