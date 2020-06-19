" MIT License. Copyright (c) 2013-2020 Bailey Ling et al.
" vim: et ts=2 sts=2 sw=2 tw=80 fdm=marker
scriptencoding utf-8
" "Import from solarized.vim" {{{1
  """"""""""""""""""""""""""""""""""""""""""""""""
  " Options
  """"""""""""""""""""""""""""""""""""""""""""""""
  let s:background           = get(g:, 'airline_dqsolarized_bg', &background)
  let s:ansi_colors          = get(g:, 'dqsolarized_termcolors', 16) != 256 && &t_Co >= 16 ? 1 : 0
  let s:use_green            = get(g:, 'airline_dqsolarized_normal_green', 0)
  let s:dark_inactive_tab    = get(g:, 'airline_dqsolarized_dark_inactive_background', 0)
  let s:dark_text            = get(g:, 'airline_dqsolarized_dark_text', 0)
  let s:dark_inactive_border = get(g:, 'airline_dqsolarized_dark_inactive_border', 0)
  let s:enable_command_color = get(g:, 'airline_dqsolarized_enable_command_color', 0)
  let s:tty                  = &t_Co == 8

  """"""""""""""""""""""""""""""""""""""""""""""""
  " Colors
  """"""""""""""""""""""""""""""""""""""""""""""""
  " Base colors
  " Extended base16 support by @cuviper.
  " Via https://github.com/blueyed/vim-colors-dqsolarized/commit/92f2f994 /
  " https://github.com/cuviper/vim-colors-dqsolarized.
  if s:ansi_colors && get(g:, 'dqsolarized_base16', 0)
    let s:base03  = {'t': 0,  'g': "#002b36"}  " Base 00
    let s:base02  = {'t': 18, 'g': "#073642"}  " Base 01
    let s:base01  = {'t': 19, 'g': "#586e75"}  " Base 02
    let s:base00  = {'t': 8,  'g': "#657b83"}  " Base 03
    let s:base0   = {'t': 20, 'g': "#839496"}  " Base 04
    let s:base1   = {'t': 7,  'g': "#93a1a1"}  " Base 05
    let s:base2   = {'t': 21, 'g': "#eee8d5"}  " Base 06
    let s:base3   = {'t': 15, 'g': "#fdf6e3"}  " Base 07
    let s:yellow  = {'t': 3,  'g': "#dc322f"}  " Base 0A
    let s:orange  = {'t': 16, 'g': "#cb4b16"}  " Base 09
    let s:red     = {'t': 1,  'g': "#b58900"}  " Base 08
    let s:magenta = {'t': 17, 'g': "#859900"}  " Base 0F
    let s:violet  = {'t': 5,  'g': "#2aa198"}  " Base 0E
    let s:blue    = {'t': 4,  'g': "#268bd2"}  " Base 0D
    let s:cyan    = {'t': 6,  'g': "#6c71c4"}  " Base 0C
    let s:green   = {'t': 2,  'g': "#d33682"}  " Base 0B
  else
    let s:base03  = {'t': s:ansi_colors ?   8 : (s:tty ? '0' : 234), 'g': '#002731'}
    let s:base02  = {'t': s:ansi_colors ? '0' : (s:tty ? '0' : 235), 'g': '#073642'}
    let s:base01  = {'t': s:ansi_colors ?  10 : (s:tty ? '0' : 240), 'g': '#4f6770'}
    let s:base00  = {'t': s:ansi_colors ?  11 : (s:tty ? '7' : 241), 'g': '#7b9199'}
    let s:base0   = {'t': s:ansi_colors ?  12 : (s:tty ? '7' : 244), 'g': '#9eb6b9'}
    let s:base1   = {'t': s:ansi_colors ?  14 : (s:tty ? '7' : 245), 'g': '#d0dada'}
    let s:base2   = {'t': s:ansi_colors ?   7 : (s:tty ? '7' : 254), 'g': '#ede5ca'}
    let s:base3   = {'t': s:ansi_colors ?  15 : (s:tty ? '7' : 230), 'g': '#fffaeb'}
    let s:yellow  = {'t': s:ansi_colors ?   3 : (s:tty ? '3' : 136), 'g': '#c39919'}
    let s:orange  = {'t': s:ansi_colors ?   9 : (s:tty ? '1' : 166), 'g': '#e06431'}
    let s:red     = {'t': s:ansi_colors ?   1 : (s:tty ? '1' : 160), 'g': '#e24d4b'}
    let s:magenta = {'t': s:ansi_colors ?   5 : (s:tty ? '5' : 125), 'g': '#e4569b'}
    let s:violet  = {'t': s:ansi_colors ?  13 : (s:tty ? '5' : 61 ), 'g': '#999ee0'}
    let s:blue    = {'t': s:ansi_colors ?   4 : (s:tty ? '4' : 33 ), 'g': '#409ee0'}
    let s:cyan    = {'t': s:ansi_colors ?   6 : (s:tty ? '6' : 37 ), 'g': '#40b3aa'}
    let s:green   = {'t': s:ansi_colors ?   2 : (s:tty ? '2' : 64 ), 'g': '#8fa214'}
  endif

  if &background == "light"
      let s:temp03      = s:base03
      let s:temp02      = s:base02
      let s:temp01      = s:base01
      let s:temp00      = s:base00
      let s:base03      = s:base3
      let s:base02      = s:base2
      let s:base01      = s:base1
      let s:base00      = s:base0
      let s:base0       = s:temp00
      let s:base1       = s:temp01
      let s:base2       = s:temp02
      let s:base3       = s:temp03
  endif

