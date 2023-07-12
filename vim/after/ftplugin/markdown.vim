setl expandtab
setl tabstop=4
setl shiftwidth=4
setl textwidth=80

function DqSetMarkdownHighlight()
  " Prevent the origin conceal setting overwritten when ftplugin is loaded twice
  if !exists("b:OriginConcealHl")
    if !has('nvim')
      let b:OriginConcealHl = hlget("Conceal")
    else
      let b:OriginConcealHl = nvim_get_hl(0, {'name': 'Conceal'})
    endif
  endif
  " To make the mathematical symbols displayed by vim-markdown more visible
  hi Conceal ctermfg=247 ctermbg=NONE
endfunction

function DqUnsetMarkdownHighlight()
  " Check to prevent running b:undo_ftplugin twice by other plugins
  if !exists('b:OriginConcealHl')
    return
  endif
  if !has('nvim')
    call hlset(b:OriginConcealHl)
  else
    call nvim_set_hl(0, 'Conceal', b:OriginConcealHl)
  endif
  " Check to prevent running b:undo_ftplugin twice by other plugins
  if exists('b:OriginConcealHl')
    unlet b:OriginConcealHl
  endif
endfunction

if !has('nvim')
  call DqSetMarkdownHighlight()

  augroup dqMarkdown
    au!
    au BufEnter *.md call DqSetMarkdownHighlight()
    au BufLeave *.md call DqUnsetMarkdownHighlight()
  augroup END
endif

iabbrev <buffer> <l <lt>leader>
  \<C-O>:let b:Eatchar=1<CR>
  \<C-R>=Eatchar('\s')<CR>

iabbrev <buffer> `<l `<lt>leader><C-v>`<left>
  \<C-O>:let b:Eatchar=1<CR>
  \<C-R>=Eatchar('\s')<CR>

iabbrev <buffer> `` <C-v>`<C-v>`<C-v>`<cr><C-v>`<C-v>`<C-v>`<up><end>
  \<C-o>:let b:Eatchar=1<cr>
  \<c-r>=Eatchar('\s')<cr>

" The following function is needed for iabbrev {{s
if !exists('*Eatchar')
  func Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
  endfunc
endif

let b:_undo_ftplugin = 'setl et< ts< sw< tw<'
      \. '| call DqUnsetMarkdownHighlight()'
      \. '| iunab <buffer> <l | iunab <buffer> `<l |iunab <buffer> ``'
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| ' . b:_undo_ftplugin
else
  let b:undo_ftplugin = b:_undo_ftplugin
endif
