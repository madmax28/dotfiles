"" Settings {{{1

set formatoptions=crajq

let b:cString = "\/\/"

"" Cscope stuff {{{1

" Add any cscope databases present in current working directory
function! AddCscopeDb()
    let l:myscope_dir = getcwd() . '/.myscope'
    let l:cscope_db   = l:myscope_dir . '/cscope.out'

    if filereadable( l:cscope_db )
        echom "Added cscope db"
        execute "silent! cs add " . l:cscope_db
        " Avoid duplicate databases
        silent! cscope reset
    else
        echoe "Couldn't find cscope db"
    endif
endfunction

" Add any cscope databases present in current working directory
" If none are present, call AirTies' newscript.sh to generate one and add it
function! AddCreateCscopeDb()
    let l:myscope_dir = getcwd() . '/.myscope'

    let l:cscope_db   = l:myscope_dir . '/cscope.out'
    if filereadable( l:cscope_db )
        echom "Rebuilding cscope db"
        call delete( l:cscope_db )
    endif

    execute "silent! !~/.vim/bin/myscope.sh " . getcwd()

    if filereadable( l:cscope_db )
        call AddCscopeDb()
    else
        echoe "Couldn't create Cscope db"
    endif

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

    silent! call AddCscopeDb()

    " Mappings
    nnoremap <buffer> <leader>fa :call AddCreateCscopeDb()<CR>

    nnoremap <buffer> <leader>fs :cs find s <C-R>=expand("<cword>")<cr><cr><c-o>:cw<cr>
    nnoremap <buffer> <leader>fg :cs find g <C-R>=expand("<cword>")<cr><cr>
    nnoremap <buffer> <leader>fc :cs find c <C-R>=expand("<cword>")<cr><cr><c-o>:cw<cr>
    nnoremap <buffer> <leader>ft :cs find t <C-R>=expand("<cword>")<cr><cr><c-o>:cw<cr>
    nnoremap <buffer> <leader>fe :cs find e <C-R>=expand("<cword>")<cr><cr><c-o>:cw<cr>
    nnoremap <buffer> <leader>ff :cs find f <C-R>=expand("<cfile>")<cr><cr>
    nnoremap <buffer> <leader>fi :cs find i ^<C-R>=expand("<cfile>")<cr>$<cr>
    nnoremap <buffer> <leader>fd :cs find d <C-R>=expand("<cword>")<cr><cr>

    nnoremap <buffer> <leader>FS :vert scs find s <C-R>=expand("<cword>")<cr><cr>
    nnoremap <buffer> <leader>FG :vert scs find g <C-R>=expand("<cword>")<cr><cr>
    nnoremap <buffer> <leader>FC :vert scs find c <C-R>=expand("<cword>")<cr><cr>
    nnoremap <buffer> <leader>FT :vert scs find t <C-R>=expand("<cword>")<cr><cr>
    nnoremap <buffer> <leader>FE :vert scs find e <C-R>=expand("<cword>")<cr><cr>
    nnoremap <buffer> <leader>FF :vert scs find f <C-R>=expand("<cfile>")<cr><cr>

    nnoremap <buffer> <leader>Fg :pta <C-R>=expand("<cword>")<cr><cr>
endif

