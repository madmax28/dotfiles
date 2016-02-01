function! madmax#tabline#MyTabLabel(n)
    " Extract filename of active buffer
    let l:buflist  = tabpagebuflist(a:n)
    let l:winnr    = tabpagewinnr(a:n)
    let l:bufname  = bufname(l:buflist[l:winnr - 1])

    if empty(l:bufname)
        return '[No Name]'
    else
        return system(g:vimconfig_dir . "/bin/spwd " . l:bufname)
    endif
endfunction

function! madmax#tabline#MyTabLine()
    let s = ''

    for i in range(tabpagenr('$'))
        " Dont print labels if only one tab
        if tabpagenr('$') == 1
            break
        endif

        " Select the highlighting
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        " Set the tab page number (for mouse clicks)
        let s .= '%' . (i + 1) . 'T'
        " The label is made by MyTabLabel()
        let s .= ' %{madmax#tabline#MyTabLabel(' . (i + 1) . ')} '
    endfor

    " After the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'
    " Print currect working directory
    let s .= '%=cwd: ' . system(g:vimconfig_dir . "/bin/spwd") . '%#TabLine#'

    return s
endfunction
