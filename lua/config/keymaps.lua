-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local utils = require("utils")

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

vim.keymap.set("i", "jj", "<ESC>")

-----------window operetions
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split Down" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split Right" })
vim.keymap.set("n", "<leader>wx", "<C-w>x", { desc = "Swap windows" })

-- map("n", "<c-j>", "<c-w>j")
-- map("n", "<c-k>", "<c-w>k")

map("n", "<leader><C-v>", '"+p', { desc = "Paste(system)" })
map("v", "<leader>gc", '"+y', { desc = "Copy(system)" })
map("n", "<leader>uN", "<cmd>Notifications<cr>", { desc = "Show All Notifications" })
map("n", "<leader><leader>", "")

-----------toggle term
map("n", "<leader>tg", function()
  utils.toggle_term_cmd({ cmd = "lazygit", direction = "tab", hidden = true })
end, { desc = "Toggleterm lazygit" })
map("n", "<leader>tb", function()
  utils.toggle_term_cmd("btm")
  -- utils.toggle_term_cmd({ "btm", "direction=tab" })
end, { desc = "Toggleterm btm" })
map("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "Toggleterm Horizontal" })
map("n", "<leader>tt", "<cmd>ToggleTerm direction=tab<cr>", { desc = "Toggleterm Horizontal" })
map("t", "<c-q>", "<cmd>tabclose<cr>")
-- map("t", "<c-tab>", "<cmd>echo 'hello'<cr>")
-- vim.keymap.set("t", "<esc>", [[<cmd>tabprevious<cr>]], { buffer = 0 })
--
----------------------------------------------search bidirectional
--
map("n", "<leader><leader>s", function()
  local current_window = vim.fn.win_getid()
  require("leap").leap({ target_windows = { current_window } })
end, { desc = "Search Bidirectional" })
--
----------------------------------------------ufo folding
--
map("n", "zp", function()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    -- vim.fn.CocActionAsync("definitionHover") -- coc.nvim
    vim.lsp.buf.hover()
  end
end, { desc = "Peek inside fold" })
---------costom cmd  revert file--
vim.api.nvim_create_user_command("Revert", function()
  vim.cmd("earlier 1f")
  local buf = vim.api.nvim_buf_get_name(0)
  -- vim.api.nvim_buf_delete(0, { force = true })
  require("mini.bufremove").delete(0, true)
  vim.cmd("e " .. buf)
end, {})
