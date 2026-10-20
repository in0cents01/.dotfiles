<div align="center">

# .dotfiles

<br>

![Neovim](https://img.shields.io/badge/Neovim-0.12.5-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![LazyVim](https://img.shields.io/badge/LazyVim-Enabled-0A7AFF?style=for-the-badge)
![Lua](https://img.shields.io/badge/Made%20with-Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
![Kitty](https://img.shields.io/badge/Terminal-Kitty-FFB86C?style=for-the-badge)
![tmux](https://img.shields.io/badge/tmux-1BB91F?style=for-the-badge&logo=tmux&logoColor=white)
![Zsh](https://img.shields.io/badge/Shell-Zsh-F15A24?style=for-the-badge&logo=gnubash&logoColor=white)
![Starship](https://img.shields.io/badge/Prompt-Starship-DD0B78?style=for-the-badge&logo=starship&logoColor=white)

<br>

[Overview](#overview) • [Requirements](#requirements) • [Install](#install) • [Layout](#layout) • [Shortcuts](#notable-neovim-shortcuts) • [Troubleshooting](#troubleshooting)

</div>

---

## Overview

This repository contains a personal Linux development setup built around Neovim, LazyVim, and a few supporting terminal tools. It is designed for a fast, low-friction workflow with a clean terminal aesthetic and a quick startup experience.

Included components:

- Neovim with LazyVim and custom plugin configuration
- Kitty terminal profile and keybindings
- tmux session config
- Zsh startup file and Starship prompt
- Git configuration for a consistent author identity and editor

---

## Requirements

### Core

- Git
- Neovim 0.12.5 or newer
- A POSIX shell environment (Linux, WSL, or similar)

### Install Git

```sh
sudo apt install git -y && git --version
```

### Install Neovim 0.12.5

```sh
curl -LO https://github.com/neovim/neovim/releases/download/v0.12.5/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.bashrc
```

Then reload your shell:

```sh
source ~/.bashrc
```

### Optional tools

- [Kitty](https://sw.kovidgoyal.net/kitty/)
- [tmux](https://github.com/tmux/tmux)
- [Zsh](https://www.zsh.org/)
- [Starship](https://starship.rs/)
- [Nerd Font](https://www.nerdfonts.com/) (recommended for icons)
- [lazygit](https://github.com/jesseduffield/lazygit)
- Language-specific toolchains for the languages you use

---

## Install

### 1. Clone the repository

```sh
git clone https://github.com/thatsothoundotctl01-dotcom/.dotfiles.git ~/.dotfiles
```

### 2. Back up any existing Neovim data

```sh
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null
mv ~/.local/share/nvim ~/.local/share/nvim.bak 2>/dev/null
mv ~/.local/state/nvim ~/.local/state/nvim.bak 2>/dev/null
mv ~/.cache/nvim ~/.cache/nvim.bak 2>/dev/null
```

### 3. Clone the LazyVim starter and add these customizations

```sh
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
```

The starter provides the base LazyVim setup. These commands layer this repository's Neovim settings and plugins onto it. The rename is needed because `init.lua` loads `config.lazy`.

### 4. (Optional) Install the terminal configs

Review the Zsh config first and update its machine-specific PATH before installing. Then link whichever configs you use:

```sh
mkdir -p ~/.config/kitty
ln -s ~/.dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -s ~/.dotfiles/.tmux/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/.zsh/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.zsh/starship.toml ~/.config/starship.toml
```

### 5. Launch Neovim

```sh
nvim
```

## Troubleshooting

### Two file explorers show up at once

Neo-tree and Snacks are both enabled. If you prefer only one, disable the other in your config.

```lua
return {
  "folke/snacks.nvim",
  opts = { explorer = { enabled = false } },
}
```

### Icons display as boxes or question marks

Install a Nerd Font and set it as the active font in your terminal.

### `nvim: command not found`

Open a new terminal or run:

```sh
source ~/.bashrc
```

or:

```sh
source ~/.zshrc
```

If your PATH was updated in a shell profile, restart the terminal session before retrying.

### `module 'config.lazy' not found`

Ensure your file name and the require path match. This repo currently references `config.lazy` from `init.lua`, so the actual file in `nvim/lua/config/` should match that module name.

---

## Updating plugins

Open Neovim and run:

```vim
:Lazy
```

This launches the Lazy plugin manager so you can update, install, or remove plugins. The `lazy-lock.json` file pins the plugin versions used by the current setup.

To pull the latest repo updates:

```sh
cd ~/.dotfiles && git pull
```

---

<div align="center">

Made with ☕ and Lua

</div>
