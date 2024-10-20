## Installation

just run this command

`curl -sSL https://raw.githubusercontent.com/4rtemis-4rrow/dotfiles/main/install.sh | sh`

it will install some packages, clone these dotfiles, and link them to their proper directory (I chose symlinks because it makes it easier to update from this repo), it will also install all the required scripts and what not

note: it's designed to work on arch based distros only, I haven't added support for package managers besides yay and paru, if you use any other distro, you'll have to manually install the dependancies, you can find the list in the install.sh file

## Screenshots

![](../main/Screenshots/Desktop.png)

this is the base desktop you get

![](../main/Screenshots/Rofi.png)

and that is the application launcher, Rofi

![](../main/Screenshots/SwayNC.png)

that is the swayNC client, do note that if your volume level is more than 100%, opening this will reset it to 100%

![](../main/Screenshots/Terminal.png)

that is the terminal and prompt

![](../main/Screenshots/Neovim.png)

and finally, the neovim config (that's the source code of my other project, [github.com/The0dinProject/0din](0din))

Note that the background changes every short while to any photo placed in ~/.wallpapers/ (it chooses the wallpaper randomly)
