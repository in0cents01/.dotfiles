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

[What's inside](#-whats-inside) ·
[Structure](#-repository-structure) ·
[Requirements](#-requirements) ·
[Install](#-installation) ·
[Shortcuts](#%EF%B8%8F-keybindings) ·
[Troubleshooting](#-troubleshooting)

</div>

---

## ✨ What's inside

| | Tool | What you get |
| :-: | --- | --- |
| 🟢 | **Neovim** | LazyVim base with custom plugins, 19 language servers, 30+ formatters/linters via Mason, Treesitter parsers, and a one-key code runner |
| 🐱 | **Kitty** | Translucent blurred terminal, powerline tabs, smooth cursor trail, split/stack/tall layouts |
| 🪟 | **tmux** | Top status bar, centered windows, mouse support, thin pane borders |
| 🐚 | **Zsh + Starship** | Minimal Zsh startup with a Catppuccin Mocha powerline prompt |
| 🧩 | **VS Code** | Clean UI with Vim keybindings that mirror the Neovim setup |
| 🎨 | **Look & feel** | Catppuccin Mocha palette, Iosevka Nerd Font, italics disabled everywhere |

---

## 📁 Repository structure

```text
.dotfiles/
├── init.lua                  # Neovim entry point
├── lazyvim.json              # LazyVim version and extras
├── lazy-lock.json            # Pinned plugin versions
├── stylelua.toml             # StyLua formatter rules (2 spaces, 120 cols)
├── nvim/
│   └── lua/
│       ├── config/           # autocmds, keymaps, options, lazy.nvim bootstrap
│       └── plugins/          # colorschemes, dashboard, editor, tree, runner
├── kitty/
│   └── kitty.conf            # Terminal settings
├── .tmux/
│   └── tmux.conf             # tmux settings
├── .zsh/
│   ├── .zshrc                # Zsh startup file
│   └── starship.toml         # Starship prompt theme
├── .vscode/
│   └── setting.json          # VS Code settings
└── git/
    └── .gitconfig            # Git identity and defaults
```

---

## 📦 Requirements

**Required for Neovim**

| Tool | Why |
| --- | --- |
| [Neovim](https://neovim.io/) 0.12.5 | The editor |
| Git | Plugin installation |
| `build-essential`, `curl`, `unzip` | Compiling Treesitter parsers, Mason downloads |
| `ripgrep`, `fd-find`, `fzf` | Search in Telescope and Snacks |
| A [Nerd Font](https://www.nerdfonts.com/) v3+ | Icons (this setup uses **Iosevka Nerd Font Mono**) |

**Optional**

[Kitty](https://sw.kovidgoyal.net/kitty/) · [tmux](https://github.com/tmux/tmux) · [Zsh](https://www.zsh.org/) · [Starship](https://starship.rs/) · [lazygit](https://github.com/jesseduffield/lazygit)

<details>
<summary><b>Install </b></summary>

<br>

```sh
# Neovim 0.12.5
curl -LO https://github.com/neovim/neovim/releases/download/v0.12.5/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.bashrc
source ~/.bashrc

# Git, build tools, and search helpers
sudo apt install -y git build-essential curl unzip ripgrep fd-find fzf

# Optional terminal stack
sudo apt install -y kitty tmux zsh
curl -sS https://starship.rs/install.sh | sh
```

</details>

---

## 🚀 Installation

### 1. Clone the repository

```sh
git clone https://github.com/thatsothoundotctl01-dotcom/.dotfiles.git ~/.dotfiles
```

### 2. Back up 

```sh
mv ~/.config/nvim      ~/.config/nvim.bak      2>/dev/null
mv ~/.local/share/nvim ~/.local/share/nvim.bak 2>/dev/null
mv ~/.local/state/nvim ~/.local/state/nvim.bak 2>/dev/null
mv ~/.cache/nvim       ~/.cache/nvim.bak       2>/dev/null
```

### 3. Clone Lazyvim 

```sh
git clone https://github.com/LazyVim/starter ~/.config/nvim && rm -rf ~/.config/nvim/.git && nvim
```

### 4. Launch

```sh
nvim
```

The first start installs lazy.nvim, every plugin, the language servers, and the Treesitter parsers. Give it a minute.

### 5. Link the other tools (optional)

| Source | Link to |
| --- | --- |
| `kitty/kitty.conf` | `~/.config/kitty/kitty.conf` |
| `.tmux/tmux.conf` | `~/.tmux.conf` |
| `.zsh/.zshrc` | `~/.zshrc` |
| `.zsh/starship.toml` | `~/.config/starship.toml` |
| `git/.gitconfig` | `~/.gitconfig` |

```sh
mkdir -p ~/.config/kitty
ln -s ~/.dotfiles/kitty/kitty.conf     ~/.config/kitty/kitty.conf
ln -s ~/.dotfiles/.tmux/tmux.conf      ~/.tmux.conf
ln -s ~/.dotfiles/.zsh/.zshrc          ~/.zshrc
ln -s ~/.dotfiles/.zsh/starship.toml   ~/.config/starship.toml
```

> [!IMPORTANT]
> Review these files before linking them:
> - `.zsh/.zshrc` adds a machine-specific path (`/home/ts-concept/.local/bin`) to `PATH`. Change it to your own home directory.
> - `git/.gitconfig` contains my name and email. Replace them with yours.
> - `.tmux/tmux.conf` sets Zsh at `/usr/bin/zsh` as the default shell.

---

## ⌨️ Keybindings

`<leader>` is `Space`. Press it and wait a moment to open the which-key menu.

### Neovim

| Key | Mode | Action |
| :-- | :-: | --- |
| `jj` | Insert | Back to Normal mode |
| `<leader>e` | Normal | Toggle Neo-tree explorer |
| `<leader>o` | Normal | Focus Neo-tree explorer |
| `<F6>` / `<leader>rr` | Normal | Save and run the current file |
| `<leader>rf` | Normal | Run the current file |
| `<leader>rc` | Normal | Close the runner terminal |

**Code runner** supports Python, JavaScript, TypeScript, Lua, Bash, C, C++, Rust, Go, Java, PHP, Ruby, HTML, and JSON. Output opens in a bottom terminal split.

### Kitty

| Key | Action |
| :-- | --- |
| `Ctrl+Shift+T` | New tab in the current directory |
| `Ctrl+Shift+Enter` | New window in the current directory |
| `Ctrl+Alt+←` / `→` | Previous / next tab |
| `Shift+Scroll` | Switch tabs |
| `Ctrl+Shift+=` / `-` / `0` | Increase / decrease / reset font size |
| `Ctrl+Shift+F5` | Reload config |

### VS Code (Vim extension)

| Key | Action |
| :-- | --- |
| `jj` | Exit insert mode |
| `<leader>w` / `<leader>q` | Save / close editor |
| `<leader>f` / `<leader>g` | Quick open / search in files |
| `<leader>p` | Command palette |
| `<leader>e` / `<leader>t` | Toggle sidebar / terminal |
| `<leader>r` / `<leader>a` | Rename symbol / quick fix |
| `H` / `L` | Start / end of line |

---

## Neovim details

<details>
<summary><b>Language support</b></summary>

<br>

**Language servers:** clangd, pyright, vtsls, html, cssls, jsonls, yamlls, bashls, lua_ls, rust_analyzer, gopls, jdtls, intelephense, dockerls, tailwindcss, kotlin, ruby_lsp, zls, neocmake

**Formatters and linters (Mason):** clang-format, ruff, black, prettier, eslint-lsp, stylua, gofumpt, shfmt, shellcheck, sql-formatter, cmakelang, cmakelint

**Treesitter:** bash, c, cpp, css, go, html, java, javascript, json, kotlin, lua, markdown, php, python, regex, ruby, rust, sql, toml, tsx, typescript, vue, yaml, zig, and more

</details>

<details>
<summary><b>Colorschemes</b></summary>

<br>

Tokyonight is the default, and the setup also loads Catppuccin, Gruvbox, Kanagawa, Rose Pine, Nightfox, Everforest, Flexoki, Monokai Pro, Bamboo, and others. All are lazy-loaded, so switching is instant with `:colorscheme <name>`. Italics are stripped from every highlight group.

</details>

<details>
<summary><b>Plugins added on top of LazyVim</b></summary>

<br>

`neo-tree.nvim` · `code_runner.nvim` · `blink.cmp` · `lualine.nvim` · `snacks.nvim` (custom NEOVIM dashboard) · `nvim-treesitter` · `mason.nvim` · `nvim-lspconfig`

</details>

---

## 🔄 Updating

```sh
cd ~/.dotfiles && git pull
```

Then, inside Neovim:

| Command | What it does |
| --- | --- |
| `:Lazy sync` | Install, update, and clean plugins |
| `:Lazy restore` | Roll back to the versions in `lazy-lock.json` |
| `:Mason` | Manage language servers and formatters |
| `:checkhealth` | Diagnose problems |

---

## 🩺 Troubleshooting

<details>
<summary><b>Neovim errors with <code>module 'config.lazy' not found</code></b></summary>

<br>

`init.lua` requires `config.lazy`, but the bootstrap file in this repo is named `lazys.lua`. Rename it:

```sh
mv ~/.dotfiles/nvim/lua/config/lazys.lua ~/.dotfiles/nvim/lua/config/lazy.lua
```

</details>

<details>
<summary><b>Lua syntax error in <code>autocmds.lua</code> or <code>keymaps.lua</code></b></summary>

<br>

Remove the stray text at the end of these files: the word `autocmds` after the last block in `autocmds.lua`, and `#update keymap.lua` after the `jj` mapping in `keymaps.lua`. Lua does not accept either.

</details>

<details>
<summary><b>Two file explorers appear at once</b></summary>

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

Install a Nerd Font and set it as your terminal font. Kitty and VS Code are configured for `Iosevka Nerd Font Mono`.

</details>

<details>
<summary><b>The code runner does nothing for my language</b></summary>

<br>

The runner calls the language's own tool (`python3`, `node`, `go`, `cargo`, and so on), so it must be installed and on your `PATH`.

</details>

---

