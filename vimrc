"
" Detect os
"

let g:os_uname = substitute(system('uname'), "\n", "", "")

"
" Settings
"

syntax on
set hlsearch incsearch
set shiftwidth=4 tabstop=4 expandtab smartindent
silent! set ruler relativenumber number scrolloff=5 backspace=2
set history=1000 wildmenu autowrite
let mapleader = ","

"
" My highlighting groups
"

function! SetHlGroups()
    " Errors
    highlight Error ctermbg=88 guibg=#880708
    " Bad Style
    highlight link BadStyle Error
    " Highlight for current search result
    highlight RevSearch ctermfg=239 ctermbg=148 guifg=#e7ddd9 guibg=#74499b
    " Big comment sections
    highlight HlComment ctermbg=26 ctermfg=255 guibg=#4f76b6 guifg=#f0f0f0
    " Taglist
    highlight link MyTagListTagScope Keyword | highlight link MyTagListTitle StatusLineNC | highlight link MyTagListFileName HlComment
    highlight link MyTagListTagName Error
    " Misc
    highlight clear CursorLineNr | highlight link CursorLineNr HlComment
    highlight clear CursorLine | highlight link CursorLine Search
    highlight clear CursorColumn | highlight link CursorColumn Search
endf
" Update HlGroups
call SetHlGroups()
augroup HlGroupsAuGrp
    autocmd!
    autocmd ColorScheme * call SetHlGroups()
augroup END

"
" Functions
"

" Search and Replace word under cursor
function! SearchAndReplace(op)
    " Highlight the words
        if a:op ==# "iw"
            silent! execute "normal! viwy"
        elseif a:op ==# "iW"
            silent! execute "normal! viWy"
        else
            echom "Invalid argument given to SearchAndReplace()!"
            return
        endif
    let l:wordToReplace = substitute(@", "\n", "", "")
    let l:wordToReplace = escape(l:wordToReplace, '"\')
    let l:match = matchadd('Error', l:wordToReplace)
    redraw!
    call matchdelete(l:match)

    " Get string with which to substitute
    let l:replaceString = input("Replace \"" . l:wordToReplace . "\" with: ")

    " Perform substitution
    execute "%s/" . l:wordToReplace . "/" . l:replaceString . "/g"
endf

"
" Handy mappings and abbreviations
"

" Dont use arrow keys nor escape
nnoremap <leader>riw :call SearchAndReplace("iw")<cr>
nnoremap <leader>riW :call SearchAndReplace("iW")<cr>
inoremap <esc> <nop>
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
noremap / <Nop>

" Moving lines
nnoremap + ddp
nnoremap - ddkP
vno <leader>- <esc>'<V'>xp

" Movement
nnoremap H ^
nnoremap J G$
nnoremap K gg
nnoremap L $
nnoremap <leader>, /

" ~/.vimrc editing
noremap <leader>ev :vsp $MYVIMRC<cr>
noremap <leader>sv :source $MYVIMRC<cr>
if has("gui")
    noremap <leader>eg :vsp $MYGVIMRC<cr>
    noremap <leader>sg :source $MYGVIMRC<cr>
endif

" Misc
inoremap jk <esc>
nnoremap <leader>hi :so $VIMRUNTIME/syntax/hitest.vim<cr>
nnoremap <C-f> <C-]>
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
noremap <C-P> :tabp<CR>
noremap <C-N> :tabn<CR>
noremap q <nop>
noremap <leader>q, q/
noremap <leader>q: q:
inoremap <s-tab> <esc><<A
command! W w
command! Q q
command! Wq wq
command! WQ wq
cnoreabbrev sp vsp
cnoremap <c-p> <c-r>"
inoremap jk <esc>
noremap <silent> <leader>c :call ToggleComment()<cr>
function! ToggleComment()
    if !exists("b:cChar")
        return
    else
        let v:errmsg = ""
        silent! execute ':s/^\(\s*\)\([^ ' . b:cChar . ']\)/' . b:cChar .
            \ ' \1\2/'
        if v:errmsg == ""
            return
        endif
        silent! execute ':s/^\(\s*\)' . b:cChar . ' /\1/'
    endif
endf

" Remap apples <a-space> to <space>
if g:os_uname ==# "Darwin"
    noremap <a-space> <space>
    noremap! <a-space> <space>
endif

"
" Matching
"

" Bad coding style
function! HlBadStyle()
    call matchadd('BadStyle', '\%80v.\+')
    call matchadd('BadStyle', '\s\+\n')
    call matchadd('BadStyle', '^\n\n')
    if g:os_uname ==# "Darwin"
        call matchadd('BadStyle', ' ')
    endif
endf
call HlBadStyle()
augroup WinEnterGrp
    autocmd!
    autocmd WinEnter * call HlBadStyle()
augroup END

" Match cursor after searching
fu! HlCursor()
    let c = 0
    while c<2
        set cursorcolumn cursorline
        redraw! | sleep 20 m
        set nocursorcolumn nocursorline
        redraw! | sleep 20 m | let c = c+1
    endwhile
endf
augroup HlCursorGrp
    autocmd!
    autocmd BufEnter * call HlCursor()
augroup END
noremap n n:call HlCursor()<CR>
noremap N N:call HlCursor()<CR>

" Match bigger comment sections
function! HlComments()
    let b:doComment=1

    if &filetype ==# "vim"
        let b:cChar = '\"'
    elseif &filetype ==# "c" || &filetype ==# "cpp"
        let b:cChar = '\/\/'
    elseif &filetype ==# "bash" || &filetype ==# "sh"
        let b:cChar = '#'
    else
        let b:doComment=0
    endif

    if b:doComment == 1
        let b:hlString = '\(^\s*' . b:cChar . '.*\n\)\{3,}'
        let b:match = matchadd('HlComment', b:hlString)
    elseif exists("b:match")
        call matchdelete(b:match)
        unlet b:match
    endif
endf
augroup HlCommentsGroup
    autocmd!
    au FileType * call HlComments()
augroup END

"
" C/CPP abbreviations
"

function! CAbbrvs()
    inorea <buffer> iff if ( )<Left><Left>
endf
augroup FileTypeGrp
    autocmd!
    autocmd FileType c call CAbbrvs()
    autocmd FileType cpp call CAbbrvs()
augroup END

"
" Clang_complete
"

if !has("python")
    echo "Python not available. Disabling clang_complete"
    let g:clang_complete_loaded
else
    " Point to libclang on OS X
    if g:os_uname ==# "Darwin"
        let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib"
    endif
    let g:clang_complete_copen=1 " Quickfixing
    let g:clang_snippets=1
    let g:clang_complete_patterns=1
    let g:clang_jumpto_declaration_key='<C-f>'
endif

"
" Taglist
"

noremap <C-g> :TlistToggle<CR>
let Tlist_Use_Right_Window = 1
let Tlist_Use_SingleClick = 1
let Tlist_Inc_Winwidth = 1
let Tlist_Max_Tag_Length = 100
let Tlist_Use_SingleClick = 1

"
" Pathogen
"

call pathogen#infect()

"
" Color Theme
"

color codeschool
