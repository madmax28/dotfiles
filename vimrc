"" Init {{{1

let g:os_uname = substitute(system('uname'), "\n", "", "")

"" Settings {{{1


syntax on
set hlsearch incsearch shiftwidth=4 softtabstop=4 expandtab smartindent ruler
    \ number scrolloff=5 backspace=2 nowrap history=1000 wildmenu
    \ completeopt=menuone,longest,preview wildmode=list:longest,full
    \ noswapfile nocompatible foldmethod=marker relativenumber hidden

" Use the mouse even without GUI
set mouse=a

" Leader key
let mapleader = ","

" Jump to existent window when spllitting new buffers and jumping from
" quicklist window
set switchbuf=usetab,split

" Use undofiles
set undodir=~/.vim/undos undofile

" Gui stuff
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


"" Syntax and colors {{{1

" Use codeschool
colorscheme codeschool

highlight Error ctermbg=88 guibg=#880708
highlight RevSearch ctermfg=239 ctermbg=148 guifg=#e7ddd9 guibg=#74499b
highlight HighlightComment ctermbg=26 ctermfg=255 guibg=#4f76b6 guifg=#f0f0f0
highlight clear FoldColumn | highlight link FoldColumn Statusline
highlight clear CursorLineNr | highlight link CursorLineNr HighlightComment
highlight clear CursorLine | highlight link CursorLine HighlightComment
highlight clear CursorColumn | highlight link CursorColumn HighlightComment
highlight clear Todo | highlight Todo ctermbg=11 ctermfg=0 guibg=#ffff00
    \ guifg=#000000
highlight clear MatchParen | highlight link MatchParen Todo
highlight clear TabLineSel | highlight link TabLineSel HighlightComment
highlight clear TabLineFill | highlight link TabLineFill TabLine
highlight clear VertSplit | highlight link VertSplit LineNr

"" Cursor highlighting {{{1

" Make the cursor easily visible
function! HighlightCursor(...)
    " Do 3 blinks
    let c = 0
    while c<3
        " What to highlight?
        if a:0 > 0
            if a:1 ==# "Match"
                let l:pat = '\%#' . @/
            else
                echom "Invalid argument given to HighlightCursor(...)!"
                return
            endif
        else
            let l:pat = '\v.{0,3}%#.{0,3}'
        endif

        " Let it blink for 50ms
        let l:match = matchadd('Todo', l:pat)
        redraw | sleep 50 m
        call matchdelete(l:match)
        redraw | sleep 50 m

        let c = c+1
    endwhile

    " If we highlighted a match, also activate visual mode
"    if exists("a:2")
"        if a:2 ==# "Visual"
            " Select the match visually
"            normal! gno
"        endif
"    endif
endfunction

" Things to do when a buffer is entered
function! OnBufEnter()
    if &filetype !=# "help" || &filetype !=# "taglist"
        call HighlightCursor()
    endif
endfunction

" Make cursor easier visible after switching the buffer and jumping to the next
" search result
nnoremap n n:call HighlightCursor("Match")<cr>
nnoremap N N:call HighlightCursor("Match")<cr>
vnoremap n <esc>n:call HighlightCursor("Match")<cr>
vnoremap N <esc>N:call HighlightCursor("Match")<cr>

"" Un-/Commenting {{{1

" Things to do when a filetype is detected
function! OnFileType()
    " Decide which character starts a comment
    if &filetype ==# "vim"
        let b:cString = '"'
    elseif &filetype ==# "c" || &filetype ==# "cpp"
        let b:cString = '\/\/'
    elseif &filetype ==# "bash" || &filetype ==# "sh" || &filetype ==# "python" || &filetype ==# "conf"
        let b:cString = '#'
    elseif &filetype ==# "xml"
        let b:cString = '<!--'
        let b:cEndString = '-->'
    endif
endfunction

" (Un)commenting lines
function! ToggleComment()
    if !exists("b:cString")
        return
    else
        let v:errmsg = ""
        " Comment
        silent! execute ':s/\v^(\s*)((\V' . b:cString . '\v)|\s)@!/' . b:cString .
            \ ' \1\2'
        if v:errmsg == ""
            " Add closing comment string at end of line if needed
            if exists("b:cEndString")
                silent! execute ':s/$/ ' . b:cEndString . '/'
            endif
            return
        endif

        " Uncomment
        silent! execute ':s/\v^(\s*)(\V' . b:cString . '\v)\s(\s*)/\1\3/'
        if exists("b:cEndString")
            silent! execute ':s/ ' . b:cEndString . '$//'
        endif
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
    call matchadd('BadStyle', '\%80v.')
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

"" Search and Replace {{{1

function! SearchAndReplace(mode, ...) " TODO: make it accept a range
    " In normal mode
    if a:mode ==# "normal"
        if a:0 > 0
            if a:1 ==# "iw"
                " S&R word under cursor
                silent! execute "normal! viwy"
            elseif a:1 ==# "iW"
                " S&R WORD under cursor
                silent! execute "normal! viWy"
            endif
        else
            " No argument given. Ask for what to replace
            let l:word = input("What to replace? ")
        endif
    endif

    " Escape backslashes
    let l:word = escape(@", '\')

    " If the string is a whole keyword, only replace if
    " not preceded/followed by keyword character
    echo l:word
    if match(l:word, '^\k\+$') > -1
        let l:pattern = '\<' . l:word . '\>'
        let l:isKeyword = 1
    else
        let l:isKeyword = 0
        let l:pattern = l:word
    endif

    " Highlight all words
    let l:match = matchadd('Error', l:word)
    redraw!
    call matchdelete(l:match)

    " Get string with which to substitute
    let l:replaceString = input("Replace \"" . l:word . "\" with: ")

    " Perform substitution
    execute '%s/\V' . l:pattern . "/" . l:replaceString . "/g"

    " Set last search to inserted string
    if l:isKeyword
        let @/ = '\<' . l:replaceString . '\>'
    else
        let @/ = l:replaceString
    endif
    set hlsearch
endfunction

" Search and Replace stuff TODO: Think about when to use \< and \>
vnoremap <leader>r y:call SearchAndReplace("visual")<cr>
nnoremap <leader>rr v:call SearchAndReplace("normal")<cr>
nnoremap <leader>riw :call SearchAndReplace("normal", "iw")<cr>
nnoremap <leader>riW :call SearchAndReplace("normal", "iW")<cr>


"" Yank and paste to clipboard {{{1

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

" Follow symbols with Enter
nnoremap <cr> <c-]>
" Not in quickfix windows though
augroup QuickfixCr
    autocmd!
    autocmd BufReadPost quickfix noremap <buffer> <cr> <cr>
augroup END

" Moving lines or blocks
nnoremap + ddp
nnoremap - ddkP

" Quickfix
nnoremap <leader>q :copen<cr>

" Apple specific stuff
if g:os_uname ==# "Darwin"
    noremap! <a-space> <space>
endif

" Joing lines
nnoremap <leader>j J
nnoremap <leader>J kJ

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
inoremap jk <esc>

" Pasting in command mode
cnoremap <c-p> <c-r>"

" Ignore command typos
command! W w
command! Q q
command! Wq wq
command! WQ wq

" Building
nnoremap <silent> <leader>b :wa<cr>:make<cr>:cw<cr>

" ~/.vimrc editing
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Jumplist navigation
nnoremap <s-tab> <c-o>

"" Tabs and splits {{{1

" More natural split directions
set splitright splitbelow

" Split navigation
inoremap <silent> <c-j> <esc><c-w>j:call HighlightCursor()<cr>
inoremap <silent> <c-k> <esc><c-w>k:call HighlightCursor()<cr>
inoremap <silent> <c-h> <esc><c-w>h:call HighlightCursor()<cr>
inoremap <silent> <c-l> <esc><c-w>l:call HighlightCursor()<cr>
nnoremap <silent> <c-j> <c-w>j:call HighlightCursor()<cr>
nnoremap <silent> <c-k> <c-w>k:call HighlightCursor()<cr>
nnoremap <silent> <c-h> <c-w>h:call HighlightCursor()<cr>
nnoremap <silent> <c-l> <c-w>l:call HighlightCursor()<cr>
" Tab navigation
nnoremap <silent> <c-p> :tabp<cr>:call HighlightCursor()<cr>
nnoremap <silent> <c-n> :tabn<cr>:call HighlightCursor()<cr>

" Maximize quickfix windows' width
function! MaxQuickfixWin()
    if &buftype ==# "quickfix"
        execute "normal! \<c-w>J"
    endif
endfunction
augroup MaxQuickfixWinGrp
    autocmd!
    autocmd BufWinEnter * call MaxQuickfixWin()
augroup END

"" Cscope stuff {{{1

" Add any cscope databases present in current working directory
function! AddCscopeDb()
    if filereadable(".myscope/cscope.out")
        echom "Added cscope db"
        silent! cs add .myscope/cscope.out
    endif
endfunction

" Add any cscope databases present in current working directory
" If none are present, call AirTies' newscript.sh to generate one and add it
function! AddCreateCscopeDb()
    if !filereadable(".myscope/cscope.out")
        echom "Building Cscope db"
        silent! execute "!~/.vim/bin/myscope.sh " . getcwd()
    endif

    if filereadable(".myscope/cscope.out")
        call AddCscopeDb()
    else
        echom "Couldn't create Cscope db"
    endif
endfunction

if has("cscope")
    " Use a quickfix window
    if has("quickfix")
        set cscopequickfix=s-,c-,d-,i-,t-,e-
    endif

    " Use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag
    " Check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0
    " Show msg when any other cscope db added
    set cscopeverbose

    " Automatically add Cscope db
    augroup AddCreateCscopeDb
        autocmd!
        autocmd BufCreate * call AddCscopeDb()
    augroup END

    " Mappings
    nnoremap <silent> <leader>fa :call AddCreateCscopeDb()<CR>

    nnoremap <leader>fs :cs find s <C-R>=expand("<cword>")<cr><cr><c-o>:cw<cr>
    nnoremap <leader>fg :cs find g <C-R>=expand("<cword>")<cr><cr><c-o>:cw<cr>
    nnoremap <leader>fc :cs find c <C-R>=expand("<cword>")<cr><cr><c-o>:cw<cr>
    nnoremap <leader>ft :cs find t <C-R>=expand("<cword>")<cr><cr><c-o>:cw<cr>
    nnoremap <leader>fe :cs find e <C-R>=expand("<cword>")<cr><cr><c-o>:cw<cr>
    nnoremap <leader>ff :cs find f <C-R>=expand("<cfile>")<cr><cr><c-o>:cw<cr>
    nnoremap <leader>fi :cs find i ^<C-R>=expand("<cfile>")<cr>$<cr><c-o>:cw<cr>
    nnoremap <leader>fd :cs find d <C-R>=expand("<cword>")<cr><cr><c-o>:cw<cr>

    nnoremap <leader>Fs :vert scs find s <C-R>=expand("<cword>")<cr><cr>
    nnoremap <leader>Fg :vert scs find g <C-R>=expand("<cword>")<cr><cr>
    nnoremap <leader>Fc :vert scs find c <C-R>=expand("<cword>")<cr><cr>
    nnoremap <leader>Ft :vert scs find t <C-R>=expand("<cword>")<cr><cr>
    nnoremap <leader>Fe :vert scs find e <C-R>=expand("<cword>")<cr><cr>
    nnoremap <leader>Ff :vert scs find f <C-R>=expand("<cfile>")<cr><cr>
    nnoremap <leader>Fi :vert scs find i ^<C-R>=expand("<cfile>")<cr>$<cr>
    nnoremap <leader>Fd :vert scs find d <C-R>=expand("<cword>")<cr><cr>
endif

"" Plugins {{{1

" Vundle
filetype off
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/plugins')

Plugin 'gmarik/Vundle.vim'
Plugin 'snipMate'
Plugin 'taglist.vim'

" Add Plugins here
call vundle#end()
filetype plugin indent on

