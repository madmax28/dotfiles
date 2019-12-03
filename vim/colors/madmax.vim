set background=dark

highlight clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="madmax"

"
" Editor settings
"
hi Normal                     ctermfg=255  ctermbg=234  cterm=NONE      guifg=#eeeeee guibg=#1c1c1c guisp=NONE gui=NONE
hi Cursor                     ctermfg=NONE ctermbg=NONE cterm=NONE      guifg=NONE    guibg=NONE    guisp=NONE gui=NONE
hi CursorLine                 ctermfg=NONE ctermbg=24   cterm=NONE      guifg=NONE    guibg=#005f87 guisp=NONE gui=NONE
hi LineNr                     ctermfg=102  ctermbg=236  cterm=NONE      guifg=#878787 guibg=#303030 guisp=NONE gui=NONE
hi CursorLineNr               ctermfg=NONE ctermbg=24   cterm=NONE      guifg=NONE    guibg=#005f87 guisp=NONE gui=NONE

"
" Number column
"
hi CursorColumn               ctermfg=NONE ctermbg=88   cterm=NONE      guifg=NONE    guibg=#870000 guisp=NONE gui=NONE
hi FoldColumn                 ctermfg=NONE ctermbg=236  cterm=NONE      guifg=NONE    guibg=#303030 guisp=NONE gui=NONE
hi SignColumn                 ctermfg=NONE ctermbg=236  cterm=NONE      guifg=NONE    guibg=#303030 guisp=NONE gui=NONE
hi Folded                     ctermfg=102  ctermbg=236  cterm=NONE      guifg=#878787 guibg=#303030 guisp=NONE gui=NONE

"
" Window/Tab delimiters
"
hi VertSplit                  ctermfg=102  ctermbg=236  cterm=NONE      guifg=#878787 guibg=#303030 guisp=NONE gui=NONE
hi ColorColumn                ctermfg=NONE ctermbg=88   cterm=NONE      guifg=NONE    guibg=#870000 guisp=NONE gui=NONE
hi TabLine                    ctermfg=NONE ctermbg=236  cterm=NONE      guifg=NONE    guibg=#303030 guisp=NONE gui=NONE
hi TabLineFill                ctermfg=NONE ctermbg=236  cterm=NONE      guifg=NONE    guibg=#303030 guisp=NONE gui=NONE
hi TabLineSel                 ctermfg=NONE ctermbg=24   cterm=NONE      guifg=NONE    guibg=#005f87 guisp=NONE gui=NONE

"
" File Navigation / Searching
"
hi Directory                  ctermfg=68   ctermbg=NONE cterm=NONE      guifg=#5f87df guibg=NONE    guisp=NONE gui=NONE
hi Search                     ctermfg=16   ctermbg=214  cterm=NONE      guifg=#000000 guibg=#ffaf00 guisp=NONE gui=NONE
hi IncSearch                  ctermfg=16   ctermbg=214  cterm=NONE      guifg=#000000 guibg=#ffaf00 guisp=NONE gui=NONE

"
" Prompt/Status
"
hi StatusLine                 ctermfg=NONE ctermbg=24   cterm=NONE      guifg=NONE    guibg=#005f87 guisp=NONE gui=NONE
hi StatusLineNC               ctermfg=NONE ctermbg=236  cterm=NONE      guifg=NONE    guibg=#303030 guisp=NONE gui=NONE
hi WildMenu                   ctermfg=16   ctermbg=250  cterm=NONE      guifg=#000000 guibg=#bcbcbc guisp=NONE gui=NONE
hi Question                   ctermfg=174  ctermbg=NONE cterm=NONE      guifg=#df8787 guibg=NONE    guisp=NONE gui=NONE
hi Title                      ctermfg=174  ctermbg=NONE cterm=NONE      guifg=#df8787 guibg=NONE    guisp=NONE gui=NONE
hi MoreMsg                    ctermfg=174  ctermbg=NONE cterm=NONE      guifg=#df8787 guibg=NONE    guisp=NONE gui=NONE
hi ModeMsg                    ctermfg=68   ctermbg=NONE cterm=NONE      guifg=#5f87df guibg=NONE    guisp=NONE gui=NONE

"
" Terminal
"
if has('terminal')
    hi StatusLineTerm         ctermfg=NONE ctermbg=24   cterm=NONE      guifg=NONE    guibg=#005f87 guisp=NONE gui=NONE
    hi StatusLineTermNC       ctermfg=NONE ctermbg=236  cterm=NONE      guifg=NONE    guibg=#303030 guisp=NONE gui=NONE
    hi debugPC                ctermfg=NONE ctermbg=24   cterm=NONE      guifg=NONE    guibg=#005f87 guisp=NONE gui=NONE
