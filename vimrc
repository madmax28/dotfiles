"" Init {{{1

" Leader key
let mapleader = ","

let g:os_uname = substitute(system('uname'), "\n", "", "")

"" Plugins {{{1

" Vundle
filetype off
set nocompatible
set rtp+=~/.vim/plugins/Vundle.vim
call vundle#begin('~/.vim/plugins')

Plugin 'gmarik/Vundle.vim'
Plugin 'snipMate'
Plugin 'taglist.vim'
Plugin 'xterm-color-table.vim'
Plugin 'clang-complete'
Plugin 'davidhalter/jedi-vim'
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'nvie/vim-flake8'
Plugin 'godlygeek/tabular'

" Add Plugins here
call vundle#end()
filetype plugin indent on

"" Flake8 {{{1

let g:flake8_show_quickfix = 0
let g:flake8_show_in_gutter = 1

highlight link Flake8_Error      Error
highlight link Flake8_Warning    WarningMsg
highlight link Flake8_Complexity WarningMsg
highlight link Flake8_Naming     WarningMsg
highlight link Flake8_PyFlake    WarningMsg

"" FuzzyFinder {{{1

let g:fuf_modesDisable = []
nnoremap <leader>of :FufFile<cr>
nnoremap <leader>or :FufMruFile<cr>
nnoremap <leader>ob :FufBuffer<cr>
nnoremap <leader>oh :FufHelp<cr>
nnoremap <leader>od :FufDir<cr>
nnoremap <leader><tab> :FufJumpList<cr>
nnoremap <leader>: :FufMruCmd<cr>
nnoremap <leader>t :FufBufferTagAll<cr>
nnoremap <leader>Q :FufQuickfix<cr>
nnoremap <leader>/ :FufLine<cr>

"" Jedi-Vim {{{1

" Mappings
let g:jedi#completions_command      = "<c-n>"
let g:jedi#goto_assignments_command = "<leader>fs"
let g:jedi#goto_definitions_command = "<leader>fg"
let g:jedi#documentation_command    = "<leader>fd"
let g:jedi#usages_command           = "<leader>fn"

let g:jedi#rename_command           = "<leader>f1"
let g:jedi#auto_vim_configuration   = 0
let g:jedi#pop_select_first         = 0
let g:jedi#use_tabs_not_buffers     = 0

"" clang complete {{{1

let g:clang_auto_select = 1
if g:os_uname ==# 'Darwin'
    let g:clang_library_path = '/Library/Developer/CommandLineTools/usr/lib'
endif
let g:clang_use_library = 1

"" Taglist {{{1

noremap <silent> <leader>T :TlistToggle<cr>

let Tlist_Close_On_Select = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_WinWidth = 30
let Tlist_Enable_Fold_Column = 0

highlight link TagListFileName StatusLineNC
highlight link TagListTitle    Keyword

augroup TlistGrp
    autocmd!
    autocmd BufWinEnter * silent! TlistUpdate
    autocmd FileType taglist setlocal nonumber norelativenumber
augroup END

"" Settings {{{1

syntax on
set hlsearch incsearch shiftwidth=4 softtabstop=4 expandtab ruler
    \ scrolloff=5 backspace=2 nowrap history=1000 wildmenu
    \ completeopt=menuone,longest wildmode=list:longest,full
    \ noswapfile nocompatible hidden gdefault
    \ number relativenumber showcmd

" Default textwidth and autowrap
set textwidth=80
set formatoptions=""

" Folding
set foldmethod=marker foldclose=all
set foldopen=hor,insert,jump,mark,quickfix,search,tag,undo

" Use the mouse even without GUI
set mouse=a

" Jump to existent windows when splitting new buffers
set switchbuf=useopen

" Viminfo
if has("viminfo")
    set viminfo=<100,'10,n~/.viminfo
endif

" Grep
let &grepprg = "grep -IHsn --color=auto $* /dev/null"

function! GrepOp(mode)
    " Mode is either 'char', 'block' or 'line'
    " Rescue register a
    let l:a = getreg('a')
    " Yank to register a
    if a:mode ==# 'v'
        normal! `<v`>"ay
    elseif a:mode ==# 'char'
        normal! `[v`]"ay
    else
        return
    endif
    " Grep
    execute "normal! :grep -R " . shellescape(getreg('a')) . " *\<cr>"
    " Restore a
    call setreg( 'a', l:a )
endfunction

function! Grep()
    let l:args = input("grep ", "-R ", "file")
    if l:args ==# ""
        return
    endif

    echom "== args = " . l:args
    execute "normal! :grep" . l:args . "\<cr>"
    redraw!
endfunction

nnoremap <silent> <leader>G :call Grep()<cr>
nnoremap <silent> <leader>g :set opfunc=GrepOp<cr>g@
vnoremap <silent> <leader>g :<c-u>call GrepOp(visualmode())<cr>

"" Use undofiles {{{1
let s:undodir = $HOME . "/.vim/undos"
if !isdirectory( s:undodir )
    call mkdir( s:undodir )
endif
let &undodir = s:undodir
set undofile

"" Gui stuff {{{1
if has("gui")
    " Appearance
    if g:os_uname ==# "Darwin"
        set guifont=Monaco:h12 guioptions-=r guioptions-=R
    elseif g:os_uname ==# "Linux"
        set guifont=Monospace\ 10
    endif
    set guioptions-=l guioptions-=L guioptions-=b guioptions-=T guioptions-=m
    set guioptions-=r guioptions-=R
endif

"" Restore cursor position per buffer {{{1

function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup ResCur
    autocmd!
    autocmd BufWinEnter * silent! call ResCur()
augroup END

"" Syntax and colors {{{1

" Use codeschool
colorscheme codeschool

highlight Error       ctermfg=231 ctermbg=88  cterm=NONE
highlight Normal      ctermfg=231 ctermbg=none cterm=NONE
highlight Folded      ctermfg=247 ctermbg=none cterm=NONE
highlight Highlighted ctermfg=231 ctermbg=24  cterm=NONE
highlight Todo        ctermfg=235 ctermbg=184 cterm=NONE
highlight NonText     ctermfg=24  ctermbg=none cterm=NONE
highlight SignColumn  ctermbg=none

highlight! link MatchParen Visual
highlight! link FoldColumn StatusLineNC
highlight! link CursorLineNr Highlighted
highlight! link CursorLine Highlighted
highlight! link CursorColumn Highlighted
highlight! link VertSplit LineNr

" StatusLine
highlight StatusLineNC cterm=NONE ctermbg=238 ctermfg=255
highlight User1        cterm=NONE ctermbg=24  ctermfg=9
highlight! link StatusLine Highlighted

" StatusLine
call matchadd('Todo', '\ctodo')

"" Status-/Tabline {{{1

function! Modified()
    if &filetype ==# 'help'
        return ''
    endif

    if &modified
        return '[+]'
    endif

    return ''
endfunction

" Returns tag prototype for c/cpp files
function! TagName()
    if match(&filetype, '\v\c[ch](pp)?') != -1
        return Tlist_Get_Tagname_By_Line()
    endif

    return ''
endfunction

function! Fname()
"     return system(g:vimconfig_dir . "/bin/shortpwd -n " . expand('%'))
endfunction

function! MyStatusLine()
    let l:statusline = '%n: %f%q %a%=%{TagName()} (%p%%) %y %1*%{Modified()}'

    return l:statusline
endfunction

set laststatus=2
set statusline=%!MyStatusLine()

" Tabline
highlight clear TabLineSel | highlight link TabLineSel Highlighted
highlight clear TabLineFill | highlight link TabLineFill TabLine
highlight clear TabLine | highlight link TabLine StatusLineNC

function! MyTabLine()
    let s = ''

    for i in range(tabpagenr('$'))
        " Dont print labels if only one tab
        if tabpagenr('$') == 1
            break
        endif

        " Select the highlighting
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        " Set the tab page number (for mouse clicks)
        let s .= '%' . (i + 1) . 'T'
        " The label is made by MyTabLabel()
        let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
    endfor

    " After the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'
    " Print currect working directory
    let s .= '%=cwd: ' . system(g:vimconfig_dir . "/bin/shortpwd -n") . '%#TabLine#'

    return s
endfunction

function! MyTabLabel(n)
    let l:buflist  = tabpagebuflist(a:n)
    let l:winnr    = tabpagewinnr(a:n)
    " Extract filename
    let l:bufname  = bufname(l:buflist[l:winnr - 1])
    let l:filename = matchstr(l:bufname, '\v[^/]*$')
    if l:filename == ''
        return '[No Name]'
    else
        return l:filename
    endif
endfunction

set showtabline=2
set tabline=%!MyTabLine()


"" Un-/Commenting {{{1

" (Un)commenting lines
function! ToggleComment()
    if !exists("b:cString")
        let b:cString = "#"
    endif

    let l:line = getline('.')

    " Ignore indented comments
    if match(l:line, '\v^\s+\V' . b:cString) >= 0
        return
    endif
    " Ignore empty lines
    if match(l:line, '\v^\s*$') >= 0
        return
    endif

    " Do
    if match(l:line, '^\V' . b:cString) >= 0
        " Uncomment
        silent! execute ':s/^\V' . escape(b:cString, '/') . '\v//'
    else
        " Comment
        silent! execute ':s/^/' . escape(b:cString, '/') . '/'
    endif
endfunction

noremap <silent> <leader>c :call ToggleComment()<cr>

"" Highlight bad style {{{1

highlight link BadStyle Error

function! HighlightBadStyle()
    " Dont highlight in help files
    if &filetype ==# "help"
        return
    endif

    " Character on 80th column
    call matchadd('BadStyle', '\%81v.')
    " Trailing whitespaces
    call matchadd('BadStyle', '\s\+\n')
    " More than one newline in a row
"     call matchadd('BadStyle', '^\n\n\+')
    " Non-breaking spaces, useful on Macs, where i tend to hit Alt+Space
    call matchadd('BadStyle', ' ')
endfunction

augroup HighlightBadStyle
    autocmd!
    autocmd FileType * call HighlightBadStyle()
augroup END

"" TODO Execute programs/scripts from within vim {{{1

"" Yanking {{{1

let g:yring_len = 10
let g:yring_idx = -1
let s:yring_f = getcwd() . '/.vimyanks'
if filereadable(s:yring_f)
    let g:yring = readfile(s:yring_f, "b")
    let g:yring_idx = (len(g:yring)-1) % g:yring_len
else
    let g:yring = []
endif

function! YankRing(mode)
    let l:yring_f = getcwd() . '/.vimyanks'

    " Save reg a
    let l:olda = getreg('a')

    " Yank to a
    if a:mode ==# 'visual'
        execute "normal! `<v`>\"ay"
    else
        execute "normal! `[v`]\"ay"
    endif

    " Save in ring
    if len(g:yring) < g:yring_len
        let g:yring = g:yring + [getreg('a')]
    else
        let g:yring[g:yring_idx] = getreg('a')
    endif

    " Restore a
    call setreg('a', l:olda)

    " Save ring to disk
    call writefile(g:yring, l:yring_f, "b")
endfunction

function! PasteRing(mode)
    if len(g:yring) == 0
        return
    endif

    " Save a
    let l:olda = getreg('a')

    let l:cur_len = len(g:yring)

    " Print all regs
    for i in range(l:cur_len)
        echom string(i) . ": " . g:yring[g:yring_idx - i]
    endfor

    let l:choice = input("Which buffer to paste? ")
    call setreg('a', g:yring[g:yring_idx - l:choice])
    if a:mode ==# 'P'
        silent! normal! "aP
    else
        silent! normal! "ap
    endif

    " Restore a
    call setreg('a', l:olda)
endfunction

nnoremap <leader>ry :set opfunc=YankRing<cr>g@
vnoremap <leader>ry <esc>:call YankRing('visual')<cr>
nnoremap <leader>rp :call PasteRing('p')<cr>
nnoremap <leader>rP :call PasteRing('P')<cr>
vnoremap <leader>rp d:call PasteRing('P')<cr>

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

"" Mappings {{{1

" Make j/k navigate visually through wrapped lines
nnoremap j gj
nnoremap k gk

" Quickfix nav
nnoremap <F12> :cn<cr>
nnoremap <S-F12> :cp<cr>

" Convenience
inoremap jk <esc>
inoremap <c-c> <esc>

" Repeat latest [ftFT] in opposite direction
nnoremap ' ,

" Prevent ex-mode
nnoremap Q <nop>

" Follow symbols with Enter
nnoremap <cr> <c-]>
nnoremap <leader><cr> :sp<cr><c-]>
augroup CmdWin
    autocmd!
    autocmd CmdwinEnter * noremap <buffer> <cr> <cr>
augroup END

" Not in quickfix windows though
augroup QuickfixCr
    autocmd!
    autocmd BufReadPost quickfix noremap <buffer> <cr> <cr>
augroup END

" Moving lines or blocks
nnoremap + ddp
nnoremap - ddkP

" Apple specific stuff
if g:os_uname ==# "Darwin"
    noremap! <a-space> <space>
endif

" Joing lines
nnoremap <leader>j J
nnoremap <leader>J xi<cr><esc>

" 'Strong' hjkl
noremap K gg
noremap H ^
noremap J G$
noremap L $

" Clear hlsearch
noremap <leader>n :nohlsearch<cr>

" Message log
nnoremap <leader>m :messages<cr>

" Check highlighting
nnoremap <leader>hi :so $VIMRUNTIME/syntax/hitest.vim<cr>

" Pasting in command mode
cnoremap <c-p> <c-r>"

" Ignore command typos
command! W w
command! Q q
command! Wq wq
command! WQ wq

command! Cd cd %:p:h

" Building
nnoremap <silent> <leader>b :wa<cr>:make<cr>:cw<cr>

" ~/.vimrc editing
function! EditVimrc()
    tabnew
    execute "edit " . g:vimconfig_dir . "/vimrc"
endfunction
nnoremap <leader>ev :call EditVimrc()<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Snippet editing
let g:snippets_dir = g:vimconfig_dir . "/vim/snippets"
function! EditSnippets()
    execute "Explore " . g:snippets_dir
endfunction
nnoremap <leader>es :call EditSnippets()<cr>

" Jumplist navigation
nnoremap <s-tab> <c-o>

"" Tab,  splits and buffers {{{1

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

" Split arrangement
nnoremap <silent> <c-w>h <c-w>H
nnoremap <silent> <c-w>j <c-w>J
nnoremap <silent> <c-w>k <c-w>K
nnoremap <silent> <c-w>l <c-w>L

"" Quickfix and location window toggle {{{1

function! GetBufferList()
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
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

noremap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
noremap <silent> <leader>q :call ToggleList("Quickfix List",
            \'c')<cr>:pclose<cr>

"" Maximize quickfix windows' width {{{1

function! MaxQuickfixWin()
    if &buftype ==# "quickfix"
        execute "normal! \<c-w>J"
    endif
endfunction
augroup MaxQuickfixWinGrp
    autocmd!
    autocmd BufWinEnter * call MaxQuickfixWin()
augroup END

"" Sessions {{{1

let &sessionoptions = "blank,sesdir,buffers,help,tabpages,folds"

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

"" Marks using F1-F12 {{{1

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
