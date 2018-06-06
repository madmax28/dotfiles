set background=dark

highlight clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="madmax"

"
" Editor settings
"
hi Normal                     ctermfg=255  ctermbg=234  cterm=NONE      guifg=#eeeeee guibg=#1c1c1c guisp=NONE
hi Cursor                     ctermfg=NONE ctermbg=NONE cterm=NONE      guifg=NONE    guibg=NONE    guisp=NONE
hi CursorLine                 ctermfg=NONE ctermbg=24   cterm=NONE      guifg=NONE    guibg=#005f87 guisp=NONE
hi LineNr                     ctermfg=102  ctermbg=236  cterm=NONE      guifg=#878787 guibg=#303030 guisp=NONE
hi CursorLineNr               ctermfg=NONE ctermbg=24   cterm=NONE      guifg=NONE    guibg=#005f87 guisp=NONE

"
" Number column
"
hi CursorColumn               ctermfg=NONE ctermbg=88   cterm=NONE      guifg=NONE    guibg=#870000 guisp=NONE
hi FoldColumn                 ctermfg=NONE ctermbg=236  cterm=NONE      guifg=NONE    guibg=#303030 guisp=NONE
hi SignColumn                 ctermfg=NONE ctermbg=236  cterm=NONE      guifg=NONE    guibg=#303030 guisp=NONE
hi Folded                     ctermfg=102  ctermbg=236  cterm=NONE      guifg=#878787 guibg=#303030 guisp=NONE

"
" Window/Tab delimiters
"
hi VertSplit                  ctermfg=102  ctermbg=236  cterm=NONE      guifg=#878787 guibg=#303030 guisp=NONE
hi ColorColumn                ctermfg=NONE ctermbg=88   cterm=NONE      guifg=NONE    guibg=#870000 guisp=NONE
hi TabLine                    ctermfg=NONE ctermbg=236  cterm=NONE      guifg=NONE    guibg=#303030 guisp=NONE
hi TabLineFill                ctermfg=NONE ctermbg=236  cterm=NONE      guifg=NONE    guibg=#303030 guisp=NONE
hi TabLineSel                 ctermfg=NONE ctermbg=24   cterm=NONE      guifg=NONE    guibg=#005f87 guisp=NONE

"
" File Navigation / Searching
"
hi Directory                  ctermfg=68   ctermbg=NONE cterm=NONE      guifg=#5f87df guibg=NONE    guisp=NONE
hi Search                     ctermfg=16   ctermbg=250  cterm=NONE      guifg=#000000 guibg=#bcbcbc guisp=NONE
hi IncSearch                  ctermfg=16   ctermbg=250  cterm=NONE      guifg=#000000 guibg=#bcbcbc guisp=NONE

"
" Prompt/Status
"
hi StatusLine                 ctermfg=NONE ctermbg=24   cterm=NONE      guifg=NONE    guibg=#005f87 guisp=NONE
hi StatusLineNC               ctermfg=NONE ctermbg=236  cterm=NONE      guifg=NONE    guibg=#303030 guisp=NONE
hi WildMenu                   ctermfg=16   ctermbg=250  cterm=NONE      guifg=#000000 guibg=#bcbcbc guisp=NONE
hi Question                   ctermfg=NONE ctermbg=24   cterm=NONE      guifg=NONE    guibg=#005f87 guisp=NONE
hi Title                      ctermfg=NONE ctermbg=24   cterm=NONE      guifg=NONE    guibg=#005f87 guisp=NONE
hi ModeMsg                    ctermfg=NONE ctermbg=24   cterm=NONE      guifg=NONE    guibg=#005f87 guisp=NONE
hi MoreMsg                    ctermfg=NONE ctermbg=24   cterm=NONE      guifg=NONE    guibg=#005f87 guisp=NONE

"
" Terminal
"

if has('terminal')
    hi StatusLineTerm             ctermfg=NONE ctermbg=24   cterm=NONE      guifg=NONE    guibg=#005f87 guisp=NONE
    hi StatusLineTermNC           ctermfg=NONE ctermbg=236  cterm=NONE      guifg=NONE    guibg=#303030 guisp=NONE
    hi debugPC                    ctermfg=NONE ctermbg=24   cterm=NONE      guifg=NONE    guibg=#005f87 guisp=NONE
