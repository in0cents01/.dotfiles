-- ~/.config/nvim/lua/plugins/look.lua
-- Clean dark gray theme, no italics, lualine (statusline bottom, tabline top).
-- Needs a Nerd Font in your terminal for the rounded ends and icons.
-- Works on Neovim 0.9+ (the no-italic cleanup is skipped safely if unsupported).
-- (needs { import = "plugins" } in your lazy.setup list in init.lua)

---------------------------------------------------------------------------
-- Options
---------------------------------------------------------------------------
vim.opt.termguicolors = true
vim.o.background = "dark"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.showtabline = 2
vim.opt.signcolumn = "yes"
vim.opt.fillchars = { eob = " ", vert = "│" }

-- Hide invisible characters (the ¬ end-of-line symbol, tabs, trailing spaces)
vim.opt.list = false
vim.opt.listchars = { eol = " ", tab = "  ", trail = " " }

-- LazyVim re-enables `list` later, so force it off again after startup
vim.api.nvim_create_autocmd({ "VimEnter", "BufWinEnter", "FileType" }, {
	callback = function()
		vim.opt_local.list = false
	end,
})

vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
	underline = true,
})

---------------------------------------------------------------------------
-- Nerd Font glyphs (written as code points so they can't get lost)
---------------------------------------------------------------------------
local function g(code)
	return vim.fn.nr2char(code)
end
local round_l, round_r = g(0xe0b6), g(0xe0b4)
local branch_icon, lock_icon = g(0xe0a0), g(0xf023)
local ico = {
	error = g(0xf057) .. " ",
	warn = g(0xf071) .. " ",
	info = g(0xf05a) .. " ",
	hint = g(0xf0eb) .. " ",
}

---------------------------------------------------------------------------
-- Dark gray palette (edit these to taste)
---------------------------------------------------------------------------
local c = {
	-- UI
	bg = "#1e1e1e",
	bg_alt = "#252525",
	bg_line = "#2a2a2a",
	bg_sel = "#3a3a3a",
	border = "#3c3c3c",
	dim = "#5c5c5c",
	line_nr = "#5a5a5a",
	fg = "#cfcfcf",
	fg_hi = "#ffffff",

	-- statusline accents (all gray, brighter = more important)
	normal = "#a8a8a8",
	insert = "#e0e0e0",
	visual = "#7c7c7c",
	replace = "#b8b8b8",
	command = "#c8c8c8",

	-- syntax (soft, muted colors that sit well on gray)
	comment = "#6a6a6a",
	keyword = "#a9a9a9",
	func = "#e2e2e2",
	string = "#9fb08c",
	number = "#c4a882",
	type = "#8fa6b5",
	const = "#c4a882",
	preproc = "#8a8a8a",
	operator = "#a0a0a0",
	special = "#b8a58c",
}

---------------------------------------------------------------------------
-- Highlights
---------------------------------------------------------------------------
-- Remove italic from every highlight group (safe on any Neovim version)
local allowed = {
	"fg",
	"bg",
	"sp",
	"bold",
	"underline",
	"undercurl",
	"underdouble",
	"underdotted",
	"underdashed",
	"strikethrough",
	"reverse",
	"standout",
	"nocombine",
	"blend",
}

local function strip_italic()
	local ok, all = pcall(vim.api.nvim_get_hl, 0, {})
	if not ok or type(all) ~= "table" then
		return
	end
	for name in pairs(all) do
		local ok2, h = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
		if ok2 and type(h) == "table" and (h.italic or h.cursive) then
			local new = {}
			for _, key in ipairs(allowed) do
				if h[key] ~= nil then
					new[key] = h[key]
				end
			end
			pcall(vim.api.nvim_set_hl, 0, name, new)
		end
	end
end

-- Runs after ANY colorscheme loads, so nothing can override the gray
local applying = false
local function apply_gray()
	if applying then
		return
	end
	applying = true

	local function hl(name, val)
		pcall(vim.api.nvim_set_hl, 0, name, val)
	end

	-- Base
	hl("Normal", { fg = c.fg, bg = c.bg })
	hl("NormalNC", { fg = c.fg, bg = c.bg })
	hl("NormalFloat", { fg = c.fg, bg = c.bg_alt })
	hl("FloatBorder", { fg = c.border, bg = c.bg_alt })
	hl("FloatTitle", { fg = c.fg_hi, bg = c.bg_alt, bold = true })
	hl("SignColumn", { bg = c.bg })
	hl("FoldColumn", { fg = c.dim, bg = c.bg })
	hl("Folded", { fg = c.dim, bg = c.bg_alt })
	hl("EndOfBuffer", { fg = c.bg, bg = c.bg })
	hl("ColorColumn", { bg = c.bg_line })
	hl("WinSeparator", { fg = c.border, bg = c.bg })
	hl("VertSplit", { fg = c.border, bg = c.bg })

	-- Lines
	hl("LineNr", { fg = c.line_nr, bg = c.bg })
	hl("CursorLine", { bg = c.bg_line })
	hl("CursorLineNr", { fg = c.fg_hi, bg = c.bg_line, bold = true })
	hl("CursorLineSign", { bg = c.bg_line })

	-- Invisible chars
	hl("NonText", { fg = c.dim })
	hl("Whitespace", { fg = c.dim })

	-- Syntax
	hl("Comment", { fg = c.comment })
	hl("Constant", { fg = c.const })
	hl("String", { fg = c.string })
	hl("Character", { fg = c.string })
	hl("Number", { fg = c.number })
	hl("Boolean", { fg = c.const })
	hl("Float", { fg = c.number })
	hl("Identifier", { fg = c.fg })
	hl("Function", { fg = c.func })
	hl("Statement", { fg = c.keyword })
	hl("Conditional", { fg = c.keyword })
	hl("Repeat", { fg = c.keyword })
	hl("Label", { fg = c.keyword })
	hl("Keyword", { fg = c.keyword })
	hl("Exception", { fg = c.keyword })
	hl("Operator", { fg = c.operator })
	hl("PreProc", { fg = c.preproc })
	hl("Include", { fg = c.preproc })
	hl("Define", { fg = c.preproc })
	hl("Macro", { fg = c.preproc })
	hl("Type", { fg = c.type })
	hl("StorageClass", { fg = c.keyword })
	hl("Structure", { fg = c.type })
	hl("Typedef", { fg = c.type })
	hl("Special", { fg = c.special })
	hl("SpecialChar", { fg = c.special })
	hl("Delimiter", { fg = c.operator })
	hl("Title", { fg = c.fg_hi, bold = true })
	hl("Todo", { fg = c.fg_hi, bg = c.bg_sel, bold = true })

	-- Treesitter extras that otherwise pick odd colors
	hl("@variable", { fg = c.fg })
	hl("@variable.parameter", { fg = c.fg })
	hl("@property", { fg = c.fg })
	hl("@field", { fg = c.fg })
	hl("@constant", { fg = c.const })
	hl("@constant.builtin", { fg = c.const })
	hl("@punctuation", { fg = c.operator })
	hl("@punctuation.bracket", { fg = c.operator })
	hl("@punctuation.delimiter", { fg = c.operator })
	hl("@comment", { fg = c.comment })

	-- Selection and search
	hl("Visual", { bg = c.bg_sel })
	hl("Search", { fg = c.bg, bg = c.normal })
	hl("IncSearch", { fg = c.bg, bg = c.insert })
	hl("MatchParen", { fg = c.fg_hi, bg = c.bg_sel, bold = true })

	-- Menus
	hl("Pmenu", { fg = c.fg, bg = c.bg_alt })
	hl("PmenuSel", { bg = c.bg_sel, bold = true })
	hl("PmenuSbar", { bg = c.bg_alt })
	hl("PmenuThumb", { bg = c.border })

	-- Bars
	hl("StatusLine", { fg = c.fg, bg = c.bg_alt })
	hl("StatusLineNC", { fg = c.dim, bg = c.bg_alt })
	hl("TabLine", { fg = c.dim, bg = c.bg_alt })
	hl("TabLineFill", { bg = c.bg_alt })
	hl("TabLineSel", { fg = c.fg_hi, bg = c.bg_sel })
	hl("WinBar", { fg = c.fg, bg = c.bg })
	hl("WinBarNC", { fg = c.dim, bg = c.bg })

	-- Diagnostics (muted, no loud colors)
	hl("DiagnosticError", { fg = "#c27a7a" })
	hl("DiagnosticWarn", { fg = "#c2a97a" })
	hl("DiagnosticInfo", { fg = "#8a9aa8" })
	hl("DiagnosticHint", { fg = c.dim })

	-- File explorer
	hl("NeoTreeNormal", { fg = c.fg, bg = c.bg_alt })
	hl("NeoTreeNormalNC", { fg = c.fg, bg = c.bg_alt })
	hl("NeoTreeEndOfBuffer", { fg = c.bg_alt, bg = c.bg_alt })
	hl("NeoTreeWinSeparator", { fg = c.border, bg = c.bg })

	-- Completion menu (blink.cmp)
	hl("BlinkCmpMenu", { bg = c.bg_alt })
	hl("BlinkCmpMenuBorder", { fg = c.border, bg = c.bg_alt })
	hl("BlinkCmpMenuSelection", { bg = c.bg_sel, bold = true })
	hl("BlinkCmpDoc", { bg = c.bg_alt })
	hl("BlinkCmpDocBorder", { fg = c.border, bg = c.bg_alt })

	-- No italics anywhere
	pcall(strip_italic)

	applying = false
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_gray })
-- Plugins/LSP can add italic groups late, so clean up once more after startup
vim.api.nvim_create_autocmd("User", { pattern = "VeryLazy", callback = apply_gray })

