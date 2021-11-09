" Init {{{1

set nocompatible                         " No vi compatability
filetype plugin indent on

" madmax library
if !exists("g:vimconfig_dir")
    echoe "g:vimconfig_dir not set!"
    finish
endif
let &rtp .= "," . g:vimconfig_dir . "/vim"
let g:os_uname = substitute(system('uname'), '\n', '', '')
call madmax#Init()

" Leader key
let mapleader = ","

" }}}1

" Plugins {{{1

" Vundle {{{2

call plug#begin(g:vimconfig_dir . "/vim/plugged")

Plug 'SirVer/ultisnips'
Plug 'vim-scripts/xterm-color-table.vim'
Plug 'vim-scripts/L9'
Plug 'nvie/vim-flake8'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-fugitive'
Plug 'majutsushi/tagbar'
Plug 'jremmen/vim-ripgrep'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'tpope/vim-commentary'
Plug 'rust-lang/rust.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
if executable("fzf")
    Plug 'junegunn/fzf.vim'
endif

call plug#end()

" }}}2

" nvim-compe {{{2

if has("nvim")
    lua << EOF
    require'compe'.setup {
        enabled = true;
        autocomplete = true;
        debug = false;
        min_length = 1;
        preselect = 'enable';
        throttle_time = 80;
        source_timeout = 200;
        resolve_timeout = 800;
        incomplete_delay = 400;
        max_abbr_width = 100;
        max_kind_width = 100;
        max_menu_width = 100;
        documentation = true;

        source = {
            path = true;
            buffer = true;
            calc = true;
            nvim_lsp = true;
            nvim_lua = true;
            vsnip = true;
            ultisnips = true;
            luasnip = true;
        };
    }
EOF

" inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
" inoremap <silent><expr> <C-e>     compe#close('<C-e>')
" inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
" inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

endif

" }}}2

" vim-ripgrep {{{2

nnoremap <leader>G :Rg -w <c-r><c-w><cr>

" }}}2

" fzf {{{2

if executable("fzf")
    let &rtp .= "," . g:vimconfig_dir . "/fzf"

    let g:fzf_command_prefix = 'FZF'
    nnoremap <leader>t :FZFTags<cr>
    nnoremap <leader>ob :FZFBuffers<cr>
    nnoremap <leader>of :FZFFiles<cr>
    nnoremap <leader>oh :FZFHelptags<cr>
    nnoremap <leader>ol :FZFLines<cr>
    nnoremap <leader>os :FZFSnippets<cr>
    nnoremap <leader>or :FZFHistory<cr>
    nnoremap <leader>: :FZFHistory:<cr>
    nnoremap <leader>/ :FZFHistory/<cr>

    let g:fzf_action = {
                \ 'ctrl-j': 'split',
                \ 'ctrl-k': 'vsplit',
                \ 'ctrl-l': 'tab split',
                \ }

    let g:fzf_colors = {
                \ 'fg':      ['fg', 'Normal'],
                \ 'bg':      ['bg', 'Normal'],
                \ 'hl':      ['fg', 'Comment'],
                \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
                \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
                \ 'hl+':     ['fg', 'Statement'],
                \ 'info':    ['fg', 'PreProc'],
                \ 'border':  ['fg', 'Ignore'],
                \ 'prompt':  ['fg', 'Conditional'],
                \ 'pointer': ['fg', 'Exception'],
                \ 'marker':  ['fg', 'Keyword'],
                \ 'spinner': ['fg', 'Label'],
                \ 'header':  ['fg', 'Comment']
                \ }
endif

" }}}2

" Completor {{{2

if s:completor
    let g:completor_min_chars = 1
    let g:completor_completion_delay = 0
endif

" }}}2

" Fugitive {{{2

function! GitGraph()
    let l:bufdir = expand("%:p:h")
    let l:curdir = getcwd()

    execute "chdir " . l:bufdir
    tabnew
    term git graph
    normal a
    execute "chdir " . l:curdir
endfunction

command! Gg :call GitGraph()