endif

"
" Visual aid
"
hi MatchParen                 ctermfg=255  ctermbg=24   cterm=NONE      guifg=#eeeeee guibg=#005f87 guisp=NONE gui=NONE
hi Visual                     ctermfg=NONE ctermbg=236  cterm=NONE      guifg=NONE    guibg=#303030 guisp=NONE gui=NONE
hi VisualNOS                  ctermfg=160  ctermbg=NONE cterm=NONE      guifg=#df0000 guibg=NONE    guisp=NONE gui=NONE
hi NonText                    ctermfg=102  ctermbg=NONE cterm=NONE      guifg=#878787 guibg=NONE    guisp=NONE gui=NONE

hi Todo                       ctermfg=223  ctermbg=NONE cterm=NONE      guifg=#ffdfaf guibg=NONE    guisp=NONE gui=NONE
hi Underlined                 ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE    guibg=NONE    guisp=NONE gui=NONE
hi Error                      ctermfg=160  ctermbg=NONE cterm=NONE      guifg=#df0000 guibg=NONE    guisp=NONE gui=NONE
hi ErrorMsg                   ctermfg=160  ctermbg=NONE cterm=NONE      guifg=#df0000 guibg=NONE    guisp=NONE gui=NONE
hi WarningMsg                 ctermfg=160  ctermbg=NONE cterm=NONE      guifg=#df0000 guibg=NONE    guisp=NONE gui=NONE
hi Ignore                     ctermfg=223  ctermbg=NONE cterm=NONE      guifg=#ffdfaf guibg=NONE    guisp=NONE gui=NONE
hi SpecialKey                 ctermfg=237  ctermbg=NONE cterm=NONE      guifg=#3a3a3a guibg=NONE    guisp=NONE gui=NONE

"
" Variable types
"
hi Constant                   ctermfg=68   ctermbg=NONE cterm=NONE      guifg=#5f87df guibg=NONE    guisp=NONE gui=NONE
hi String                     ctermfg=107  ctermbg=NONE cterm=NONE      guifg=#87af5f guibg=NONE    guisp=NONE gui=NONE
hi StringDelimiter            ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE    guibg=NONE    guisp=NONE gui=NONE
hi Character                  ctermfg=68   ctermbg=NONE cterm=NONE      guifg=#5f87df guibg=NONE    guisp=NONE gui=NONE
hi Number                     ctermfg=68   ctermbg=NONE cterm=NONE      guifg=#5f87df guibg=NONE    guisp=NONE gui=NONE
hi Boolean                    ctermfg=68   ctermbg=NONE cterm=NONE      guifg=#5f87df guibg=NONE    guisp=NONE gui=NONE
hi Float                      ctermfg=68   ctermbg=NONE cterm=NONE      guifg=#5f87df guibg=NONE    guisp=NONE gui=NONE

hi Function                   ctermfg=153  ctermbg=NONE cterm=NONE      guifg=#afdfff guibg=NONE    guisp=NONE gui=NONE
hi Identifier                 ctermfg=68   ctermbg=NONE cterm=NONE      guifg=#5f87df guibg=NONE    guisp=NONE gui=NONE

"
" Language constructs
"
hi Statement                  ctermfg=174  ctermbg=NONE cterm=NONE      guifg=#df8787 guibg=NONE    guisp=NONE gui=NONE
hi Conditional                ctermfg=174  ctermbg=NONE cterm=NONE      guifg=#df8787 guibg=NONE    guisp=NONE gui=NONE
hi Repeat                     ctermfg=174  ctermbg=NONE cterm=NONE      guifg=#df8787 guibg=NONE    guisp=NONE gui=NONE
hi Label                      ctermfg=174  ctermbg=NONE cterm=NONE      guifg=#df8787 guibg=NONE    guisp=NONE gui=NONE
hi Operator                   ctermfg=223  ctermbg=NONE cterm=NONE      guifg=#ffdfaf guibg=NONE    guisp=NONE gui=NONE
hi Keyword                    ctermfg=174  ctermbg=NONE cterm=NONE      guifg=#df8787 guibg=NONE    guisp=NONE gui=NONE
hi Exception                  ctermfg=174  ctermbg=NONE cterm=NONE      guifg=#df8787 guibg=NONE    guisp=NONE gui=NONE
hi Comment                    ctermfg=102  ctermbg=NONE cterm=NONE      guifg=#878787 guibg=NONE    guisp=NONE gui=NONE

