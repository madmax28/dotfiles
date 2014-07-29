""
"" Detect os
""

let g:os_uname = substitute(system('uname'), "\n", "", "")
call clearmatches()

""
"" Functions
""

" Things to do when a buffer is entered
" function! OnBufEnter()
"     if &filetype !=# "help" || &filetype !=# "taglist"
"         call HighlightCursor()
"     endif
" endfunction

" Things to do when a filetype is detected
function! OnFileType()
    " Do nothing for help files and taglist
    if &filetype !=# "help" || &filetype !=# "taglist"
        " Which characters start a comment?
        call DetectCommentCharacter()
        " Highlight special comments, e.g. '///' for c or '""' for vim
        call HighlightComments()
        " Highlight bad coding style
        call HighlightBadStyle()
    endif

    " In Taglist, highlight the cursorline
    if &filetype ==# "taglist"
        set cursorline
    endif

    " For python
    if &filetype ==# "python"
        " Add our dictionary
        if exists("g:pydiction_location")
            execute "setlocal dictionary=" . g:pydiction_location
            set complete+=k complete-=t
        endif
        " Add a mapping to open pydoc
        command! -nargs=1 Pydoc execute "normal! :vnew\<cr>:read !pydoc <args>\<cr>gg"
        nnoremap <buffer> <silent> <leader>K yiw:Pydoc <c-r>"<cr>
        nnoremap <buffer> <leader>k :Pydoc 
    endif

    " Filetype mappings
    if &filetype ==# "bash" || &filetype ==# "sh"
        nnoremap <buffer> <leader>x :w<cr>:!bash %<cr>
    elseif &filetype ==# "python"
        nnoremap <buffer> <leader>x :w<cr>:!python %<cr>
    endif
endfunction

" Detect which character starts comments
function! DetectCommentCharacter()
    " Decide which character starts a comment
    if &filetype ==# "vim"
        let b:cString = '"'
    elseif &filetype ==# "c" || &filetype ==# "cpp"
        let b:cString = '\/\/'
    elseif &filetype ==# "bash" || &filetype ==# "sh" || &filetype ==# "python"
        let b:cString = '#'
    endif
endfunction

" Match bigger comment sections
function! HighlightComments()
    " Are they highlighted already?
    if !exists("b:cString")
        return
    endif

    " Get last character of comment string
    let b:cChar = substitute( b:cString, '\v^.*(.$)', '\1', '')

    " Highlight the big comments
    let b:hlString = '^\s*' . b:cString . b:cChar . '.*\n'
    let b:match = matchadd('HighlightComment', b:hlString)
endfunction

" Match cursor after searching
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
    if exists("a:2")
        if a:2 ==# "Visual"
            " Select the match visually
            normal! gno
        endif
    endif
endfunction