nnoremap <leader>gd :Git diff<cr>
nnoremap <leader>gs :Git<cr>
nnoremap <leader>gg :Gg<cr>
nnoremap <leader>gw :Git write<cr>

" }}}2

" Tagbar {{{2

let g:tagbar_sort = 0

" }}}2

" Flake8 {{{2

let g:flake8_show_quickfix = 0
let g:flake8_show_in_gutter = 1
highlight link Flake8_Error      Error
highlight link Flake8_Warning    WarningMsg
highlight link Flake8_Complexity WarningMsg
highlight link Flake8_Naming     WarningMsg
highlight link Flake8_PyFlake    WarningMsg

" }}}2

" UltiSnips {{{2

let g:UltiSnipsExpandTrigger = '<c-e>'

" }}}2

" Rust-vim {{{2

let g:tagbar_type_rust = {
            \ 'ctagstype' : 'rust',
            \ 'kinds' : [
            \'n:modules',
            \'s:structs',
            \'i:interfaces',
            \'c:implementations',
            \'f:functions',
            \'g:enums',
            \'t:typedefs',
            \'v:variables',
            \'M:macros',
            \'m:fields',
            \'e:enumerators',
            \'P:methods',
            \ ]
            \ }

" }}}2

" Tagbar {{{2

noremap <silent> <leader>T :TagbarToggle<cr>
let g:tagbar_autclose = 0

" }}}2

" }}}1

" NVIM native LSP {{{1

if has("nvim")
    lua << EOF
    local on_attach = function(_client, bufnr)
        -- Install `omnifunc` completion handler, get completion with <C-x><C-o>.
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Key mappings.
        local opts = { noremap=true, silent=true }
        vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>pr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>pi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>pf", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    end

    -- Setup rust-analyzer.
    require'lspconfig'.rust_analyzer.setup {
        on_attach = on_attach,
    }

    -- Setup clangd.
    require'lspconfig'.clangd.setup {
        cmd = { "clangd", "--background-index", "--completion-style=detailed" },
        on_attach = on_attach,
    }

    -- Setup pylsp.
    require'lspconfig'.pylsp.setup {
        on_attach = on_attach,
    }

    -- Setup intelephense.
    require'lspconfig'.intelephense.setup {
        on_attach = on_attach,
    }

    -- Setup tsserver.
    require'lspconfig'.tsserver.setup {
        on_attach = on_attach,
    }
EOF
endif


" }}}1

" Settings {{{1

" Colors {{{2

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set tgc
colorscheme madmax
syntax on

hi link LspDiagnosticsDefaultWarning Warning
hi link LspDiagnosticsDefaultError Error

" }}}2

" Generic settings {{{2

set hlsearch incsearch                   " Search highlighting
set shiftwidth=4 softtabstop=4           " Default tab behaviour
set tabstop=8 expandtab
set textwidth=80                         " Use 80 columns
set scrolloff=5                          " Keep some lines around the cursor
set backspace=2
set history=1000                         " Keep a longer history of things
set wildmenu wildmode=list:longest,full  " Wildmenu behavior
set completeopt=menuone,noselect         " Required by nvim-compe
set noswapfile                           " Don't use swapfiles
set hidden                               " Allow hidden buffers
set gdefault                             " Use g flags for :s by default
set number relativenumber                " Show line numbers
set showcmd                              " Show cmd in status bar
set wrap linebreak                       " Wrap lines, at reasonable points
set foldmethod=marker
set foldopen=hor,insert,jump,mark        " When to open folds
set foldopen+=quickfix,search,tag,undo
set mouse=a                              " Allow using the mouse
set listchars=tab:>-,trail:- list        " Explicity list tabs, trailing spaces
set ignorecase smartcase                 " Search case sensitivity
set cinoptions=l1,h0,N-s,i1s,+2s,c0,C1,u0,U1,ks
set nowrapscan                           " Don't wrap searches
set nojoinspaces                         " Don't insert double spaces
set fo-=t
set tags=tags,TAGS                       " Don't look for tags next to file

let g:tex_flavor = "latex"               " Prevent 'plaintex' ft

