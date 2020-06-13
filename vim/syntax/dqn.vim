" Vim syntax file
" Language:     DQNote
" Maintainer:   DQ
" Version:      1.35.0 (DQN v1.35)
" Last Change:  13 Jun 2020
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO differentiate background colour and shade fg colour.
" TODO Src Block allows fold marks

" Quit when a (custom) syntax file was already loaded {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists("b:current_syntax")
  finish
endif
" }}}1
"=====================================================================
" Syntax {{{1
""""""""""""""""""""""""""""""""""""""""
" Coloured highlighting without background {{{2
""""""""""""""""""""
syn region dqnRed     matchgroup=dqnMark start=+\[/+ end=+]/+ skip=+\~]+
  \ concealends contains=@Spell,dqnBreak,@dqnColor,@dqnBgColor
syn region dqnOrange  matchgroup=dqnMark start=+\[-+ end=+]-+ skip=+\~]+
  \ concealends contains=@Spell,dqnBreak,@dqnColor,@dqnBgColor
syn region dqnYellow  matchgroup=dqnMark start=+\[\[+ end=+]]+ skip=+\~]+
  \ concealends contains=@Spell,dqnBreak,@dqnColor,@dqnBgColor
syn region dqnGreen   matchgroup=dqnMark start=+\[{+ end=+]}+ skip=+\~]+
  \ concealends contains=@Spell,dqnBreak,@dqnColor,@dqnBgColor
syn region dqnCyan    matchgroup=dqnMark start=+\["+ end=+]"+ skip=+\~]+
  \ concealends contains=@Spell,dqnBreak,@dqnColor,@dqnBgColor
syn region dqnBlue    matchgroup=dqnMark start=+\['+ end=+]'+ skip=+\~]+
  \ concealends contains=@Spell,dqnBreak,@dqnColor,@dqnBgColor
syn region dqnPurple  matchgroup=dqnMark start=+\[=+ end=+]=+ skip=+\~]+
  \ concealends contains=@Spell,dqnBreak,@dqnColor,@dqnBgColor
syn region dqnMagenta matchgroup=dqnMark start=+\[;+ end=+];+ skip=+\~]+
  \ concealends contains=@Spell,dqnBreak,@dqnColor,@dqnBgColor
syn region dqnShade   matchgroup=dqnMark start=+\[,+ end=+],+ skip=+\~]+
  \ concealends contains=@Spell,dqnBreak,@dqnColor,@dqnBgColor
syn region dqnFrgrd   matchgroup=dqnMark start=+\[`+ end=+]`+ skip=+\~]+
  \ concealends contains=@Spell,dqnBreak,@dqnColor,@dqnBgColor
syn region dqnBkgrd   matchgroup=dqnMark start=+\[_+ end=+]_+ skip=+\~]+
  \ concealends contains=@Spell,dqnBreak,@dqnColor,@dqnBgColor

syn cluster dqnColor add=dqnRed,dqnOrange,dqnYellow,dqnGreen,dqnCyan,dqnBlue
  \,dqnPurple,dqnMagenta,dqnShade,dqnFrgrd,dqnBkgrd

" Coloured highlighting with gray background {{{2
""""""""""""""""""""
syn region dqnBgRed     matchgroup=dqnMark start=+{/+ end=+}/+ skip=+\~}+
  \ concealends contains=@NoSpell,dqnBreak,@dqnColor,@dqnBgColor
syn region dqnBgOrange  matchgroup=dqnMark start=+{-+ end=+}-+ skip=+\~}+
  \ concealends contains=@NoSpell,dqnBreak,@dqnColor,@dqnBgColor
syn region dqnBgYellow  matchgroup=dqnMark start=+{\[+ end=+}]+ skip=+\~}+
  \ concealends contains=@NoSpell,dqnBreak,@dqnColor,@dqnBgColor
syn region dqnBgGreen   matchgroup=dqnMark start=+{{+ end=+}}+ skip=+\~}+
  \ concealends contains=@NoSpell,dqnBreak,@dqnColor,@dqnBgColor
syn region dqnBgCyan    matchgroup=dqnMark start=+{"+ end=+}"+ skip=+\~}+
  \ concealends contains=@NoSpell,dqnBreak,@dqnColor,@dqnBgColor
syn region dqnBgBlue    matchgroup=dqnMark start=+{'+ end=+}'+ skip=+\~}+
  \ concealends contains=@NoSpell,dqnBreak,@dqnColor,@dqnBgColor
syn region dqnBgPurple  matchgroup=dqnMark start=+{=+ end=+}=+ skip=+\~}+
  \ concealends contains=@NoSpell,dqnBreak,@dqnColor,@dqnBgColor
syn region dqnBgMagenta matchgroup=dqnMark start=+{;+ end=+};+ skip=+\~}+
  \ concealends contains=@NoSpell,dqnBreak,@dqnColor,@dqnBgColor
syn region dqnBgShade   matchgroup=dqnMark start=+{,+ end=+},+ skip=+\~}+
  \ concealends contains=@NoSpell,dqnBreak,@dqnColor,@dqnBgColor
syn region dqnBgFrgrd   matchgroup=dqnMark start=+{`+ end=+}`+ skip=+\~}+
  \ concealends contains=@NoSpell,dqnBreak,@dqnColor,@dqnBgColor
syn region dqnBgBkgrd   matchgroup=dqnMark start=+{_+ end=+}_+ skip=+\~}+
  \ concealends contains=@NoSpell,dqnBreak,@dqnColor,@dqnBgColor

syn cluster dqnBgColor add=dqnBgRed,dqnBgOrange,dqnBgYellow,dqnBgGreen
  \,dqnBgCyan,dqnBgBlue,dqnBgPurple,dqnBgMagenta,dqnBgShade,dqnBgFrgrd
  \,dqnBgBkgrd

" Conceal Paragraph {{{2
""""""""""""""""""""
syn region dqnConceal matchgroup=dqnMark start=+\[\.+ end=+]\.+ skip=+\~]+
  \ concealends conceal cchar=▒ contains=@Spell,dqnBreak

" code highlighting {{{2
""""""""""""""""""""
syn match dqnEsc     +`.+he=e-1 conceal contained containedin=dqnCodeEsc
syn match dqnCodeEsc +`.+ contained display
syn match dqnCodeSym +\.\.\.\|[]{|}[]+ contained display
syn region dqnCodeAlt matchgroup=dqnMark start=+:+ end=+:+ skip=+\~:+
  \ concealends contained contains=@NoSpell,dqnCodeSym,dqnCodeEsc
syn region dqnCodeNrm matchgroup=dqnMark start=+\[\\+ end=+]\\+ skip=+\~]+
  \ concealends contains=@NoSpell,dqnCodeAlt keepend

syn cluster dqnCode add=dqnCodeNrm,dqnCodeAlt,dqnCodeSym

" Titles {{{2
""""""""""""""""""""
syn match dqnTitle1 /^\[\~{ .\+ }\~]\ze\%( \={\{3}1\)\=$/ contains=dqnTitle1Text
      \ display
syn match dqnTitle1Text /\[\~{ \zs.\+\ze }\~]/ contained contains=@Spell
syn match dqnTitle2 /^ \zs== .\+ ==\ze\%( \={\{3}2\)\=$/ contains=dqnTitle2Text
      \ display
syn match dqnTitle2Text /== \zs.\+\ze ==/ contained contains=@Spell
syn match dqnTitle3 /^  \zs> .\+ <\ze\%( \={\{3}3\)\=$/ contains=dqnTitle3Text
      \ display
syn match dqnTitle3Text /> \zs.\+\ze </ contained contains=@Spell
" \t is depricated. Use a series of 4 spaces instead, for expandtab is set.
syn match dqnSubtitle /^\%(\t\| \{4}\)* \{3}\zs|.\+|\ze\%( \={\{3}\d\=\)\=$/
      \ contains=@Spell,dqnSubtitleText display
syn match dqnSubtitleText /|\zs.\+\ze|/ contained contains=@Spell
syn cluster dqnTitle add=dqnTitle1,dqnTitle2,dqnTitle3,dqnSubtitle

" Keywords {{{2
""""""""""""""""""""
syn keyword dqnKeyword DUNNO NOTE WARN TODO XXX FIXME
syn match   dqnKeyword +/?/+ display

" Tags TODO {{{2
""""""""""""""""""""

" Others {{{2
""""""""""""""""""""
syn match dqnComment  +///.*$+ keepend display contains=@Spell
syn match dqnFoldMark /{\{3}\d\=/
syn match dqnFoldMark /}\{3}\d\=/


" Concealed {{{2
""""""""""""""""""""
" A mark used to prevent DQNYank() from joining the following line:
syn match dqnBreak /░\ze$/ conceal display
" A mark used to prevent dqn2html() recognizing the line as a list:
syn match dqnBreak /^\s*\zs░/ conceal display

" Include syntax for other filetype {{{2
""""""""""""""""""""
" Python {{{3
""""""""""
syn include @dqnPython syntax/python.vim
syn region  dqnPython matchgroup=dqnMark start=/#beginPython#\( {\{3}\d\=\)\=/ end=/#endPython#\( }\{3}\d\=\)\=/
      \ contains=@dqnPython

