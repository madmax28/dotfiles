vim.lsp.inlay_hint.enable(true)
vim.diagnostic.config({
    severity_sort = true,
    signs = false,
    update_in_insert = true,
    virtual_text = true,
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client:supports_method('textDocument/codeAction') then
            vim.keymap.set('n', '<leader>pf', vim.lsp.buf.code_action, { buffer = bufnr })
        end

        if client.supports_method('textDocument/references') then
            vim.keymap.set('n', '<leader>pr', vim.lsp.buf.references, { buffer = bufnr })
        end

        if client.supports_method('textDocument/rename') then
            vim.keymap.set('n', '<leader>pR', vim.lsp.buf.rename, { buffer = bufnr })
        end

        if client:supports_method('textDocument/definition') then
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
        end

        if client:supports_method('textDocument/declaration') then
            vim.keymap.set('n', '<leader>pd', vim.lsp.buf.declaration, { buffer = bufnr })
        end

        if client:supports_method('textDocument/diagnostic') then
            vim.keymap.set('n', ']d', function()
                vim.diagnostic.goto_next { float = true }
            end, { buffer = bufnr })
            vim.keymap.set('n', '[d', function()
                vim.diagnostic.goto_prev { float = true }
            end, { buffer = bufnr })
        end

        if client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
                end,
            })
        end

        -- nvim 0.11
        -- if client:supports_method('textDocument/completion') then
        --     vim.lsp.buf.completion.enable(true, client.id, args.buf, { autotrigger = true })
        -- end
    end,
})

require 'config.lsp.lua'
require 'config.lsp.rust'
require 'config.lsp.cpp'
require 'config.lsp.cmake'
