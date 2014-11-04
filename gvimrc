""
"" Appearance
""

if g:os_uname ==# "Darwin"
    set guifont=Monaco:h13 guioptions-=r guioptions-=R
elseif g:os_uname ==# "Linux"
    set guifont=Monospace\ 10
endif
set guioptions-=l guioptions-=L guioptions-=b guioptions-=T guioptions-=m
set guioptions-=r guioptions-=R

""
"" Behavior
""

so $MYVIMRC

""
"" Colorscheme
""

colorscheme codeschool
