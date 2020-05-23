" Vim syntax file
" Language:	DQNote
" Maintainer:	DQ
" Version:	1.32.3
" Last Change:	22 May 2020

" Quit when a (custom) syntax file was already loaded {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists("b:current_syntax")
  finish
endif
" }}}1
"=====================================================================
" Syntax {{{1
""""""""""""""""""""""""""""""""""""""""
" Titles {{{2
""""""""""""""""""""
syn match dqnTitle1 /^\[\~{ .\+ }\~]\ze\%( \={\{3}1\)\=$/ contains=@Spell
      \ display
syn match dqnTitle2 /^ \zs== .\+ ==\ze\%( \={\{3}2\)\=$/ contains=@Spell
      \ display
syn match dqnTitle3 /^  \zs> .\+ <\ze\%( \={\{3}3\)\=$/ contains=@Spell
      \ display
syn match dqnSubtitle /^\t* \{3}\zs|.\+|\ze\%( \={\{3}\d\=\)\=$/ contains=@Spell
      \ display
syn cluster dqnTitle add=dqnTitle1,dqnTitle2,dqnTitle3,dqnSubtitle

" Coloured highlighting without background {{{2
""""""""""""""""""""
syn region dqnYellow  matchgroup=dqnMark start=+\[\[+ end=+]]+ concealends
      \ contains=@Spell,dqnBreak
syn region dqnGreen   matchgroup=dqnMark start=+\[{+ end=+]}+ concealends
      \ contains=@Spell,dqnBreak
syn region dqnBlue    matchgroup=dqnMark start=+\['+ end=+]'+ concealends
      \ contains=@Spell,dqnBreak
syn region dqnOrange  matchgroup=dqnMark start=+\[-+ end=+]-+ concealends
      \ contains=@Spell,dqnBreak
syn region dqnPurple  matchgroup=dqnMark start=+\[=+ end=+]=+ concealends
      \ contains=@Spell,dqnBreak
syn region dqnCyan    matchgroup=dqnMark start=+\["+ end=+]"+ concealends
      \ contains=@Spell,dqnBreak
syn region dqnMagenta matchgroup=dqnMark start=+\[;+ end=+];+ concealends
      \ contains=@Spell,dqnBreak
syn region dqnRed     matchgroup=dqnMark start=+\[/+ end=+]/+ concealends
      \ contains=@Spell,dqnBreak
syn region dqnGray    matchgroup=dqnMark start=+\[,+ end=+],+ concealends
      \ contains=@Spell,dqnBreak
syn region dqnBkgrd   matchgroup=dqnMark start=+\[_+ end=+]_+ concealends
      \ contains=@Spell,dqnBreak
syn cluster dqnColor add=dqnYellow,dqnGreen,dqnBlue,dqnOrange,dqnPurple
      \,dqnCyan,dqnMagenta,dqnRed,dqnGray,dqnBkgrd

" Coloured highlighting with gray background {{{2
""""""""""""""""""""
syn region dqnBgYellow  matchgroup=dqnMark start=+`\[+ end=+`]+ concealends
      \ contains=@Spell,dqnBgBreak
syn region dqnBgGreen   matchgroup=dqnMark start=+`{+  end=+`}+ concealends
      \ contains=@Spell,dqnBgBreak
syn region dqnBgBlue    matchgroup=dqnMark start=+`'+  end=+`'+ concealends
      \ contains=@Spell,dqnBgBreak
syn region dqnBgOrange  matchgroup=dqnMark start=+`-+  end=+`-+ concealends
      \ contains=@Spell,dqnBgBreak
syn region dqnBgPurple  matchgroup=dqnMark start=+`=+  end=+`=+ concealends
      \ contains=@Spell,dqnBgBreak
syn region dqnBgCyan    matchgroup=dqnMark start=+`"+  end=+`"+ concealends
      \ contains=@Spell,dqnBgBreak
syn region dqnBgMagenta matchgroup=dqnMark start=+`;+  end=+`;+ concealends
      \ contains=@Spell,dqnBgBreak
syn region dqnBgRed     matchgroup=dqnMark start=+`/+  end=+`/+ concealends
      \ contains=@Spell,dqnBgBreak
syn region dqnBgGray    matchgroup=dqnMark start=+`,+  end=+`,+ concealends
      \ contains=@Spell,dqnBgBreak
syn region dqnBgBkgrd   matchgroup=dqnMark start=+`_+  end=+`_+ concealends
      \ contains=@Spell,dqnBgBreak
syn region dqnBgFrgrd   matchgroup=dqnMark start=+`\\+ end=+`\\+
      \ concealends contains=@Spell,dqnBgBreak
syn cluster dqnBgColor add=dqnBgYellow,dqnBgGreen,dqnBgBlue,dqnBgOrange
      \,dqnBgPurple,dqnBgCyan,dqnBgMagenta,dqnBgRed,dqnBgGray,dqnBgBkgrd
      \,dqnBgFrgrd

syn region dqnCode     matchgroup=dqnMark start=+\[\\+ end=+]\\+ concealends
      \ contains=@NoSpell,dqnBreak
syn region dqnCodeType matchgroup=dqnMark start=+\[|+ end=+]|+   concealends
      \ contains=@NoSpell,dqnBreak
syn cluster dqnBgColor add=dqnCode,dqnCodeType

" Keywords {{{2
""""""""""""""""""""
syn keyword dqnKeyword DUNNO NOTE WARN
syn match   dqnKeyword +/?/+ display

" Tags TODO {{{2
""""""""""""""""""""

" Others {{{2
""""""""""""""""""""
syn region dqnCode     matchgroup=dqnMark start=+\[\\+ end=+]\\+ concealends
      \ contains=@NoSpell,dqnBreak
syn region dqnCodeType matchgroup=dqnMark start=+\[|+ end=+]|+   concealends
      \ contains=@NoSpell,dqnBreak
syn match dqnComment +///.*$+ keepend display contains=@Spell
syn match dqnFoldMark /{\{3}[0-9]\{0,1}/ display
syn match dqnFoldMark /}\{3}[0-9]\{0,1}/ display

" Concealed {{{2
""""""""""""""""""""
" A mark used to prevent DQNYank() from joining the following line:
syn match dqnBreak /░\ze$/ conceal display
syn region dqnConceal matchgroup=dqnMark start=+\[\.+ end=+]\.+ concealends
      \ conceal cchar=▒ contains=@Spell,dqnBreak
" Used to prevent matching dqn syntax:
syn match dqnNomatch +[`[]\zs`\ze[[{'-=";/,_\\|.]+ conceal display
syn match dqnNomatch +[]`]\zs`\ze[]}'-=";/,_\\|.]+ conceal display
      \ containedin=@dqnColor,@dqnBgColor

" Include syntax for other filetype {{{2
""""""""""""""""""""
" Python {{{3
""""""""""
syn include @dqnPython syntax/python.vim
syn region  dqnPython matchgroup=dqnMark start=/#beginPython#$/ end=/#endPython#$/
      \ contains=@dqnPython

