require 'lspconfig'.rust_analyzer.setup {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    settings = {
        ["rust-analyzer"] = {
            rustfmt = {
                rangeFormatting = {
                    enable = true,
                },
            },
            checkOnSave = true,
            check = {
                enable = true,
                command = "clippy",
                features = "all",
            },
        },
    },
}
