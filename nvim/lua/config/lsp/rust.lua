require 'lspconfig'.rust_analyzer.setup {
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
