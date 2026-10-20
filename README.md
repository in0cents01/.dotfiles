<div align="center">

#  dotfiles

**My personal Neovim-first development setup**
LazyVim · Kitty · tmux · Zsh 

<br>

![Neovim](https://img.shields.io/badge/Neovim-LazyVim-57A143?style=for-the-badge&logo=neovim&logoColor=white) 
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
[Updating](#-updating-plugins)

</div>

---

## ✨ What's included

| | Component | What you get |
| :-: | --- | --- |
| 🟢 | **Neovim** | LazyVim configuration, plugin specs, language servers, formatters, Treesitter parsers, and code-running shortcuts |
| 🐱 | **Kitty** | Terminal appearance, tabs, layouts, and key bindings |
| 🪟 | **tmux** | Compact status bar, pane styling, mouse support, and Zsh as the default shell |
| 🐚 | **Zsh** | Shell initialization and a Catppuccin-inspired prompt |

---

## 📦 Requirements

**Required**

- [Neovim](https://neovim.io/) and [Git](https://git-scm.com/) — plugins are installed automatically by `lazy.nvim`

**Optional**

- [Kitty](https://sw.kovidgoyal.net/kitty/), [tmux](https://github.com/tmux/tmux), [Zsh](https://www.zsh.org/), and [Starship](https://starship.rs/) for the matching configs
- Language tools for the languages you use

> [!NOTE]
> The Neovim config asks **Mason** to install a selection of language servers and formatters.
> Running code also requires the relevant language runtime or compiler.

---

## 🚀 Neovim setup

### 1. Clone the repository

```sh
git clone https://github.com/thatsothoundotctl01-dotcom/.dotfiles.git
```

### 2. Link the config into Neovim

```sh
mkdir -p ~/.config/nvim/lua
ln -s ~/dotfiles-plugins/init.lua ~/.config/nvim/init.lua
ln -s ~/dotfiles-plugins/nvim/lua/config ~/.config/nvim/lua/config
ln -s ~/dotfiles-plugins/nvim/lua/plugins ~/.config/nvim/lua/plugins
```

### 3. Launch

```sh
nvim
```

On first launch, `lazy.nvim` bootstraps itself and installs every configured plugin. Wait for it to finish, then restart Neovim.

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
ln -s ~/dotfiles-plugins/kitty/kitty.conf ~/.config/kitty/kitty.conf
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

---

## 🔄 Updating plugins

Open Neovim and run:

```vim
:Lazy
```

to manage plugins. The `lazy-lock.json` file records the exact plugin versions in use, so commit it if you want the same setup on every machine.

---

<div align="center">

Made with ☕ and Lua

</div>