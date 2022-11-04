export SOURCES=$DEV/sources
export ZIM_HOME=$DOT/zim/zim

source $ZIM_HOME/init.zsh
cp $DOT/zim/zimrc $HOME/.zimrc
zsh $ZIM_HOME/zimfw.zsh install -q

setopt HIST_IGNORE_ALL_DUPS
bindkey -e

WORDCHARS=${WORDCHARS//[\/]}

ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

zmodload -F zsh/terminfo +p:terminfo
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key

(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=fg=cyan

