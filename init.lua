vim.g.mapleader = ','

-- {{{ plugins

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'neovim/nvim-lspconfig',
        requires = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'j-hui/fidget.nvim',
        },
    }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip'
        },
    }


    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    }

    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    }

    use {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = { 'nvim-lua/plenary.nvim' },
    }

    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        cond = vim.fn.executable 'make' == 1,
    }

    use 'navarasu/onedark.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-commentary'
    use 'tpope/vim-sleuth'
    use 'simrat39/rust-tools.nvim'
end)

-- }}}

-- {{{ Treesitter

require('nvim-treesitter.configs').setup {
    ensure_installed = { 'c', 'cpp', 'lua', 'python', 'rust', 'zig' },
    auto_install = true,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<c-backspace>',
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
    },
}

-- }}}

-- {{{ Telescope

require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
                ['<C-j>'] = 'select_horizontal',
                ['<C-k>'] = 'select_vertical',
                ['<C-t>'] = 'select_tab',
            },
        },
    },
}

pcall(require('telescope').load_extension, 'fzf')
local ts = require('telescope.builtin')
vim.keymap.set('n', '<leader>or', ts.oldfiles)
vim.keymap.set('n', '<leader>ob', ts.buffers)
vim.keymap.set('n', '<leader>of', ts.find_files)
vim.keymap.set('n', '<leader>oh', ts.help_tags)
vim.keymap.set('n', '<leader>od', ts.diagnostics)
vim.keymap.set('n', '<leader>og', ts.live_grep)

-- }}}

-- {{{ LSP

require('mason').setup()

local servers = { 'sumneko_lua', 'zls' }

require('mason-lspconfig').setup {
    ensure_installed = servers,
}

local function global_on_attach(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local function nmap(lhs, rhs)
        vim.keymap.set('n', lhs, rhs, { buffer = bufnr })
    end

    nmap('[d', vim.diagnostic.goto_prev)
    nmap(']d', vim.diagnostic.goto_next)
    nmap('K', vim.lsp.buf.hover)
    nmap('<C-k>', vim.lsp.buf.signature_help)
    nmap('gd', vim.lsp.buf.definition)
    nmap('gi', vim.lsp.buf.implementation)
    nmap('gr', require('telescope.builtin').lsp_references)
    nmap('<leader>pe', vim.diagnostic.open_float)
    nmap('<leader>pq', vim.diagnostic.setqflist)
    nmap('<leader>pf', vim.lsp.buf.code_action)
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = global_on_attach,
        capabilities = capabilities,
    }
end

-- {{{ Lua

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
    on_attach = global_on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = runtime_path,
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
}

-- }}}

-- }}}

-- {{{ rust-tools

local rt = require('rust-tools')
rt.setup({
    tools = {
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = '',
            other_hints_prefix = '',
        },
    },
    server = {
        on_attach = function(client, bufnr)
            global_on_attach(client, bufnr)
            vim.keymap.set(
                'n',
                'K',
                rt.hover_actions.hover_actions,
                { buffer = bufnr }
            )
            vim.keymap.set(
                'n',
                '<leader>pf',
                rt.code_action_group.code_action_group,
                { buffer = bufnr }
            )
        end,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
            }
        },
    },
})

-- }}}

-- {{{ nvim-cmp

local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}

-- }}}

-- {{{ Onedark

require('onedark').setup({
    style = 'warmer',
})
require('onedark').load()

-- }}}

-- {{{ Fidget

require('fidget').setup()

-- }}}

-- {{{ Lualine

require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
    },
}

-- }}}

-- {{{ Options

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.textwidth = 80
vim.o.number = true
vim.o.relativenumber = true
vim.o.wildmode = 'longest:full'
vim.o.scrolloff = 5
vim.o.swapfile = false
vim.o.gdefault = true
vim.o.foldmethod = 'marker'
vim.o.foldopen = 'hor,mark,percent,quickfix,search,tag,undo'
vim.o.mouse = 'a'
vim.o.listchars = 'tab:>-,trail:-,nbsp:+'
vim.o.list = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.wrapscan = false
vim.o.undofile = true
vim.o.inccommand = 'split'
vim.o.formatoptions = 'jcrql'
vim.o.cursorline = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.termguicolors = true
vim.o.completeopt = 'menu,menuone,noselect'

-- }}}

