" Vim syntax file
" Language:	DQNote
" Maintainer:	DQ
" Version:	1.32
" Last Change:	1 May 2020

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" Tags and other identifiers.
  syn region	dqnTag	    matchgroup=dqnMarker concealends start=/^\s*\%(\[\s-\|===\|  >\|\[<\).\+\n\zs^\s*\[1\ze/ end=/]1/ contains=dqnSubtag1 display
  syn region	dqnSubtag1  matchgroup=dqnMarker concealends start=/#2#/ end=/#2#/  contained nextgroup=dqnSubtag2 display
  syn region	dqnSubtag2  matchgroup=dqnMarker concealends start=/#3#/ end=/#3#/  contained nextgroup=dqnSubtag2 display


" The following two definition could be better. A syntax file can conceal the \" and use " to represent it instead.
  "syn region	confString	start=+"+ skip=+\\\\\|\\"+ end=+"+ oneline
  "syn region	dqnOption	start=+'+ skip=+\\\\\|\\'+ end=+'+ oneline

" Syntax keywords
  syn keyword	dqnTrueFalse	TRUE FALSE

" Paragraphs
  syn region	dqnParagraph		start=+/\*+ end=+\*/+ contains=dqnComment,@dqnBrackets

" Conceal leading '·' or ending '░', which is used to prevent joining lines with DQNYank().
  syn match	dqnLineBreaker conceal display	/^\s\+\zs·\ze./
  syn match	dqnLineBreaker  conceal display /░\ze$/

" Titles, items and statements
  syn match	dqnTitle1		/^###.\+###\|^\[\%( -\|\~{\) .\+ \%(- \|}\~\)]\ze\%( \={\{3}1\)\=$/ display contains=@Spell
  syn match	dqnTitle2		/^---.\+---\|^\%(\zs=\| \zs\)== .\+ ===\=\ze\%( \={\{3}2\)\=$/ display contains=@Spell
  syn match	dqnTitle3		/^\~\~\~.\+\~\~\~\|^  \zs> .\+ <\ze\%( \={\{3}3\)\=$/ display contains=@Spell
  "syn region	dqnSubtitle keepend matchgroup=dqnMarker concealends	start=+\[< + end=+]>+	oneline display
  syn match dqnSubtitleOldMk  conceal contained /\[< \|]>/
  syn match	dqnSubtitle	contains=dqnSubtitleOldMk /^\t* \{3}\zs|.\+|\ze\%( \={\{3}\d\)\=$\|^\t\+\zs\[< \S.*]>\ze\%( \={\{3}\d\)\=$/ display contains=@Spell
  syn match	dqnComment  keepend	+///.*+			contains=dqnSlash display contains=@Spell
  "syn match	dqnComment  keepend	+^\(\s*\)\@>\zs///.*+

" New colouring scheme with concealends
  syn region  dqnYellow	    contains=dqnLineBreaker,@Spell matchgroup=dqnMarker keepend concealends start=+\[\[+ end=+]]+
  syn region  dqnGreen	    contains=dqnLineBreaker,@Spell matchgroup=dqnMarker keepend concealends start=+\[{+ end=+]}+
  syn region  dqnBlue	    contains=dqnLineBreaker,@Spell matchgroup=dqnMarker keepend concealends start=+\['+ end=+]'+
  syn region  dqnOrange	    contains=dqnLineBreaker,@Spell matchgroup=dqnMarker keepend concealends start=+\[-+ end=+]-+
  syn region  dqnPurple	    contains=dqnLineBreaker,@Spell matchgroup=dqnMarker keepend concealends start=+\[=+ end=+]=+
  syn region  dqnGreenBlue  contains=dqnLineBreaker,@Spell matchgroup=dqnMarker keepend concealends start=+\["+ end=+]"+
  syn region  dqnLightBlue  contains=dqnLineBreaker,@Spell matchgroup=dqnMarker keepend concealends start=+\[;+ end=+];+
  syn region  dqnPaleBlue   contains=dqnLineBreaker,@Spell matchgroup=dqnMarker keepend concealends start=+\[,+ end=+],+
  syn region  dqnRed	    contains=dqnLineBreaker,@Spell matchgroup=dqnMarker keepend concealends start=+\[/+ end=+]/+
  syn match   dqnConceal    keepend conceal cchar=※ /\[\.\_.\{-}]\./
  syn region  dqnCode	    contains=dqnLineBreaker,@NoSpell matchgroup=dqnMarker keepend concealends start=+\[\\+ end=+]\\+
  syn region  dqnCodeClass  contains=dqnLineBreaker,@NoSpell matchgroup=dqnMarker keepend concealends start=+\[|+ end=+]|+

" Allow source blocks.
" Allow quoting source codes by including syntax highlighting for other
" languages.
  " Python
    syn include	@dqnPython  syntax/python.vim
    syn region	dqnPython   matchgroup=dqnSrcRegMat	    start=+##beginPython+ end=+##endPython+ contains=@dqnPython
    syn cluster	@dqnSrcReg  add=dqnPython
    unlet! b:current_syntax

  " Vim
    syn include	@dqnVim	    syntax/vim.vim
    syn region	dqnVim	    matchgroup=dqnSrcRegMat	    start=+"#beginVim+ end=+"#endVim+ contains=@dqnVim
    syn cluster	@dqnSrcReg  add=dqnVim
    unlet! b:current_syntax

" Syntax for Vim fold markers.
  syn match	dqnFoldMarker	/{\{3}[0-9]\{0,1}/
  syn match	dqnFoldMarker	/}\{3}[0-9]\{0,1}/

" Define syntax items. This is used for "vim" note.
  "syn keyword	dqnKeywords	Boo[lean] Variable Option Command Function
  "syn keyword	dqnKeywords	VAR OPT CMD FUN EVT
  "syn keyword	dqnKeywOpt	Boo Gl Lo

"Define highlighting
  if g:colors_name ==# 'solarized' || g:colors_name ==# 'dqsolarized'
    " Define the default highlighting.
      " Paragraphs
      hi! def link dqnParagraph Directory

    " Only used when an item doesn't have highlighting yet
      "hi! def link dqnTitle1	Todo
      "hi! def link dqnTitle2	Todo
      "hi! def link dqnTitle3	Todo
      "hi! def link dqnSubtitle	FoldColumn
      hi! def link dqnComment	Comment

    " Define highlighting for tags and other identifiers.
      hi! def link dqnTag	SignColumn
      hi! def link dqnSubtag1	SpellRare
      hi! def link dqnSubtag2	SpellCap

      hi! def link dqnYellow	Type
      hi! def link dqnGreen	Statement
      hi! def link dqnBlue	Identifier
      hi! def link dqnOrange	Preproc
      hi! def link dqnPurple	Underlined
      hi! def link dqnGreenBlue	Constant
      hi! def link dqnMarker	LineNr
      hi! def link dqnLightBlue	Todo
      hi! def link dqnPaleBlue	hsString
      hi! def link dqnRed	special
      hi! def link dqnConceal	comment
      "hi! def link dqnCode	SignColumn
      "hi! def link dqnCodeClass	Pl_3_12285958_0_472642_NONE

    " Define highlighting for source region.
      hi! def link dqnSrcRegMat	  pandocStrikeout

    " Define highlighting for Vim fold markers.
      hi! def link dqnFoldMarker  dqnBlack

    " Define highlighting for keywords
      hi! def link dqnTrueFalse   Statement

    " Define spell
      syntax spell toplevel

    " Define highlighting for "vim" note keywords.
      "hi! def link dqnKeywords    SpellCap
      "hi! def link dqnKeywOpt	    Underlined
  else
    " Define the default highlighting.
      " Paragraphs
      hi! def link dqnParagraph Directory

    " Only used when an item doesn't have highlighting yet
      hi! def link dqnTitle1	Identifier
      hi! def link dqnTitle2	orangeB
      hi! def link dqnTitle3	greenB
      hi! def link dqnSubtitle	lightBlueU
      hi! def link dqnSubtitleOldMk PmenuSel
      hi! def link dqnComment	Comment

    " Define highlighting for tags and other identifiers.
      hi! def link dqnTag	SignColumn
      hi! def link dqnSubtag1	SpellRare
      hi! def link dqnSubtag2 SpellCap

      hi! def link dqnYellow	Statement
      hi! def link dqnGreen	Type
      hi! def link dqnBlue	PreProc
      hi! def link dqnOrange	Special
      hi! def link dqnPurple	String
      hi! def link dqnGreenBlue	Identifier
      hi! def link dqnMarker	PmenuSel
      hi! def link dqnLightBlue	Directory
      hi! def link dqnPaleBlue	comment
      hi! def link dqnRed	Special
      hi! def link dqnConceal	comment
      hi! def link dqnCode	String
      hi! def link dqnCodeClass	PreProc

    " Define highlighting for source region.
      hi! def link dqnSrcRegMat DiffAdd

    " Define highlighting for Vim fold markers.
      hi! def link dqnFoldMarker  PmenuSel

    " Define highlighting for keywords
      hi! def link dqnTrueFalse   Statement

    " Define highlighting for "vim" note keywords.
      "hi! def link dqnKeywords    SpellCap
      "hi! def link dqnKeywOpt	    Underlined
  endif

" Setting Synchronzation
  syn sync match dqnFoldMarkerSync grouphere NONE /{\{3}[0-9]/
  syn sync minlines=3 maxlines=100

let b:current_syntax = "dqn"

" vim: ts=8 sw=2 fdm=indent