" Escape character (highest priority) {{{2
""""""""""""""""""""
syn match dqnEscChar +\~.+he=e-1 conceal contained contains=@NoSpell display
syn match dqnEsc     +\~[|.:`]+ transparent contains=dqnEscChar
  \ contained containedin=@dqnCode
syn match dqnEsc     +\~[]{~}[]+ transparent contains=dqnEscChar
  \ containedin=@dqnColor,@dqnBgColor,@dqnCode display

" Setting colors according to colorscheme {{{1
""""""""""""""""""""""""""""""""""""""""
" Solarized Colorscheme: t_Co>=16 && g:solarized_termcolors != 256 {{{2
""""""""""""""""""""
if g:colors_name =~ 'solarized' && &t_Co>=16 && g:solarized_termcolors != 256
      \ && !has("gui_running")

let s:g_Yellow  = '#b58900'
let s:g_Green   = '#859900'
let s:g_Blue    = '#268bd2'
let s:g_Orange  = '#cb4b16'
let s:g_Purple  = '#6c71c4'
let s:g_Cyan    = '#2aa198'
let s:g_Magenta = '#d33682'
let s:g_Red     = '#dc322f'
  if &background ==# 'dark'
let s:g_Shade = '#073642'
let s:g_Bkgrd = '#002b36'
let s:g_Frgrd = '#eee8d5'
  else
let s:g_Shade = '#eee8d5'
let s:g_Bkgrd = '#fdf6e3'
let s:g_Frgrd = '#073642'
  endif

let s:t_Yellow  = '3'
let s:t_Green   = '2'
let s:t_Blue    = '4'
let s:t_Orange  = '9'
let s:t_Purple  = '13'
let s:t_Cyan    = '6'
let s:t_Magenta = '5'
let s:t_Red     = '1'
  if g:colors_name ==# 'solarized' && &background ==# 'dark'
exe 'let s:t_Shade = ' .($TERM==#'linux' ? 0 : 236)
let s:t_Bkgrd = '8'
let s:t_Frgrd = '7'
  else
exe 'let s:t_Shade = ' .($TERM==#'linux' ? 7 : 253)
let s:t_Bkgrd = '15'
let s:t_Frgrd = '0'
  endif

" Solarized Colorscheme: gui || t_Co<16 || g:solarized_termcolors==256 {{{2
""""""""""""""""""""
elseif g:colors_name =~ 'solarized'

let s:g_Yellow  = '#b58900'
let s:g_Green   = '#859900'
let s:g_Blue    = '#268bd2'
let s:g_Orange  = '#cb4b16'
let s:g_Purple  = '#6c71c4'
let s:g_Cyan    = '#2aa198'
let s:g_Magenta = '#d33682'
let s:g_Red     = '#dc322f'
  if &background ==# 'dark'
let s:g_Shade = '#657b83'
let s:g_Bkgrd = '#002b36'
let s:g_Frgrd = '#fdf6e3'
  else
let s:g_Shade = '#93a1a1'
let s:g_Bkgrd = '#fdf6e3'
let s:g_Frgrd = '#002b36'
  endif

  if &t_Co<16
let s:t_Yellow  = 'darkyellow'
let s:t_Green   = 'darkgreen'
let s:t_Blue    = 'darkblue'
let s:t_Orange  = 'lightred'
let s:t_Purple  = 'lightmagenta'
let s:t_Cyan    = 'darkcyan'
let s:t_Magenta = 'darkmagenta'
let s:t_Red     = 'darkred'
    if &background ==# 'dark'
let s:t_Shade = 'lightgreen'
let s:t_Bkgrd = 'darkgray'
let s:t_Frgrd = 'white'
    else
let s:t_Shade = 'lightcyan'
let s:t_Bkgrd = 'white'
let s:t_Frgrd = 'darkgray'
    endif

  else " if t_Co >= 16 i.e. g:solarized_termcolors == 256
let s:t_Yellow  = '136'
let s:t_Green   = '64'
let s:t_Blue    = '33'
let s:t_Orange  = '166'
let s:t_Purple  = '61'
let s:t_Cyan    = '37'
let s:t_Magenta = '125'
let s:t_Red     = '160'
    if &background ==# 'dark'
let s:t_Shade = '240'
let s:t_Bkgrd = '234'
let s:t_Frgrd = '230'
    else
let s:t_Shade = '245'
let s:t_Bkgrd = '230'
let s:t_Frgrd = '234'
    endif
  endif

" Other colorscheme {{{2
""""""""""""""""""""
else " colorscheme other than solarized

let s:g_Yellow  = 'yellow'
let s:g_Green   = 'green'
let s:g_Blue    = 'blue'
let s:g_Orange  = 'brown'
let s:g_Purple  = 'darkmagenta'
let s:g_Cyan    = 'cyan'
let s:g_Magenta = 'magenta'
let s:g_Red     = 'darkred'
  if &background ==# 'dark'
let s:g_Shade = 'darkgray'
let s:g_Bkgrd = 'black'
let s:g_Frgrd = 'white'
  else
let s:g_Shade = 'lightgray'
let s:g_Bkgrd = 'white'
let s:g_Frgrd = 'black'
  endif

let s:t_Yellow  = 'yellow'
let s:t_Green   = 'green'
let s:t_Blue    = 'blue'
let s:t_Orange  = 'brown'
let s:t_Purple  = 'darkmagenta'
let s:t_Cyan    = 'cyan'
let s:t_Magenta = 'magenta'
let s:t_Red     = 'darkred'
  if &background ==# 'dark'
let s:t_Shade = 'darkgray'
let s:t_Bkgrd = 'black'
let s:t_Frgrd = 'white'
  else
let s:t_Shade = 'lightgray'
let s:t_Bkgrd = 'white'
let s:t_Frgrd = 'black'
  endif

endif " colorscheme: =~ solarized OR else

" Highlighting {{{1
""""""""""""""""""""""""""""""""""""""""
" Titles {{{2
""""""""""""""""""""
  if (has("gui_running") || &t_Co >= 256)
hi def dqnTitle1   guifg=#af5faf ctermfg=133 gui=bold cterm=bold
hi def dqnTitle1Text guifg=#af5faf ctermfg=133
      \ gui=bold,underline cterm=bold,underline
hi def dqnTitle2   guifg=#af5f00 ctermfg=130 gui=bold cterm=bold
hi def dqnTitle2Text guifg=#af5f00 ctermfg=130
      \ gui=bold,underline cterm=bold,underline
hi def dqnTitle3   guifg=#008787 ctermfg=30  gui=bold cterm=bold
hi def dqnTitle3Text guifg=#008787 ctermfg=30 gui=underline cterm=underline
hi  dqnSubtitle guifg=#0087af ctermfg=31 gui=bold cterm=bold
hi def dqnSubtitleText guifg=#0087af ctermfg=31 gui=none cterm=none
  else " if has('gui_running') OR &t_Co < 256
exe 'hi def dqnTitle1   guifg=' .s:g_Magenta
      \ .' ctermfg=' .s:t_Magenta .' gui=bold cterm=bold'
exe 'hi def dqnTitle2   guifg=' .s:g_Orange
      \ .' ctermfg=' .s:t_Orange  .' gui=bold cterm=bold'
exe 'hi def dqnTitle3   guifg=' .s:g_Green
      \ .' ctermfg=' .s:t_Green   .' gui=bold cterm=bold'
exe 'hi def dqnSubtitle guifg=' .s:g_Blue
      \ .' ctermfg=' .s:t_Blue    .' gui=bold cterm=bold'
  endif

" Coloured highlighting without background {{{2
""""""""""
let s:list = ['Yellow', 'Green', 'Blue', 'Orange', 'Purple', 'Cyan',
      \ 'Magenta', 'Red', 'Shade', 'Bkgrd']
for i in s:list
  exe 'hi def dqn' .i .' guifg=' .eval('s:g_'.i) .' ctermfg=' .eval('s:t_'.i)
endfor

"" Coloured highlighting with gray background {{{2
"""""""""""
let s:list = ['Yellow', 'Green', 'Blue', 'Orange', 'Purple', 'Cyan',
      \ 'Magenta', 'Red', 'Shade', 'Bkgrd', 'Frgrd']
for i in s:list
  exe 'hi def dqnBg' .i .' guifg=' .eval('s:g_'.i) .' ctermfg='
        \ .eval('s:t_'.i) . ' guibg=' .s:g_Shade .' ctermbg=' .s:t_Shade
endfor


"" Code highlighting {{{2
"""""""""""
"  if g:colors_name ==# 'solarized' && &bg ==# 'dark'
"hi def dqnCode guifg=#93a1a1 ctermfg=15 guibg=#657b83 ctermbg=10
"  elseif g:colors_name ==# 'solarized'
"hi def dqnCode guifg=#657b83 ctermfg=10 guibg=#93a1a1 ctermbg=7
"  else
hi def link dqnCodeNrm dqnBgFrgrd
  "endif
hi def link dqnCodeAlt dqnBgGreen
hi def link dqnCodeSym dqnBgOrange
hi def link dqnCodeEsc dqnCodeNrm

"" Keywords and others {{{2
"""""""""""
hi def link dqnKeyword  Todo
hi def link dqnMark     Comment
hi def link dqnFoldMark dqnBkgrd
hi def link dqnComment  Comment
hi def link dqnNomatch  dqnBgFrgrd
hi def link dqnCodeMark dqnBgOrange
hi def link dqnEscChar  Comment

" Syntax Syncing {{{1
""""""""""""""""""""""""""""""""""""""""
syn sync match dqnIncludeSync  groupthere NONE      /#endPython#$/
syn sync match dqnIncludeSync  groupthere dqnPython /#beginPython#$/
syn sync match dqnSubtitleSync groupthere NONE      /^\%(\t\| \{4}\)* \{3}|.\+|$/
syn sync match dqnFoldMarkSync groupthere NONE      /{\{3}\d\=$/
syn sync minlines=1
" }}}1
"=====================================================================
" Others {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spelling {{{2
""""""""""""""""""""""""""""""""""""""""
syn spell toplevel

" To reapply cleared highlightings upon colorscheme change {{{2
""""""""""""""""""""""""""""""""""""""""
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

