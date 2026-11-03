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

