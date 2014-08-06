"
" Appearance
"

if g:os_uname ==# "Darwin"
    set guifont=Monaco:h13
elseif g:os_uname ==# "Linux"
    set guifont=Monospace\ 14
endif
set guioptions-=l guioptions-=L guioptions-=b guioptions-=T guioptions-=m
set guioptions-=r guioptions-=R

"
" Behavior
"

so $MYVIMRC
