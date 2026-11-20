return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle explorer" },
			{ "<leader>o", "<cmd>Neotree focus<CR>", desc = "Focus explorer" },
		},
		opts = {
			close_if_last_window = true,
			popup_border_style = "rounded",
			enable_git_status = true,
			window = { width = 30 },
			filesystem = {
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
				filtered_items = { hide_dotfiles = false, hide_gitignored = false },
			},
		},
	},
	{
		"CRAG666/code_runner.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("code_runner").setup({
				mode = "term",
				focus = true,
				startinsert = true,
				term = { position = "bot", size = 15 },
				filetype = {
					python = "python3 -u $fileName",
					javascript = "node $fileName",
					typescript = "ts-node $fileName",
					lua = "lua $fileName",
					sh = "bash $fileName",
					bash = "bash $fileName",
					go = "go run $fileName",
					rust = "cd $dir && cargo run",
					php = "php $fileName",
					ruby = "ruby $fileName",
					html = "xdg-open $fileName",
					json = "cat $fileName | jq .",
					c = "cd $dir && gcc $fileName -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt",
					cpp = "cd $dir && g++ -std=c++17 $fileName -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt",
					java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
				},
			})
		end,
		keys = {
			{
				"<F6>",
				function()
					vim.cmd("silent! write")
					vim.cmd("RunCode")
				end,
				desc = "Save & Run Code",
			},
			{
				"<leader>rr",
				function()
					vim.cmd("silent! write")
					vim.cmd("RunCode")
				end,
				desc = "Save & Run Code",
			},
			{ "<leader>rf", "<cmd>RunFile<cr>", desc = "Run File" },
			{ "<leader>rc", "<cmd>RunClose<cr>", desc = "Close Runner" },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"cmake",
				"css",
				"dockerfile",
				"go",
				"gomod",
				"gosum",
				"html",
				"java",
				"javascript",
				"json",
				"json5",
				"kotlin",
				"latex",
				"lua",
				"luadoc",
				"make",
				"markdown",
				"markdown_inline",
				"php",
				"python",
				"query",
				"regex",
				"ruby",
				"rust",
				"sql",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"vue",
				"xml",
				"yaml",
				"zig",
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "+" },
			},
			on_attach = function(bufnr)
				local gs = require("gitsigns")

				local function map(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
				end

				map("]c", function()
					gs.nav_hunk("next")
				end, "Next change")
				map("[c", function()
					gs.nav_hunk("prev")
				end, "Previous change")

				map("<leader>hp", gs.preview_hunk, "Preview change")
				map("<leader>hs", gs.stage_hunk, "Stage change")
				map("<leader>hr", gs.reset_hunk, "Reset change")

				map("<leader>hb", function()
					gs.blame_line({ full = true })
				end, "Blame line")
				map("<leader>ht", gs.toggle_current_line_blame, "Toggle line blame")
				map("<leader>hd", gs.diffthis, "Diff this file")
			end,
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			diagnostics = {
				virtual_text = { spacing = 2, prefix = "●" },
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = { border = "single", source = true },
			},
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
							telemetry = { enable = false },
						},
					},
				},
				clangd = {},
				pyright = {},
				vtsls = {},
				html = {},
				cssls = {},
				jsonls = {},
				yamlls = {},
				bashls = {},
				lua_ls = {},
				rust_analyzer = {},
				gopls = {},
				jdtls = {},
				intelephense = {},
				dockerls = {},
				tailwindcss = {},
				kotlin_language_server = {},
				ruby_lsp = {},
				zls = {},
				neocmake = {},
			},
		},
	},
	{
		"mason-org/mason.nvim",
		keys = { { "<leader>m", "<cmd>Mason<cr>", desc = "Mason" } },
		opts = {
			ensure_installed = {
				"clangd",
				"clang-format",
				"pyright",
				"ruff",
				"black",
				"typescript-language-server",
				"prettier",
				"eslint-lsp",
				"html-lsp",
				"css-lsp",
				"json-lsp",
				"yaml-language-server",
				"bash-language-server",
				"lua-language-server",
				"stylua",
				"rust-analyzer",
				"gopls",
				"gofumpt",
				"jdtls",
				"intelephense",
				"dockerfile-language-server",
				"tailwindcss-language-server",
				"kotlin-language-server",
				"ruby-lsp",
				"zls",
				"cmakelang",
				"cmakelint",
				"shfmt",
				"shellcheck",
				"sql-formatter",
			},
		},
	},
	{
		"saghen/blink.cmp",
		opts = {
			completion = { documentation = { auto_show = true, auto_show_delay_ms = 200 }, menu = { auto_show = true } },
			sources = { default = { "lsp", "path", "snippets", "buffer" } },
		},
	},
}
