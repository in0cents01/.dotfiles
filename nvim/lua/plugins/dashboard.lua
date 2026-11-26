local IMG = vim.fn.stdpath("config") .. "/logo.jpeg"

-- width = 2 x height keeps the square image proportions
local W, H = 25, 15

local cmd = ("chafa %s --format symbols --size %dx%d; sleep .1"):format(IMG, W, H)

return {
	{
		"folke/snacks.nvim",
		opts = function(_, opts)
			opts.dashboard = opts.dashboard or {}
			opts.dashboard.sections = {
				{ section = "terminal", cmd = cmd, height = H, width = W, padding = 1, align = "center" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			}
		end,
	},
}
