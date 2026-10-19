# dotfiles-plugins

Personal configuration files for a Neovim-based development setup, with optional
terminal and shell customizations.

## What's included

- **Neovim** — LazyVim configuration, plugin specs, language servers, formatters,
  Treesitter parsers, and code-running shortcuts.
- **Kitty** — terminal appearance, tabs, layouts, and key bindings.
- **tmux** — a compact status bar, pane styling, mouse support, and Zsh as the
  default shell.
- **Zsh and Starship** — shell initialization and a Catppuccin-inspired prompt.

## Requirements

- Neovim and Git (Neovim plugins are installed by `lazy.nvim`).
- Kitty, tmux, Zsh, and Starship for the optional corresponding configurations.
- Language tools for the languages you use. The Neovim configuration asks Mason
  to install a selection of language servers and formatters; running code also
  requires the relevant language runtime or compiler.

## Neovim setup

Clone the repository, then link its Neovim entry point and Lua modules into the
standard Neovim config directory:

```sh
git clone https://github.com/thatsothoundotctl01-dotcom/dotfiles-plugins.git ~/dotfiles-plugins
mkdir -p ~/.config/nvim/lua
ln -s ~/dotfiles-plugins/init.lua ~/.config/nvim/init.lua
ln -s ~/dotfiles-plugins/nvim/lua/config ~/.config/nvim/lua/config
ln -s ~/dotfiles-plugins/nvim/lua/plugins ~/.config/nvim/lua/plugins
```

Start Neovim with `nvim`. On its first launch, `lazy.nvim` bootstraps itself and
installs the configured plugins.

> **Bootstrap note:** `init.lua` loads `config.lazy`, which Neovim resolves to
> `lua/config/lazy.lua`. The tracked file in this repository is currently named
> `nvim/lua/config/lazys.lua`. Make the module filename and the `require()` in
> `init.lua` agree before launching Neovim; Linux filesystems are case-sensitive.

## Optional configurations

Review each file and adapt it to your machine before linking or copying it:

| File | Purpose |
| --- | --- |
| `kitty/kitty.conf` | Kitty settings; use as `~/.config/kitty/kitty.conf`. |
| `.tmux/tmux.conf` | tmux settings; use as `~/.tmux.conf`. |
| `.zsh/.zshrc` | Zsh startup settings; use as `~/.zshrc`. |
| `.zsh/starship.toml` | Starship prompt; use as `~/.config/starship.toml`. |

For example, after reviewing the Kitty settings:

```sh
mkdir -p ~/.config/kitty
ln -s ~/dotfiles-plugins/kitty/kitty.conf ~/.config/kitty/kitty.conf
```

The Zsh startup file includes a machine-specific path. Edit it for your
environment before installing it.

## Notable Neovim shortcuts

These custom mappings are defined in the plugin configuration:

| Key | Action |
| --- | --- |
| `<leader>e` | Toggle the Neo-tree file explorer. |
| `<leader>o` | Focus the Neo-tree file explorer. |
| `<F6>` or `<leader>rr` | Save the current file and run it. |
| `<leader>rf` | Run the current file. |
| `<leader>rc` | Close the code-runner terminal. |
| `jj` in Insert mode | Return to Normal mode. |

`<leader>` is the leader key configured by LazyVim.

## Updating plugins

Open Neovim and run `:Lazy` to manage plugins. The `lazy-lock.json` file records
the plugin revisions for reproducible installs; keep it with the configuration.