" Explanation {{{1
" Airline themes are generated based on the following concepts:
"   * The section of the status line, valid Airline statusline sections are:
"       * airline_a (left most section)
"       * airline_b (section just to the right of airline_a)
"       * airline_c (section just to the right of airline_b)
"       * airline_x (first section of the right most sections)
"       * airline_y (section just to the right of airline_x)
"       * airline_z (right most section)
"   * The mode of the buffer, as reported by the :mode() function.  Airline
"     converts the values reported by mode() to the following:
"       * normal
"       * insert
"       * replace
"       * visual
"       * inactive
"       The last one is actually no real mode as returned by mode(), but used by
"       airline to style inactive statuslines (e.g. windows, where the cursor
"       currently does not reside in).
"   * In addition to each section and mode specified above, airline themes
"     can also specify overrides.  Overrides can be provided for the following
"     scenarios:
"       * 'modified'
"       * 'paste'
"
" Airline themes are specified as a global viml dictionary using the above
" sections, modes and overrides as keys to the dictionary.  The name of the
" dictionary is significant and should be specified as:
"   * g:airline#themes#<theme_name>#palette
" where <theme_name> is substituted for the name of the theme.vim file where the
" theme definition resides.  Airline themes should reside somewhere on the
" 'runtimepath' where it will be loaded at vim startup, for example:
"   * autoload/airline/themes/theme_name.vim
"
" For this, the dark.vim, theme, this is defined as
let g:airline#themes#dqsolarized#palette = {}

" Keys in the dictionary are composed of the mode, and if specified the
" override.  For example:
"   * g:airline#themes#dqsolarized#palette.normal
"       * the colors for a statusline while in normal mode
"   * g:airline#themes#dqsolarized#palette.normal_modified
"       * the colors for a statusline while in normal mode when the buffer has
"         been modified
"   * g:airline#themes#dqsolarized#palette.visual
"       * the colors for a statusline while in visual mode
"
" Values for each dictionary key is an array of color values that should be
" familiar for colorscheme designers:
"   * [guifg, guibg, ctermfg, ctermbg, opts]
" See "help attr-list" for valid values for the "opt" value.
"
" Each theme must provide an array of such values for each airline section of
" the statusline (airline_a through airline_z).  A convenience function,
" airline#themes#generate_color_map() exists to mirror airline_a/b/c to
" airline_x/y/z, respectively.