endif

"
" Visual aid
"
hi MatchParen                 ctermfg=255  ctermbg=24   cterm=NONE      guifg=#eeeeee guibg=#005f87 guisp=NONE
hi Visual                     ctermfg=NONE ctermbg=236  cterm=NONE      guifg=NONE    guibg=#303030 guisp=NONE
hi VisualNOS                  ctermfg=NONE ctermbg=88   cterm=NONE      guifg=NONE    guibg=#870000 guisp=NONE
hi NonText                    ctermfg=102  ctermbg=NONE cterm=NONE      guifg=#878787 guibg=NONE    guisp=NONE

hi Todo                       ctermfg=0    ctermbg=3    cterm=NONE      guifg=#000000 guibg=#808000 guisp=NONE
hi Underlined                 ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE    guibg=NONE    guisp=NONE
hi Error                      ctermfg=NONE ctermbg=88   cterm=NONE      guifg=NONE    guibg=#870000 guisp=NONE
hi ErrorMsg                   ctermfg=NONE ctermbg=88   cterm=NONE      guifg=NONE    guibg=#870000 guisp=NONE
hi WarningMsg                 ctermfg=NONE ctermbg=88   cterm=NONE      guifg=NONE    guibg=#870000 guisp=NONE
hi Ignore                     ctermfg=NONE ctermbg=88   cterm=NONE      guifg=NONE    guibg=#870000 guisp=NONE
hi SpecialKey                 ctermfg=237  ctermbg=NONE cterm=NONE      guifg=#3a3a3a guibg=NONE    guisp=NONE

"
" Variable types
"
hi Constant                   ctermfg=68   ctermbg=NONE cterm=NONE      guifg=#5f87df guibg=NONE    guisp=NONE
hi String                     ctermfg=107  ctermbg=NONE cterm=NONE      guifg=#87af5f guibg=NONE    guisp=NONE
hi StringDelimiter            ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE    guibg=NONE    guisp=NONE
hi Character                  ctermfg=68   ctermbg=NONE cterm=NONE      guifg=#5f87df guibg=NONE    guisp=NONE
hi Number                     ctermfg=68   ctermbg=NONE cterm=NONE      guifg=#5f87df guibg=NONE    guisp=NONE
hi Boolean                    ctermfg=68   ctermbg=NONE cterm=NONE      guifg=#5f87df guibg=NONE    guisp=NONE
hi Float                      ctermfg=68   ctermbg=NONE cterm=NONE      guifg=#5f87df guibg=NONE    guisp=NONE

hi Function                   ctermfg=153  ctermbg=NONE cterm=NONE      guifg=#afdfff guibg=NONE    guisp=NONE
hi Identifier                 ctermfg=68   ctermbg=NONE cterm=NONE      guifg=#5f87df guibg=NONE    guisp=NONE

"
" Language constructs
"
hi Statement                  ctermfg=174  ctermbg=NONE cterm=NONE      guifg=#df8787 guibg=NONE    guisp=NONE
hi Conditional                ctermfg=174  ctermbg=NONE cterm=NONE      guifg=#df8787 guibg=NONE    guisp=NONE
hi Repeat                     ctermfg=174  ctermbg=NONE cterm=NONE      guifg=#df8787 guibg=NONE    guisp=NONE
hi Label                      ctermfg=174  ctermbg=NONE cterm=NONE      guifg=#df8787 guibg=NONE    guisp=NONE
hi Operator                   ctermfg=223  ctermbg=NONE cterm=NONE      guifg=#ffdfaf guibg=NONE    guisp=NONE
hi Keyword                    ctermfg=174  ctermbg=NONE cterm=NONE      guifg=#df8787 guibg=NONE    guisp=NONE
hi Exception                  ctermfg=174  ctermbg=NONE cterm=NONE      guifg=#df8787 guibg=NONE    guisp=NONE
hi Comment                    ctermfg=102  ctermbg=NONE cterm=NONE      guifg=#878787 guibg=NONE    guisp=NONE

