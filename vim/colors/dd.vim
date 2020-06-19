" Vim color file
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2001 Jul 23

" This is the default color scheme.  It doesn't define the Normal
" highlighting, it uses whatever the colors used to be.

" First disable highlighting of non-highlighted text (the group "Normal").
" Then, set 'background' back to the dark.
hi clear Normal
set background=dark

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

" Best weak color for comment: 67 109-110
if &t_Co == 256
  hi comment		cterm=italic ctermfg=109
  hi special		ctermfg=214
  hi orangeB		cterm=bold ctermfg=221
  hi greenB		cterm=bold ctermfg=48
  hi cyanB		cterm=bold ctermfg=6
  hi lightBlueU		cterm=underline ctermfg=159
elseif &t_Co == 8
  hi comment		ctermfg=7
  hi special		ctermfg=3
  hi orangeB		ctermfg=1
  hi greenB		ctermfg=2
  hi cyanB		ctermfg=6
  hi lightBlueU		ctermfg=4
endif

" Weak color: 2-6 8 12-13 23-24 29-31 35-37 59-61 65-67 100-103 107-110 173-175 241-251
" B&W: 7-8 232-256
" Red: 1 9
" Orange: 3 214
" Yellow: 11 226-231
" Green: 2 10
" Cyan: 6
" Blue: 4
" Purple: 5 212
" To test 256 color code, record the next line and replay.
" :w|colo dd
" vim: sw=2


let colors_name = "dd"
