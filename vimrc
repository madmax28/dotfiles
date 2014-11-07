""
"" Init
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
        " Highlight special comments, e.g. '///' for c or '""' for vim
        call HighlightComments()
        " Highlight bad coding style
        call HighlightBadStyle()
    endif

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

    " In Taglist, highlight the cursorline
    if &filetype ==# "taglist"
        set cursorline
    endif

    " Python
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
        nnoremap <buffer> <leader>x :w<cr>:!python %<cr>
    endif

    " Bash
    if &filetype ==# "bash" || &filetype ==# "sh"
        nnoremap <buffer> <leader>x :w<cr>:!bash %<cr>
    endif

    " C / CPP
    if &filetype ==# "c" || &filetype ==# "cpp"
        set iskeyword=a-z,A-Z,48-57,_
        nnoremap <buffer> <leader>b :wa<cr>:!make -j8<cr>
    endif
endfunction

" Match bigger comment sections
function! HighlightComments()
    " Are they highlighted already?
    if !exists("b:cString")
        return
    endif

    " Get last character of comment string
    let b:cChar = substitute( b:cString, '\v^.*(.)$', '\1', '')

    " Highlight the big comments
    let b:hlString = '^\s*' . b:cString . b:cChar . '.*\n'
    let b:match = matchadd('HighlightComment', b:hlString)
endfunction

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

" Search and Replace word under cursor
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

" Highlight bad coding style
function! HighlightBadStyle()
    " Character on 80th column
    call matchadd('BadStyle', '\%80v.')
    " Trailing whitespaces
"     call matchadd('BadStyle', '\s\+\n')
    " More than one newline in a row
"     call matchadd('BadStyle', '^\n\n\+')
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
    " Matchin parenthesis
    highlight MatchParen cterm=underline ctermfg=255 ctermbg=26
        \ gui=underline guibg=#4f76b6 guifg=#f0f0f0
    " Taglist
    highlight link MyTagListTagScope Keyword | highlight link MyTagListTitle
        \ StatusLineNC | highlight link MyTagListFileName HighlightComment
    highlight link MyTagListTagName Error
    " Misc
    highlight clear FoldColumn | highlight link FoldColumn Statusline
    highlight clear CursorLineNr | highlight link CursorLineNr HighlightComment
    highlight clear CursorLine | highlight link CursorLine HighlightComment
    highlight clear CursorColumn | highlight link CursorColumn HighlightComment
    highlight clear Todo | highlight Todo ctermbg=11 ctermfg=0 guibg=#ffff00
        \ guifg=#000000
    highlight clear TabLineSel | highlight link TabLineSel HighlightComment
    highlight clear TabLineFill | highlight link TabLineFill TabLine
endfunction

""
"" Settings
""

syntax on
filetype plugin on
set hlsearch incsearch shiftwidth=4 tabstop=4 expandtab smartindent ruler
    \ number scrolloff=5 backspace=2 nowrap history=1000 wildmenu
    \ autowrite completeopt=menuone,preview wildmode=list:longest,full
    \ noswapfile
if v:version >= 703
    set relativenumber
endif
let mapleader = ","

" Update highlighting groups
call SetHighlightGroups()
augroup HighlightGroupsAuGrp
    autocmd!
    autocmd ColorScheme * call SetHighlightGroups()
augroup END

augroup FileTypeGrp
    autocmd!
    autocmd BufEnter *vim set filetype=vim
augroup END

""
"" Handy mappings and abbreviations
""

" Search and Replace stuff TODO: Think about when to use \< and \>
vnoremap <leader>r y:call SearchAndReplace("visual")<cr>
nnoremap <leader>rr v:call SearchAndReplace("normal")<cr>
nnoremap <leader>riw :call SearchAndReplace("normal", "iw")<cr>
nnoremap <leader>riW :call SearchAndReplace("normal", "iW")<cr>

" Force yourself to not use some keys
if g:os_uname ==# "Darwin"
    nnoremap OA <esc>
    inoremap OA <esc><esc>li
    nnoremap OB <esc>
    inoremap OB <esc><esc>li
    nnoremap OD <esc>
    inoremap OD <esc><esc>li
    nnoremap OC <esc>
    inoremap OC <esc><esc>li
else
    nnoremap <Up> <esc>
    nnoremap <Down> <esc>
    nnoremap <Left> <esc>
    nnoremap <Right> <esc>
    inoremap <Up> <esc><esc>li
    inoremap <Down> <esc><esc>li
    inoremap <Left> <esc><esc>li
    inoremap <Right> <esc><esc>li