hi Special                    ctermfg=219  ctermbg=NONE cterm=NONE      guifg=#ffafff guibg=NONE    guisp=NONE gui=NONE
hi SpecialChar                ctermfg=219  ctermbg=NONE cterm=NONE      guifg=#ffafff guibg=NONE    guisp=NONE gui=NONE
hi Tag                        ctermfg=9    ctermbg=NONE cterm=NONE      guifg=#ff0000 guibg=NONE    guisp=NONE gui=NONE
hi Delimiter                  ctermfg=223  ctermbg=NONE cterm=NONE      guifg=#ffdfaf guibg=NONE    guisp=NONE gui=NONE
hi SpecialComment             ctermfg=102  ctermbg=NONE cterm=NONE      guifg=#878787 guibg=NONE    guisp=NONE gui=NONE
hi Debug                      ctermfg=NONE ctermbg=88   cterm=NONE      guifg=NONE    guibg=#870000 guisp=NONE gui=NONE

"
" C like
"
hi PreProc                    ctermfg=180  ctermbg=NONE cterm=NONE      guifg=#dfaf87 guibg=NONE    guisp=NONE gui=NONE
hi Include                    ctermfg=180  ctermbg=NONE cterm=NONE      guifg=#dfaf87 guibg=NONE    guisp=NONE gui=NONE
hi Define                     ctermfg=180  ctermbg=NONE cterm=NONE      guifg=#dfaf87 guibg=NONE    guisp=NONE gui=NONE
hi Macro                      ctermfg=180  ctermbg=NONE cterm=NONE      guifg=#dfaf87 guibg=NONE    guisp=NONE gui=NONE
hi PreCondit                  ctermfg=180  ctermbg=NONE cterm=NONE      guifg=#dfaf87 guibg=NONE    guisp=NONE gui=NONE

hi Type                       ctermfg=205  ctermbg=NONE cterm=NONE      guifg=#ff5faf guibg=NONE    guisp=NONE gui=NONE
hi StorageClass               ctermfg=2    ctermbg=NONE cterm=NONE      guifg=#008000 guibg=NONE    guisp=NONE gui=NONE
hi Structure                  ctermfg=2    ctermbg=NONE cterm=NONE      guifg=#008000 guibg=NONE    guisp=NONE gui=NONE
hi Typedef                    ctermfg=2    ctermbg=NONE cterm=NONE      guifg=#008000 guibg=NONE    guisp=NONE gui=NONE

"
" Diff
"
hi DiffAdd                    ctermfg=NONE ctermbg=22   cterm=NONE      guifg=NONE    guibg=#1c441c guisp=NONE gui=NONE
hi DiffChange                 ctermfg=NONE ctermbg=17   cterm=NONE      guifg=NONE    guibg=#1c1c44 guisp=NONE gui=NONE
hi DiffDelete                 ctermfg=234  ctermbg=NONE cterm=NONE      guifg=#441c1c guibg=NONE    guisp=NONE gui=NONE
hi DiffText                   ctermfg=NONE ctermbg=24   cterm=NONE      guifg=NONE    guibg=#1c4f77 guisp=NONE gui=NONE

"
" Completion menu
"
hi Pmenu                      ctermfg=NONE ctermbg=236  cterm=NONE      guifg=NONE    guibg=#303030 guisp=NONE gui=NONE
hi PmenuSel                   ctermfg=NONE ctermbg=24   cterm=NONE      guifg=NONE    guibg=#005f87 guisp=NONE gui=NONE
hi PmenuSbar                  ctermfg=NONE ctermbg=236  cterm=NONE      guifg=NONE    guibg=#303030 guisp=NONE gui=NONE
hi PmenuThumb                 ctermfg=NONE ctermbg=24   cterm=NONE      guifg=NONE    guibg=#005f87 guisp=NONE gui=NONE

"
" Spelling
"
hi SpellBad                   ctermfg=NONE ctermbg=88   cterm=NONE      guifg=NONE    guibg=#870000 guisp=NONE gui=NONE
hi SpellCap                   ctermfg=NONE ctermbg=88   cterm=NONE      guifg=NONE    guibg=#870000 guisp=NONE gui=NONE
hi SpellLocal                 ctermfg=NONE ctermbg=88   cterm=NONE      guifg=NONE    guibg=#870000 guisp=NONE gui=NONE
hi SpellRare                  ctermfg=NONE ctermbg=88   cterm=NONE      guifg=NONE    guibg=#870000 guisp=NONE gui=NONE

"
" User 1
"
hi User1                      ctermfg=9    ctermbg=24   cterm=NONE      guifg=#ff0000 guibg=#005f87 guisp=NONE gui=NONE