-- {{{ Mappings

vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('i', '<c-c>', '<esc>')
vim.keymap.set('n', '<leader>n', ':nohlsearch<cr>')
vim.keymap.set('c', '<c-a>', '<home>')
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<leader>J', 'xi<cr><esc>')
vim.keymap.set('n', '+', 'ddp')
vim.keymap.set('n', '-', 'ddkP')
vim.keymap.set('n', '<leader>w', ':set wrap!<cr>')

-- Activate/update diff
vim.keymap.set('n', '<leader>dd', ':diffthis<cr>')
vim.keymap.set('n', '<leader>dD', ':windo diffthis<cr>')
vim.keymap.set('n', '<leader>do', ':diffoff<cr>')
vim.keymap.set('n', '<leader>dO', ':diffoff!<cr>')
vim.keymap.set('n', '<leader>du', ':diffupdate!<cr>')

-- Go to previous file
vim.keymap.set('n', '<leader>b', ':b#<cr>')

vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Repeat latest [ftFT] in opposite direction
vim.keymap.set('n', "'", ',')
vim.keymap.set('n', '<cr>', '<c-]>')

-- In quickfix and command window, unmap <cr>
vim.cmd([[
    augroup agUnmapCr
        autocmd!
        autocmd CmdwinEnter * noremap <buffer> <cr> <cr>
        autocmd BufReadPost quickfix noremap <buffer> <cr> <cr>
    augroup END
]])

-- This shouldn't close the window
vim.keymap.set('n', '<c-w><c-c>', '<nop>')

-- Do not pollute jumplist with [{}]
vim.keymap.set('n', '}', ':keepjumps normal! }<cr>')
vim.keymap.set('n', '{', ':keepjumps normal! {<cr>')
vim.keymap.set('n', '<leader><tab>', ':cn<cr>')
vim.keymap.set('n', '<leader><s-tab>', ':cp<cr>')

-- Tab arrangement
vim.keymap.set('n', '<c-w>Q', ':tabc<cr>', { silent = true })
vim.keymap.set('n', '<c-w>t', ':tabnew<cr>', { silent = true })

-- Split navigation
vim.keymap.set('i', '<c-j>', '<esc><c-w>j', { silent = true })
vim.keymap.set('i', '<c-k>', '<esc><c-w>k', { silent = true })
vim.keymap.set('i', '<c-h>', '<esc><c-w>h', { silent = true })
vim.keymap.set('i', '<c-l>', '<esc><c-w>l', { silent = true })
vim.keymap.set('n', '<c-j>', '<c-w>j', { silent = true })
vim.keymap.set('n', '<c-k>', '<c-w>k', { silent = true })
vim.keymap.set('n', '<c-h>', '<c-w>h', { silent = true })
vim.keymap.set('n', '<c-l>', '<c-w>l', { silent = true })

-- Tab navigation
vim.keymap.set('n', '<c-p>', ':tabp<cr>', { silent = true })
vim.keymap.set('n', '<c-n>', ':tabn<cr>', { silent = true })

-- Togle quickfix/loclist
vim.cmd([[
    function! s:GetBufferList()
      redir =>buflist
      silent! ls
      redir END
      return buflist
    endfunction

    function! ToggleList(bufname, pfx)
      let buflist = s:GetBufferList()
      for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
        if bufwinnr(bufnum) != -1
          exec(a:pfx.'close')
          return
        endif
      endfor
      if a:pfx == 'l' && len(getloclist(0)) == 0
          echohl ErrorMsg
          echo "Location List is Empty."
          return
      endif
      let winnr = winnr()
      exec(a:pfx.'open')
      if winnr() != winnr
        wincmd p
      endif
    endfunction
]])
vim.keymap.set('n', '<leader>l', ':call ToggleList("Location List", "l")<cr>', { silent = true })
vim.keymap.set('n', '<leader>q', ':call ToggleList("Quickfix List", "c")<cr>:pclose<cr>', { silent = true })

vim.keymap.set('t', '<leader>jk', '<c-\\><c-n>')

-- }}}

-- {{{ Commands

vim.cmd([[
    " Ignore command typos
    command! W w
    command! Q q
    command! Wq wq
    command! WQ wq

    " Change to directory of current file
    command! Cd cd %:p:h
]])

-- }}}

-- {{{ Restore cursor position per buffer

vim.cmd([[
    function! RestoreCursor()
        if line("'\\") <= line("$")
            normal! g`"
            return 1
        endif
    endfunction

    augroup RestoreCursor
        autocmd!
        autocmd BufWinEnter * silent! call RestoreCursor()
    augroup END
]])

-- }}}

-- Maximize quickfix windows' width {{{

vim.cmd([[
    function! MaxQuickfixWin()
        if &buftype ==# "quickfix"
            execute "normal! \<c-w>J"
        endif
    endfunction
    augroup MaxQuickfixWinGrp
        autocmd!
        autocmd BufWinEnter * call MaxQuickfixWin()
    augroup END
]])

-- }}}

-- {{{ Sessions

vim.o.sessionoptions = "blank,sesdir,buffers,help,tabpages,folds"
vim.cmd([[
    function! RestoreSession()
        let l:sessionfile = getcwd() . "/.vimsession"
        if filereadable(l:sessionfile) && !argc()
            execute 'source ' . l:sessionfile
        endif
    endfunction

    function! UpdateSession()
        let l:sessionfile = getcwd() . "/.vimsession"
        if !argc()
            execute 'mksession! ' . l:sessionfile
        endif
    endfunction

    augroup SessionGrp
        autocmd!
        autocmd VimEnter * nested call RestoreSession()
        autocmd VimLeave * nested call UpdateSession()
    augroup END
]])

-- }}}
