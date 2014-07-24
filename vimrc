"
" Settings
"

syntax on
set hlsearch incsearch
set shiftwidth=4 tabstop=4 expandtab smartindent
silent! set ruler relativenumber number scrolloff=10 backspace=2
set history=1000 wildmenu autowrite
let mapleader = ","
let g:os_uname = substitute(system('uname'), "\n", "", "")

"
" Handy mappings
"

" Dont use arrow keys nor escape
ino <esc> <nop>
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
nno + ddp
nno - ddkP
vno <leader>- <esc>'<V'>xp

" Movement
nno H ^
nno J G$
nno K gg
nno L $
nno <leader>, /

" ~/.vimrc editing
noremap <leader>ev :vsp $MYVIMRC<cr>
noremap <leader>sv :source $MYVIMRC<cr>
if has("gui")
    noremap <leader>eg :vsp $MYGVIMRC<cr>
    noremap <leader>sg :source $MYVIMRC<cr>
endif

" Misc
ino jk <esc>
nno <leader>hi :so $VIMRUNTIME/syntax/hitest.vim<cr>
nno <C-f> <C-]>
no <C-j> <C-w>j
no <C-k> <C-w>k
no <C-h> <C-w>h
no <C-l> <C-w>l
no <C-P> :tabp<CR>
no <C-N> :tabn<CR>
no q <nop>
no <leader>q, q/
no <leader>q: q:
ino <s-tab> <esc><<A
com! W w
com! Q q
com! Wq wq
com! WQ wq
cno sp vsp
cno <c-p> <c-r>"
ino jk <esc>
no <silent> <leader>c :call ToggleComment()<cr>
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
" Highlighting and matching
"

" Adjust highlighting groups
hi Error ctermbg=88 guibg=#880708
augroup HlErrorGrp
    au!
    au ColorScheme * hi Error ctermbg=88 guibg=#880708
augroup END

" Bad coding style
hi link BadStyle Error
augroup HlBadStyleGrp
    au!
    au ColorScheme * hi link BadStyle Error
    au WinEnter,VimEnter,GUIEnter * call HlBadStyle()
augroup END
fun! HlBadStyle()
    call matchadd('BadStyle', '\%80v.\+')
    call matchadd('BadStyle', '\s\+\n')
    call matchadd('BadStyle', '^\n\n')
    if g:os_uname == "Darwin"
        call matchadd('BadStyle', ' ')
    endif
endf

" Highlight cursor after searching
hi RevSearch ctermfg=239 ctermbg=148 guifg=#e7ddd9 guibg=#74499b
au ColorScheme * hi RevSearch ctermfg=239 ctermbg=148 guifg=#e7ddd9 guibg=#74499b
fu! HighlightCursor()
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
no n n:call HighlightCursor()<CR>
no N N:call HighlightCursor()<CR>

" Highlight bigger comment sections
hi HlComment ctermbg=26 ctermfg=255 guibg=#4f76b6 guifg=#f0f0f0
au ColorScheme * hi HlComment ctermbg=26 ctermfg=255 guibg=#4f76b6 guifg=#f0f0f0
augroup HlCommentsGroup
    au!
    au FileType,VimEnter,GUIEnter * call HlComments()
augroup END
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
        let w:hlString = '\(^\s*' . w:cChar . '\).*\n\1.*\n\1.*\n'
        let w:match = matchadd('HlComment', w:hlString)
    elseif exists("w:match")
        echom "Trying to clear HLComments"
        echom w:match
        call matchdelete(w:match)
        unlet w:match
    endif
endf

"
" C/CPP abbreviations
"

fun! CAbbrvs()
    inorea <buffer> iff if ( )<Left><Left>
endf
au FileType c call CAbbrvs()
au FileType cpp call CAbbrvs()

"
" Taglist
"

no <C-g> :TlistToggle<CR>
let Tlist_Use_Right_Window = 1
let Tlist_Use_SingleClick = 1
let Tlist_Inc_Winwidth = 1

"
" Clang_complete
"

if !has("python")
    echo "Python not available. Disabling clang_complete"
    let g:clang_complete_loaded
else

"
" Point to libclang on OS X
"

    if g:os_uname == "Darwin"
        let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib"
    endif
    let g:clang_complete_copen=1 " Quickfixing
    let g:clang_snippets=1
    let g:clang_complete_patterns=1
    let g:clang_jumpto_declaration_key='<C-f>'
endif

"
" Pathogen
"

call pathogen#infect()

"
" Color Theme
"

color codeschool
