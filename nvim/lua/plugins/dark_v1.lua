-- ~/.config/nvim/lua/plugins/look.lua
-- (needs { import = "plugins" } in your lazy.setup list in init.lua


vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"

vim.opt.list = true
vim.opt.listchars = { eol = "¬", tab = "▏ ", trail = "·" }
vim.opt.fillchars = { vert = "│" }

vim.diagnostic.config({
	virtual_text = false,
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

-- Dark gray palette (edit these to taste)
local c = {
	bg = "#1e1e1e",
	bg_alt = "#252526",
	bg_line = "#2d2d2d",
	bg_sel = "#3a3a3a",
	border = "#444444",
	dim = "#5a5a5a",
	line_nr = "#6e6e6e",
	fg = "#d4d4d4",
	fg_hi = "#ffffff",
}

-- Runs after ANY colorscheme loads, so nothing can override the gray
local function apply_gray()
	local hl = vim.api.nvim_set_hl
	hl(0, "Normal", { fg = c.fg, bg = c.bg })
	hl(0, "NormalNC", { fg = c.fg, bg = c.bg })
	hl(0, "NormalFloat", { fg = c.fg, bg = c.bg_alt })
	hl(0, "FloatBorder", { fg = c.border, bg = c.bg_alt })
	hl(0, "SignColumn", { bg = c.bg })
	hl(0, "EndOfBuffer", { fg = c.bg, bg = c.bg })
	hl(0, "LineNr", { fg = c.line_nr, bg = c.bg })
	hl(0, "CursorLine", { bg = c.bg_line })
	hl(0, "CursorLineNr", { fg = c.fg_hi, bg = c.bg_line, bold = true })
	hl(0, "NonText", { fg = c.dim })
	hl(0, "Whitespace", { fg = c.dim })
	hl(0, "WinSeparator", { fg = c.border, bg = c.bg })
	hl(0, "Pmenu", { fg = c.fg, bg = c.bg_alt })
	hl(0, "PmenuSel", { bg = c.bg_sel, bold = true })
	hl(0, "Visual", { bg = c.bg_sel })
	hl(0, "StatusLine", { fg = c.fg, bg = c.bg_sel })
	hl(0, "IblIndent", { fg = c.bg_line })

	hl(0, "BlinkCmpMenu", { bg = c.bg_alt })
	hl(0, "BlinkCmpMenuBorder", { fg = c.border, bg = c.bg_alt })
	hl(0, "BlinkCmpMenuSelection", { bg = c.bg_sel, bold = true })
	hl(0, "BlinkCmpDoc", { bg = c.bg_alt })
	hl(0, "BlinkCmpDocBorder", { fg = c.border, bg = c.bg_alt })
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_gray })

local arrow_right = vim.fn.nr2char(0xe0b0)
local arrow_left = vim.fn.nr2char(0xe0b2)

local function mode(bg_a)
	return {
		a = { fg = c.bg, bg = bg_a, gui = "bold" },
		b = { fg = c.fg, bg = c.bg_sel },
		c = { fg = c.fg, bg = c.bg_alt },
	}
end
local gray_theme = {
	normal = mode("#9d9d9d"),
	insert = mode("#d4d4d4"),
	visual = mode("#7a7a7a"),
	replace = mode("#b0b0b0"),
	command = mode("#c0c0c0"),
	inactive = mode("#5a5a5a"),
}

return {
	-- Disable themes that would clash
	{ "catppuccin/nvim", enabled = false },
	{ "ellisonleao/gruvbox.nvim", enabled = false },
	{ "folke/tokyonight.nvim", enabled = false },
	{ "akinsho/bufferline.nvim", enabled = false },

	-- Force the base colorscheme (works with or without LazyVim)
	{
		"LazyVim/LazyVim",
		optional = true,
		opts = {
			colorscheme = function()
				vim.o.background = "dark"
				vim.cmd.colorscheme("habamax")
				apply_gray()
			end,
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = gray_theme,
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
			},
		},
	},

	{
		"saghen/blink.cmp",
		opts = {
			completion = {
				menu = { border = "single", draw = { columns = { { "label" }, { "kind" } } } },
				documentation = { auto_show = true, auto_show_delay_ms = 100, window = { border = "single" } },
			},
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = { char = "¦", highlight = "IblIndent" },
			scope = { enabled = false },
		},
	},
}
