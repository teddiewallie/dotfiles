if [ -z "$TMUX" ]; then
  tmux attach || tmux
fi

export PATH=/home/tewa/.local/bin:$PATH

export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia

export WAYLAND_DISPLAY=wayland-0

alias vim="nvr -s --remote-tab-silent"

source $HOME/.apps/zsh-abbr/zsh-abbr.zsh

fzfvim() {
  nvr -s --remote-tab-silent $(fzf)
}

rgvim() {
  nvr -s --remote-tab-silent $(rg -i -l $@ | fzf)
}

setfont() {
  newcritty=$(sed "s/.*size.*/ size: $1/" ~/.config/alacritty/alacritty.yml)
  echo $newcritty > ~/.config/alacritty/alacritty.yml
}

abb() {
  KEY=$1
  VAL=$2

  abbr -qq erase ${KEY}

  abbr -qq ${KEY}=${VAL}
}

reabbr_arch() {
  abb "sps" "sudo pacman -S"
  abb "sprs" "sudo pacman -Rs"
  abb "spsyy" "sudo pacman -Syy"
  abb "spsyyu" "sudo pacman -Syyu"
}

eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -Uz compinit && compinit

clear

