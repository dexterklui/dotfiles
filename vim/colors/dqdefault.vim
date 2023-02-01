" Vim color file

" This is the default color scheme.  It doesn't define the Normal
" highlighting, it uses whatever the colors used to be.

" First disable highlighting of non-highlighted text (the group "Normal").
" Then, set 'background' back to the dark.

" Environment Specific Overrides "{{{1
" =====================================================================
" Allow or disallow certain features based on current terminal emulator or 
" environment.

" Terminals that support italics
let s:terms_italic=[
            \"rxvt",
            \"gnome-terminal",
            \"tmux",
            \"kitty"
            \]
" For reference only, terminals are known to be incomptible.
" Terminals that are in neither list need to be tested.
let s:terms_noitalic=[
            \"iTerm.app",
            \"Apple_Terminal"
            \]
if has("gui_running")
    let s:terminal_italic=1 " TODO: could refactor to not require this at all
else
    let s:terminal_italic=0 " terminals will be guilty until proven compatible
    for term in s:terms_italic
        if $TERM_PROGRAM =~ term
            let s:terminal_italic=1
        endif
    endfor
endif

" Colorscheme initialization "{{{1
" =====================================================================
hi clear
if exists("syntax_on")
  syntax reset
endif
let colors_name = "dqdefault"

" Set color and style variables "{{{1
" =====================================================================
" 16 Color "{{{2
" ========================================
if &t_Co >= 16
  let s:black       = "0"
  let s:red         = "1"
  let s:green       = "2"
  let s:yellow      = "3"
  let s:blue        = "4"
  let s:magenta     = "5"
  let s:cyan        = "6"
  let s:white       = "7"

  let s:black_alt   = "8"
  let s:red_alt     = "9"
  let s:green_alt   = "10"
  let s:yellow_alt  = "11"
  let s:blue_alt    = "12"
  let s:magenta_alt = "13"
  let s:cyan_alt    = "14"
  let s:white_alt   = "15"

  if &background ==# "dark"
    let s:fg     = s:white
    let s:bg     = s:black
    let s:fg_alt = s:white_alt
    let s:bg_alt = s:black_alt
  else
    let s:fg     = s:black
    let s:bg     = s:white
    let s:fg_alt = s:black_alt
    let s:bg_alt = s:white_alt
  endif
endif

" format "{{{2
" ========================================
"let s:none = "NONE"
"let s:c    = ",undercurl"
"let s:r    = ",reverse"
"let s:s    = ",standout"
"let s:b    = ",bold"
"let s:i    = ",italic"
"let s:u    = ",underline"

" cterm highlight arguments "{{{2
" ========================================
" Text colors
let s:fg_none         = " ctermfg=NONE"
let s:fg_fg           = " ctermfg=" .s:fg
let s:fg_bg           = " ctermfg=" .s:bg
let s:fg_fg_alt       = " ctermfg=" .s:fg_alt
let s:fg_bg_alt       = " ctermfg=" .s:bg_alt
let s:fg_black        = " ctermfg=" .s:black
let s:fg_red          = " ctermfg=" .s:red
let s:fg_green        = " ctermfg=" .s:green
let s:fg_yellow       = " ctermfg=" .s:yellow
let s:fg_blue         = " ctermfg=" .s:blue
let s:fg_magenta      = " ctermfg=" .s:magenta
let s:fg_cyan         = " ctermfg=" .s:cyan
let s:fg_white        = " ctermfg=" .s:white
let s:fg_black_alt    = " ctermfg=" .s:black_alt
let s:fg_red_alt      = " ctermfg=" .s:red_alt
let s:fg_green_alt    = " ctermfg=" .s:green_alt
let s:fg_yellow_alt   = " ctermfg=" .s:yellow_alt
let s:fg_blue_alt     = " ctermfg=" .s:blue_alt
let s:fg_magenta_alt  = " ctermfg=" .s:magenta_alt
let s:fg_cyan_alt     = " ctermfg=" .s:cyan_alt
let s:fg_white_alt    = " ctermfg=" .s:white_alt

" Background colors
let s:bg_none         = " ctermbg=NONE"
let s:bg_fg           = " ctermbg=" .s:fg
let s:bg_bg           = " ctermbg=" .s:bg
let s:bg_fg_alt       = " ctermbg=" .s:fg_alt
let s:bg_bg_alt       = " ctermbg=" .s:bg_alt
let s:bg_black        = " ctermbg=" .s:black
let s:bg_red          = " ctermbg=" .s:red
let s:bg_green        = " ctermbg=" .s:green
let s:bg_yellow       = " ctermbg=" .s:yellow
let s:bg_blue         = " ctermbg=" .s:blue
let s:bg_magenta      = " ctermbg=" .s:magenta
let s:bg_cyan         = " ctermbg=" .s:cyan
let s:bg_white        = " ctermbg=" .s:white
let s:bg_black_alt    = " ctermbg=" .s:black_alt
let s:bg_red_alt      = " ctermbg=" .s:red_alt
let s:bg_green_alt    = " ctermbg=" .s:green_alt
let s:bg_yellow_alt   = " ctermbg=" .s:yellow_alt
let s:bg_blue_alt     = " ctermbg=" .s:blue_alt
let s:bg_magenta_alt  = " ctermbg=" .s:magenta_alt
let s:bg_cyan_alt     = " ctermbg=" .s:cyan_alt
let s:bg_white_alt    = " ctermbg=" .s:white_alt

" Colors for underlines
if has('nvim') " Nvim has no ctermul
  let s:ul_none         = " guisp=NONE"
  let s:ul_fg           = " guisp=fg"
  let s:ul_bg           = " guisp=bg"
  let s:ul_fg_alt       = " guisp=fg"
  let s:ul_bg_alt       = " guisp=bg"
  let s:ul_black        = " guisp=Black"
  let s:ul_red          = " guisp=Red"
  let s:ul_green        = " guisp=Green"
  let s:ul_yellow       = " guisp=Yellow"
  let s:ul_blue         = " guisp=Blue"
  let s:ul_magenta      = " guisp=Magenta"
  let s:ul_cyan         = " guisp=Cyan"
  let s:ul_white        = " guisp=White"
  let s:ul_black_alt    = " guisp=LightBlack"
  let s:ul_red_alt      = " guisp=LightRed"
  let s:ul_green_alt    = " guisp=LightGreen"
  let s:ul_yellow_alt   = " guisp=LightYellow"
  let s:ul_blue_alt     = " guisp=LightBlue"
  let s:ul_magenta_alt  = " guisp=LightMagenta"
  let s:ul_cyan_alt     = " guisp=LightCyan"
  let s:ul_white_alt    = " guisp=White"
else
  let s:ul_none         = " ctermul=NONE"               ." guisp=NONE"
  let s:ul_fg           = " ctermul=" .s:fg             ." guisp=fg"
  let s:ul_bg           = " ctermul=" .s:bg             ." guisp=bg"
  let s:ul_fg_alt       = " ctermul=" .s:fg_alt         ." guisp=fg"
  let s:ul_bg_alt       = " ctermul=" .s:bg_alt         ." guisp=bg"
  let s:ul_black        = " ctermul=" .s:black          ." guisp=Black"
  let s:ul_red          = " ctermul=" .s:red            ." guisp=Red"
  let s:ul_green        = " ctermul=" .s:green          ." guisp=Green"
  let s:ul_yellow       = " ctermul=" .s:yellow         ." guisp=Yellow"
  let s:ul_blue         = " ctermul=" .s:blue           ." guisp=Blue"
  let s:ul_magenta      = " ctermul=" .s:magenta        ." guisp=Magenta"
  let s:ul_cyan         = " ctermul=" .s:cyan           ." guisp=Cyan"
  let s:ul_white        = " ctermul=" .s:white          ." guisp=White"
  let s:ul_black_alt    = " ctermul=" .s:black_alt      ." guisp=LightBlack"
  let s:ul_red_alt      = " ctermul=" .s:red_alt        ." guisp=LightRed"
  let s:ul_green_alt    = " ctermul=" .s:green_alt      ." guisp=LightGreen"
  let s:ul_yellow_alt   = " ctermul=" .s:yellow_alt     ." guisp=LightYellow"
  let s:ul_blue_alt     = " ctermul=" .s:blue_alt       ." guisp=LightBlue"
  let s:ul_magenta_alt  = " ctermul=" .s:magenta_alt    ." guisp=LightMagenta"
  let s:ul_cyan_alt     = " ctermul=" .s:cyan_alt       ." guisp=LightCyan"
  let s:ul_white_alt    = " ctermul=" .s:white_alt      ." guisp=White"
endif

" Formats
let s:fmt_none        = " cterm=NONE"
let s:fmt_bold        = " cterm=bold"
let s:fmt_italic      = " cterm=italic"
let s:fmt_underline   = " cterm=underline"
let s:fmt_reverse     = " cterm=reverse"
let s:fmt_undercurl   = " cterm=undercurl"
let s:fmt_underdouble = " cterm=underdouble"
let s:fmt_standout    = " cterm=standout"

let s:fmt_b_i         = " cterm=bold,italic"
let s:fmt_b_u         = " cterm=bold,underline"
let s:fmt_b_r         = " cterm=bold,reverse"
let s:fmt_i_u         = " cterm=italic,underline"
let s:fmt_i_ud        = " cterm=italic,underdouble"

" First apply default highlight "{{{1
" =====================================================================
let s:background      = &background
colorscheme default
let &background=s:background

" Highlight "{{{1
" =====================================================================
" XXX Check :help :hi-normal-cterm
"exe "hi def Normal"         .s:fmt_none       .s:fg_fg      .s:bg_none
"
"exe "hi def ColorColumn"                                    .s:bg_bg
"exe "hi def Conceal"                          .s:fg_none    .s:bg_none
"exe "hi def Cursor"         .s:fmt_none       .s:fg_bg      .s:bg_fg
"exe "hi def lCursor"        .s:fmt_none       .s:fg_bg      .s:bg_fg
"exe "hi def CursorColumn"   .s:fmt_underline
"exe "hi def CursorLine"     .s:fmt_underline
"exe "hi def Directory"      .s:fmt_bold       .s:fg_blue
"exe "hi def DiffAdd"        .s:fmt_reverse    .s:fg_green   .s:bg_bg
"exe "hi def DiffChange"     .s:fmt_reverse    .s:fg_yellow  .s:bg_bg
"exe "hi def DiffDelete"     .s:fmt_reverse    .s:fg_red     .s:bg_bg
"exe "hi def DiffText"       .s:fmt_reverse    .s:fg_magenta .s:bg_bg
"exe "hi def EndOfBuffer"
"exe "hi def ErrorMsg"       .s:fmt_standout   .s:fg_red     .s:bg_white
"exe "hi def VertSplit"      .s:fmt_bold       .s:fg_fg      .s:bg_bg
"exe "hi def Folded"         .s:fmt_b_i        .s:fg_fg      .s:bg_none
hi Statement                                ctermfg=DarkGreen
hi Function             cterm=bold          ctermfg=DarkCyan
hi NonText                                  ctermfg=DarkGrey
hi Comment              cterm=italic        ctermfg=243
hi Constant                                 ctermfg=DarkCyan
hi Identifier                               ctermfg=DarkBlue
hi PreProc              cterm=bold          ctermfg=Brown
hi Type                                     ctermfg=Yellow
hi Underlined           cterm=underline     ctermfg=DarkMagenta
hi Ignore               cterm=NONE          ctermfg=NONE            ctermbg=NONE
hi Error                cterm=standout      ctermfg=Red             ctermbg=Black
hi Todo                 cterm=standout      ctermfg=Magenta         ctermbg=Black
hi Special                                  ctermfg=DarkRed

hi NonText                                  ctermfg=240
hi Folded               cterm=bold,italic   ctermfg=243             ctermbg=NONE

hi LineNr                                   ctermfg=243
hi SignColumn                                                       ctermbg=NONE

hi DiffAdd              cterm=reverse       ctermfg=DarkGreen       ctermbg=Black
hi DiffChange           cterm=reverse       ctermfg=DarkYellow      ctermbg=Black
hi DiffDelete           cterm=reverse       ctermfg=DarkRed         ctermbg=Black
hi DiffText             cterm=reverse       ctermfg=DarkMagenta     ctermbg=Black

exe "hi SpellBad"       .s:fmt_undercurl                            .s:bg_none      .s:ul_red
exe "hi SpellCap"       .s:fmt_undercurl                            .s:bg_none      .s:ul_blue
exe "hi SpellLocal"     .s:fmt_undercurl                            .s:bg_none      .s:ul_green
exe "hi SpellRare"      .s:fmt_undercurl                            .s:bg_none      .s:ul_magenta

" Syntastic plugin syntax highlighting "{{{2
" ========================================
"hi SyntasticWarning"          .s:bg_base01
"hi SyntasticError"            .s:bg_base01
hi SyntasticWarningSign cterm=bold          ctermfg=Yellow
hi SyntasticErrorSign   cterm=bold          ctermfg=Red

" GitGutter plugin syntax highlighting "{{{2
" ========================================
hi GitGutterAdd         cterm=bold          ctermfg=Green
hi GitGutterChange      cterm=bold          ctermfg=Yellow
hi GitGutterDelete      cterm=bold          ctermfg=Red

" Vim syntax highlighting "{{{1
" =====================================================================
hi! link vimVar Identifier
hi! link vimFunc Function
hi! link vimUserFunc Function
hi! link helpSpecial Special
hi! link vimSet Normal
hi! link vimSetEqual Normal

"hi vimCommentString     cterm=NONE    .s:fg_violet .s:bg_none
hi! link vimCommentString Comment
"hi vimCommand           cterm=NONE    .s:fg_yellow .s:bg_none
hi! link vimCommand       Statement
hi vimCmdSep            cterm=bold          ctermfg=DarkBlue        ctermbg=NONE
"hi helpExample          cterm=NONE    .s:fg_base1  .s:bg_none
hi helpExample          cterm=NONE          ctermfg=245             ctermbg=NONE
hi helpOption           cterm=NONE          ctermfg=DarkCyan        ctermbg=NONE
hi helpNote             cterm=NONE          ctermfg=DarkMagenta     ctermbg=NONE
hi helpVim              cterm=NONE          ctermfg=DarkMagenta     ctermbg=NONE
hi helpHyperTextJump    cterm=underline     ctermfg=DarkBlue        ctermbg=NONE
hi helpHyperTextEntry   cterm=NONE          ctermfg=DarkGreen       ctermbg=NONE
hi vimIsCommand         cterm=NONE          ctermfg=243             ctermbg=NONE
hi vimSynMtchOpt        cterm=NONE          ctermfg=DarkYellow      ctermbg=NONE
hi vimSynType           cterm=NONE          ctermfg=DarkCyan        ctermbg=NONE
hi vimHiLink            cterm=NONE          ctermfg=DarkBlue        ctermbg=NONE
hi vimHiGroup           cterm=NONE          ctermfg=DarkBlue        ctermbg=NONE
hi vimGroup             cterm=underdouble   ctermfg=DarkBlue        ctermbg=NONE
hi vimOption            cterm=NONE          ctermfg=Brown
hi vimHiAttrib          cterm=NONE          ctermfg=DarkMagenta

" Git and gitcommit highlighting "{{{1
" =====================================================================
"hi! link gitcommitComment Co

" }}}1

" vim: sw=2 fdm=marker tw=0
