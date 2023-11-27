## Why?

I made this config as my first proper rice after switching from KDE, as a power user, I wanted it to be perfect for that, but I also wanted to make it simple to use for beginners, while at the same time being as beautiful as possible, tokyo night was the perfect theme for that, offering high contrast in colors to make it easy to code with, at the same time having a great set of colors

## Installation

just run this command

`curl -sSL https://raw.githubusercontent.com/4rtemis-4rrow/dotfiles/main/install.sh | sh`

it will install the following, clone these dotfiles, and link them to their proper directory (I chose symlinks because it makes it easier to update from this repo)

note: it's designed to work on arch based distros only, I haven't added support for package managers besides yay and paru, if you use any other distro, you'll have to manually install the dependancies as well as manually move the dotfiles

1. swayfx
2. swaync
3. waybar
4. kitty
5. zsh
6. oh my zsh
7. neovim
8. zathura
9. wofi
10. grim
11. slurp
12. swappy
13. autotiling
14. brightnessctl
15. swaybg
16. workstyle
17. clipman
18. python-pyquery
19. lsd
20. bat
21. cless
22. ranger
23. ripdrag
24. satty
24. ripgrep

there might be missing dependancies that I forgot to add here, if you find any, feel free to update the install.sh file, or submit an issue for me to update it

## Screenshots

![](../main/Screenshots/Desktop.png)

this is the base desktop you get

![](../main/Screenshots/Wofi.png)

and that is the application launcher, wofi

![](../main/Screenshots/SwayNC.png)

that is the swayNC client, do note that if your volume level is more than 100%, opening this will reset it to 100%

![](../main/Screenshots/Terminal.png)

that is the terminal and prompt, do note that the red block is there to cover my IP

![](../main/Screenshots/Neovim.png)

and finally, the neovim config (that's the source code of my other project, [github.com/4rtemis-4rrow/Ash](Ash))

## GTK and QT themes + icons
since this is all based around tokyo night, you'd want something similar too for GTK or QT, or both, these are just suggestions, choose what you like most

QT:

    sweet

    utterly sweet

GTK:

    https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme

Icons:

    BeautyLine: https://github.com/gvolpe/BeautyLine


## Credits:
some of the configs here aren't mine, but rather copied them from other repos

swayNC: https://github.com/lvntcnylmz/dotfiles

waybar weather module: https://gist.github.com/Surendrajat/ff3876fd2166dd86fb71180f4e9342d7

wofi: https://github.com/Jguer/dotfiles

thanks to these people for the configs/code

