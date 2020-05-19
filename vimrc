""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" *** Load first *** {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This must be first, because it changes other options as a side effect.
set nocompatible " Use Vim, rather than Vi settings (nvim default).

syntax on " (nvim default)
filetype plugin indent on " (nvim default)
let mapleader = ' '

if v:vim_did_enter
  augroup! vimrcEx " Delete any old autocmds added by vimrc.
endif
"}}}1

" *** Adding packages *** {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ** setup vim-plug ** {{{2
""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/bundle')
" General
Plug 'Valloric/YouCompleteMe'
Plug 'altercation/vim-colors-solarized'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-syntastic/syntastic'
Plug 'preservim/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/goyo.vim'
Plug 'frazrepo/vim-rainbow'
Plug 'junegunn/limelight.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'godlygeek/tabular'
Plug 'dhruvasagar/vim-table-mode'
" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" For optimizing python3
Plug 'tmhedberg/SimpylFold'
call plug#end()

" ** packadd ** {{{2
""""""""""""""""""""""""""""""""""""""""
if !has('nvim')
  packadd matchit " already added by nvim.
endif

" *** Vim customization *** {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setting the colorscheme
if $TERM ==# 'linux'
  colorscheme dd-noitalic
else
  let g:solarized_termtrans=1
  let g:dqsolarized_dqn_title_color=1
  let g:solarized_diffmode='high'
  " ^Config var must be assigned before applying colorscheme to take effect.
  colorscheme dqsolarized
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup END

" Make vim able to read man pages within Vim.
runtime! ftplugin/man.vim

" Source digraphs
source ~/.vim/DQScripts/digraphs/symbols.vim
source ~/.vim/DQScripts/digraphs/super_sub_scripts.vim

" *** settings *** {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ** Both vim and nvim ** {{{2
""""""""""""""""""""""""""""""""""""""""
set hlsearch	      " highlight search matches (nvim default)
set autoindent      " (nvim default)
set mouse=a	      " Use mouse
set history=1000    " keep 50 lines of command line history
set ruler	      " show the cursor position all the time (nvim deault)
set number	      " Show line number on left side
set relativenumber  " Show relative instead of absolute line nr
set showcmd	      " display incomplete commands (nvim default)
set incsearch	      " do incremental searching (nvim default)
set wildmenu	      " Show matching terms when pressing tab
set scrolloff=2     " Set the numbers of line to show around cursor
set splitright
set path+=**	      " allow :find fuzzy search with * at front
set laststatus=2    " always show statusline (nvim default)
set showtabline=2   " always show tabline
let &fillchars = 'vert:|,fold: '
set conceallevel=2  " This is also needed for the plugin indentLine
set nowrapscan      " disable search through bottom to the top
set shiftwidth=4    " Make each indent level to be of 4 spaces.
set softtabstop=4   " Make a <Tab> to add 4 spaces, auto turn 8spaces to Tab character
set backspace=indent,eol,start " allow backspacing over everything in insert mode (nvim default)
set belloff=all     " (nvim default)
set nobackup
set autoread	      " autoupdate the buffer when the file is changed externally (nvim default)
set listchars=eol:$,tab:>\ ,nbsp:+  " adjust the text printed by :list
set nrformats=bin,hex	  " adjust what format of numbers <C-A> and <C-X> recognize (nvim default)
set shortmess+=F    " Adjust the message format: often shorting them (nvim default)
set sidescroll=1    " When 'wrap' is off, adjust the min cols to scoll horizontally (nvim default)
set smarttab	      " <Tab> if front of a line inserts blacks according to 'shiftwidth' (nvim def)
set undodir=~/.local/share/nvim/undo " (nvim default)
set undofile	      " Now vim will safe undo history
set ttimeoutlen=50  " Time in ms that is waited for a key sequence to complete. (nvim default)
set viminfo^=!      " (nvim default)
set langnoremap	    " (nvim default)
set cursorline
set updatetime=250  " After 250ms nothing is typed, .swp is written and gitgutter is updated.

