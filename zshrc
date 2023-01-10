# Export PATH {{{1
########################################################################
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# ZSH Path {{{1
########################################################################
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# ZSH Theme {{{1
########################################################################
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="dqpygmalion-virtualenv"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# ZSH Completion Setting {{{1
########################################################################
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# ZSH Update Setting {{{1
########################################################################
# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Misc settings {{{1
########################################################################
# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# ZSH custom folder path {{{1
########################################################################
# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# ZSH Plugins {{{1
########################################################################
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting zsh-history-substring-search zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# ZSH Key bindings {{{1
########################################################################
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# Export ENV variables {{{1
########################################################################
# export MANPATH="/usr/local/man:$MANPATH"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

if [ -f ~/.bash_env ]; then
    . ~/.bash_env
fi

# Set aliases {{{1
########################################################################
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# TODO: No need? {{{1
########################################################################
[ -f ~/.config/localshellrc ] && . ~/.config/localshellrc

# ZSH plugins settings {{{1
########################################################################
# ZSH_AUTOSUGGEST {{{2
########################################
if [ -n "$(echo $COLORSCHEME | grep solarized)" ]; then
    export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
fi
export ZSH_AUTOSUGGEST_USE_ASYNC='True'
export ZSH_AUTOSUGGEST_HISTORY_IGNORE='cd*'
export ZSH_AUTOSUGGEST_COMPLETION_IGNORE='git*'
bindkey '^ ' autosuggest-toggle

# Settings for programs {{{1
########################################################################
# fasd {{{2
########################################
# Enable fasd
if [ -x "/usr/bin/fasd" -o -x "$(which fasd)" ]; then
    eval "$(fasd --init auto)"
fi

# kitty {{{2
########################################
if [ -x "/usr/bin/kitty" -o -x "$(which kitty)" ]; then
    autoload -Uz compinit
    compinit
    # Completion for kitty
    kitty + complete setup zsh | source /dev/stdin
    alias icat='kitty +kitten icat'
fi

# papis {{{2
########################################
if [ -x "/usr/bin/papis" -o -x "$(which papis)" ]; then
    eval "$(_PAPIS_COMPLETE=source_zsh papis)"
fi

# fzf {{{2
########################################
if [ -x "/usr/bin/fzf" -o -x "$(which fzf)" ]; then
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
    export FZF_DEFAULT_OPTS='--height 40% --border'
fi

# }}}1
# vim: fdm=marker
