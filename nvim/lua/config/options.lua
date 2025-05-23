vim.g.mapleader = ','
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
vim.o.scrollback = 100000

vim.o.foldopen = 'hor,mark,percent,quickfix,search,tag,undo'
vim.o.foldmethod = 'marker'
-- Avoid inheriting foldmethod from current window
vim.api.nvim_create_autocmd(
    { 'WinNew' },
    {
        pattern = { '*' },
        callback = function() vim.wo.foldmethod = 'marker' end
    }
)
