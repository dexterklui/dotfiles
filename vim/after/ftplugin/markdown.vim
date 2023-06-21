setl expandtab
setl tabstop=4
setl shiftwidth=4
setl textwidth=0

function s:SetMarkdownHighlight()
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

function s:UnsetMarkdownHighlight()
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

call s:SetMarkdownHighlight()

augroup dqMarkdown
  au!
  au BufEnter *.md call s:SetMarkdownHighlight()
  au BufLeave *.md call s:UnsetMarkdownHighlight()
augroup END

let b:_undo_ftplugin = 'setl et< ts< sw< tw< | call s:UnsetMarkdownHighlight()'
let b:_undo_ftplugin = 'setl et< ts< sw< tw<'
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| ' . b:_undo_ftplugin
else
  let b:undo_ftplugin = b:_undo_ftplugin
endif
