export SDL_VIDEODRIVER=wayland
export QT_QPA_PLATFORM='qt5ct'
export GOPATH=~/.go
export ZSH="$HOME/.oh-my-zsh"
export LC_ALL=en_US.UTF-8
export LESS='-R --use-color -Dd+r$Du+b$'
export EDITOR='nvim'
export MANPAGER="nvim +Man!"
export UPDATE_ZSH_DAYS=1

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
zstyle ':omz:update' mode auto

plugins=(git
	zsh-autosuggestions
	zsh-syntax-highlighting
    command-not-found
    sudo
    copyfile
    zsh-256color
    auto-notify
    autoupdate
    colored-man-pages
)

ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

nv() {
    kitty @ set-background-opacity 1
    nvim "$@"
    kitty @ set-background-opacity $(pgrep -x nvim > /dev/null && echo 1 || echo 0.7)
}


# Arch Linux command-not-found support, you must have package pkgfile installed
# https://wiki.archlinux.org/index.php/Pkgfile#.22Command_not_found.22_hook
[[ -e /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh

# Advanced command-not-found hook
[[ -e /usr/share/doc/find-the-command/ftc.zsh ]] && source /usr/share/doc/find-the-command/ftc.zsh

source $ZSH/oh-my-zsh.sh

alias 1d="cd .."  
alias 2d="cd ..;cd .."  
alias 3d="cd ..;cd ..;cd .."  
alias 4d="cd ..;cd ..;cd ..;cd .."  
alias 5d="cd ..;cd ..;cd ..;cd ..;cd .." 
alias ytm='yt-dlp -f 139'
alias ls='lsd'
alias img='kitty +kitten icat'
alias py='ipython'
alias mk='musikcube'
alias cat='bat'
alias grep='rg'
alias ip='ip -color=auto'
alias mkd='mkdir -p'
alias ytdlp='yt-dlp'
alias snapper='QT_QPA_PLATFORM='' sudo -E snapper-tools'
alias qbittorrent='QT_QPA_PLATFORM="" qbittorrent'
alias ranger='ranger --choosedir=/dev/shm/cdir && cd $(cat /dev/shm/cdir)'
cd() { builtin cd "$@" && ls; }
