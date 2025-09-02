### Environment Variables ###
export PNPM_HOME="$HOME/.local/share/pnpm"
export GOPATH="$HOME/.go"
export HISTFILE=~/.zsh_history
export SUDO_PROMPT="$(tput setab 1 setaf 7 bold)[sudo]$(tput sgr0) $(tput setaf 6)password for$(tput sgr0) $(tput setaf 5)%p$(tput sgr0): "
export BAT_THEME="Enki-Tokyo-Night"
typeset -U path
path=(
  "$HOME/.bin"
  "$HOME/.cargo/bin"
  "$HOME/.scripts"
  "$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
  "$ANDROID_SDK_ROOT/platform-tools"
  "$HOME/.local/bin"
  "$HOME/.lmstudio/bin"
  "$PNPM_HOME"
  $path
)
export PATH

### Load zinit ###
if [[ ! -f ~/.zinit/bin/zinit.zsh ]]; then
  mkdir -p ~/.zinit && git clone https://github.com/zinit-zsh/zinit.git ~/.zinit/bin
fi
source ~/.zinit/bin/zinit.zsh

### Instant Prompt ###
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Theme: Powerlevel10k ###
zinit light romkatv/powerlevel10k
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

### Plugins ###
# zinit light zsh-users/zsh-syntax-highlighting
zinit light zdharma/fast-syntax-highlighting
zinit light marlonrichert/zsh-autocomplete
zinit light hlissner/zsh-autopair
zinit light MichaelAquilina/zsh-you-should-use
zinit light MenkeTechnologies/zsh-more-completions
zinit light zpm-zsh/colorize
zinit load wfxr/forgit
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::copyfile
zinit snippet OMZP::sudo
autoload -Uz compinit && compinit
zstyle ':completion:*' completer _complete _complete:-fuzzy _correct _approximate _ignored

### Custom Functions ###
ex () {
    if [ -f "$1" ]; then
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

### Zoxide Integration ###
zinit light ajeetdsouza/zoxide
eval "$(zoxide init --no-cmd zsh)"
unalias zi 2>/dev/null
z() { __zoxide_z "$@" && lsd; }
zi() {__zoxide_zi "$@" && lsd; }

### Aliases ###
alias arch='wget -E -k -p'
alias c="printf '\033[2J\033[3J\033[1;1H'"
alias cat='bat'
alias compose='podman-compose'
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
alias yayfind="yay -Slq | fzf --multi --preview 'yay -Si {}' | xargs -ro yay -S"
alias z1="z .."  
alias z2="z ../.."  
alias z3="z ../../.."  
alias z4="z ../../../.."  
alias z5="z ../../../../.." 

### Yazi integration ###
function y() {
    print -Pn "\e]0;yazi\a"
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
