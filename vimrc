if has("$XDG_CONFIG_HOME")
  let s:dir = $XDG_CONFIG_HOME
else
  let s:dir = $HOME .'/.config/nvim'
endif

exec 'set rtp^=' .s:dir
exec 'source ' .s:dir .'/init.vim'
