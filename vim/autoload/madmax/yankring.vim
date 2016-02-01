let s:yring_len = 10
let s:yring_idx = -1
let s:yring_f = getcwd() . '/.vimyanks'

if filereadable(s:yring_f)
    let s:yring = readfile(s:yring_f, "b")
    let s:yring_idx = (len(s:yring)-1) % s:yring_len
else
    let s:yring = []
endif

function! madmax#yankring#Yank(mode)
    let l:yring_f = getcwd() . '/.vimyanks'

    " Save reg a
    let l:olda = getreg('a')

    " Yank to a
    if a:mode ==# 'visual'
        execute "normal! `<v`>\"ay"
    else
        execute "normal! `[v`]\"ay"
    endif

    " Save in ring
    if len(s:yring) < s:yring_len
        let s:yring = s:yring + [getreg('a')]
    else
        let s:yring[s:yring_idx] = getreg('a')
    endif

    " Restore a
    call setreg('a', l:olda)

    " Save ring to disk
    call writefile(s:yring, l:yring_f, "b")
endfunction

function! madmax#yankring#Paste(mode)
    if len(s:yring) == 0
        return
    endif

    " Save a
    let l:olda = getreg('a')

    let l:cur_len = len(s:yring)

    " Print all regs
    for i in range(l:cur_len)
        echom string(i) . ": " . s:yring[s:yring_idx - i]
    endfor

    let l:choice = input("Which buffer to paste? ")
    call setreg('a', s:yring[s:yring_idx - l:choice])
    if a:mode ==# 'P'
        silent! normal! "aP
    else
        silent! normal! "ap
    endif

    " Restore a
    call setreg('a', l:olda)
endfunction

