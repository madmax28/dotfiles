function! madmax#ycm#YcmAvailable()
    " Get the output of ":scriptnames" in the scriptnames_output variable.
    let scriptnames_output = ''
    redir => scriptnames_output
    silent scriptnames
    redir END

    " Split the output into lines and parse each line.
    for line in split(scriptnames_output, "\n")
        " Only do non-blank lines.
        if line =~ '\S'
            " Match for youcompleteme.vim
            if match(line, 'youcompleteme\.vim$') != -1
                return 1
            endif
        endif
    endfor

    return 0
endfunction