" Search and Replace word under cursor
function! SearchAndReplace(...) " TODO: make it accept a range
    " Decide what to replace
    if a:0 > 0
        if a:1 ==# "iw"
            " S&R word under cursor
            silent! execute "normal! viwy"
        elseif a:1 ==# "iW"

            " S&R Word under cursor
            silent! execute "normal! viWy"
        elseif a:1 ==# "ii"
            silent! execute 'normal! ?\j\@!' . "\<cr>" . 'lv/\k\@!' . "\<cr>hy"
        endif

        " Replace literal by actualy newlines and escape backslashes
        let l:wordToReplace = substitute(@", "\n", "", "")
        let l:wordToReplace = escape(l:wordToReplace, '"\')
    else
        " No argument given. Ask for what to replace
        let l:wordToReplace = input("What to replace? ")
    endif

    " If the string starts or ends with a keyword character, only replace if
    " not besides another keyword character
    echom l:wordToReplace
    if match(l:wordToReplace, '^\k') > -1
        echom "Begins with \k"
        let l:wordToReplace = '\<' . l:wordToReplace
    endif
    echom l:wordToReplace
    if match(l:wordToReplace, '\k$') > -1
        echom "Ends with \k"
        let l:wordToReplace = l:wordToReplace . '\>'
    endif

    " Highlight all words
    let l:match = matchadd('Error', l:wordToReplace)
    redraw!
    call matchdelete(l:match)

    " Get string with which to substitute
    let l:replaceString = input("Replace \"" . l:wordToReplace . "\" with: ")

    " Perform substitution
    execute "%s/" . l:wordToReplace . "/" . l:replaceString . "/g"
endfunction

" Moving lines TODO: This is inefficient and does not accept a [count]
function! DragBlock(dir)
    " Delete and put
    silent! execute "normal! :'<,'>delete\<cr>"
    if a:dir ==# "down"
        silent! normal! p
    elseif a:dir ==# "up"
        silent! normal! kP
    else
        echom "DragBlock(): Invalid argument"
    endif

    " Get yanked text; Escape \ since we use \V and ? for backwards search
    " Substitute actual newlines with symbolic newlines
    let l:toFind = '\V' . substitute(escape(@", '\?'), '\n', '\\n', 'g')
    let l:cmd = "normal! ?" . l:toFind . "\<cr>//\<cr>gn"
    silent! execute l:cmd
endfunction

" (Un)commenting lines
function! ToggleComment()
    if !exists("b:cString")
        return
    else
        let v:errmsg = ""
        " Comment
        silent! execute ':s/^\(\s*\)\([^ ' . b:cString . ']\)/' . b:cString .
            \ '\1\2/'
        if v:errmsg == ""
            return
        endif
        " Uncomment
      silent! execute ':s/^\(\s*\)' . b:cString . '\1/'
    endif
endfunction

" Highlight bad coding style
function! HighlightBadStyle()
    if &filetype ==# "help" || &filetype ==# "taglist"
        return
    endif

    " Character on 81th column
    call matchadd('BadStyle', '\%81v.')
    " Trailing whitespaces
    call matchadd('BadStyle', '\s\+\n')
    " More than one newline in a row
    call matchadd('BadStyle', '^\n\n\+')
    " Non-breaking spaces
    call matchadd('BadStyle', ' ')
endfunction

" Set my highlighting groups
function! SetHighlightGroups()
    " Errors
    highlight Error ctermbg=88 guibg=#880708
    " Bad Style
    highlight link BadStyle Error
    " Highlight for current search result
    highlight RevSearch ctermfg=239 ctermbg=148 guifg=#e7ddd9 guibg=#74499b
    " Big comment sections
    highlight HighlightComment ctermbg=26 ctermfg=255 guibg=#4f76b6 guifg=#f0f0f0
    " Taglist
    highlight link MyTagListTagScope Keyword | highlight link MyTagListTitle
        \ StatusLineNC | highlight link MyTagListFileName HighlightComment
    highlight link MyTagListTagName Error
    " Misc
    highlight clear CursorLineNr | highlight link CursorLineNr HighlightComment
    highlight clear CursorLine | highlight link CursorLine HighlightComment
    highlight clear CursorColumn | highlight link CursorColumn HighlightComment
    highlight clear Todo | highlight Todo ctermbg=11 ctermfg=0 guibg=#ffff00
        \ guifg=#000000
endfunction

""
"" Settings
""

syntax on
filetype plugin on
set hlsearch incsearch shiftwidth=4 tabstop=4 expandtab smartindent ruler
    \ relativenumber number scrolloff=5 backspace=2 nowrap history=1000 wildmenu
    \ autowrite completeopt=menuone,preview wildmode=list:longest,full
let mapleader = ","

" Update highlighting groups
call SetHighlightGroups()
augroup HighlightGroupsAuGrp
    autocmd!
    autocmd ColorScheme * call SetHighlightGroups()
augroup END

""
"" Handy mappings and abbreviations
""

" Search and Replace stuff TODO: Think about when to use \< and \>
nnoremap <leader>R :call SearchAndReplace()<cr>
nnoremap <leader>rr v:call SearchAndReplace()<cr>
nnoremap <leader>riw :call SearchAndReplace("iw")<cr>
nnoremap <leader>riW :call SearchAndReplace("iW")<cr>
nnoremap <leader>rii :call SearchAndReplace("ii")<cr>

" Force yourself to not use some keys
inoremap <esc> <esc><esc>i
nnoremap <Up> <esc>
nnoremap <Down> <esc>
nnoremap <Left> <esc>
nnoremap <Right> <esc>
inoremap <Up> <esc><esc>i
inoremap <Down> <esc><esc>i
inoremap <Left> <esc><esc>i
inoremap <Right> <esc><esc>i
nnoremap / <esc>

" Moving lines or blocks
vnoremap <silent> + <esc>:call DragBlock("down")<cr>
vnoremap <silent> - <esc>:call DragBlock("up")<cr>
nnoremap + ddp
nnoremap - ddkP

" ~/.vimrc editing
noremap <leader>ev :sp $MYVIMRC<cr>
noremap <leader>sv :source $MYVIMRC<cr>
if has("gui")
    noremap <leader>eg :sp $MYGVIMRC<cr>
    noremap <leader>sg :source $MYGVIMRC<cr>
endif

" Buffer resizing
noremap <leader>iw :vertical :resize +10<cr>
noremap <leader>ih :resize +10<cr>
noremap <leader>dw :vertical :resize -10<cr>
noremap <leader>dh :resize -10<cr>

" Helpfile, split and tab navigation
nnoremap <c-f> <c-]>
" Open last closed buffer
nnoremap <leader>el :sp<bar>:b#<cr>
" Move active buffer to new tab
nnoremap <leader>t <c-W>T
inoremap <silent> <c-j> <esc><c-w>j:call HighlightCursor()<cr>
inoremap <silent> <c-k> <esc><c-w>k:call HighlightCursor()<cr>
inoremap <silent> <c-h> <esc><c-w>h:call HighlightCursor()<cr>
inoremap <silent> <c-l> <esc><c-w>l:call HighlightCursor()<cr>
nnoremap <silent> <c-j> <c-w>j:call HighlightCursor()<cr>
nnoremap <silent> <c-k> <c-w>k:call HighlightCursor()<cr>
nnoremap <silent> <c-h> <c-w>h:call HighlightCursor()<cr>
nnoremap <silent> <c-l> <c-w>l:call HighlightCursor()<cr>
nnoremap <silent> <c-p> :tabp<cr>:call HighlightCursor()<cr>
nnoremap <silent> <c-p> :tabn<cr>:call HighlightCursor()<cr>

" Apple specific stuff
if g:os_uname ==# "Darwin"
    " Remap <a-space> to <space>
    noremap <a-space> <space>
    noremap! <a-space> <space>
endif

" Make cursor easier visible after switching the buffer and jumping to the next
" search result
nnoremap n n:call HighlightCursor("Match", "Visual")<cr>
nnoremap N N:call HighlightCursor("Match", "Visual")<cr>
vnoremap n <esc>n:call HighlightCursor("Match", "Visual")<cr>
vnoremap N <esc>N:call HighlightCursor("Match", "Visual")<cr>

" Misc
nnoremap <leader>x :echom "Don't know how to execute filetype '" . &filetype
    \ . "'"<cr>
nnoremap <leader>j J
nnoremap <leader>J kJ
noremap <silent> <leader>c :call ToggleComment()<cr>
noremap <leader>n :nohlsearch<cr>
nnoremap <leader>, /
nnoremap <leader>m :messages<cr>
nnoremap <leader>hi :so $VIMRUNTIME/syntax/hitest.vim<cr>
nnoremap K gg
nnoremap H ^
nnoremap J G$
nnoremap L $
inoremap jk <esc>
cnoremap <c-p> <c-r>"
command! W w
command! Q q
command! Wq wq
command! WQ wq

""
"" Matching
""

call OnFileType() " To immediately apply changes when sourced
augroup FileTypeAuGrp
    autocmd!
    au FileType * call OnFileType()
augroup END

""
"" Plugins
""

" Clang_complete
if !has("python")
    echo "Python not available. Disabling clang_complete"
    let g:clang_complete_loaded
else
    " Point to libclang on OS X
    if g:os_uname ==# "Darwin"
        let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/To
            \olchains/XcodeDefault.xctoolchain/usr/lib"
    endif
    let g:clang_complete_copen=1 " Quickfixing
    let g:clang_snippets=1
    let g:clang_complete_patterns=1
    let g:clang_jumpto_declaration_in_preview_key='<c-f>'
    let g:clang_jumpto_declaration_key='<c-F>'
endif

" Taglist
noremap <c-g> :TlistToggle<cr>
let Tlist_Use_Right_Window = 1
let Tlist_Use_SingleClick = 1
let Tlist_Inc_Winwidth = 1
let Tlist_Max_Tag_Length = 100
let Tlist_Use_SingleClick = 1

" Pathogen
call pathogen#infect()

""
"" Color Theme
""

color codeschool