"" Setting colors according to colorscheme {{{1
"""""""""""""""""""""""""""""""""""""""""
"" Solarized Colorscheme: t_Co>=16 && g:solarized_termcolors != 256 {{{2
"""""""""""""""""""""
"if g:colors_name =~ 'solarized' && &t_Co>=16 && g:solarized_termcolors != 256
"      \ && !has("gui_running")
"
"let g_yellow  = '#b58900'
"let g_green   = '#859900'
"let g_blue    = '#268bd2'
"let g_orange  = '#cb4b16'
"let g_purple  = '#6c71c4'
"let g_cyan    = '#2aa198'
"let g_magenta = '#d33682'
"let g_red     = '#dc322f'
"  if &background ==# 'dark'
"let g_gray  = '#657b83'
"let g_bkgrd = '#002b36'
"let g_frgrd = '#fdf6e3'
"  else
"let g_gray  = '#93a1a1'
"let g_bkgrd = '#fdf6e3'
"let g_frgrd = '#002b36'
"  endif
"  
"let t_yellow  = '3'
"let t_green   = '2'
"let t_blue    = '4'
"let t_orange  = '9'
"let t_purple  = '13'
"let t_cyan    = '6'
"let t_magenta = '5'
"let t_red     = '1'
"  if &background ==# 'dark'
"let t_gray  = '10'
"let t_bkgrd = '8'
"let t_frgrd = '15'
"  else
"let t_gray  = '14'
"let t_bkgrd = '15'
"let t_frgrd = '8'
"  endif
"
"" Solarized Colorscheme: gui || t_Co<16 || g:solarized_termcolors==256 {{{2
"""""""""""""""""""""
"elseif g:colors_name =~ 'solarized'
"
"let g_yellow  = '#b58900'
"let g_green   = '#859900'
"let g_blue    = '#268bd2'
"let g_orange  = '#cb4b16'
"let g_purple  = '#6c71c4'
"let g_cyan    = '#2aa198'
"let g_magenta = '#d33682'
"let g_red     = '#dc322f'
"  if &background ==# 'dark'
"let g_gray  = '#657b83'
"let g_bkgrd = '#002b36'
"let g_frgrd = '#fdf6e3'
"  else
"let g_gray  = '#93a1a1'
"let g_bkgrd = '#fdf6e3'
"let g_frgrd = '#002b36'
"  endif
"  
"  if t_Co<16
"let t_yellow  = 'darkyellow'
"let t_green   = 'darkgreen'
"let t_blue    = 'darkblue'
"let t_orange  = 'lightred'
"let t_purple  = 'lightmagenta'
"let t_cyan    = 'darkcyan'
"let t_magenta = 'darkmagenta'
"let t_red     = 'darkred'
"    if &background ==# 'dark'
"let t_gray  = 'lightgreen'
"let t_bkgrd = 'darkgray'
"let t_frgrd = 'white'
"    else
"let t_gray  = 'lightcyan'
"let t_bkgrd = 'white'
"let t_frgrd = 'darkgray'
"    endif
"
"  else " if t_Co >= 16 i.e. g:solarized_termcolors == 256
"let t_yellow  = '136'
"let t_green   = '64'
"let t_blue    = '33'
"let t_orange  = '166'
"let t_purple  = '61'
"let t_cyan    = '37'
"let t_magenta = '125'
"let t_red     = '160'
"    if &background ==# 'dark'
"let t_gray  = '240'
"let t_bkgrd = '234'
"let t_frgrd = '230'
"    else
"let t_gray  = '245'
"let t_bkgrd = '230'
"let t_frgrd = '234'
"    endif
"  endif
"
"" Other colorscheme {{{2
"""""""""""""""""""""
"else " colorscheme other than solarized
"
"let g_yellow  = 'yellow'
"let g_green   = 'green'
"let g_blue    = 'blue'
"let g_orange  = 'orange'
"let g_purple  = 'darkmagenta'
"let g_cyan    = 'cyan'
"let g_magenta = 'magenta'
"let g_red     = 'darkred'
"  if &background ==# 'dark'
"let g_gray  = 'darkgray'
"let g_bkgrd = 'black'
"let g_frgrd = 'white'
"  else
"let g_gray  = 'lightgray'
"let g_bkgrd = 'white'
"let g_frgrd = 'black'
"  endif
"
"let t_yellow  = 'yellow'
"let t_green   = 'green'
"let t_blue    = 'blue'
"let t_orange  = 'orange'
"let t_purple  = 'darkmagenta'
"let t_cyan    = 'cyan'
"let t_magenta = 'magenta'
"let t_red     = 'darkred'
"  if &background ==# 'dark'
"let t_gray  = 'darkgray'
"let t_bkgrd = 'black'
"let t_frgrd = 'white'
"  else
"let t_gray  = 'lightgray'
"let t_bkgrd = 'white'
"let t_frgrd = 'black'
"  endif
"
"endif " colorscheme: =~ solarized OR else
"
" Old Highlighting {{{1
""""""""""""""""""""""""""""""""""""""""
" Solarized Colorscheme: t_Co>=16 && g:solarized_termcolors != 256 {{{2
""""""""""""""""""""
if g:colors_name =~ 'solarized' && &t_Co>=16 && g:solarized_termcolors != 256
      \ && !has("gui_running")
" Titles {{{3
""""""""""
  if &t_Co >= 256 && &background ==# 'dark'
hi     dqnTitle1   ctermfg=213 cterm=bold
hi     dqnTitle2   ctermfg=215 cterm=bold
hi     dqnTitle3   ctermfg=43  cterm=bold
hi     dqnSubtitle ctermfg=111
  elseif &t_Co >= 256
hi     dqnTitle1   ctermfg=133 cterm=bold
hi     dqnTitle2   ctermfg=130 cterm=bold
hi     dqnTitle3   ctermfg=30  cterm=bold
hi     dqnSubtitle ctermfg=25
  else " if &t_Co < 256
hi def dqnTitle1   ctermfg=5 cterm=bold
hi def dqnTitle2   ctermfg=9 cterm=bold
hi def dqnTitle3   ctermfg=2 cterm=bold
hi def dqnSubtitle ctermfg=4 cterm=bold
  endif

" Coloured highlighting without background {{{3
""""""""""
hi def dqnYellow  ctermfg=3  cterm=none
hi def dqnGreen   ctermfg=2  cterm=none
hi def dqnBlue    ctermfg=4  cterm=none
hi def dqnOrange  ctermfg=9  cterm=none
hi def dqnPurple  ctermfg=13 cterm=none
hi def dqnCyan    ctermfg=6  cterm=none
hi def dqnMagenta ctermfg=5  cterm=none
hi def dqnRed     ctermfg=1  cterm=none
hi def dqnGray    ctermfg=11 cterm=none
if &bg ==# 'dark'
  hi def dqnBkgrd ctermfg=8  cterm=none
else
  hi def dqnBkgrd ctermfg=15 cterm=none
endif

" Coloured highlighting with gray background {{{3
""""""""""
hi def dqnBgYellow  ctermfg=3  cterm=none ctermbg=10
hi def dqnBgGreen   ctermfg=2  cterm=none ctermbg=10
hi def dqnBgBlue    ctermfg=4  cterm=none ctermbg=10
hi def dqnBgOrange  ctermfg=9  cterm=none ctermbg=10
hi def dqnBgPurple  ctermfg=13 cterm=none ctermbg=10
hi def dqnBgCyan    ctermfg=6  cterm=none ctermbg=10
hi def dqnBgMagenta ctermfg=5  cterm=none ctermbg=10
hi def dqnBgRed     ctermfg=1  cterm=none ctermbg=10
hi def dqnBgGray    ctermfg=11 cterm=none ctermbg=10
  if &bg ==# 'dark'
hi def dqnBgBkgrd   ctermfg=8  cterm=none ctermbg=10
hi def dqnBgFrgrd   ctermfg=15 cterm=none ctermbg=10
  else
hi def dqnBgBkgrd   ctermfg=15 cterm=none ctermbg=10
hi def dqnBgFrgrd   ctermfg=8  cterm=none ctermbg=10
  endif
hi def dqnCode      ctermfg=14 cterm=none ctermbg=10
hi def dqnCodeType  ctermfg=6  cterm=none ctermbg=10

" Keywords and others {{{3
""""""""""
hi def link dqnKeyword  Todo
hi def      dqnMark     ctermfg=10 cterm=none
hi def link dqnFoldMark dqnBkgrd
hi def link dqnComment  Comment
hi def link dqnNomatch  dqnBgFrgrd

" Solarized Colorscheme: gui || t_Co<16 || g:solarized_termcolors ==256 {{{2
""""""""""""""""""""
elseif g:colors_name =~ 'solarized'
" Titles {{{3
""""""""""
  if (has("gui_running") || &t_Co >= 256) && &background ==# 'dark'
hi     dqnTitle1   guifg=#ff87ff ctermfg=213 gui=bold cterm=bold
hi     dqnTitle2   guifg=#ffaf5f ctermfg=215 gui=bold cterm=bold
hi     dqnTitle3   guifg=#00d7af ctermfg=43  gui=bold cterm=bold
hi     dqnSubtitle guifg=#87afff ctermfg=111 gui=bold 
  elseif has("gui_running") || &t_Co >= 256
hi     dqnTitle1   guifg=#af5faf ctermfg=133 gui=bold cterm=bold
hi     dqnTitle2   guifg=#af5f00 ctermfg=130 gui=bold cterm=bold
hi     dqnTitle3   guifg=#008787 ctermfg=30  gui=bold cterm=bold
hi     dqnSubtitle guifg=#005faf ctermfg=25  gui=bold 
  else " if &t_Co < 256
hi def dqnTitle1   ctermfg=darkmagenta cterm=bold
hi def dqnTitle2   ctermfg=lightred    cterm=bold
hi def dqnTitle3   ctermfg=darkgreen   cterm=bold
hi def dqnSubtitle ctermfg=darkblue    cterm=bold
  endif

" Coloured highlighting without background {{{3
""""""""""
hi def dqnYellow  guifg=#b58900 ctermfg=darkyellow   gui=none cterm=none
hi def dqnGreen   guifg=#859900 ctermfg=darkgreen    gui=none cterm=none
hi def dqnBlue    guifg=#268bd2 ctermfg=darkblue     gui=none cterm=none
hi def dqnOrange  guifg=#cb4b16 ctermfg=lightred     gui=none cterm=none
hi def dqnPurple  guifg=#6c71c4 ctermfg=lightmagenta gui=none cterm=none
hi def dqnCyan    guifg=#2aa198 ctermfg=darkcyan     gui=none cterm=none
hi def dqnMagenta guifg=#d33682 ctermfg=darkmagenta  gui=none cterm=none
hi def dqnRed     guifg=#dc322f ctermfg=darkred      gui=none cterm=none
hi def dqnGray    guifg=#586e75 ctermfg=lightgreen   gui=none cterm=none
  if &bg ==# 'dark'
hi def dqnBkgrd guifg=#002b36 ctermfg=darkgray     gui=none cterm=none
  else
hi def dqnBkgrd guifg=#fdf6e3 ctermfg=white        gui=none cterm=none
  endif

" Coloured highlighting with gray background {{{3
""""""""""
hi def dqnBgYellow  guifg=#b58900 ctermfg=darkyellow   gui=none cterm=none
      \ guibg=#586e75 ctermbg=lightgreen
hi def dqnBgGreen   guifg=#859900 ctermfg=darkgreen    gui=none cterm=none
      \ guibg=#586e75 ctermbg=lightgreen
hi def dqnBgBlue    guifg=#268bd2 ctermfg=darkblue     gui=none cterm=none
      \ guibg=#586e75 ctermbg=lightgreen
hi def dqnBgOrange  guifg=#cb4b16 ctermfg=lightred     gui=none cterm=none
      \ guibg=#586e75 ctermbg=lightgreen
hi def dqnBgPurple  guifg=#6c71c4 ctermfg=lightmagenta gui=none cterm=none
      \ guibg=#586e75 ctermbg=lightgreen
hi def dqnBgCyan    guifg=#2aa198 ctermfg=darkcyan     gui=none cterm=none
      \ guibg=#586e75 ctermbg=lightgreen
hi def dqnBgMagenta guifg=#d33682 ctermfg=darkmagenta  gui=none cterm=none
      \ guibg=#586e75 ctermbg=lightgreen
hi def dqnBgRed     guifg=#dc322f ctermfg=darkred      gui=none cterm=none
      \ guibg=#586e75 ctermbg=lightgreen
hi def dqnBgGray    guifg=#586e75 ctermfg=lightgreen   gui=none cterm=none
      \ guibg=#586e75 ctermbg=lightgreen
  if &bg ==# 'dark'
hi def dqnBgBkgrd   guifg=#002b36 ctermfg=darkgray     gui=none cterm=none
    \ guibg=#586e75 ctermbg=lightgreen
hi def dqnBgFrgrd   guifg=#fdf6e3 ctermfg=white        gui=none cterm=none
    \ guibg=#586e75 ctermbg=lightgreen
  else
hi def dqnBgBkgrd   guifg=#fdf6e3 ctermfg=white        gui=none cterm=none
    \ guibg=#586e75 ctermbg=lightgreen
hi def dqnBgFrgrd   guifg=#002b36 ctermfg=darkgray     gui=none cterm=none
    \ guibg=#586e75 ctermbg=lightgreen
  endif
hi def dqnCode      guifg=#93a1a1 ctermfg=lightcyan    gui=none cterm=none
    \ guibg=#586e75 ctermbg=lightgreen
hi def dqnCodeType  guifg=#2aa198 ctermfg=darkcyan     gui=none cterm=none
    \ guibg=#586e75 ctermbg=lightgreen

" Keywords and others {{{3
""""""""""
hi def link dqnKeyword  Todo
hi def dqnMark    guifg=#586e75 ctermfg=lightgreen gui=none cterm=none
hi def link dqnFoldMark dqnBkgrd
hi def link dqnComment  Comment
hi def link dqnNomatch  dqnBgFrgrd

" Other colorscheme {{{2
""""""""""""""""""""
else " colorscheme other than solarized
" Titles {{{3
""""""""""
hi def dqnTitle1   guifg=cyan  ctermfg=cyan  gui=bold cterm=bold
hi def dqnTitle2   guifg=brown ctermfg=brown gui=bold cterm=bold
hi def dqnTitle3   guifg=green ctermfg=green gui=bold cterm=bold
hi def dqnSubtitle guifg=blue  ctermfg=blue  gui=bold cterm=bold

" Coloured highlighting without background {{{3
""""""""""
hi def dqnYellow  guifg=yellow      ctermfg=yellow      gui=none cterm=none
hi def dqnGreen   guifg=green       ctermfg=green       gui=none cterm=none
hi def dqnBlue    guifg=blue        ctermfg=blue        gui=none cterm=none
hi def dqnOrange  guifg=brown       ctermfg=brown       gui=none cterm=none
hi def dqnPurple  guifg=darkmagenta ctermfg=darkmagenta gui=none cterm=none
hi def dqnCyan    guifg=cyan        ctermfg=cyan        gui=none cterm=none
hi def dqnMagenta guifg=magenta     ctermfg=magenta     gui=none cterm=none
hi def dqnRed     guifg=darkred     ctermfg=darkred     gui=none cterm=none
hi def dqnGray    guifg=darkgray    ctermfg=darkgray    gui=none cterm=none
  if &bg ==# 'dark'
hi def dqnBkgrd   guifg=black     ctermfg=black       gui=none cterm=none
  else
hi def dqnBkgrd   guifg=white     ctermfg=white       gui=none cterm=none
  endif

" Coloured highlighting with gray background {{{3
""""""""""
hi def dqnBgYellow  guifg=yellow      ctermfg=yellow      gui=none cterm=none
      \ guibg=darkgray ctermbg=darkgray
hi def dqnBgGreen   guifg=green       ctermfg=green       gui=none cterm=none
      \ guibg=darkgray ctermbg=darkgray
hi def dqnBgBlue    guifg=blue        ctermfg=blue        gui=none cterm=none
      \ guibg=darkgray ctermbg=darkgray
hi def dqnBgOrange  guifg=brown       ctermfg=brown       gui=none cterm=none
      \ guibg=darkgray ctermbg=darkgray
hi def dqnBgPurple  guifg=darkmagenta ctermfg=darkmagenta gui=none cterm=none
      \ guibg=darkgray ctermbg=darkgray
hi def dqnBgCyan    guifg=cyan        ctermfg=cyan        gui=none cterm=none
      \ guibg=darkgray ctermbg=darkgray
hi def dqnBgMagenta guifg=magenta     ctermfg=magenta     gui=none cterm=none
      \ guibg=darkgray ctermbg=darkgray
hi def dqnBgRed     guifg=darkred     ctermfg=darkred     gui=none cterm=none
      \ guibg=darkgray ctermbg=darkgray
hi def dqnBgGray    guifg=darkgray    ctermfg=darkgray    gui=none cterm=none
      \ guibg=darkgray ctermbg=darkgray

  if &bg ==# 'dark'
hi def dqnBgBkgrd   guifg=black     ctermfg=black       gui=none cterm=none
      \ guibg=darkgray ctermbg=darkgray
hi def dqnBgFrgrd   guifg=white     ctermfg=white       gui=none cterm=none
      \ guibg=darkgray ctermbg=darkgray
  else
hi def dqnBgBkgrd   guifg=white     ctermfg=white       gui=none cterm=none
      \ guibg=darkgray ctermbg=darkgray
hi def dqnBgFrgrd   guifg=black     ctermfg=black       gui=none cterm=none
      \ guibg=darkgray ctermbg=darkgray
  endif

hi def dqnCode      guifg=white     ctermfg=white       gui=none cterm=none
    \ guibg=darkgray ctermbg=darkgray
hi def dqnCodeType  guifg=cyan      ctermfg=cyan        gui=none cterm=none
    \ guibg=darkgray ctermbg=darkgray

" Keywords and others {{{3
""""""""""
hi def link dqnKeyword  Todo
hi def dqnMark    guifg=darkgray    ctermfg=darkgray    gui=none cterm=none
hi def link dqnFoldMark dqnBkgrd
hi def link dqnComment  Comment
hi def link dqnNomatch  dqnBgFrgrd

endif " colorscheme: =~ solarized OR else

" Syntax Syncing {{{1
""""""""""""""""""""""""""""""""""""""""
syn sync match dqnIncludeSync  grouphere NONE      /#endPython#$/
syn sync match dqnIncludeSync  grouphere dqnPython /#beginPython#$/
syn sync match dqnSubtitleSync grouphere NONE      /^\t* \{3}|.\+|$/
syn sync match dqnFoldMarkSync grouphere NONE      /{\{3}[0-9]/
syn sync minlines=1 maxlines=100
" }}}1
"=====================================================================
" To reapply cleared highlightings upon colorscheme change {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This is needed because changing 'background' causes changing colorscheme,
" and whenever new colorscheme is applied, all defined highlightings are
" cleared before reapplying what defined by the new colorscheme's scipt. Since
" no colorscheme will ever define dqn syntax highlighting, therefore we need
" to force vim to reapply dqn filetype settings. Maybe there is a smarter way
" to just reapply the syntax highlighting though (perhaps by sourcing the
" syntax file only?). Now we need to store the current winnr and later return
" to it because I used :windo which moves the cursor to the last window
" applied by :windo.

augroup dqnHighlight
  au!
  autocmd ColorScheme * let g:storewinnr = winnr()
  autocmd ColorScheme * windo if &ft==#'dqn'|let &ft=&ft|end
  autocmd ColorScheme * exe 'normal ' . string(g:storewinnr)
	\ . "\<C-w>\<C-w>" | unlet g:storewinnr
augroup END

" Vim thingy {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let b:current_syntax = "dqn"
" vim: sts=2 sw=2 fdm=marker
