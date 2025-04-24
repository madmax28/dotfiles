vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('t', '<leader>jk', '<c-\\><c-n>')
vim.keymap.set('i', '<c-c>', '<esc>')
vim.keymap.set('c', '<c-a>', '<home>')
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<c-w><c-c>', '<nop>')
vim.keymap.set('n', '<leader>w', ':set wrap!<cr>')
vim.keymap.set('n', '<leader>n', ':nohlsearch<cr>')
vim.keymap.set('n', '+', 'ddp')
vim.keymap.set('n', '-', 'ddkP')

-- Activate/update diff
vim.keymap.set('n', '<leader>dd', ':diffthis<cr>')
vim.keymap.set('n', '<leader>dD', ':windo diffthis<cr>')
vim.keymap.set('n', '<leader>do', ':diffoff<cr>')
vim.keymap.set('n', '<leader>dO', ':diffoff!<cr>')
vim.keymap.set('n', '<leader>du', ':diffupdate!<cr>')

-- Go to previous file
vim.keymap.set('n', '<leader>b', ':b#<cr>')

-- 'Visual' move
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Do not pollute jumplist with [{}]
vim.keymap.set('n', '}', ':keepjumps normal! }<cr>')
vim.keymap.set('n', '{', ':keepjumps normal! {<cr>')

-- Tab arrangement & navigation
vim.keymap.set('n', '<c-w>Q', ':tabc<cr>', { silent = true })
vim.keymap.set('n', '<c-w>t', ':tabnew<cr>', { silent = true })
vim.keymap.set('n', '<c-p>', ':tabp<cr>', { silent = true })
vim.keymap.set('n', '<c-n>', ':tabn<cr>', { silent = true })

-- Split navigation
vim.keymap.set('i', '<c-j>', '<esc><c-w>j', { silent = true })
vim.keymap.set('i', '<c-k>', '<esc><c-w>k', { silent = true })
vim.keymap.set('i', '<c-h>', '<esc><c-w>h', { silent = true })
vim.keymap.set('i', '<c-l>', '<esc><c-w>l', { silent = true })
vim.keymap.set('n', '<c-j>', '<c-w>j', { silent = true })
vim.keymap.set('n', '<c-k>', '<c-w>k', { silent = true })
vim.keymap.set('n', '<c-h>', '<c-w>h', { silent = true })
vim.keymap.set('n', '<c-l>', '<c-w>l', { silent = true })

vim.keymap.set('n', 'gt', ':tselect <c-r><c-w><cr>', { silent = true })
