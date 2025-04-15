export PATH="$PATH:$HOME/.bin/"
export PATH="$HOME/.cargo/bin:$PATH"
export GOPATH=$HOME/.go
export SUDO_PROMPT="$(tput setab 1 setaf 7 bold)[sudo]$(tput sgr0) $(tput setaf 6)password for$(tput sgr0) $(tput setaf 5)%p$(tput sgr0): "
export BAT_THEME="Enki-Tokyo-Night"
export ANDROID_SDK_ROOT=/opt/android-sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

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

alias arch='wget -E -k -p'
alias c="printf '\033[2J\033[3J\033[1;1H'"
alias cat='bat'
alias compose='sudo docker compose'
alias grep='rg'
alias gudo='sudo /bin/env WAYLAND_DISPLAY="$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY"  XDG_RUNTIME_DIR=/user/run/1000'
alias img='kitten icat'
alias ip='ip -color=auto'
alias kdenlive='QT_QPA_PLATFORM=xcb LIBGL_ALWAYS_SOFTWARE=true kdenlive'
alias ls='lsd'
alias mkdir='mkdir -p'
alias nv="nvim"
alias py='ipython'
alias rsync='rsync -avzh --progress --stats'
alias sudo='run0 --background=0'
alias wiki='zen-browser /usr/share/doc/arch-wiki/html/en/Table_of_contents.html'
alias ytdlp='yt-dlp'
alias ytm='yt-dlp -f 139'
alias z1="z .."  
alias z2="z ../.."  
alias z3="z ../../.."  
alias z4="z ../../../.."  
alias z5="z ../../../../.." 

eval "$(zoxide init zsh)"
z() { __zoxide_z "$@" && lsd; }
zi() {__zoxide_zi "$@" && lsd; }

function y() {
    print -Pn "\e]0;yazi\a"
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

zstyle ':completion:*' completer _complete _complete:-fuzzy _correct _approximate _ignored

# Created by `pipx` on 2025-03-25 18:36:16
export PATH="$PATH:/home/artemis-arrow/.local/bin"

# pnpm
export PNPM_HOME="/home/artemis-arrow/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/artemis-arrow/.lmstudio/bin"