" }}}2

" Vimdiff {{{2

" Do not start vimdiff in readonly mode
if &diff
    set noreadonly
    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif

" }}}2

" Viminfo {{{2

" The following information is stored:
"   <100  Max. 100 lines per register
"   '100  Remember marks for the last 100 files
if has("viminfo")
    set viminfo=<100,'100,n~/.vim/.viminfo
endif

" }}}2

" Undofiles {{{2

let s:undodir = $HOME . "/.vim/undos"
if !isdirectory( s:undodir )
    call mkdir( s:undodir )
endif
let &undodir = s:undodir
set undofile

" }}}2

" Neovim-specific {{{2

if has("nvim")
    set inccommand=split
endif

" }}}2

" }}}1

" Netrw {{{1


let g:netrw_sort_sequence = "[\/]$,\<core\%(\.\d\+\)\=\>,\~\=\*$,*,\.o$,\.obj$,\.info$,\.swp$,\.bak$,\~$"
let g:netrw_hide = 0
nnoremap <leader>e :Explore<cr>

" }}}1

" Termdebug {{{1

nnoremap <leader>hr :Run<cr>
nnoremap <leader>hb :Break<cr>
nnoremap <leader>hd :Clear<cr>
nnoremap <leader>hs :Step<cr>
nnoremap <leader>hn :Over<cr>
nnoremap <leader>hf :Finish<cr>
nnoremap <leader>hc :Continue<cr>
nnoremap <leader>hq :Stop<cr>

" }}}1

" Mappings and Commands {{{1

" Mappings {{{2

" Misc {{{3

" Convenience
inoremap jk <esc>
inoremap <c-c> <esc>

" Prevent ex-mode, who uses that anyway?
nnoremap Q <nop>

" Clear hlsearch
noremap <leader>n :nohlsearch<cr>

" Pasting in command mode
cnoremap <c-p> <c-r>"

" Check highlighting
nnoremap <leader>hi :so $VIMRUNTIME/syntax/hitest.vim<cr>

" On macs, prevent non-breaking spaces
if g:os_uname ==# "Darwin"
    noremap! <a-space> <space>
endif

" Activate diff, update diff
nnoremap <leader>dd :diffthis<cr>
nnoremap <leader>dD :windo diffthis<cr>
nnoremap <leader>do :diffoff<cr>
nnoremap <leader>dO :diffoff!<cr>
nnoremap <leader>du :diffupdate!<cr>

nnoremap <leader>w :set wrap!<cr>

" Regenerate ctags
nnoremap <leader>C :silent !ctags -R<cr>:redr!<cr>

" }}}3

" Editing {{{3

" Joing and splitting lines
noremap <leader>j J
nnoremap <leader>J xi<cr><esc>
" Moving lines down/up
nnoremap + ddp
nnoremap - ddkP

" Indents {range} following lines to current cursor column
" Example: With the cursor on the 'l' of 'first line', 2<leader>= leads to:
" Before       |After
" first line   |first line
" second       |      second
" 3rd          |      3rd
function! IndentToCursor(count)
    let l:indent = getcurpos()[2]-1
    let l:n_lines = max([1, a:count])
    silent! execute "+1,+" . l:n_lines . "s/\\v^\\s*(\\S)/"
                \ . repeat(" ", l:indent) . "\\1"
endfunction
nnoremap <leader>= :<c-u>call IndentToCursor(v:count)<cr>

" }}}3

" Navigation {{{3

" Go to previous file
nnoremap <leader>b :b#<cr>
" Make j/k navigate visually through wrapped lines
nnoremap j gj
nnoremap k gk
" Repeat latest [ftFT] in opposite direction
nnoremap ' ,
" Do not pollute jumplist with [{}]
nnoremap } :keepjumps normal! }<cr>
nnoremap { :keepjumps normal! {<cr>
" Quickfix navigation
nnoremap <leader><tab> :cn<cr>
nnoremap <leader><s-tab> :cp<cr>
" Follow symbols with Enter
nnoremap <cr> <c-]>
nnoremap <leader><cr> :sp<cr><c-]>
" In quickfix and command window, unmap <cr>
augroup agUnmapCr
    autocmd!
    autocmd CmdwinEnter * noremap <buffer> <cr> <cr>
    autocmd BufReadPost quickfix noremap <buffer> <cr> <cr>
