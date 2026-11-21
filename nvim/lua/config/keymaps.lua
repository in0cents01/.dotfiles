-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
--
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("n", "<F5>", "<cmd>Neotree toggle<cr>", { desc = "Toggle file tree" })

-- lua/config/keymaps.lua
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Copy / paste to the SYSTEM clipboard (the register "+)
map("v", "y", '"+y', vim.tbl_extend("force", opts, { desc = "Copy selection" }))
map("n", "yy", '"+yy', vim.tbl_extend("force", opts, { desc = "Copy entire line" }))
map("n", "yw", '"+yw', vim.tbl_extend("force", opts, { desc = "Copy word" }))
map("n", "y$", '"+y$', vim.tbl_extend("force", opts, { desc = "Copy to end of line" }))
map("n", "p", '"+p', vim.tbl_extend("force", opts, { desc = "Paste after cursor / below line" }))
map("n", "P", '"+P', vim.tbl_extend("force", opts, { desc = "Paste before cursor / above line" }))