" "Normal mode"": {{{1
if &background ==# 'dark'
  let s:Na   = [ s:base3.g  , s:green.g  , s:base3.t  , s:green.t  ]
  let s:Nb   = [ s:base3.g  , s:base00.g , s:base3.t  , s:base00.t ]
  let s:Nc   = [ s:base3.g  , s:base02.g , s:base3.t  , s:base02.t ]
  let s:Nx   = [ s:base3.g  , s:base01.g , s:base3.t  , s:base01.t ]
else
  let s:Na   = [ s:base03.g  , s:green.g  , s:base03.t  , s:green.t  ]
  let s:Nb   = [ s:base03.g  , s:base00.g , s:base03.t  , s:base00.t ]
  let s:Nc   = [ s:base1.g   , s:base02.g , s:base1.t   , s:base02.t ]
  let s:Nx   = [ s:base1.g  , s:base01.g , s:base03.t  , s:base01.t ]
endif

let s:Ny   = s:Nb
let s:Nz   = [ s:base02.g , s:base1.g  , s:base02.t , s:base1.t  ]
let g:airline#themes#dqsolarized#palette.normal = airline#themes#generate_color_map(s:Na, s:Nb, s:Nc, s:Nx, s:Ny, s:Nz)

" Explanation {{{2
" It should be noted the above is equivalent to:
" let g:airline#themes#dqsolarized#palette.normal = airline#themes#generate_color_map(
"    \  [ '#00005f' , '#dfff00' , 17  , 190 ],  " section airline_a
"    \  [ '#ffffff' , '#444444' , 255 , 238 ],  " section airline_b
"    \  [ '#9cffd3' , '#202020' , 85  , 234 ]   " section airline_c
"    \)
"
" In turn, that is equivalent to:
" let g:airline#themes#dqsolarized#palette.normal = {
"    \  'airline_a': [ '#00005f' , '#dfff00' , 17  , 190 ],  "section airline_a
"    \  'airline_b': [ '#ffffff' , '#444444' , 255 , 238 ],  "section airline_b
"    \  'airline_c': [ '#9cffd3' , '#202020' , 85  , 234 ],  "section airline_c
"    \  'airline_x': [ '#9cffd3' , '#202020' , 85  , 234 ],  "section airline_x
"    \  'airline_y': [ '#ffffff' , '#444444' , 255 , 238 ],  "section airline_y
"    \  'airline_z': [ '#00005f' , '#dfff00' , 17  , 190 ]   "section airline_z
"    \}
"
" airline#themes#generate_color_map() also uses the values provided as
" parameters to create intermediary groups such as:
"   airline_a_to_airline_b
"   airline_b_to_airline_c
"   etc...

" Here we define overrides for when the buffer is modified.  This will be
" applied after g:airline#themes#dqsolarized#palette.normal, hence why only certain keys are
" declared. }}}2
let g:airline#themes#dqsolarized#palette.normal_modified = {
      \ 'airline_c': [ s:yellow.g, s:Nc[1], s:yellow.t, s:Nc[3] ] ,
      \ }

let g:airline#themes#dqsolarized#palette.normal.airline_warning = [
      \ s:Na[0], s:yellow.g, s:Na[2], s:yellow.t, '' ]
let g:airline#themes#dqsolarized#palette.normal.airline_error = [
      \ s:Na[0], s:red.g, s:Na[2], s:red.t, '' ]
let g:airline#themes#dqsolarized#palette.normal_modified.airline_warning =
      \ g:airline#themes#dqsolarized#palette.normal.airline_warning
let g:airline#themes#dqsolarized#palette.normal_modified.airline_error =
      \ g:airline#themes#dqsolarized#palette.normal.airline_error

