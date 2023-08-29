export SDL_VIDEODRIVER=wayland
export QT_QPA_PLATFORMTHEME="qt5ct"
export GOPATH=~/.go
export ZSH="$HOME/.oh-my-zsh"
export LC_ALL=en_US.UTF-8
export LESS='-R --use-color -Dd+r$Du+b$'
export EDITOR='nvim'

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
ZSH_THEME="powerlevel10k/powerlevel10k"
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
zstyle ':omz:update' mode auto

plugins=(git
	zsh-autosuggestions
	zsh-syntax-highlighting
    command-not-found
    sudo
    copyfile
)
source $ZSH/oh-my-zsh.sh

alias ytm='yt-dlp -f 139'
alias nv='nvim'
alias ls='lsd'
alias less='cless'
alias img='kitty +kitten icat'
alias py='ipython'
alias mk='musikcube'
alias cat='bat'
alias grep='rg'
alias ip='ip -color=auto'
alias mkd='mkdir -pv'

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
