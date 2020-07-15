if !exists('s:run_args')
    let s:run_args = ''
endif

command! -nargs=* RustArgs call s:set_args(<f-args>)
function! s:set_args(...)
    let s:run_args = ''
    for l:arg in a:000
        let s:run_args .= ' ' . l:arg
    endfor
endfunction

function! RustRun(...)
    let l:user_args = ''
    for l:arg in a:000
        let l:user_args .= ' ' . l:arg
    endfor

    let l:cmd = 'make! run ' . l:user_args . ' ' . s:run_args
    echom l:cmd
    execute l:cmd
endfunction

nnoremap <leader>mb :make! check<cr>
nnoremap <leader>mc :make! clean<cr>
nnoremap <leader>mC :make! clippy<cr>
nnoremap <leader>mt :make! test<cr>
nnoremap <leader>mr :call RustRun()<cr>
nnoremap <leader>mR :call RustRun("--release")<cr>
