require 'lspconfig'.markdown_oxide.setup {
    capabilities = vim.tbl_deep_extend(
        'force',
        require('cmp_nvim_lsp').default_capabilities(),
        {
            workspace = {
                didChangeWatchedFiles = {
                    dynamicRegistration = true,
                },
            },
        }
    ),
}
