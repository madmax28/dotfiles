let s:python = substitute(system("which python"), "\n", "", "")
if v:shell_error != 0
    echoerr "Python not found in your path!"
    finish
endif

" Execute python script
function! ExecutePython(readargs)
    if !exists("s:args")
        let s:args = ''
    endif

    if a:readargs
        let s:args = input("Arguments: ", s:args, "file")
        redraw!
    endif

    let l:file = @%
    let l:cmd = s:python . ' ' . l:file . ' ' . s:args
    echom l:cmd

    let l:output = system(l:cmd)

    echo "=== Output of " . l:cmd . ":\n"
    echo l:output
    echo "=== Return value: " . v:shell_error
endfunction

nnoremap <buffer> <leader>x :wa<cr>:call ExecutePython("0")<cr>
nnoremap <buffer> <leader>X :wa<cr>:call ExecutePython("1")<cr>

" Execute flake8 after writing a file

augroup AutoFlake8
    autocmd!
    autocmd BufWritePost *py call Flake8()
augroup END
