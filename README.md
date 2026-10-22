<div align="center">

# .dotfiles

<br>

![Neovim](https://img.shields.io/badge/Neovim-0.12.5-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![LazyVim](https://img.shields.io/badge/Distro-LazyVim-0A7AFF?style=for-the-badge)
![Lua](https://img.shields.io/badge/Made%20with-Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
![Kitty](https://img.shields.io/badge/Terminal-Kitty-FFB86C?style=for-the-badge)
![tmux](https://img.shields.io/badge/tmux-1BB91F?style=for-the-badge&logo=tmux&logoColor=white)
![Zsh](https://img.shields.io/badge/Shell-Zsh-F15A24?style=for-the-badge&logo=gnubash&logoColor=white)
![Starship](https://img.shields.io/badge/Prompt-Starship-DD0B78?style=for-the-badge&logo=starship&logoColor=white)

<br>

</div>

---


## Requirements

| Tool | Purpose |
| :-- | :-- |
| `Neovim 0.12.5` | Editor |
| `git` | Plugin installation |
| `build-essential` `curl` `unzip` | Treesitter parsers and Mason downloads |
| `ripgrep` `fd-find` `fzf` | Fuzzy search |
| `Nerd Font`| Icons (uses **Iosevka Nerd Font Mono**) |


## Neovim 


```sh
# Neovim 0.12.5
curl -LO https://github.com/neovim/neovim/releases/download/v0.12.5/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.bashrc
source ~/.bashrc

# Tools
sudo apt install -y git build-essential curl unzip ripgrep fd-find fzf

# Optional
sudo apt install -y kitty tmux zsh
curl -sS https://starship.rs/install.sh | sh
```




## Installation

**1. Clone the repository**

```sh
git clone https://github.com/thatsothoundotctl01-dotcom/.dotfiles.git ~/.dotfiles
```

**2. Back up your existing Neovim config**

```sh
mv ~/.config/nvim      ~/.config/nvim.bak      2>/dev/null
mv ~/.local/share/nvim ~/.local/share/nvim.bak 2>/dev/null
mv ~/.local/state/nvim ~/.local/state/nvim.bak 2>/dev/null
mv ~/.cache/nvim       ~/.cache/nvim.bak       2>/dev/null
```

**3. Install LazyVim**

```sh
git clone https://github.com/LazyVim/starter ~/.config/nvim && rm -rf ~/.config/nvim/.git
nvim
```

**4.  launch**
```sh
nvim 
```





