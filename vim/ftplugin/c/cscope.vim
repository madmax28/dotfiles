if has("cscope")
    let s:myscope_dir = getcwd() . '/.myscope'
    let s:cscope_db   = s:myscope_dir . '/cscope.out'
    let s:ctags_vim   = s:myscope_dir . '/ctags.vim'

    " Functions {{{1

    " Add cscope db ./.myscope/cscope.out
    function! AddCscopeDb()
        if filereadable( s:cscope_db )
            echom "Added cscope db"
            " Add cscope db
            execute "silent! cs add " . s:cscope_db
            " Avoid duplicate databases
            silent! cscope reset
        else
            echoe "Couldn't find cscope db"
        endif
    endfunction

    " Source ./.myscope/ctags.vim
    function! AddCtagsVim()
        if filereadable( s:ctags_vim )
            " Source ctags.vim highlighting file
            execute "silent! source " . s:ctags_vim
        else
            echoe "Couldn't find ctags.vim"
        endif
    endfunction

    " Use myscope to generate a cscope db for the cwd
    " Also creates a ctags.vim with syntax highlighting for tags
    function! CreateScopeDbCtags()
        if filereadable( s:cscope_db )
            echom "Rebuilding cscope db"
            call delete( s:cscope_db )
            call delete( s:ctags_vim )
        endif

        execute "silent! !" . g:vimconfig_dir . "/bin/myscope " . getcwd()

        silent! call AddCscopeDb()
        silent! call AddCtagsVim()

        redraw!
    endfunction

    " Settings {{{1

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

    " Mappings {{{1

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
    " }}}
endif
