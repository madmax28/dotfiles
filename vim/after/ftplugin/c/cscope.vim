if has("cscope")
    let s:myscope_cmd  = g:vimconfig_dir . "/bin/myscope"
    let s:myscope_cmd .= " -p " . getcwd()
    let s:myscope_cmd .= " -o " . getcwd()
    let s:myscope_cmd .= " -v "

    " Functions {{{1

    " Add cscope db ./.myscope/cscope.out
    function! AddCscopeDb(myscope_dir)
        let l:tmp = system("find " . a:myscope_dir . " -name cscope.out 2>/dev/null")
        let l:cscope_dbs = split(l:tmp, '\n')
        for l:db in l:cscope_dbs
            echom l:db
            if filereadable(l:db)
                " Add cscope db
                execute "silent! cs add " . l:db
            else
                echoe "Couldn't find cscope db"
            endif
        endfor
        " Avoid duplicate connections
        silent! cscope reset
    endfunction

    " Source ./.myscope/ctags.vim
    function! AddCtagsVim(myscope_dir)
        let l:tmp = system("find " . a:myscope_dir . " -name ctags.vim 2>/dev/null")
        let l:hl_files = split(l:tmp, '\n')
        for l:hlf in l:hl_files
            if filereadable(l:hlf)
                " Source ctags.vim highlighting file
                execute "silent! source " . l:hlf
            else
                echoe "Couldn't find ctags.vim"
            endif
        endfor
    endfunction

    " Use myscope to generate a cscope db for the cwd
    " Also creates a ctags.vim with syntax highlighting for tags
    function! CreateScopeDbCtags()
        execute "silent! !" . s:myscope_cmd
        silent! call AddCscopeDb(getcwd() . "/.myscope")
        silent! call AddCtagsVim(getcwd() . "/.myscope")
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

    " Add existing cscope dbs
    silent! call AddCscopeDb(getcwd() . "/.myscope")
    if exists("g:myscope_dir")
        silent! call AddCscopeDb(g:myscope_dir)
    endif

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
