" Settings {{{1

let s:sh = '/bin/sh'

" Functions {{{1

" Execute script
function! Execute(readargs)
    if a:readargs
        if !exists("s:args")
            let s:args = input("Arguments: ", "",     "file")
        else
            let s:args = input("Arguments: ", s:args, "file")
        endif
        redraw!
    endif

    let l:file = @%
    let l:cmd = s:sh . " " . l:file
    if exists("s:args")
        let l:cmd = l:cmd . " " . s:args
    endif

    let l:output = system(l:cmd)

    echo "=== Output of " . l:cmd . ":\n"
    echo l:output
    echo "=== Return value: " . v:shell_error
endfunction

" Mappings {{{1

" Execute script
nnoremap <buffer> <leader>x :wa<cr>:call Execute("0")<cr>
nnoremap <buffer> <leader>X :wa<cr>:call Execute("1")<cr>
