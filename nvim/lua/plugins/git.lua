-- ~/.config/nvim/lua/plugins/git.lua
-- Shows Git changes inside Neovim (gitsigns).
--
-- What you will see:
--   +  green  = new line
--   ~  blue   = changed line
--   _  red    = deleted line
-- These marks appear in the column left of the line numbers.
--
-- Keys (Space is the leader key):
--   ]c / [c         next / previous change
--   Space h p       preview the change (see what it was before)
--   Space h s       stage the change (like git add for one piece)
--   Space h r       reset the change (throw it away)
--   Space h b       show who wrote this line (git blame)
--   Space h t       turn blame text at end of line on/off
--   Space h d       open a side-by-side diff of this file

vim.pack.add({
	"https://github.com/lewis6991/gitsigns.nvim",
}, { confirm = false })

require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "+" },
	},

	-- Runs for every file inside a Git repo
	on_attach = function(bufnr)
		local gs = require("gitsigns")

		local function map(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
		end

		-- Jump between changes
		map("]c", function()
			gs.nav_hunk("next")
		end, "Next change")
		map("[c", function()
			gs.nav_hunk("prev")
		end, "Previous change")

		-- Work with a change
		map("<leader>hp", gs.preview_hunk, "Preview change")
		map("<leader>hs", gs.stage_hunk, "Stage change")
		map("<leader>hr", gs.reset_hunk, "Reset change")

		-- Blame and diff
		map("<leader>hb", function()
			gs.blame_line({ full = true })
		end, "Blame line")
		map("<leader>ht", gs.toggle_current_line_blame, "Toggle line blame")
		map("<leader>hd", gs.diffthis, "Diff this file")
	end,
})
