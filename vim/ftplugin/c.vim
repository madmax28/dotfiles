"" Settings {{{1

set formatoptions=crajq

let b:cString = "\/\/"

"" Cscope and ctags stuff {{{1

" Add cscope db ./.myscope/cscope.out
function! AddCscopeDb()
    let l:myscope_dir = getcwd() . '/.myscope'
    let l:cscope_db   = l:myscope_dir . '/cscope.out'

    if filereadable( l:cscope_db )
        echom "Added cscope db"
        " Add cscope db
        execute "silent! cs add " . l:cscope_db
        " Avoid duplicate databases
        silent! cscope reset
    else
        echoe "Couldn't find cscope db"
    endif
endfunction

" Source ./.myscope/ctags.vim
function! AddCtagsVim()
    let l:myscope_dir = getcwd() . '/.myscope'
    let l:ctags_vim   = l:myscope_dir . '/ctags.vim'

    if filereadable( l:ctags_vim )
        " Source ctags.vim highlighting file
        execute "silent! source " . l:ctags_vim
    else
        echoe "Couldn't find ctags.vim"
    endif
endfunction

" Use myscope.sh to generate a cscope db for the cwd
" Also creates a ctags.vim with syntax highlighting for tags
function! CreateScopeDbCtags()
    let l:myscope_dir = getcwd() . '/.myscope'

    let l:cscope_db   = l:myscope_dir . '/cscope.out'
    let l:ctags_vim   = l:myscope_dir . '/ctags.vim'
    if filereadable( l:cscope_db )
        echom "Rebuilding cscope db"
        call delete( l:cscope_db )
        call delete( l:ctags_vim )
    endif

    execute "silent! !~/.vim/bin/myscope.sh " . getcwd()

    silent! call AddCscopeDb()
    silent! call AddCtagsVim()

    redraw!
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

    " Add existing cscope db
    silent! call AddCscopeDb()

    " Mappings
    nnoremap <buffer> <leader>fa :call CreateScopeDbCtags()<CR>

    " Jump
    nnoremap <buffer> <leader>fs :cs find s <C-R>=expand("<cword>")<cr><cr><c-o>:cw<cr>
    nnoremap <buffer> <leader>fg :cs find g <C-R>=expand("<cword>")<cr><cr>
    nnoremap <buffer> <leader>fc :cs find c <C-R>=expand("<cword>")<cr><cr><c-o>:cw<cr>
    nnoremap <buffer> <leader>ft :cs find t <C-R>=expand("<cword>")<cr><cr><c-o>:cw<cr>
    nnoremap <buffer> <leader>fe :cs find e <C-R>=expand("<cword>")<cr><cr><c-o>:cw<cr>
    nnoremap <buffer> <leader>ff :cs find f <C-R>=expand("<cfile>")<cr><cr>
    nnoremap <buffer> <leader>fi :cs find i ^<C-R>=expand("<cfile>")<cr>$<cr>
    nnoremap <buffer> <leader>fd :cs find d <C-R>=expand("<cword>")<cr><cr>

    " Split
    nnoremap <buffer> <leader>FS :vert scs find s <C-R>=expand("<cword>")<cr><cr>
    nnoremap <buffer> <leader>FG :vert scs find g <C-R>=expand("<cword>")<cr><cr>
    nnoremap <buffer> <leader>FC :vert scs find c <C-R>=expand("<cword>")<cr><cr>
    nnoremap <buffer> <leader>FT :vert scs find t <C-R>=expand("<cword>")<cr><cr>
    nnoremap <buffer> <leader>FE :vert scs find e <C-R>=expand("<cword>")<cr><cr>
    nnoremap <buffer> <leader>FF :vert scs find f <C-R>=expand("<cfile>")<cr><cr>

    " Preview
    nnoremap <buffer> <leader>Fg :pta <C-R>=expand("<cword>")<cr><cr>
endif

"" Find things {{{1

" First occurence of keyword in function
function! JumpToFirstOccurenceInFunction()
    normal *
    keepjumps normal N999[{n
    nohlsearch
endfunction

" First occurence of keyword in file
function! JumpToFirstOccurenceInFile()
    normal *
    keepjumps normal ggn
    nohlsearch
endfunction

nnoremap [[ 999[{
nnoremap ]] 999]}
nnoremap gd :silent call JumpToFirstOccurenceInFunction()<cr>
nnoremap gD :silent call JumpToFirstOccurenceInFile()<cr>

