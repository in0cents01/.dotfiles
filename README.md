<div align="center">

# 🗂️ .dotfiles

**My personal Neovim-first development setup**
LazyVim · Kitty · tmux · Zsh · Starship

<br>

![Neovim](https://img.shields.io/badge/Neovim-0.12.5-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![LazyVim](https://img.shields.io/badge/Distro-LazyVim-0A7AFF?style=for-the-badge)
![Lua](https://img.shields.io/badge/Made%20with-Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
![Kitty](https://img.shields.io/badge/Terminal-Kitty-FFB86C?style=for-the-badge)
![tmux](https://img.shields.io/badge/tmux-1BB91F?style=for-the-badge&logo=tmux&logoColor=white)
![Zsh](https://img.shields.io/badge/Shell-Zsh-F15A24?style=for-the-badge&logo=gnubash&logoColor=white)
![Starship](https://img.shields.io/badge/Prompt-Starship-DD0B78?style=for-the-badge&logo=starship&logoColor=white)

<br>

[Features](#-whats-included) •
[Requirements](#-requirements) •
[Install](#-neovim-setup) •
[Shortcuts](#-notable-neovim-shortcuts) •
[Troubleshooting](#-troubleshooting) •
[Updating](#-updating-plugins)

</div>

---

## ✨ What's included

| | Component | What you get |
| :-: | --- | --- |
| 🟢 | **Neovim** | LazyVim configuration, plugin specs, language servers, formatters, Treesitter parsers, and code-running shortcuts |
| 🐱 | **Kitty** | Terminal appearance, tabs, layouts, and key bindings |
| 🪟 | **tmux** | Compact status bar, pane styling, mouse support, and Zsh as the default shell |
| 🐚 | **Zsh + Starship** | Shell initialization and a Catppuccin-inspired prompt |

---

## 📦 Requirements

> [!NOTE]
> The commands below target **Ubuntu / Debian on x86_64**. On macOS use `brew install neovim git`.

### Required

<details open>
<summary><b>Neovim 0.12.5</b></summary>

<br>

```sh
curl -LO https://github.com/neovim/neovim/releases/download/v0.12.5/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.bashrc   # use ~/.zshrc if you use Zsh
source ~/.bashrc
nvim --version | head -1
```

</details>

<details open>
<summary><b>Git</b></summary>

<br>

```sh
sudo apt install git -y && git --version
```

</details>

<details open>
<summary><b>Build tools and search helpers</b> (needed by Treesitter, Telescope, and Snacks)</summary>

<br>

```sh
sudo apt install -y build-essential curl unzip ripgrep fd-find fzf
```

</details>

### Optional

- [Kitty](https://sw.kovidgoyal.net/kitty/), [tmux](https://github.com/tmux/tmux), [Zsh](https://www.zsh.org/), and [Starship](https://starship.rs/) for the matching configs
- A [Nerd Font](https://www.nerdfonts.com/) (v3.0+) so icons display correctly
- [lazygit](https://github.com/jesseduffield/lazygit) for the Git UI
- Language tools for the languages you use

> [!NOTE]
> The Neovim config asks **Mason** to install a selection of language servers and formatters.
> Running code also requires the relevant language runtime or compiler.

---

## 🚀 Neovim setup

### 1. Clone the repository

```sh
git clone https://github.com/thatsothoundotctl01-dotcom/.dotfiles.git ~/.dotfiles
```

### 2. Back up any existing config

```sh
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null
mv ~/.local/share/nvim ~/.local/share/nvim.bak 2>/dev/null
mv ~/.local/state/nvim ~/.local/state/nvim.bak 2>/dev/null
mv ~/.cache/nvim ~/.cache/nvim.bak 2>/dev/null
```

### 3. Link the config into Neovim

```sh
mkdir -p ~/.config/nvim/lua
ln -s ~/.dotfiles/init.lua ~/.config/nvim/init.lua
ln -s ~/.dotfiles/nvim/lua/config ~/.config/nvim/lua/config
ln -s ~/.dotfiles/nvim/lua/plugins ~/.config/nvim/lua/plugins
```

### 4. Launch

```sh
nvim
```

On first launch, `lazy.nvim` bootstraps itself and installs every configured plugin. Wait for it to finish, then restart Neovim and run `:LazyHealth` to confirm everything loaded.

> [!WARNING]
> **Bootstrap note:** `init.lua` loads `config.lazy`, which Neovim resolves to `lua/config/lazy.lua`.
> The tracked file in this repository is currently named `nvim/lua/config/lazys.lua`.
> Make the module filename and the `require()` in `init.lua` agree before launching Neovim.
> Linux filesystems are case-sensitive.

---

## 🧩 Optional configurations

Review each file and adapt it to your machine before linking or copying it.

| File | Purpose | Install as |
| --- | --- | --- |
| `kitty/kitty.conf` | Kitty settings | `~/.config/kitty/kitty.conf` |
| `.tmux/tmux.conf` | tmux settings | `~/.tmux.conf` |
| `.zsh/.zshrc` | Zsh startup settings | `~/.zshrc` |
| `.zsh/starship.toml` | Starship prompt | `~/.config/starship.toml` |

<details>
<summary><b>Example: install the Kitty config</b></summary>

<br>

```sh
mkdir -p ~/.config/kitty
ln -s ~/.dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
```

</details>

<details>
<summary><b>Example: install tmux, Zsh, and Starship configs</b></summary>

<br>

```sh
ln -s ~/.dotfiles/.tmux/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/.zsh/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.zsh/starship.toml ~/.config/starship.toml
```

</details>

> [!IMPORTANT]
> The Zsh startup file includes a machine-specific path. Edit it for your environment before installing it.

---

## ⌨️ Notable Neovim shortcuts

Custom mappings defined in the plugin configuration. `<leader>` is the leader key configured by LazyVim (`Space` by default).

| Key | Action |
| :-- | --- |
| `<leader>e` | Toggle the Neo-tree file explorer |
| `<leader>o` | Focus the Neo-tree file explorer |
| `<F6>` or `<leader>rr` | Save the current file and run it |
| `<leader>rf` | Run the current file |
| `<leader>rc` | Close the code-runner terminal |
| `jj` *(Insert mode)* | Return to Normal mode |

Press `Space` and wait a second in Neovim to see every available key in the which-key menu.

---

## 🩺 Troubleshooting

<details>
<summary><b>Two file explorers show up at once</b></summary>

<br>

Neo-tree and the Snacks explorer are both enabled. Disable the one you don't want, for example Snacks:

```lua
return {
  "folke/snacks.nvim",
  opts = { explorer = { enabled = false } },
}
```

</details>

<details>
<summary><b>Icons show as boxes or question marks</b></summary>

<br>

Install a Nerd Font and set it as your terminal font.

</details>

<details>
<summary><b><code>module 'config.lazy' not found</code> on startup</b></summary>

<br>

See the bootstrap warning above: rename `lazys.lua` to `lazy.lua`, or change the `require()` in `init.lua` to match.

</details>

<details>
<summary><b><code>nvim: command not found</code></b></summary>

<br>

Open a new terminal, or run `source ~/.bashrc` (or `~/.zshrc`) so the new `PATH` entry is loaded.

</details>

---

## 🔄 Updating plugins

Open Neovim and run:

```vim
:Lazy
```

to manage plugins. The `lazy-lock.json` file records the exact plugin versions in use, so commit it if you want the same setup on every machine.

To pull the latest dotfiles:

```sh
cd ~/.dotfiles && git pull
```

---

<div align="center">

Made with ☕ and Lua

</div>