augroup END

" }}}3

" Marks using F1-F12 {{{3

nnoremap <leader><F1> mO
nnoremap <leader><F2> mP
nnoremap <leader><F3> mQ
nnoremap <leader><F4> mR
nnoremap <leader><F5> mS
nnoremap <leader><F6> mT
nnoremap <leader><F7> mU
nnoremap <leader><F8> mV
nnoremap <leader><F9> mW
nnoremap <leader><F10> mX
nnoremap <leader><F11> mY
nnoremap <leader><F12> mZ

nnoremap <F1> `O
nnoremap <F2> `P
nnoremap <F3> `Q
nnoremap <F4> `R
nnoremap <F5> `S
nnoremap <F6> `T
nnoremap <F7> `U
nnoremap <F8> `V
nnoremap <F9> `W
nnoremap <F10> `X
nnoremap <F11> `Y
nnoremap <F12> `Z

" }}}3

" Tab, splits and buffers {{{3

" More natural split directions
set splitright splitbelow
" This shouldn't close the window
nnoremap <c-w><c-c> <nop>
" Tab arrangement
nnoremap <silent> <c-w>Q :tabc<cr>
nnoremap <silent> <c-w>t :tabnew<cr>
" Save, close files
nnoremap <silent> <c-w>wq :wq<cr>
nnoremap <silent> <c-w>ww :w<cr>
nnoremap <silent> <c-w>w :w<cr>
" Split navigation
inoremap <silent> <c-j> <esc><c-w>j
inoremap <silent> <c-k> <esc><c-w>k
inoremap <silent> <c-h> <esc><c-w>h
inoremap <silent> <c-l> <esc><c-w>l
nnoremap <silent> <c-j> <c-w>j
nnoremap <silent> <c-k> <c-w>k
nnoremap <silent> <c-h> <c-w>h
nnoremap <silent> <c-l> <c-w>l
" Tab navigation
nnoremap <silent> <c-p> :tabp<cr>
nnoremap <silent> <c-n> :tabn<cr>

" }}}3

" Quickfix and location window toggle {{{3

noremap <silent> <leader>l :call madmax#togglelist#Toggle("Location List",
            \'l')<CR>
noremap <silent> <leader>q :call madmax#togglelist#Toggle("Quickfix List",
            \'c')<cr>:pclose<cr>

" }}}3

" Command line editing {{{3

" Pasting in command mode
cnoremap <c-p> <c-r>"
cnoremap <c-a> <home>
cnoremap <c-f> <right>
cnoremap <c-b> <left>

" }}}3

" Terminal {{{3

if has("terminal") || has("nvim")
    tnoremap <leader>jk <c-\><c-n>
    tnoremap <leader>h <c-\><c-n><c-w>h
    tnoremap <leader>j <c-\><c-n><c-w>j
    tnoremap <leader>k <c-\><c-n><c-w>k
    tnoremap <leader>l <c-\><c-n><c-w>l
    tnoremap <leader>H <c-\><c-n><c-w>Ha
    tnoremap <leader>J <c-\><c-n><c-w>Ja
    tnoremap <leader>K <c-\><c-n><c-w>Ka
    tnoremap <leader>L <c-\><c-n><c-w>La
endif

" }}}3

" }}}2

" Commands {{{2

" Ignore command typos
command! W w
command! Q q
command! Wq wq
command! WQ wq
" Change to directory of current file
command! Cd cd %:p:h

" Silence :make
command! Make silent! make | redraw!

" Filter commands
" Sum integers in range
command! -range=% Sum <line1>,<line2>!awk '{s+=$1} END {printf "\%.0f", s}'

