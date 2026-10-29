-- ~/.config/nvim/lua/plugins/mason.lua
-- Mason downloads and installs language servers for you.
-- A language server is what gives you autocomplete, errors and "go to definition".
--
-- How to use:
--   Space m      open the Mason window
--   Inside it:   i = install,  X = uninstall,  U = update,  g? = help
--
-- To add a language, add its server name to ensure_installed below.
-- Find names inside :Mason (press 2 to see the LSP list).
--
-- Needs on Ubuntu:  sudo apt install -y nodejs npm unzip curl git

vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
}, { confirm = false })

require("mason").setup({
	ui = {
		border = "single",
		check_outdated_packages_on_open = false,
	},
})

require("mason-lspconfig").setup({
	-- These are installed automatically the first time you open Neovim
	ensure_installed = {
		"lua_ls", -- Lua  (your Neovim config)
		"pyright", -- Python
		"ts_ls", -- JavaScript / TypeScript
		"bashls", -- Bash / shell scripts
	},

	-- Turns each installed server on by itself (no extra setup needed)
	automatic_enable = true,
})

vim.keymap.set("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Open Mason" })
