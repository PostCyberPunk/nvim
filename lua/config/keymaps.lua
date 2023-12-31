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
require("which-key").register({
  ["<leader>s"] = { name = "󰍉 Search" },
  ["<leader>c"] = { name = " Coding" },
  ["<leader>u"] = { name = " UI" },
  ["<leader>b"] = { name = "󰓩 Buffers" },
  ["<leader>d"] = { name = " Debugger" },
  ["<leader>g"] = { name = "󰊢 Git" },
  ["<leader>q"] = { name = "󱂬 Session" },
  ["<leader>t"] = { name = " Terminal" },
})
-----------window operetions
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split Down" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split Right" })
vim.keymap.set("n", "<leader>wx", "<C-w>x", { desc = "Swap windows" })

-- map("n", "<c-j>", "<c-w>j")
-- map("n", "<c-k>", "<c-w>k")

map("n", "<leader>pp", '"+p', { desc = "Paste(system)" })
map("x", "<leader>pp", '"+p', { desc = "Paste(system)" })
map("x", "<leader>yy", '"+y', { desc = "Copy(system)" })
map("n", "<leader><C-v>", '"+p', { desc = "Paste(system)" })
map("x", "P", '"0p', { desc = "Paste(Last Yanked)" })
map("x", "<C-c>", '"+y', { desc = "Copy(system)" })
map("n", "<leader>uN", "<cmd>Telescope notify<cr>", { desc = "Show All Notifications" })
map("n", "<leader><leader>", "", { desc = "More Actions" })
map("n", "<leader><c-a>", "gg<s-v>G", { desc = "Select All" })
------------------exchange---------------
vim.keymap.set("n", "gX", require("substitute.exchange").operator, { noremap = true })
vim.keymap.set("n", "gXX", require("substitute.exchange").line, { noremap = true })
vim.keymap.set("x", "gX", require("substitute.exchange").visual, { noremap = true })
-----------utils
map("n", "<leader>uh", function()
  utils.toggle_syntax()
end, { desc = "Toggle Syntax Highlight" })
map("n", "<leader>up", function()
  utils.toggle_autopairs()
end, { desc = "Toggle AutoParits" })
-----------toggle term
map("n", "<leader>gg", function()
  utils.toggle_term_cmd({ cmd = "lazygit", direction = "float", hidden = true })
end, { desc = "Toggleterm lazygit" })
map("n", "<leader>tl", function()
  utils.toggle_term_cmd("lf")
end, { desc = "Toggleterm lf " })
map("n", "<leader>tb", function()
  utils.toggle_term_cmd("btm")
end, { desc = "Toggleterm btm" })
map("n", "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", { desc = "Toggleterm Horizontal" })
map("n", "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggleterm Floating" })
map("t", "<c-q>", "<cmd>tabclose<cr>")
map("t", "<c-q>", function()
  if vim.api.nvim_list_tabpages()[2] == nil then
    vim.api.nvim_win_close(0, false)
  else
    vim.cmd("tabclose")
  end
end)
-- map("t", "<c-tab>", "<cmd>echo 'hello'<cr>")
-- vim.keymap.set("t", "<esc>", [[<cmd>tabprevious<cr>]], { buffer = 0 })
--
----------------------------------------------search bidirectional
--
-- map("n", "<leader><leader>s", function()
--   local current_window = vim.fn.win_getid()
--   require("leap").leap({ target_windows = { current_window } })
-- end, { desc = "Search Bidirectional" })
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
  utils.notify("Revert file:" .. buf)
end, {})
------------open with rider -----
map("n", "<leader>tr", function()
  local line = vim.fn.line(".")
  local col = vim.fn.virtcol(".")
  vim.cmd("!rider64 --line " .. line .. " --column " .. col .. " %")
end, { silent = true })