" ~/.vimrc, dotfile and snippet editing
command! Evimrc execute "edit " . g:vimconfig_dir . "/vimrc"
command! Edotfiles execute "Explore " . g:vimconfig_dir
command! Esnippets execute "Explore " . g:vimconfig_dir . "/vim/UltiSnips"

" Silence :make
command! Make silent! make | redraw!

" }}}2

" }}}1

" Sessions {{{1

let &sessionoptions = "blank,sesdir,buffers,help,tabpages,folds"
augroup SessionGrp
    autocmd!
    autocmd VimEnter * nested call madmax#sessions#Restore()
    autocmd VimLeave * nested call madmax#sessions#Update()
augroup END

" }}}1

" Statusline and Tabline {{{1

" Statusline {{{2

function! MyStatusLine()
    let l:statusline  = '%n: %f%q %a%=%{tagbar#currenttag(''%s'', '''')} (%p%% c%c) %y %1*'
    let l:statusline .= '%{madmax#statusline#Modified()}'
    return l:statusline
endfunction
set laststatus=2
set statusline=%!MyStatusLine()

" }}}2

" Tabline {{{2

set showtabline=2
set tabline=%!madmax#tabline#MyTabLine()

" }}}2

" }}}1

" Yanking {{{1

" Yank Ring, to save frequent yanks to disk {{{2

nnoremap <leader>ry :set opfunc=madmax#yankring#Yank<cr>g@
vnoremap <leader>ry <esc>:call madmax#yankring#Yank('visual')<cr>
nnoremap <leader>rp :call madmax#yankring#Paste('p')<cr>
nnoremap <leader>rP :call madmax#yankring#Paste('P')<cr>
vnoremap <leader>rp d:call madmax#yankring#Paste('P')<cr>

" }}}2

" Yank to system clipboard {{{2

if has("clipboard")
    function! YankToClipboard(mode)
        " Mode is either 'char', 'block' or 'line'
        execute "normal! `[v`]\"+y"
    endfunction

    nnoremap <silent> <leader>y :set opfunc=YankToClipboard<cr>g@
    vnoremap <leader>y "+y
    nnoremap <leader>p "+p
    nnoremap <leader>P "+P
    vnoremap <leader>p d"+P
endif

" }}}2

" }}}1

" Restore cursor position per buffer {{{1

function! ResCur()
    if line("'\") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup ResCur
    autocmd!
    autocmd BufWinEnter * silent! call ResCur()
augroup END

" }}}1

" Maximize quickfix windows' width {{{1

function! MaxQuickfixWin()
    if &buftype ==# "quickfix"
        execute "normal! \<c-w>J"
    endif
endfunction
augroup MaxQuickfixWinGrp
    autocmd!
    autocmd BufWinEnter * call MaxQuickfixWin()
augroup END

" }}}1

" Highlight bad style {{{1

"augroup agHlBadStyle
"    autocmd!
"    autocmd FileType * call madmax#badstyle#HighlightBadStyle()
"augroup END

" }}}1

" Append mode line {{{1

function! AppendModeline()
    let l:modeline = printf("vim: set ts=%d sw=%d tw=%d %set :",
                \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
    let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
    call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>M :call AppendModeline()<CR>

" }}}1

" Perforce {{{1

command! -nargs=? P4diff call P4diff(<args>)
function! P4diff(...)
    " Retrieve file from depot
    let l:tmp = system('mktemp --suffix=".' . expand('%:t') . '"')
    let l:cwd = getcwd()
    cd %:p:h
    if a:0 > 0
        echom 'Diffing against rev ' . a:1
        call system('p4 print -q ' . expand("%:p") . '@=' . a:1 . ' > ' . l:tmp)
    else
        call system('p4 print -q ' . expand("%:p") . ' > ' . l:tmp)
    endif
    exec 'cd ' . l:cwd

    " Diff it
    let l:file = expand("%")
    exec 'tabnew ' . l:tmp
    exec 'vert diffs ' . l:file
endfunction

" Open current file for edit in perforce
command! P4edit execute "!p4 edit " . expand("%")

" }}}1

" vim: foldmethod=marker et sw=4
