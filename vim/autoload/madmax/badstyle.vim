highlight link BadStyle Error

function! madmax#badstyle#HighlightBadStyle()
    " Dont highlight in help files
    if &filetype ==# "help" || &filetype ==# "qf"
        return
    endif

    " Clear previous matches
    call clearmatches()

    " Character on 80th column
    if &filetype !=# "tex"
        call matchadd('BadStyle', '\%81v.')
    endif
    " Trailing whitespaces
    call matchadd('BadStyle', '\s\+\n')
    " Non-breaking spaces, useful on Macs, where i tend to hit Alt+Space
    call matchadd('BadStyle', ' ')
endfunction
