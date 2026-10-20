-- ~/.config/nvim/lua/plugins/git.lua
-- Needs `git` and `lazygit` installed on your system.

return {
	-- Gutter signs, hunk actions, inline blame (already in LazyVim, tuned here)
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 500,
				virt_text_pos = "eol",
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		},
	},

	-- Side-by-side diffs and file history
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview open" },
			{ "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diffview close" },
			{ "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "File history (current)" },
			{ "<leader>gR", "<cmd>DiffviewFileHistory<cr>", desc = "Repo history" },
		},
		opts = {},
	},

	-- Resolve merge conflicts
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		event = "BufReadPre",
		opts = {
			default_mappings = true,
		},
	},

	-- Git UI inside Neovim (Magit style)
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
		},
		keys = {
			{ "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit" },
		},
		opts = {
			integrations = { diffview = true },
		},
	},

	-- Open the file/line on GitHub or GitLab (:GBrowse style)
	{
		"folke/snacks.nvim",
		keys = {
			{
				"<leader>gB",
				function()
					Snacks.gitbrowse()
				end,
				desc = "Git browse (open in browser)",
				mode = { "n", "v" },
			},
		},
	},
}
