set background=dark

highlight clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="madmax"

"
" Editor settings
"
hi Normal                     ctermfg=255  ctermbg=234  cterm=none
hi Cursor                     ctermfg=none ctermbg=none cterm=none
hi CursorLine                 ctermfg=none ctermbg=24   cterm=none
hi LineNr                     ctermfg=102  ctermbg=236  cterm=none
hi CursorLineNr               ctermfg=none ctermbg=24   cterm=none

"
" Number column
"
hi CursorColumn               ctermfg=none ctermbg=88   cterm=none
hi FoldColumn                 ctermfg=none ctermbg=236  cterm=none
hi SignColumn                 ctermfg=none ctermbg=236  cterm=none
hi Folded                     ctermfg=102  ctermbg=236  cterm=none

"
" Window/Tab delimiters
"
hi VertSplit                  ctermfg=102  ctermbg=236  cterm=none
hi ColorColumn                ctermfg=none ctermbg=88   cterm=none
hi TabLine                    ctermfg=none ctermbg=236  cterm=none
hi TabLineFill                ctermfg=none ctermbg=236  cterm=none
hi TabLineSel                 ctermfg=none ctermbg=24   cterm=none

"
" File Navigation / Searching
"
hi Directory                  ctermfg=68   ctermbg=none cterm=none
hi Search                     ctermfg=16   ctermbg=250  cterm=none
hi IncSearch                  ctermfg=16   ctermbg=250  cterm=none

"
" Prompt/Status
"
hi StatusLine                 ctermfg=none ctermbg=24   cterm=none
hi StatusLineNC               ctermfg=none ctermbg=236  cterm=none
hi WildMenu                   ctermfg=none ctermbg=none cterm=none
hi Question                   ctermfg=none ctermbg=24   cterm=none
hi Title                      ctermfg=none ctermbg=24   cterm=none
hi ModeMsg                    ctermfg=none ctermbg=24   cterm=none
hi MoreMsg                    ctermfg=none ctermbg=24   cterm=none

"
" Visual aid
"
hi MatchParen                 ctermfg=none ctermbg=240  cterm=none
hi Visual                     ctermfg=none ctermbg=240  cterm=none
hi VisualNOS                  ctermfg=none ctermbg=88   cterm=none
hi NonText                    ctermfg=102  ctermbg=none cterm=none

hi Todo                       ctermfg=0    ctermbg=3    cterm=none
hi Underlined                 ctermfg=none ctermbg=none cterm=underline
hi Error                      ctermfg=none ctermbg=88   cterm=none
hi ErrorMsg                   ctermfg=none ctermbg=88   cterm=none
hi WarningMsg                 ctermfg=none ctermbg=88   cterm=none
hi Ignore                     ctermfg=none ctermbg=88   cterm=none
hi SpecialKey                 ctermfg=237 ctermbg=none cterm=none

"
" Variable types
"
hi Constant                   ctermfg=68   ctermbg=none cterm=none
hi String                     ctermfg=107  ctermbg=none cterm=none
hi StringDelimiter            ctermfg=none ctermbg=none cterm=underline
hi Character                  ctermfg=68   ctermbg=none cterm=none
hi Number                     ctermfg=68   ctermbg=none cterm=none
hi Boolean                    ctermfg=68   ctermbg=none cterm=none
hi Float                      ctermfg=68   ctermbg=none cterm=none

hi Function                   ctermfg=153  ctermbg=none cterm=none
hi Identifier                 ctermfg=68   ctermbg=none cterm=none

"
" Language constructs
"
hi Statement                  ctermfg=174  ctermbg=none cterm=none
hi Conditional                ctermfg=174  ctermbg=none cterm=none
hi Repeat                     ctermfg=174  ctermbg=none cterm=none
hi Label                      ctermfg=174  ctermbg=none cterm=none
hi Operator                   ctermfg=223  ctermbg=none cterm=none
hi Keyword                    ctermfg=174  ctermbg=none cterm=none
hi Exception                  ctermfg=174  ctermbg=none cterm=none
hi Comment                    ctermfg=102  ctermbg=none cterm=none

hi Special                    ctermfg=219  ctermbg=none cterm=none
hi SpecialChar                ctermfg=219  ctermbg=none cterm=none
hi Tag                        ctermfg=9    ctermbg=none cterm=none
hi Delimiter                  ctermfg=223  ctermbg=none cterm=none
hi SpecialComment             ctermfg=none ctermbg=88   cterm=none
hi Debug                      ctermfg=none ctermbg=88   cterm=none

"
" C like
"
hi PreProc                    ctermfg=180  ctermbg=none cterm=none
hi Include                    ctermfg=180  ctermbg=none cterm=none
hi Define                     ctermfg=180  ctermbg=none cterm=none
hi Macro                      ctermfg=180  ctermbg=none cterm=none
hi PreCondit                  ctermfg=180  ctermbg=none cterm=none

hi Type                       ctermfg=205  ctermbg=none cterm=none
hi StorageClass               ctermfg=2    ctermbg=none cterm=none
hi Structure                  ctermfg=2    ctermbg=none cterm=none
hi Typedef                    ctermfg=2    ctermbg=none cterm=none

"
" Diff
"
hi DiffAdd                    ctermfg=none ctermbg=22   cterm=none
hi DiffChange                 ctermfg=none ctermbg=24   cterm=none
hi DiffDelete                 ctermfg=102  ctermbg=52   cterm=none
hi DiffText                   ctermfg=16   ctermbg=250  cterm=none

"
" Completion menu
"
hi Pmenu                      ctermfg=none ctermbg=236  cterm=none
hi PmenuSel                   ctermfg=none ctermbg=24   cterm=none
hi PmenuSbar                  ctermfg=none ctermbg=236  cterm=none
hi PmenuThumb                 ctermfg=none ctermbg=24   cterm=none

"
" Spelling
"
hi SpellBad                   ctermfg=none ctermbg=88   cterm=none
hi SpellCap                   ctermfg=none ctermbg=88   cterm=none
hi SpellLocal                 ctermfg=none ctermbg=88   cterm=none
hi SpellRare                  ctermfg=none ctermbg=88   cterm=none

"
" User 1
"
hi User1                      ctermfg=9    ctermbg=24   cterm=none