" ** For vim only ** {{{2
""""""""""""""""""""""""""""""""""""""""
if !has('nvim')
  set termkey=<C-E>   " Set the key that starts a CTRL-W cmd in terminal window
endif

" *** Commands and Mappings *** {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
  \ | wincmd p | diffthis

" For easy access some documents:
command Vimnote tabe ~/Documents/learn-type/vim.dqn0
command Master e ~/.master.dqn
" For saving and compiling current file
command -nargs=0 Make update | make %:p:S

" For allowing virtual editing in Visual block mode.
nnoremap <Leader>ve :call dq_autoload#toggle_ve_blk()<CR>
nnoremap j gj
nnoremap k gk
" Highlight last inserted line.
nnoremap gV `[v`]
nnoremap PP "+p
nnoremap Pp "0p
nnoremap <Leader>sea :setl spell spelllang=en<CR>
nnoremap <Leader>sen :setl spell spelllang=en_gb<CR>
nnoremap <Leader>sde :setl spell spelllang=de_de<CR>
nnoremap <Leader>sno :setl nospell
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

nnoremap Q <nop>
exe 'nnoremap <silent> <Leader>B'
  \ . ' :if &bg==#"dark"<CR>se bg=light<CR>el<CR>se bg=dark<CR>end<CR>'

" *** Customizing Plugins *** {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ** For both vim and nvim ** {{{2
""""""""""""""""""""""""""""""""""""""""
" * Airline * {{{3
""""""""""""""""""""
" General {{{4
""""""""""
let g:airline_powerline_fonts = 1
let g:airline_mode_map = {
  \ '__'     : '-',
  \ 'c'      : 'C',
  \ 'i'      : 'I',
  \ 'ic'     : 'I^N',
  \ 'ix'     : 'I^X',
  \ 'n'      : 'N',
  \ 'multi'  : 'Mlt',
  \ 'ni'     : 'N',
  \ 'no'     : 'N.O',
  \ 'R'      : 'R',
  \ 'Rv'     : 'VR',
  \ 's'      : 'S',
  \ 'S'      : 'S.L',
  \ ''     : 'S.B',
  \ 't'      : 'TRM',
  \ 'v'      : 'V',
  \ 'V'      : 'V.L',
  \ ''     : '^V',
  \ }

" Sections customization {{{4
""""""""""
function AirlineMixIndent()
  if indent(".") % &sw == 0
    return ''
  else
    return ':' . string(indent(".") % &sw)
  endif
endfunction

function AirlineInit()
  let g:airline_section_z = '%p%% %l:%v'
    \ . ' I%{indent(".")/&sw}%#airline_z_red#'
    \ . '%{AirlineMixIndent()}%#__restore__# F%{foldlevel(".")}'
endfunction

autocmd vimrcEx User AirlineAfterInit call AirlineInit()

" Whitespace check {{{4
""""""""""
let g:airline#extensions#whitespace#trailing_format = 'sp[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = '>[%s]'
let g:airline#extensions#whitespace#mixed_indent_file_format = '>F[%s]'
let g:airline#extensions#whitespace#skip_indent_check_ft =
  \ {'dqn': ['indent', 'mixed-indent-file']}
nnoremap <Leader>ta :AirlineToggleWhitespace<CR>

" Tabline config {{{4
""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#overflow_marker = '💬 ' " The symbol for skipped tab/buf
let g:airline#extensions#tabline#formatter = 'dq_short_path'
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_close_button = 0
if exists(g:airline#extensions#tabline#formatter) ? g:airline#extensions#tabline#formatter =~'^default$' : 0
  let g:airline#extensions#tabline#fnamemod = ':p:~:.' " The filename format %:p:~:.
  let g:airline#extensions#tabline#fnamecollapse = 1 " Whether shorten the parent dirs
endif

" Tabs {{{4
""""""""""
  let g:airline#extensions#tabline#tabs_label = 'T' " Text for tab lable
  let g:airline#extensions#tabline#tab_nr_type = 2 " show tab nr, instead of nr of wins in tab

" Buffers {{{4
""""""""""
let g:airline#extensions#tabline#buffers_label = 'B' " text for buffer lable
let g:airline#extensions#tabline#buffer_nr_show = 1 " show buf nr
let g:airline#extensions#tabline#buffer_nr_format = '%s:'

" dqsolarized theme {{{4
""""""""""
let airline_dqsolarized_dark_text = 1

" * NERDTree * {{{3
""""""""""""""""""""
nmap <leader><Tab> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen = 3
let NERDTreeMinimalUI = 1
let NERDTreeShowBookmarks = 1

" * YouCompleteMe * {{{3
""""""""""""""""""""
map <leader>g	:YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']

" * ctrlp * {{{3
""""""""""""""""""""
let g:ctrlp_root_markers = ['.dqn']
let g:ctrlp_mruf_include = '\.dqn$'
let g:ctrlp_mruf_save_on_update = 0
nnoremap <leader>sm :CtrlPMixed<CR>
nnoremap <leader>sr :CtrlPMRUFiles<CR>
nnoremap <leader>sb :CtrlPBuffer<CR>

" * Table-mode setting * {{{3
""""""""""""""""""""
let g:table_mode_align='c1'

" * indentLine * {{{3
""""""""""""""""""""
let g:indentLine_enabled = 1 " enablde indentLine (it is by default disabled)
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" indentLine will overrite default colour for concealed characters and
" conceallevel and concealcursor. This keeps the conceallevel and
" concealcursor not overwriten.
let g:indentLine_setConceal = 0

