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
silent! set ruler relativenumber number scrolloff=10 backspace=2
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
    highlight link MyTagListTagScope Keyword
    highlight link MyTagListTitle StatusLineNC
    highlight link MyTagListFileName HlComment
    highlight link MyTagListTagName Error
endf
" Update HlGroups
call SetHlGroups()
augroup HlGroupsAuGrp
    autocmd!
    autocmd ColorScheme * call SetHlGroups()
augroup END

"
" Handy mappings
"

" Dont use arrow keys nor escape
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
    noremap <leader>sg :source $MYVIMRC<cr>
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
cnoremap sp vsp
cnoremap <c-p> <c-r>"
inoremap jk <esc>
noremap <silent> <leader>c :call ToggleComment()<cr>
fun! ToggleComment()
    if !exists("w:cChar")
        return
    else
        let v:errmsg = ""
        " execute ':s/^\(\s*\)\([^ ' . w:cChar . ']\)/\1' . w:cChar . ' \2/'
        silent! execute ':s/^\(\s*\)\([^ ' . w:cChar . ']\)/\1' . w:cChar . ' \2/'
        if v:errmsg == ""
            return
        endif
        " execute ':s/^\(\s*\)' . w:cChar . '\s*/\1/'
        silent! execute ':s/^\(\s*\)' . w:cChar . '\s*/\1/'
    endif
endf

" Remap apples <a-space> to <space>
if g:os_uname == "Darwin"
    noremap <a-space> <space>
    noremap! <a-space> <space>
endif

"
" Matching
"

" Bad coding style
fun! HlBadStyle()
    call matchadd('BadStyle', '\%80v.\+')
    call matchadd('BadStyle', '\s\+\n')
    call matchadd('BadStyle', '^\n\n')
    if g:os_uname == "Darwin"
        call matchadd('BadStyle', ' ')
    endif
endf

" Match cursor after searching
fu! MatchCursor()
    let c = 0
    while c<2
        let pat = "\\%#" . @/
        let m = matchadd('RevSearch', pat)
        redr!
        sleep 50 m
        call matchdelete(m)
        redr!
        sleep 50 m
        let c+=1
    endwhile
endf
noremap n n:call MatchCursor()<CR>
noremap N N:call MatchCursor()<CR>

" Match bigger comment sections
fun! HlComments()
    let w:doComment=1

    if &filetype == "vim"
        let w:cChar = '\"'
    elseif &filetype == "c" || &filetype == "cpp"
        let w:cChar = '\/\/'
    elseif &filetype == "bash" || &filetype == "sh"
        let w:cChar = '#'
    else
        let w:doComment=0
    endif

    if w:doComment == 1
        let w:hlString = '\(^\s*' . w:cChar . '.*\n\)\{3,}'
        let w:match = matchadd('HlComment', w:hlString)
    elseif exists("w:match")
        call matchdelete(w:match)
        unlet w:match
    endif
endf
augroup HlCommentsGroup
    autocmd!
    au FileType * call HlComments()
augroup END

"
" C/CPP abbreviations
"

fun! CAbbrvs()
    inorea <buffer> iff if ( )<Left><Left>
endf
au FileType c call CAbbrvs()
au FileType cpp call CAbbrvs()

"
" Clang_complete
"

if !has("python")
    echo "Python not available. Disabling clang_complete"
    let g:clang_complete_loaded
else
    " Point to libclang on OS X
    if g:os_uname == "Darwin"
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
