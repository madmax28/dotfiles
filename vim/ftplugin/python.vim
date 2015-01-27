" Check for python
let s:python = "/usr/bin/python"
if !filereadable(s:python)
    let s:python = system("which python")
    if v:shell_error != 0
        echoerr "Python not found!"
        finish
    endif
endif

" Execute python script
function! ExecutePython(readargs)
    if a:readargs
        if !exists("s:args")
            s:args = ''
        endif

        let s:args = input("Arguments: ", s:args, "file")
        redraw!
    endif

    let l:file = @%
    let l:cmd = s:python . ' ' . l:file . ' ' . s:args

    let l:output = system(l:cmd)

    echo "=== Output of " . l:cmd . ":\n"
    echo l:output
    echo "=== Return value: " . v:shell_error
endfunction

nnoremap <buffer> <leader>x :wa<cr>:call ExecutePython("0")<cr>
nnoremap <buffer> <leader>X :wa<cr>:call ExecutePython("1")<cr>

" Execute flake8 after writing a file
autocmd! BufWritePost <buffer> * silent! call Flake8()