" "Insert mode"": {{{1
let s:Ia = [ s:Na[0]    , s:blue.g  , s:Na[2]    , s:blue.t  ]
if &background ==# 'dark'
  let s:Ib = [ s:base02.g , s:base2.g , s:base02.t , s:base2.t ]
  let s:Ic = [ s:base02.g , s:base0.g , s:base02.t , s:base0.t ]
  let s:Ix = [ s:base02.g , s:base1.g , s:base02.t , s:base1.t ]
else
  let s:Ib = [ s:base02.g , s:base1.g , s:base02.t , s:base1.t ]
  let s:Ic = [ s:base02.g , s:base00.g , s:base02.t , s:base00.t ]
  let s:Ix = [ s:base02.g , s:base0.g , s:base02.t , s:base0.t ]
endif
let s:Iy = s:Ib
let s:Iz = s:Ia
let g:airline#themes#dqsolarized#palette.insert = airline#themes#generate_color_map(s:Ia, s:Ib, s:Ic, s:Ix, s:Iy, s:Iz)
let g:airline#themes#dqsolarized#palette.insert_modified = {
      \ 'airline_c': [ s:Ic[0] , s:cyan.g , s:Ic[2] , s:cyan.t ] ,
      \ }
let g:airline#themes#dqsolarized#palette.insert_paste = {
      \ 'airline_a': [ s:Ia[0] , s:violet.t , s:Ia[2] , s:violet.t ] ,
      \ }

let g:airline#themes#dqsolarized#palette.insert.airline_warning =
      \ g:airline#themes#dqsolarized#palette.normal.airline_warning
let g:airline#themes#dqsolarized#palette.insert.airline_error =
      \ g:airline#themes#dqsolarized#palette.normal.airline_error
let g:airline#themes#dqsolarized#palette.insert_modified.airline_warning =
      \ g:airline#themes#dqsolarized#palette.normal.airline_warning
let g:airline#themes#dqsolarized#palette.insert_modified.airline_error =
      \ g:airline#themes#dqsolarized#palette.normal.airline_error

" "Replace mode"": {{{1
let g:airline#themes#dqsolarized#palette.replace = copy(g:airline#themes#dqsolarized#palette.insert)
let g:airline#themes#dqsolarized#palette.replace.airline_a = [ s:Ib[0] , s:red.g , s:Ib[2] , s:red.t ]
let g:airline#themes#dqsolarized#palette.replace.airline_z = [ s:Ib[0] , s:red.g , s:Ib[2] , s:red.t ]
let g:airline#themes#dqsolarized#palette.replace_modified = {
      \ 'airline_c': [ s:Ic[0] , s:yellow.g , s:Ic[2] , s:yellow.t ] ,
      \ }

let g:airline#themes#dqsolarized#palette.replace.airline_warning =
      \ g:airline#themes#dqsolarized#palette.normal.airline_warning
let g:airline#themes#dqsolarized#palette.replace.airline_error =
      \ g:airline#themes#dqsolarized#palette.normal.airline_error
let g:airline#themes#dqsolarized#palette.replace_modified.airline_warning =
      \ g:airline#themes#dqsolarized#palette.normal.airline_warning
let g:airline#themes#dqsolarized#palette.replace_modified.airline_error =
      \ g:airline#themes#dqsolarized#palette.normal.airline_error

" "Visual mode": {{{1
let s:Va = [ s:Na[0]    , s:orange.g  , s:Na[2]    , s:orange.t   ]
let s:Vb = [ s:base02.g , s:base2.g   , s:base02.t , s:base2.t    ]
let s:Vc = [ s:base02.g , s:base0.g   , s:base02.t , s:base0.t    ]
let s:Vx = [ s:base02.g , s:base1.g   , s:base02.t , s:base1.t    ]
let s:Vy = s:Vb
let s:Vz = s:Va
let g:airline#themes#dqsolarized#palette.visual = airline#themes#generate_color_map(s:Va, s:Vb, s:Vc, s:Vx, s:Vy, s:Vz)
let g:airline#themes#dqsolarized#palette.visual_modified = {
      \ 'airline_c': [ s:Vc[0] , s:yellow.g , s:Vc[2] , s:yellow.t ] ,
      \ }

let g:airline#themes#dqsolarized#palette.visual.airline_warning =
      \ g:airline#themes#dqsolarized#palette.normal.airline_warning
let g:airline#themes#dqsolarized#palette.visual.airline_error =
      \ g:airline#themes#dqsolarized#palette.normal.airline_error
let g:airline#themes#dqsolarized#palette.visual_modified.airline_warning =
      \ g:airline#themes#dqsolarized#palette.normal.airline_warning
let g:airline#themes#dqsolarized#palette.visual_modified.airline_error =
      \ g:airline#themes#dqsolarized#palette.normal.airline_error

" "Interactive mode": {{{1
"let s:IAa = [ '#4e4e4e' , '#1c1c1c' , 239 , 234 , '' ]
"let s:IAb = [ '#4e4e4e' , '#262626' , 239 , 235 , '' ]
"let s:IAc = [ '#4e4e4e' , '#303030' , 239 , 236 , '' ]
let s:IAa = [ s:base03.g , s:base01.g  , s:base03.t , s:base01.t   ]
let s:IAb = [ s:base01.g , s:base02.g  , s:base01.t , s:base02.t   ]
let s:IAc = [ s:base01.g , s:base03.g  , s:base01.t , s:base03.t   ]
let s:IAx = s:IAc
let s:IAy = s:IAb
let s:IAz = s:IAa
let g:airline#themes#dqsolarized#palette.inactive = airline#themes#generate_color_map(s:IAa, s:IAb, s:IAc, s:IAx, s:IAy, s:IAz)
let g:airline#themes#dqsolarized#palette.inactive_modified = {
      \ 'airline_c': [ s:yellow.g , s:IAc[1]   , s:yellow.t , s:IAc[3]   ] ,
      \ }

" "Commandline mode": {{{1
let s:Ca = [ s:Na[0]    , s:yellow.g , s:Na[2]    , s:yellow.t ]
let s:Cb = [ s:Nb[0]    , s:Nb[1]    , s:Nb[2]    , s:Nb[3]    ]
let s:Cc = [ s:Nc[0]    , s:Nc[1]    , s:Nc[2]    , s:Nc[3]    ]
let s:Cx = [ s:Nx[0]    , s:Nx[1]    , s:Nx[2]    , s:Nx[3]    ]
let s:Cy = s:Cb
let s:Cz = s:Ca
let g:airline#themes#dqsolarized#palette.commandline = airline#themes#generate_color_map(s:Ca, s:Cb, s:Cc, s:Cx, s:Cy, s:Cz)

let g:airline#themes#dqsolarized#palette.commandline.airline_warning = [
      \ s:base3.g, s:orange.g, s:base3.t, s:orange.t, '' ]
