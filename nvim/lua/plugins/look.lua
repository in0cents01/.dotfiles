-- Save as ~/.config/nvim/lua/plugins/look.lua
-- and add  { import = "plugins" },  to the require("lazy").setup({ ... }) list in init.lua

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true -- relative numbers, absolute on current line
vim.opt.cursorline = true -- highlight the whole current line
vim.opt.showmode = false -- lualine already shows the mode
vim.opt.laststatus = 3 -- one global statusline
vim.opt.signcolumn = "yes"

-- Show "¬" at end of every line, dim, like the screenshot
vim.opt.list = true
vim.opt.listchars = { eol = "¬", tab = "▏ ", trail = "·" }
vim.opt.fillchars = { vert = "│" }

-- Diagnostics: only signs in the gutter (✗ for errors, Δ for warnings)
vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = false, -- set to true if you want "└── message" lines under the code
	severity_sort = true,
	underline = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✗",
			[vim.diagnostic.severity.WARN] = "Δ",
			[vim.diagnostic.severity.INFO] = "i",
			[vim.diagnostic.severity.HINT] = "?",
		},
	},
})

-- Powerline arrow glyphs (need a Nerd Font / Powerline font)
local arrow_right = vim.fn.nr2char(0xe0b0)
local arrow_left = vim.fn.nr2char(0xe0b2)

return {
	-- Remove other colorschemes / tabline plugins that would clash
	{ "catppuccin/nvim", enabled = false },
	{ "akinsho/bufferline.nvim", enabled = false },

	-- Classic gruvbox (dark, medium contrast, no italics)
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				terminal_colors = true,
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = false,
					emphasis = false,
					comments = false,
					operators = false,
					folds = false,
				},
				strikethrough = true,
				inverse = true,
				contrast = "", -- "" = medium, or "hard" / "soft"
				transparent_mode = false, -- solid #282828 background like the screenshot
				overrides = {
					-- current line + its number (yellow, bold)
					CursorLine = { bg = "#3c3836" },
					CursorLineNr = { fg = "#fabd2f", bg = "#3c3836", bold = true },
					LineNr = { fg = "#7c6f64" },

					-- dim "¬" end-of-line markers and whitespace
					NonText = { fg = "#504945" },
					Whitespace = { fg = "#504945" },

					-- split separator
					WinSeparator = { fg = "#504945", bg = "#282828" },

					-- gutter signs
					SignColumn = { bg = "#282828" },
					DiagnosticSignError = { fg = "#fb4934", bg = "#282828" },
					DiagnosticSignWarn = { fg = "#fe8019", bg = "#282828" },

					-- indent guides
					IblIndent = { fg = "#3c3836" },

					-- completion menu (blink.cmp)
					BlinkCmpMenu = { bg = "#282828" },
					BlinkCmpMenuBorder = { fg = "#928374", bg = "#282828" },
					BlinkCmpMenuSelection = { bg = "#504945", bold = true },
					BlinkCmpLabel = { fg = "#ebdbb2" },
					BlinkCmpLabelMatch = { fg = "#fabd2f", bold = true },
					BlinkCmpKind = { fg = "#8ec07c" },
					BlinkCmpDoc = { bg = "#282828" },
					BlinkCmpDocBorder = { fg = "#928374", bg = "#282828" },
				},
			})
			vim.o.background = "dark"
			vim.cmd.colorscheme("gruvbox")
		end,
	},

	-- Airline-style powerline statusline + buffer tabline
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "gruvbox",
				globalstatus = true,
				component_separators = "",
				section_separators = { left = arrow_right, right = arrow_left },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "diagnostics", "filetype" },
				lualine_y = { "encoding", "fileformat" },
				lualine_z = { "progress", "location" },
			},
			tabline = {
				lualine_a = { { "buffers", mode = 0 } },
				lualine_z = {
					{
						function()
							return "buffers"
						end,
						color = { fg = "#282828", bg = "#fe8019", gui = "bold" }, -- orange label
					},
				},
			},
		},
	},

	-- Completion menu with kind labels and a docs window beside it
	{
		"saghen/blink.cmp",
		opts = {
			completion = {
				menu = {
					border = "single",
					draw = { columns = { { "label" }, { "kind" } } },
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 100,
					window = { border = "single" },
				},
			},
		},
	},

	-- Thin dotted indent guides
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = { char = "¦", highlight = "IblIndent" },
			scope = { enabled = false },
		},
	},
}
