compiler cargo

silent! nunmap <leader>mg
silent! nunmap <leader>M
nnoremap <buffer> <leader>m :silent make! check <bar> redraw!<cr>
nnoremap <buffer> <leader>M :silent make! test <bar> redraw!<cr>

function! rust#settings#FormatRange(mode)
    silent! call rustfmt#FormatRange(line("'["), line("']"))
endfunction

nnoremap <buffer> <leader>F :RustFmt<cr>
nnoremap <buffer> <leader>f :set opfunc=rust#settings#FormatRange<cr>g@
