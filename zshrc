export PATH="$PATH:$HOME/.bin/"
export GOPATH=$HOME/.go
export SUDO_PROMPT="$(tput setab 1 setaf 7 bold)[sudo]$(tput sgr0) $(tput setaf 6)password for$(tput sgr0) $(tput setaf 5)%p$(tput sgr0): "
export BAT_THEME="Enki-Tokyo-Night"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
zstyle ':omz:update' mode auto                                                                                                                                                   

plugins=(
    auto-notify
    autoupdate
    colored-man-pages
    command-not-found
    copyfile
    git
    sudo
	zsh-autocomplete
	zsh-syntax-highlighting
    zsh-calc
    colorize
    forgit
)

ex () {
    if [ -f "$1" ] ; then
        case $1 in
            *.7z)        7z x $1      ;;
            *.bz2)       bunzip2 $1   ;;
            *.deb)       ar x $1      ;;
            *.gz)        gunzip $1    ;;
            *.rar)       unrar x $1   ;;
            *.tar.bz2)   tar xjf $1   ;;
            *.tar.gz)    tar xzf $1   ;;
            *.tar)       tar xf $1    ;;
            *.tar.xz)    tar xf $1    ;;
            *.tar.zst)   unzstd $1    ;;
            *.tbz2)      tar xjf $1   ;;
            *.tgz)       tar xzf $1   ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

k() { ps aux | grep -i "$1" | awk '{print $2, $11, $12}' | column -t | fzf -m | awk '{print $1}' | xargs -r kill -9; }

[[ -e /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh
[[ -e /usr/share/doc/find-the-command/ftc.zsh ]] && source /usr/share/doc/find-the-command/ftc.zsh

source $ZSH/oh-my-zsh.sh

alias z1="z .."  
alias z2="z ../.."  
alias z3="z ../../.."  
alias z4="z ../../../.."  
alias z5="z ../../../../.." 
alias c="printf '\033[2J\033[3J\033[1;1H'"
alias cat='bat'
alias compose='sudo docker compose'
alias grep='rg'
alias img='kitten icat'
alias ip='ip -color=auto'
alias ls='lsd'
alias mkdir='mkdir -p'
alias py='ipython'
alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; z "$LASTDIR"'
alias sudo='run0 --background=0'
alias wiki='floorp /usr/share/doc/arch-wiki/html/en/Table_of_contents.html'
alias ytdlp='yt-dlp'
alias ytm='yt-dlp -f 139'
alias arch='wget -E -k -p'
alias rsync='rsync -avzh --progress --stats'
alias gudo='sudo /bin/env WAYLAND_DISPLAY="$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY"  XDG_RUNTIME_DIR=/user/run/1000'
alias nv="nvim"

eval "$(zoxide init zsh)"
z() { __zoxide_z "$@" && lsd; }
zi() {__zoxide_zi "$@" && lsd; }
