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
)

ex ()
{
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

nv() {
    kitty @ set-background-opacity 1
    nvim "$@"
    kitty @ set-background-opacity $(pgrep -x nvim > /dev/null && echo 1 || echo 0.7)
}

cd() { builtin cd "$@" && lsd; }

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Arch Linux command-not-found support, you must have package pkgfile installed
# https://wiki.archlinux.org/index.php/Pkgfile#.22Command_not_found.22_hook
[[ -e /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh
# Advanced command-not-found hook
[[ -e /usr/share/doc/find-the-command/ftc.zsh ]] && source /usr/share/doc/find-the-command/ftc.zsh

source $ZSH/oh-my-zsh.sh

alias 1d="cd .."  
alias 2d="cd ../.."  
alias 3d="cd ../../.."  
alias 4d="cd ../../../.."  
alias 5d="cd ../../../../.." 
alias cat='bat'
alias c='clear'
alias grep='rg'
alias img='kitten icat'
alias ip='ip -color=auto'
alias ls='lsd'
alias mkdir='mkdir -p'
alias py='ipython'
alias ytdlp='yt-dlp'
alias ytm='yt-dlp -f 139'
alias snapper-restore='sudo snapper --ambit classic rollback'
alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
