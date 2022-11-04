zimfw() { source /Users/tafd/Development/dotfiles/zim/zim/zimfw.zsh "${@}" }
zmodule() { source /Users/tafd/Development/dotfiles/zim/zim/zimfw.zsh "${@}" }
typeset -g _zim_fpath=(/Users/tafd/Development/dotfiles/zim/zim/modules/utility/functions /Users/tafd/Development/dotfiles/zim/zim/modules/duration-info/functions /Users/tafd/Development/dotfiles/zim/zim/modules/prompt-pwd/functions /Users/tafd/Development/dotfiles/zim/zim/modules/git-info/functions /Users/tafd/Development/dotfiles/zim/zim/modules/zsh-completions/src)
fpath=(${_zim_fpath} ${fpath})
autoload -Uz -- mkcd mkpw duration-info-precmd duration-info-preexec prompt-pwd coalesce git-action git-info
source /Users/tafd/Development/dotfiles/zim/zim/modules/environment/init.zsh
source /Users/tafd/Development/dotfiles/zim/zim/modules/input/init.zsh
source /Users/tafd/Development/dotfiles/zim/zim/modules/termtitle/init.zsh
source /Users/tafd/Development/dotfiles/zim/zim/modules/utility/init.zsh
source /Users/tafd/Development/dotfiles/zim/zim/modules/duration-info/init.zsh
source /Users/tafd/Development/dotfiles/zim/zim/modules/s1ck94/s1ck94.zsh-theme
source /Users/tafd/Development/dotfiles/zim/zim/modules/completion/init.zsh
source /Users/tafd/Development/dotfiles/zim/zim/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /Users/tafd/Development/dotfiles/zim/zim/modules/zsh-history-substring-search/zsh-history-substring-search.zsh
source /Users/tafd/Development/dotfiles/zim/zim/modules/zsh-autosuggestions/zsh-autosuggestions.zsh
