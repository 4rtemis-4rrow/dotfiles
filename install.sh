#!/bin/bash

packages=("swayfx" "swaync" "waybar" "kitty" "zsh" "neovim" "zathura" "wofi" "grim" "slurp" "swappy" "autotiling" "brightnessctl" "swaybg" "workstyle" "clipman" "python-pyquery" "lsd" "bat" "ranger" "satty-bin" "ripdrag-git" "ripgrep)

if [ -f "/etc/os-release" ]; then
    # Source the os-release file
    . /etc/os-release
    
    # Check if the ID or ID_LIKE fields contain "arch"
    if [[ "$ID" == "arch" || "$ID_LIKE" == *"arch"* ]]; then
        if command -v yay &>/dev/null; then
            echo "Using yay to install packages..."
            yay -S "${packages[@]}"
        elif command -v paru &>/dev/null; then
            echo "Using paru to install packages..."
            paru -S "${packages[@]}"
        else
            echo "Neither yay nor paru found. Installing yay..."
            pacman -S --needed git base-devel
            git clone https://aur.archlinux.org/yay-bin.git
            cd yay-bin
            makepkg -si
            yay -S "${packages[@]}"
        fi
    fi
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

git clone github.com/4rtemis-4rrow/dotfiles
cd dotfiles
ln -s kitty/ nvim/ sway/ swaync/ wofi/ waybar/ ~/.config/
ln -s p10k.zsh ~/.p10k.zsh
ln -s zshrc ~/.zshrc
ln -s scripts ~/.scripts
ln -s wallpapers ~/.wallpapers
chmod +x ~/.scripts/*

echo "make sure to edit the weather.py script to add the location code for the weather.com website"
