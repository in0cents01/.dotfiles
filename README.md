<div align="center">

#  .dotfiles

**A fast, minimal terminal setup: LazyVim · Kitty · tmux · Zsh · Starship**

<br>

![Neovim](https://img.shields.io/badge/Neovim-0.12.5-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![LazyVim](https://img.shields.io/badge/Distro-LazyVim-0A7AFF?style=for-the-badge)
![Lua](https://img.shields.io/badge/Made%20with-Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
![Kitty](https://img.shields.io/badge/Terminal-Kitty-FFB86C?style=for-the-badge)
![tmux](https://img.shields.io/badge/tmux-1BB91F?style=for-the-badge&logo=tmux&logoColor=white)
![Zsh](https://img.shields.io/badge/Shell-Zsh-F15A24?style=for-the-badge&logo=gnubash&logoColor=white)
![Starship](https://img.shields.io/badge/Prompt-Starship-DD0B78?style=for-the-badge&logo=starship&logoColor=white)

<br>

[What's included](#-whats-included) ·
[Requirements](#-requirements) ·
[Quick start](#-quick-start) ·
[Shell & terminal](#-shell--terminal-configs) ·
[Shortcuts](#-notable-shortcuts) ·
[Troubleshooting](#-troubleshooting) ·
[Updating](#-updating)

</div>

---

## ✨ What's included

| | Component | What you get |
| :-: | --- | --- |
| 🟢 | **Neovim** | LazyVim config, plugin specs, language servers, formatters, Treesitter parsers, and code-runner shortcuts |
| 🐱 | **Kitty** | Terminal appearance, tabs, layouts, and key bindings |
| 🪟 | **tmux** | Compact status bar, pane styling, mouse support, Zsh as default shell |
| 🐚 | **Zsh + Starship** | Shell initialization and a Catppuccin-inspired prompt |

## 📁 Repository layout

```text
.dotfiles/
├── nvim/               # LazyVim config  →  ~/.config/nvim
├── kitty/kitty.conf    # Kitty           →  ~/.config/kitty/kitty.conf
├── .tmux/tmux.conf     # tmux            →  ~/.tmux.conf
└── .zsh/
    ├── .zshrc          # Zsh             →  ~/.zshrc
    └── starship.toml   # Starship        →  ~/.config/starship.toml
```

---

## 📦 Requirements

Tested on **Ubuntu (x86_64)**.

<details open>
<summary><b>1. Base tools</b></summary>

<br>

```sh
sudo apt update
sudo apt install -y git curl build-essential ripgrep fd-find unzip

# Ubuntu ships `fd` as `fdfind`; LazyVim expects `fd`
mkdir -p ~/.local/bin
ln -sf "$(which fdfind)" ~/.local/bin/fd
```

</details>

<details open>
<summary><b>2. Neovim 0.12.5</b></summary>

<br>

```sh
curl -LO https://github.com/neovim/neovim/releases/download/v0.12.5/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.bashrc
source ~/.bashrc

nvim --version   # should print NVIM v0.12.5
```

> On ARM64 (`uname -m` prints `aarch64`), use `nvim-linux-arm64.tar.gz` and `/opt/nvim-linux-arm64/bin` instead.

</details>

<details>
<summary><b>3. Optional extras</b></summary>

<br>

- [Nerd Font](https://www.nerdfonts.com/) v3.0+ so icons render correctly
- [Kitty](https://sw.kovidgoyal.net/kitty/), [tmux](https://github.com/tmux/tmux), [Zsh](https://www.zsh.org/), [Starship](https://starship.rs/) for the matching configs
- [lazygit](https://github.com/jesseduffield/lazygit) for the Git UI (`<leader>gg`)
- Language tools for whatever you code in

</details>

---

## 🚀 Quick start

### 1. Clone the repo

```sh
git clone https://github.com/thatsothoundotctl01-dotcom/.dotfiles.git ~/.dotfiles
```

### 2. Back up any existing Neovim setup

```sh
mv ~/.config/nvim      ~/.config/nvim.bak      2>/dev/null
mv ~/.local/share/nvim ~/.local/share/nvim.bak 2>/dev/null
mv ~/.local/state/nvim ~/.local/state/nvim.bak 2>/dev/null
mv ~/.cache/nvim       ~/.cache/nvim.bak       2>/dev/null
```

### 3. Link the Neovim config

```sh
ln -s ~/.dotfiles/nvim ~/.config/nvim
```

### 4. Launch

```sh
nvim
```

On first launch, `lazy.nvim` bootstraps itself and installs every configured plugin. Wait for it to finish, restart Neovim, then run `:LazyHealth` to confirm everything loaded.

> [!WARNING]
> **Bootstrap note:** `init.lua` loads `config.lazy`, which Neovim resolves to `lua/config/lazy.lua`.
> The tracked file is currently named `nvim/lua/config/lazys.lua`.
> Make the filename and the `require()` in `init.lua` agree before launching. Linux filesystems are case-sensitive.
>
> ```sh
> mv ~/.dotfiles/nvim/lua/config/lazys.lua ~/.dotfiles/nvim/lua/config/lazy.lua
> ```

---

## 🧩 Shell & terminal configs

All optional. Review each file and adapt it to your machine before linking.

| File | Purpose | Link to |
| --- | --- | --- |
| `kitty/kitty.conf` | Kitty settings | `~/.config/kitty/kitty.conf` |
| `.tmux/tmux.conf` | tmux settings | `~/.tmux.conf` |
| `.zsh/.zshrc` | Zsh startup | `~/.zshrc` |
| `.zsh/starship.toml` | Starship prompt | `~/.config/starship.toml` |

```sh
mkdir -p ~/.config/kitty

ln -s ~/.dotfiles/kitty/kitty.conf     ~/.config/kitty/kitty.conf
ln -s ~/.dotfiles/.tmux/tmux.conf      ~/.tmux.conf
ln -s ~/.dotfiles/.zsh/.zshrc          ~/.zshrc
ln -s ~/.dotfiles/.zsh/starship.toml   ~/.config/starship.toml
```

> [!IMPORTANT]
> `.zshrc` contains a machine-specific path. Edit it for your environment before linking.
> If a target file already exists, `ln -s` will fail; move the old file aside first (e.g. `mv ~/.zshrc ~/.zshrc.bak`).

---

## ⌨️ Notable shortcuts

Custom mappings from the plugin config. `<leader>` is `Space` (LazyVim default).

| Key | Action |
| :-- | --- |
| `<leader>e` | Toggle Neo-tree file explorer |
| `<leader>o` | Focus Neo-tree file explorer |
| `<F6>` / `<leader>rr` | Save the current file and run it |
| `<leader>rf` | Run the current file |
| `<leader>rc` | Close the code-runner terminal |
| `jj` *(Insert mode)* | Return to Normal mode |

Press `Space` and wait a second to see every available key in the which-key menu.

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

Rename `lazys.lua` to `lazy.lua`, or change the `require()` in `init.lua` to match. See the bootstrap note above.

</details>

<details>
<summary><b><code>nvim: command not found</code></b></summary>

<br>

Open a new terminal, or run `source ~/.bashrc` (or `~/.zshrc`) so the new `PATH` entry loads.

</details>

<details>
<summary><b>Treesitter or Mason errors on first launch</b></summary>

<br>

Make sure `build-essential` is installed, restart `nvim`, then run `:checkhealth` and look for `ERROR` entries.

</details>

---

## 🔄 Updating

**Plugins:** open Neovim and run `:Lazy`, then press `U` to update. `lazy-lock.json` records the exact plugin versions, so commit it to get an identical setup on every machine.

**Dotfiles:**

```sh
cd ~/.dotfiles && git pull
```

## 🧹 Uninstall

```sh
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
```

Since the config is symlinked, this removes only the link and Neovim's data; your `~/.dotfiles` repo stays intact.

---

<div align="center">

Made with ☕ and Lua

</div>