" Vim syntax file
" Language:     dqn0ote
" Maintainer:   DQ
" Last Change:  Jun 21, 2018

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" Tags and other identifiers.
syn match       dqn0Tag     keepend     /\(^\s*\)\@5<!#\a\S*\ze\(\s\|$\)/ contains=dqn0Subtag1 display
syn match       dqn0Subtag1             /+[a-zA-Z0-9]\+/ contained nextgroup=dqn0Subtag2 display
syn match       dqn0Subtag2             /-[a-zA-Z0-9]\+/ contained nextgroup=dqn0Subtag2 display

" For {string}, [string], (string), <string>, /string/, :string:, "string" and 'string'.
"syn match      dqn0Curl                        /\(^\s*\)\@5<!{[^{}]\{-}}/
syn match       dqn0Curl                /{[^{}]\{-}}/ display
syn match       dqn0Brac                /\[[^\[\]]\{-}\]/ display
syn region      dqn0Paren               start=+(+ end=+)+   oneline contains=dqn0Paren display
syn match       dqn0Angle               /<[^<>]\{-}>/ display
syn match       dqn0Slash               +\S\@1<!/\{1,2}[^/*]\{-1,}/\{1,2}+ display
syn region      dqn0Colon               start=+\S\@1<!:\ze\S+ skip=+\\:+ end=+\S\zs:\ze\(\s\|\.\|,\|;\|!\|?\|$\)+ oneline display
syn region      dqn0Percent             start=+\S\@1<!%\ze\S+ skip=+\\%+ end=+\S\zs%\ze\(\s\|\.\|,\|;\|!\|?\|$\)+ oneline display
syn region      dqn0Bar                 start=+\S\@1<!|\ze\S+ skip=+\\|+ end=+\S\zs|\ze\(\s\|\.\|,\|;\|!\|?\|$\)+ oneline display
syn region      dqn0String              start=+\S\@1<!"\ze\S+ end=+\S\zs"\ze\(\s\|\.\|,\|;\|!\|?\|$\)+ oneline display
syn region      dqn0Option              start=+\S\@1<!'\ze\S+ end=+\S\zs'\ze\(\s\|\.\|,\|;\|!\|?\|$\)+ oneline display

" The following two definition could be better. A syntax file can conceal the \" and use " to represent it instead.
"syn region     confString      start=+"+ skip=+\\\\\|\\"+ end=+"+ oneline
"syn region     dqn0Option      start=+'+ skip=+\\\\\|\\'+ end=+'+ oneline
syn cluster     dqn0Brackets contains=dqn0Curl,dqn0Brac,dqn0Paren,dqn0Angle,dqn0Slash,dqn0Colon,dqn0Percent,dqn0Bar,dqn0String,dqn0Option

" Syntax keywords
syn keyword     dqn0TrueFalse   TRUE FALSE

" Paragraphs
syn region      dqn0Paragraph           start=+/\*+ end=+\*/+ contains=dqn0Comment,@dqn0Brackets

" dqn0Item0 is defined first. This allows later item which also matches to override the syntax match of dqn0Item0.
syn match       dqn0Item0               "^\(\s*\)\@>\(///\)\@3!\zs[^\t]\{1}[^\t]\{-}\ze\t\+[^\t ]\+" display
syn match       dqn0Item1    keepend    /^\(\s*\)\@>\zs:[^\t]\{-}\ze\(\t\|$\)/ display
syn match       dqn0Item2    keepend    /^\(\s*\)\@>\zs%[^\t]\{-}\ze\(\t\|$\)/ display
syn match       dqn0Item3    keepend    /^\(\s*\)\@>\zs$[^\t]\{-}\ze\(\t\|$\)/ display

" Titles, items and statements
syn match       dqn0Title1              /^###.\+###/ display
syn match       dqn0Title2              /^---.\+---/ display
syn match       dqn0Title3              /^\~\~\~.\+\~\~\~/ display
syn region      dqn0Subtitle keepend    start=+^< + end=+ >+    oneline display
syn match       dqn0Comment  keepend    +///.*+                 contains=dqn0Slash display
"syn match      dqn0Comment  keepend    +^\(\s*\)\@>\zs///.*+

" New colouring scheme with concealends
syn region      dqn0Yellow   matchgroup=dqn0Marker keepend concealends start=+\[\[+ end=+]]+
syn region      dqn0Green    matchgroup=dqn0Marker keepend concealends start=+\[{+ end=+]}+
syn region      dqn0Blue            matchgroup=dqn0Marker keepend concealends start=+\['+ end=+]'+
syn region      dqn0Orange   matchgroup=dqn0Marker keepend concealends start=+\[-+ end=+]-+
syn region      dqn0Purple   matchgroup=dqn0Marker keepend concealends start=+\[=+ end=+]=+
"syn region     dqn0GreenBlue   matchgroup=dqn0Marker keepend concealends start=+\["+ end=+]"+

" Allow source blocks. {{{1
" Allow quoting source codes by including syntax highlighting for other
" languages.

" Vim
syn include     @dqn0Vim            syntax/vim.vim
syn region      dqn0Vim     matchgroup=dqn0SrcRegMat        start=+"!\\beginVim+ end=+"!\\endVim+ contains=@dqn0Vim
syn cluster     @dqn0SrcReg   add=dqn0Vim
" }}}1

" Syntax for Vim fold markers.
syn match       dqn0FoldMarker  /{{{[0-9]/
syn match       dqn0FoldMarker  /}}}[0-9]/

" Define syntax items. This is used for "vim" note. {{{
" syn keyword   dqn0Keywords    Boo[lean] Variable Option Command Function
" syn keyword   dqn0Keywords    VAR OPT CMD FUN EVT
" syn keyword   dqn0KeywOpt     Boo Gl Lo
" }}}


" Define the default highlighting.
" Paragraphs
hi! def link dqn0Paragraph Directory

" Only used when an item doesn't have highlighting yet
hi! def link dqn0Title1 Identifier
hi! def link dqn0Title2 Special
hi! def link dqn0Title3 Type
hi! def link dqn0Subtitle VisualNOS
hi! def link dqn0Comment        Comment
hi! def link dqn0Item1  Statement
hi! def link dqn0Item2  Type
hi! def link dqn0Item0  PreProc
hi! def link dqn0Item3  Underlined

" Define highlighting for tags and other identifiers.
hi! def link dqn0Tag    SignColumn
hi! def link dqn0Subtag1        SpellRare
hi! def link dqn0Subtag2 SpellCap

hi! def link dqn0Curl   Special
hi! def link dqn0Brac   Special
hi! def link dqn0Paren  WarningMsg
hi! def link dqn0Angle  SpecialKey
hi! def link dqn0Slash  String
hi! def link dqn0Colon  Statement
hi! def link dqn0Percent        Type
hi! def link dqn0Bar    PreProc
hi! def link dqn0String String
hi! def link dqn0Option Type

hi! def link dqn0Yellow Statement
hi! def link dqn0Green  Type
hi! def link dqn0Blue   PreProc
hi! def link dqn0Orange Special
hi! def link dqn0Purple String
hi! def link dqn0GreenBlue Identifier
hi! def link dqn0Marker String

" Define highlighting for source region.
hi! def link dqn0SrcRegMat DiffAdd

" Define highlighting for Vim fold markers.
hi! def link dqn0FoldMarker  PmenuSel

" Define highlighting for keywords
hi! def link dqn0TrueFalse   Statement

" Define highlighting for "vim" note keywords. {{{
" hi! def link dqn0Keywords    SpellCap
" hi! def link dqn0KeywOpt          Underlined
" }}}

" Setting Synchronzation
syn sync match dqn0FoldMarkerSync grouphere NONE /{{{[0-9]/
syn sync minlines=3 maxlines=100
syn sync ccomment dqn0Paragraph minlines=3 maxlines=100
" }}}

let b:current_syntax = "dq"

" vim: ts=8 sw=2 fdm=marker
