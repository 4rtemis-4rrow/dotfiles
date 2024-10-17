#!/bin/zsh

packages=("swayfx" "swaync" "waybar" "wezterm" "zsh" "neovim" "zathura" "rofi" "grim" "slurp" "autotiling" "swaybg" "workstyle" "python-pyquery" "lsd" "bat" "satty-bin" "dragon-drop" "ripgrep" "xfce-polkit" "git" "curl" "ranger-git" "cliphist" "imv" "swayosd-git" "zen-browser-bin" "network-manager-widget" "udiskie" "ttf-jetbrains-mono-nerd" "fd" "mpv" "nwg-clipman" "hyprlock" "zoxide" "catppuccin-cursors-mocha" "aur/beautyline" "avfs")

if [ -f "/etc/os-release" ]; then
    # Source the os-release file
    . /etc/os-release
    
    # Check if the ID or ID_LIKE fields contain "arch"
    if [[ "$ID" == "arch" || "$ID_LIKE" == *"arch"* ]]; then
        if command -v yay &>/dev/null; then
            echo "[!] Using yay to install packages..."
            yay -Syu
            yay -S "${packages[@]} --noconfirm"
            yay -Yc
        elif command -v paru &>/dev/null; then
            echo "[!] Using paru to install packages..."
            paru -Syu
            paru -S "${packages[@]} --noconfirm"
            paru -Yc
        else
            echo "[!] Neither yay nor paru found. Installing yay..."
            sudo pacman -S --needed git base-devel
            git clone https://aur.archlinux.org/yay-bin.git
            cd yay-bin
            makepkg -si
            yay -Syu
            yay -S "${packages[@]}"
            yay -Yc
        fi
    fi
fi

sudo systemctl enable --now swayosd-libinput-backend.service

echo "[!] Installing Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "[!] Installing Zsh Plugins"
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ~/.oh-my-zsh/custom/plugins/zsh-autocomplete
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
git clone https://github.com/MichaelAquilina/zsh-auto-notify.git $ZSH_CUSTOM/plugins/auto-notify
git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins $ZSH_CUSTOM/plugins/autoupdate
echo "[!] Downloading Dotfiles"
git clone github.com/4rtemis-4rrow/dotfiles
echo "[!] Installing Dotfiles"
dotfiles_dir="$(pwd)/dotfiles"
ln -s "$dotfiles_dir/hypr" "$HOME/.config/hypr"
ln -s "$dotfiles_dir/wezterm/" "$HOME/.config/wezterm"
ln -s "$dotfiles_dir/neonote" "$HOME/.config/neonote"
ln -s "$dotfiles_dir/nvim/" "$HOME/.config/nvim"
ln -s "$dotfiles_dir/p10k.zsh" "$HOME/.p10k.zsh"
ln -s "$dotfiles_dir/ranger" "$HOME/.config/ranger"
ln -s "$dotfiles_dir/rofi/" "$HOME/.config/rofi"
ln -s "$dotfiles_dir/scripts" "$HOME/.scripts"
ln -s "$dotfiles_dir/sway/" "$HOME/.config/sway"
ln -s "$dotfiles_dir/swaync/" "$HOME/.config/swaync"
ln -s "$dotfiles_dir/wallpapers" "$HOME/.wallpapers"
ln -s "$dotfiles_dir/waybar/" "$HOME/.config/waybar"
ln -s "$dotfiles_dir/zshenv" "$HOME/.zshenv"
ln -s "$dotfiles_dir/zshrc" "$HOME/.zshrc"
chmod +x $HOME/.scripts/*
mountavfs

git clone https://github.com/enkia/enki-theme "$(bat --config-dir)/themes/enki-theme" && bat cache --build

echo "[!] Now everything should be ready to go, you might want to install icons, cursors, a gtk theme, a qt theme, etc, that is all up to you, enjoy"