let g:airline#themes#dqsolarized#palette.commandline.airline_error =
      \ g:airline#themes#dqsolarized#palette.normal.airline_error
" The 2 following seems to not required (or else there be error)
"let g:airline#themes#dqsolarized#palette.commandline_modified.airline_warning =
"      \ g:airline#themes#dqsolarized#palette.commandline.airline_warning
"let g:airline#themes#dqsolarized#palette.commandline_modified.airline_error =
"      \ g:airline#themes#dqsolarized#palette.normal.airline_error

" "Tablines" {{{1
"let g:airline#themes#dqsolarized#palette.tabline = {}
"
"let g:airline#themes#dqsolarized#palette.tabline.airline_tab = [
"      \ s:Ib[0], s:Ib[1], s:Ib[2], s:Ib[3], '']
"
"let g:airline#themes#dqsolarized#palette.tabline.airline_tabtype = [
"      \ s:Nb[0], s:Nb[1], s:orange.t, s:orange.t, '']

" "Others" {{{1
" Accents are used to give parts within a section a slightly different look or
" color. Here we are defining a "red" accent, which is used by the "readonly"
" part by default. Only the foreground colors are specified, so the background
" colors are automatically extracted from the underlying section colors. What
" this means is that regardless of which section the part is defined in, it
" will be red instead of the section's foreground color. You can also have
" multiple parts with accents within a section.
let g:airline#themes#dqsolarized#palette.accents = {
      \ 'red': [ s:red.g , '' , s:red.t , ''  ]
      \ }


" Here we define the color map for ctrlp.  We check for the g:loaded_ctrlp
" variable so that related functionality is loaded iff the user is using
" ctrlp. Note that this is optional, and if you do not define ctrlp colors
" they will be chosen automatically from the existing palette.
if get(g:, 'loaded_ctrlp', 0)
  let g:airline#themes#dqsolarized#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
        \ [ s:base0.g  , s:base02.g  , s:base0.t  , s:base02.t  , 'bold' ],
        \ [ s:base3.g  , s:base00.g  , s:base3.t  , s:base00.t  , ''     ],
        \ [ s:base3.g  , s:magenta.g , s:base3.t  , s:magenta.t , 'bold' ])
endif
