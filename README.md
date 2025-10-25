# dotfiles

Marby's `.dotfiles` Repository

# Installation

Before you start be sure you will backup your `config` files.

If not, the `install.sh` script will do it for you!

Next you can clone this repo.

Install the required software:

For Debian and its derivates:

```sh
xargs -a ~.dotfiles/software.list sudo apt-get install
```

For Arch Linux and its derivates:

```sh
xargs -a ~.dotfiles/software.list sudo pacman -S
```

Install (stowing) the configs

```sh
./install.sh
```
