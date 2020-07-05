if has("$XDG_CONFIG_HOME")
  let s:dir = $XDG_CONFIG_HOME
else
  let s:dir = $HOME .'/.config/nvim'
endif

exec 'source ' .s:dir .'/init.vim'
exec 'set rtp^=' .s:dir