" * AutoPairs * {{{3
""""""""""""""""""""
map <leader>pp <M-p>
map <leader>pn <M-n>
imap <C-b>e <M-e>
imap <C-b>1e <M-e><M-e><C-o>ge<C-o>ge<M-e><M-e><C-o>h
imap <C-b>2e <M-e><C-o>ge<C-o>ge<M-e><M-e><C-o>h
imap <C-b>b <M-b>

" * Syntastic * {{{3
""""""""""""""""""""
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
  \ "mode": "passive",
  \ "active_filetypes": [],
  \ "passive_filetypes": [] }
command -nargs=0 SC SyntasticCheck
command -nargs=0 ST SyntasticToggleMode
command -nargs=0 SI SyntasticInfo
command -nargs=0 SR SyntasticReset

" * GitGutter * {{{3
""""""""""""""""""""
nnoremap <Leader>hc :GitGutterQuickFix<CR>

" * Fugitive * {{{3
""""""""""""""""""""
command GitLog Git log --all --graph --decorate

" * goyo * {{{3
""""""""""""""""""""
function s:goyo_enter()
  if exists('g:loaded_limelight')
    Limelight
  endif
  if &ft ==# 'dqn'
    let g:limelight_paragraph_span = 2
  endif
endfunction

function s:goyo_leave()
  if exists('g:loaded_limelight')
    Limelight!
  endif
  if &ft ==# 'dqn'
    let g:limelight_paragraph_span = 0
  endif
  "let &ft=&ft
endfunction

autocmd vimrcEx User GoyoEnter nested call <SID>goyo_enter()
autocmd vimrcEx User GoyoLeave nested call <SID>goyo_leave()

nnoremap <silent> <Leader><Leader> :Goyo<CR>

if exists('g:loaded_airline')
  autocmd vimrcEx User GoyoEnter nested set eventignore=FocusGained
  autocmd vimrcEx User GoyoLeave nested set eventignore=
endif

" * limelight * {{{3
""""""""""""""""""""
if g:colors_name =~ 'solarized'
autocmd vimrcEx ColorScheme *
  \ if &background ==# 'dark' |
    \ let g:limelight_conceal_ctermfg = 10 |
    \ let g:limelight_conceal_guifg = '#4F6770' |
  \ else |
    \ let g:limelight_conceal_ctermfg = 14 |
    \ let g:limelight_conceal_guifg = '#B3BCBC' |
  \ endif
endif

let g:limelight_paragraph_span = 0
nmap <Leader>l <Plug>(Limelight)
xmap <Leader>l <Plug>(Limelight)
function s:LimePara(...)
  if a:0 == 0
    Limelight!!
  elseif a:1 >= 0
    let g:limelight_paragraph_span = a:1
    Limelight
  else
    Limelight!
  endif
endfunction
command -nargs=? L call s:LimePara(<args>)

" * rainbow * {{{3
""""""""""""""""""""
au FileType python,vim,tex,sh call rainbow#load()
nnoremap <Leader>rb :RainbowToggle<CR>

" * Netrw Customization * {{{3
""""""""""""""""""""
"if !exists('g:loaded_netrwPlugin') && !exists('g:loaded_nerd_tree')
"  let g:netrw_banner = 0
"  let g:netrw_liststyle = 3
"  let g:netrw_browse_split = 4
"  let g:netrw_altv = 1
"  let g:netrw_winsize = -28
"  let g:netrw_list_hide = '\~.\=$,\(^\|\s\s\)\zs\.\S\+'
"  let g:netrw_hide = 1
"  " For NetrwShrink (see netrw-c-tab)
"  let g:netrw_usetab = 1
"  "nmap <unique> <leader><Space> <Plug>NetrwShrink
"  let g:netrw_wiw = 1
"  augroup DqnNetrwTree
"    autocmd!
"    " Open Netrw Explorer when onpening Vim
"      "autocmd VimEnter * :Lexplore
"    " Per default, netrw leaves unmodified buffers open. This autocommand
"    " deletes netrw's buffer once it's hidden (using ':q', for example)
"      autocmd FileType netrw setl bufhidden=delete
"    " Fix Netrw Explorer's window width
"      autocmd FileType netrw setl wfw
"    " Cause <S-CR> is not recognized, we use another mapping.
"      autocmd FileType netrw nmap <buffer> <silent> <nowait> <leader><CR>
"      \ <Plug>NetrwTreeSqueeze
"  augroup END
"endif

" *** Post vimrc *** {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if v:vim_did_enter
  let &ft=&ft " Reload ftplugin to override vimrc settings.
endif

" vi: fdm=marker
