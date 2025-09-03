### Environment Variables ###
set -Ux PNPM_HOME "$HOME/.local/share/pnpm"
set -Ux GOPATH "$HOME/.go"
set -Ux SUDO_PROMPT (tput setab 1; tput setaf 7; tput bold)"[sudo]"(tput sgr0)" "(tput setaf 6)"password for"(tput sgr0)" "(tput setaf 5)"%p"(tput sgr0)": "
set -Ux BAT_THEME "Enki-Tokyo-Night"
set -U fish_history_size 100000

# PATH
set -Ux PATH \
    $HOME/.bin \
    $HOME/.cargo/bin \
    $HOME/.scripts \
    $ANDROID_SDK_ROOT/cmdline-tools/latest/bin \
    $ANDROID_SDK_ROOT/platform-tools \
    $HOME/.local/bin \
    $HOME/.lmstudio/bin \
    $PNPM_HOME \
    $PATH
fish_add_path $PATH

### Plugins ###
# fisher install jethrokuan/z
# fisher install jethrokuan/fzf
# fisher install PatrickF1/fzf.fish
# fisher install decors/fish-colored-man
#
### Functions ###
# Extract archives
function ex
    if test -f $argv[1]
        switch $argv[1]
            case '*.7z'
                7z x $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.deb'
                ar x $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.rar'
                unrar x $argv[1]
            case '*.tar.bz2'
                tar xjf $argv[1]
            case '*.tar.gz'
                tar xzf $argv[1]
            case '*.tar'
                tar xf $argv[1]
            case '*.tar.xz'
                tar xf $argv[1]
            case '*.tar.zst'
                unzstd $argv[1]
            case '*.tbz2'
                tar xjf $argv[1]
            case '*.tgz'
                tar xzf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*'
                echo "'$argv[1]' cannot be extracted via ex()"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end

# Kill process with fzf
function k
    ps aux | grep -i $argv[1] | awk '{print $2, $11, $12}' | column -t | fzf -m | awk '{print $1}' | xargs -r kill -9
end

# Yazi integration
function y
    printf "\e]0;yazi\a"
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file=$tmp
    set cwd (cat $tmp ^/dev/null)
    if test -n "$cwd"; and test "$cwd" != "$PWD"
        cd $cwd
    end
    rm -f $tmp
end

### Aliases / Abbreviations ###
abbr arch "wget -E -k -p"
abbr c "printf '\033[2J\033[3J\033[1;1H'"
abbr cat "bat"
abbr compose "podman-compose"
abbr grep "rg"
abbr gudo 'sudo /bin/env WAYLAND_DISPLAY="$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" XDG_RUNTIME_DIR=/user/run/1000'
abbr img "kitten icat"
abbr ip "ip -color=auto"
abbr kdenlive "QT_QPA_PLATFORM=xcb LIBGL_ALWAYS_SOFTWARE=true kdenlive"
abbr ls "lsd"
abbr mkdir "mkdir -p"
abbr nv "nvim"
abbr py "ipython"
abbr rsync "rsync -avzh --progress --stats"
abbr sudo "run0 --background=0"
abbr wiki "zen-browser /usr/share/doc/arch-wiki/html/en/Table_of_contents.html"
abbr ytdlp "yt-dlp"
abbr ytm "yt-dlp -f 139"
abbr yayfind "yay -Slq | fzf --multi --preview 'yay -Si {}' | xargs -ro yay -S"

abbr z1 "z .."
abbr z2 "z ../.."
abbr z3 "z ../../.."
abbr z4 "z ../../../.."
abbr z5 "z ../../../../.."

### Zoxide Integration ###
# Zoxide init
# Zoxide integration
if type -q zoxide
    zoxide init fish | source

    # Wrap z to run lsd after jumping
    functions -e z    # remove any existing z
    function z
        __zoxide_z $argv; and lsd
    end
end

# Remove zoxide’s default completions
complete -c z -e

# Add cd-like directory completions
complete -c z -a "(__fish_complete_directories)"


### Prompt Config ###
set -g fish_greeting ""
set -g tide_left_prompt_frame_enabled true
set -g tide_prompt_char_ok '⮚'
set -g tide_prompt_char_error '❯'
fish_vi_key_bindings
