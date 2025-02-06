local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out,                            'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    spec = {
        { 'neovim/nvim-lspconfig' },
        { 'navarasu/onedark.nvim' },
        {
            'nvim-telescope/telescope.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim',
                {
                    'nvim-telescope/telescope-fzf-native.nvim',
                    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
                }
            },
        },
        { 'tpope/vim-fugitive' },
        { 'tpope/vim-sleuth' },
        {
            "L3MON4D3/LuaSnip",
            build = "make install_jsregexp",
        },
        {
            'hrsh7th/nvim-cmp',
            dependencies = {
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'hrsh7th/cmp-buffer' },
                { 'hrsh7th/cmp-path' },
                { 'hrsh7th/cmp-cmdline' },
                { 'saadparwaiz1/cmp_luasnip' },
                { 'andersevenrud/cmp-tmux' },
            },
        },
        { 'nvim-lualine/lualine.nvim' },
    },
    install = { colorscheme = { 'habamax' } },
    checker = { enabled = true },
    performance = {
        rtp = {
            paths = {
                vim.g.dotfiles_rtp,
            },
        },
    },
})

require 'config.plugins.onedark'
require 'config.plugins.telescope'
require 'config.plugins.cmp'
require 'config.plugins.lualine'
require 'config.plugins.fugitive'