endif

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
noremap <leader><right> :vertical :resize +5<cr>
noremap <leader><up> :resize +5<cr>
noremap <leader><left> :vertical :resize -5<cr>
noremap <leader><down> :resize -5<cr>
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
nnoremap <silent> <c-n> :tabn<cr>:call HighlightCursor()<cr>

" Apple specific stuff
if g:os_uname ==# "Darwin"
    " Remap <a-space> to <space>
    noremap <a-space> <space>
    noremap! <a-space> <space>
endif

" Make cursor easier visible after switching the buffer and jumping to the next
" search result
nnoremap n n:call HighlightCursor("Match")<cr>
nnoremap N N:call HighlightCursor("Match")<cr>
vnoremap n <esc>n:call HighlightCursor("Match")<cr>
vnoremap N <esc>N:call HighlightCursor("Match")<cr>

" Misc
nnoremap <leader>x :echom "Don't know how to execute filetype '" . &filetype
    \ . "'"<cr>
nnoremap <leader>j J
nnoremap <leader>J kJ
noremap <silent> <leader>c :call ToggleComment()<cr>
noremap <leader>n :nohlsearch<cr>
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
"" Cscope stuff
""

" Add any cscope databases present in current working directory
function! AddCscopeDb()
    if filereadable("cscope.out")
        silent! cs add cscope.out  
    endif
endfunction

" Add any cscope databases present in current working directory
" If none are present, call AirTies' newscript.sh to generate one and add it
function! AddCreateCscopeDb()
    if !filereadable("cscope.out")
        echom "Building Cscope db"
        silent! execute "!newscope.sh " . getcwd()
    endif

    if filereadable("cscope.out")
        call AddCscopeDb()
    else
        echoe "Couldn't create Cscope db"
    endif
endfunction

if has("cscope")
    " Use a quickfix window
    if has("quickfix")
"         set cscopequickfix=s-,c-,d-,i-,t-,e-
    endif

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0
 
    " show msg when any other cscope db added
    set cscopeverbose

    " When present, automatically add Cscope db
    augroup AddCreateCscopeDb
        autocmd!
        autocmd BufCreate * call AddCscopeDb()
    augroup END

    " Mappings
    nnoremap <leader>fa :call AddCreateCscopeDb()<CR>

    nnoremap <leader>fs :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nnoremap <leader>fg :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nnoremap <leader>fc :cs find c <C-R>=expand("<cword>")<CR><CR>	
    nnoremap <leader>ft :cs find t <C-R>=expand("<cword>")<CR><CR>	
    nnoremap <leader>fe :cs find e <C-R>=expand("<cword>")<CR><CR>	
    nnoremap <leader>ff :cs find f <C-R>=expand("<cfile>")<CR><CR>	
    nnoremap <leader>fi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nnoremap <leader>fd :cs find d <C-R>=expand("<cword>")<CR><CR>	

    nnoremap <leader>Fs :vert scs find s <C-R>=expand("<cword>")<CR><CR>	
    nnoremap <leader>Fg :vert scs find g <C-R>=expand("<cword>")<CR><CR>	
    nnoremap <leader>Fc :vert scs find c <C-R>=expand("<cword>")<CR><CR>	
    nnoremap <leader>Ft :vert scs find t <C-R>=expand("<cword>")<CR><CR>	
    nnoremap <leader>Fe :vert scs find e <C-R>=expand("<cword>")<CR><CR>	
    nnoremap <leader>Ff :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nnoremap <leader>Fi :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nnoremap <leader>Fd :vert scs find d <C-R>=expand("<cword>")<CR><CR>	
endif

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
    echom "Python not available. Disabling clang_complete"
    let g:clang_complete_loaded
else
    " Point to libclang on OS X
    if g:os_uname ==# "Darwin"
        let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/To
            \olchains/XcodeDefault.xctoolchain/usr/lib"
    endif
    let g:clang_jumpto_declaration_in_preview_key='<c-f>'
    let g:clang_jumpto_declaration_key='<c-F>'
endif

" Taglist
noremap <leader>g :TlistToggle<cr>
let Tlist_Use_Right_Window = 1
let Tlist_Use_SingleClick = 1
let Tlist_Inc_Winwidth = 1
let Tlist_Max_Tag_Length = 100
let Tlist_Use_SingleClick = 1

" Pathogen
call pathogen#infect()

""
"" Colorscheme
""

colorscheme codeschool