---------------------------------------------------------------------------
-- Lualine theme
---------------------------------------------------------------------------
local function mode(accent)
	return {
		a = { fg = c.bg, bg = accent, gui = "bold" },
		b = { fg = c.fg, bg = c.bg_sel },
		c = { fg = c.fg, bg = c.bg_alt },
	}
end

local gray_theme = {
	normal = mode(c.normal),
	insert = mode(c.insert),
	visual = mode(c.visual),
	replace = mode(c.replace),
	command = mode(c.command),
	inactive = {
		a = { fg = c.dim, bg = c.bg_alt },
		b = { fg = c.dim, bg = c.bg_alt },
		c = { fg = c.dim, bg = c.bg_alt },
	},
}

---------------------------------------------------------------------------
-- Plugins
---------------------------------------------------------------------------
return {
	-- Disable plugins that add visual noise
	{ "lewis6991/gitsigns.nvim", enabled = false },
	{ "lukas-reineke/indent-blankline.nvim", enabled = false },
	{ "akinsho/bufferline.nvim", enabled = false }, -- lualine draws the top bar instead

	-- Disable indent guides (the thin | lines) from snacks.nvim
	{
		"folke/snacks.nvim",
		optional = true,
		opts = {
			indent = { enabled = false },
			scope = { enabled = false },
		},
	},

	-- Disable themes that would clash
	{ "catppuccin/nvim", enabled = false },
	{ "ellisonleao/gruvbox.nvim", enabled = false },
	{ "folke/tokyonight.nvim", enabled = false },

	-- Base colorscheme (the ColorScheme autocmd above then applies the dark gray)
	{
		"LazyVim/LazyVim",
		optional = true,
		opts = {
			colorscheme = "habamax",
		},
	},

	-- Statusline (bottom) + tabline (top)
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			opts.options = {
				theme = gray_theme,
				globalstatus = true,
				icons_enabled = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = round_r, right = round_l },
				disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
			}

			-- Bottom bar
			opts.sections = {
				lualine_a = { { "mode", separator = { left = round_l }, right_padding = 2 } },
				lualine_b = { { "branch", icon = branch_icon }, "diff" },
				lualine_c = {
					{
						"filename",
						path = 1,
						symbols = { modified = " ●", readonly = " " .. lock_icon, unnamed = "[No Name]" },
					},
				},
				lualine_x = {
					{
						"diagnostics",
						symbols = { error = ico.error, warn = ico.warn, info = ico.info, hint = ico.hint },
					},
					"filetype",
				},
				lualine_y = { "encoding", "progress" },
				lualine_z = { { "location", separator = { right = round_r }, left_padding = 2 } },
			}
			opts.inactive_sections = {
				lualine_c = { "filename" },
				lualine_x = { "location" },
			}

			-- Top bar
			opts.tabline = {
				lualine_a = {
					{
						"buffers",
						mode = 0,
						show_filename_only = true,
						show_modified_status = true,
						symbols = { modified = " ●", alternate_file = "", directory = "" },
						separator = { left = round_l },
						right_padding = 2,
						buffers_color = {
							active = { fg = c.bg, bg = c.normal, gui = "bold" },
							inactive = { fg = c.dim, bg = c.bg_alt },
						},
					},
				},
				lualine_z = {
					{ "tabs", mode = 0, separator = { right = round_r }, left_padding = 2 },
				},
			}

			opts.extensions = { "lazy", "neo-tree", "quickfix" }
			return opts
		end,
	},
}
