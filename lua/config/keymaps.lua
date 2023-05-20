-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- vim.keymap.set("i", "<Tab>", "<C-n>")
-- vim.keymap.set("i", "<S-Tab>", "<C-p>")
-- vim.keymap.set("i", "ii", "<ESC>")

-- vim.keymap.set("i", "ii", "<ESC>")
vim.keymap.set("n", "<leader>ws", "<C-w>v", { desc = "splitright" })

map("n", "<leader><C-v>", '"+p', { desc = "Paste(system)" })
map("v", "<leader>gc", '"+y', { desc = "Copy(system)" })
map("n", "<leader>fm", "gg=G''", { desc = "Format this File" })
map("n", "<leader>uN", "<cmd>Notifications<cr>", { desc = "Show All Notifications" })
map("n", "<leader><leader>", "")
--window pick

vim.keymap.set("n", "<leader>wp", function()
  local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(picked_window_id)
end, { desc = "Pick a window" })

--search bidirectional
vim.keymap.set("n", "s", function()
  local current_window = vim.fn.win_getid()
  require("leap").leap({ target_windows = { current_window } })
end)
