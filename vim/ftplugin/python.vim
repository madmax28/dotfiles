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
        let l:args = input("Arguments: ", "", "file")
    else
        let l:args = ""
    endif

    let l:file = @%
    let l:cmd = s:python . " " . l:file
    if a:readargs
        let l:cmd = l:cmd . " " . l:args
    endif

    let l:output = system(l:cmd)

    echo "=== Output of " . l:cmd . ":\n"
    echo l:output
    echo "=== Return value: " . v:shell_error
endfunction

nnoremap <leader>x :call ExecutePython("0")<cr>
nnoremap <leader>X :call ExecutePython("1")<cr>
