# dotfiles

Marby's `.dotfiles` Repository

# Installation

Before you start be sure you will backup your `config` files.

Next you can clone the repo.

```sh
git clone https://github.com/MarbyRazor/dotfiles.git ~/.dotfiles
```

Install the required software:

For Debian and its derivates:

```sh
xargs -a ~.dotfiles/software.list sudo apt-get install
```

For Arch Linux and its derivates:

```sh
xargs -a ~.dotfiles/software.list sudo pacman -Ss
```

> The kickstart init.lua will be untouched. For customisation we will use separat files.
> Get the latest kickstart init lua

```sh
curl ... ~/.dotfiles/nvim/.config/nvim/init.lua
```

Install (stowing) the configs

```sh
./install
```

# Thank You

- [LunarVim Basic IDE](https://github.com/LunarVim/nvim-basic-ide)
- [tmux-sessionizer](https://github.com/edr3x/tmux-sessionizer)
- [ThePrimeagen](https://github.com/ThePrimeagen/)
- [SDaschner](https://github.com/sdaschner/dotfiles)