hi Special                    ctermfg=219  ctermbg=NONE cterm=NONE      guifg=#ffafff guibg=NONE    guisp=NONE
hi SpecialChar                ctermfg=219  ctermbg=NONE cterm=NONE      guifg=#ffafff guibg=NONE    guisp=NONE
hi Tag                        ctermfg=9    ctermbg=NONE cterm=NONE      guifg=#ff0000 guibg=NONE    guisp=NONE
hi Delimiter                  ctermfg=223  ctermbg=NONE cterm=NONE      guifg=#ffdfaf guibg=NONE    guisp=NONE
hi SpecialComment             ctermfg=NONE ctermbg=88   cterm=NONE      guifg=NONE    guibg=#870000 guisp=NONE
hi Debug                      ctermfg=NONE ctermbg=88   cterm=NONE      guifg=NONE    guibg=#870000 guisp=NONE

"
" C like
"
hi PreProc                    ctermfg=180  ctermbg=NONE cterm=NONE      guifg=#dfaf87 guibg=NONE    guisp=NONE
hi Include                    ctermfg=180  ctermbg=NONE cterm=NONE      guifg=#dfaf87 guibg=NONE    guisp=NONE
hi Define                     ctermfg=180  ctermbg=NONE cterm=NONE      guifg=#dfaf87 guibg=NONE    guisp=NONE
hi Macro                      ctermfg=180  ctermbg=NONE cterm=NONE      guifg=#dfaf87 guibg=NONE    guisp=NONE
hi PreCondit                  ctermfg=180  ctermbg=NONE cterm=NONE      guifg=#dfaf87 guibg=NONE    guisp=NONE

hi Type                       ctermfg=205  ctermbg=NONE cterm=NONE      guifg=#ff5faf guibg=NONE    guisp=NONE
hi StorageClass               ctermfg=2    ctermbg=NONE cterm=NONE      guifg=#008000 guibg=NONE    guisp=NONE
hi Structure                  ctermfg=2    ctermbg=NONE cterm=NONE      guifg=#008000 guibg=NONE    guisp=NONE
hi Typedef                    ctermfg=2    ctermbg=NONE cterm=NONE      guifg=#008000 guibg=NONE    guisp=NONE

"
" Diff
"
hi DiffAdd                    ctermfg=NONE ctermbg=22   cterm=NONE      guifg=NONE    guibg=#1c441c guisp=NONE
hi DiffChange                 ctermfg=NONE ctermbg=17   cterm=NONE      guifg=NONE    guibg=#1c1c44 guisp=NONE
hi DiffDelete                 ctermfg=234  ctermbg=NONE cterm=NONE      guifg=#441c1c guibg=NONE    guisp=NONE
hi DiffText                   ctermfg=NONE ctermbg=24   cterm=NONE      guifg=NONE    guibg=#1c4f77 guisp=NONE

"
" Completion menu
"
hi Pmenu                      ctermfg=NONE ctermbg=236  cterm=NONE      guifg=NONE    guibg=#303030 guisp=NONE
hi PmenuSel                   ctermfg=NONE ctermbg=24   cterm=NONE      guifg=NONE    guibg=#005f87 guisp=NONE
hi PmenuSbar                  ctermfg=NONE ctermbg=236  cterm=NONE      guifg=NONE    guibg=#303030 guisp=NONE
hi PmenuThumb                 ctermfg=NONE ctermbg=24   cterm=NONE      guifg=NONE    guibg=#005f87 guisp=NONE

"
" Spelling
"
hi SpellBad                   ctermfg=NONE ctermbg=88   cterm=NONE      guifg=NONE    guibg=#870000 guisp=NONE
hi SpellCap                   ctermfg=NONE ctermbg=88   cterm=NONE      guifg=NONE    guibg=#870000 guisp=NONE
hi SpellLocal                 ctermfg=NONE ctermbg=88   cterm=NONE      guifg=NONE    guibg=#870000 guisp=NONE
hi SpellRare                  ctermfg=NONE ctermbg=88   cterm=NONE      guifg=NONE    guibg=#870000 guisp=NONE

"
" User 1
"
hi User1                      ctermfg=9    ctermbg=24   cterm=NONE      guifg=#ff0000 guibg=#005f87 guisp=NONE
