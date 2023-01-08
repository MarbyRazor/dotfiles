# dotfiles

Marby's `.dotfiels` Repository with the following features:

- NeoVim as IDE

# Required Software

- NeoVim
- fzf
- ripgrep
- tmux
- lazygit
- k9s
- stow
- xsel (on X11)

# Installation 

Before you start be sure you will backup your `config` files.

Next you can clone the repo.
```sh
git clone https://github.com/MarbyRazor/dotfiles.git ~/.dotfiles
```
> The kickstart init.lua will be untouched. For customisation we will use separat files.
Get the latest kickstart init lua

```sh
curl ... ~/.dotfiles/nvim/.config/nvim/init.lua
```

Todo: 
- Renaming lua folder to custom name
- Check configurstion to yout needs

Install (stowing) the configs
```sh
./install
```

Add the ZSH Profile to your `~/.zshrc` file and reload the zsv profile
```sh
source ~/.zsh_profile
```

# Thank You

- [LunarVim Basic IDE](https://github.com/LunarVim/nvim-basic-ide) 
- [tmux-sessionizer](https://github.com/edr3x/tmux-sessionizer) 
- ThePrimeagen
