setlocal keywordprg=pydoc
set fo=crj

" If YouCompleteMe is available, define some mappings for it
if madmax#ycm#YcmAvailable()
    " Jump to things
    nnoremap <buffer> <leader>fg :silent! YcmCompleter GoToDefinition<cr>
    nnoremap <buffer> <leader>fd :silent! YcmCompleter GoToDeclaration<cr>
    nnoremap <buffer> <leader>fs :silent! YcmCompleter GoToReferences<cr>
    nnoremap <buffer> <leader>fK :silent! YcmCompleter GetDoc<cr>
endif
