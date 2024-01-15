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
map({ "n", "x" }, "gh", vim.lsp.buf.hover, { desc = "Hover" })
-------------- Copy and Paste
map("n", "<leader><c-a>", "gg<s-v>G", { desc = "Select All" })
map("x", "P", '"0p', { desc = "Paste(Last Yanked)" })
map({ "n", "x" }, "<c-v>", '"+p', { desc = "Paste(system)" })
map({"i" }, "<c-v>", "<c-r>+", { desc = "Paste(system)" })
map({ "n", "x" }, "<leader>pp", '"+p', { desc = "Paste(system)" })
map({ "n", "x" }, "<leader>PP", '"+P', { desc = "Paste(system) Before" })
map("x", "<leader>yy", '"+y', { desc = "Copy(system)" })
map("x", "<C-c>", '"+y', { desc = "Copy(system)" })

------------------exchange---------------
vim.keymap.set("n", "gX", require("substitute.exchange").operator, { noremap = true })
vim.keymap.set("n", "gXX", require("substitute.exchange").line, { noremap = true })
vim.keymap.set("x", "gX", require("substitute.exchange").visual, { noremap = true })
-----------SerachReplace(spectre)-------------
vim.keymap.set("n", "<leader>sl", "<esc><cmd>Telescope resume<CR>", {
  desc = "Telescope Resume Last Search",
})
vim.keymap.set("v", "<leader>sr", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = "Search current word",
})
vim.keymap.set("n", "<leader>sR", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "Search on current file",
})
-----------GitSigns
map({ "n", "v" }, "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
map({ "n", "v" }, "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", { desc = " Reset Hunk" })
map("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", { desc = "Undo Stage Hunk" })
-----------utils
map("n", "<leader>uh", function()
  utils.toggle_syntax()
end, { desc = "Toggle Syntax Highlight" })
map("n", "<leader>up", function()
  utils.toggle_autopairs()
end, { desc = "Toggle AutoParits" })
-----------toggle term
map("n", "<leader>tg", function()
  utils.toggle_term_cmd("lazygit")
end, { desc = "Toggleterm lazygit" })
map("n", "<leader>tl", function()
  utils.toggle_term_cmd("lf")
end, { desc = "Toggleterm lf " })
map("n", "<leader>tL", function()
  utils.toggle_term_cmd({cmd = "lf " .. vim.fn.getreg('%'), tid = "lffile"})
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
----------Misc
map("n", "<leader>snn", "<cmd>Telescope notify<cr>", { desc = "Show All Notifications" })
map("n", "<leader><leader>", "", { desc = "More Actions" })
map("n", "<leader><leader>H", "<cmd>EnableHL<CR>", { desc = "EnableHL" })
map("n", "<leader><leader>h", "<cmd>DisableHL<CR>", { desc = "DisableHL" })
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
-----------Disable Term Navi-----------
vim.keymap.set("t", "<c-j>", "<c-j>", { nowait = true })
vim.keymap.set("t", "<c-k>", "<c-k>", { nowait = true })
vim.keymap.set("t", "<c-l>", "<c-l>", { nowait = true })
