-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.keymap.set("i", "<Tab>", "<C-n>")
-- vim.keymap.set("i", "<S-Tab>", "<C-p>")
-- vim.keymap.set("i", "ii", "<ESC>")

vim.keymap.set("i", "ii", "<ESC>")
vim.keymap.set("n", "<leader>ws", "<C-w>v", { desc = "splitright" })

--window pick
-- vim.keymap.set("n", "<leader>wp", function()
--   local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
--   vim.api.nvim_set_current_win(picked_window_id)
-- end, { desc = "Pick a window" })
