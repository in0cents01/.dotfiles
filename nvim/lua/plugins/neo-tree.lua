return {
	"nvim-neo-tree/neo-tree.nvim",
	opts = {
		popup_border_style = "rounded",
		default_component_configs = {
			indent = {
				with_markers = true,
				indent_marker = "│",
				last_indent_marker = "└",
				with_expanders = true,
			},
			diagnostics = {
				symbols = { error = "", warn = "", info = "", hint = "󰌵" },
			},
			git_status = {
				symbols = {
					added = "",
					modified = "",
					deleted = "✖",
					renamed = "󰁕",
					untracked = "",
					ignored = "",
					unstaged = "󰄱",
					staged = "",
					conflict = "",
				},
			},
		},
		window = { width = 35 },
		filesystem = {
			follow_current_file = { enabled = true },
			filtered_items = { visible = true, hide_dotfiles = false },
		},
	},
}
