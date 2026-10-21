-- ~/.config/nvim/lua/plugins/lsp.lua
-- Java (jdtls) and Rust (rust-analyzer) are NOT here on purpose.
-- Enable them with :LazyExtras -> lang.java and lang.rust

return {
	-- LSP servers
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = true },
			servers = {
				-- Lua
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							workspace = { checkThirdParty = false },
							completion = { callSnippet = "Replace" },
							hint = { enable = true },
						},
					},
				},

				-- Python
				pyright = {},
				ruff = {},

				-- JavaScript / TypeScript
				vtsls = {},

				-- HTML / CSS
				html = {},
				cssls = {},
				emmet_ls = {
					filetypes = {
						"html",
						"css",
						"scss",
						"javascriptreact",
						"typescriptreact",
					},
				},
				tailwindcss = {},

				-- JSON / YAML
				jsonls = {},
				yamlls = {},

				-- Go
				gopls = {},

				-- C / C++
				clangd = {},

				-- PHP
				intelephense = {},

				-- Bash
				bashls = {},

				-- Markdown
				marksman = {},

				-- Docker
				dockerls = {},
				docker_compose_language_service = {},

				-- SQL
				sqlls = {},
			},
		},
	},

	-- Formatters / linters / debuggers installed through Mason
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"shfmt",
				"shellcheck",
				"prettier",
				"black",
				"gofumpt",
				"goimports",
				"clang-format",
				"hadolint",
				"markdownlint-cli2",
				"sqlfluff",
				"google-java-format",
			},
		},
	},
}
