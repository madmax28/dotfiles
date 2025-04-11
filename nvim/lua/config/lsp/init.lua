vim.lsp.inlay_hint.enable(true)
vim.diagnostic.config({
    severity_sort = true,
    signs = false,
    update_in_insert = true,
    virtual_text = false,
    virtual_lines = true,
    jump = {
        float = false,
    },
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client == nil then
            error('could not get lsp client')
        end

        if client:supports_method('textDocument/definition') then
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
        end

        if client:supports_method('textDocument/typeDefinition') then
            vim.keymap.set('n', 'grt', vim.lsp.buf.type_definition, { buffer = bufnr })
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
            local excluded_filetypes = { 'c', 'cpp' }
            local ft = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
            if not vim.tbl_contains(excluded_filetypes, ft) then
                vim.api.nvim_create_autocmd('BufWritePre', {
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
                    end,
                })
            end
            vim.keymap.set('n', '<leader>F', vim.lsp.buf.format, { buffer = bufnr })
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
require 'config.lsp.ts_ls'
require 'config.lsp.glsl'
require 'config.lsp.python'
require 'config.lsp.markdown-oxide'
