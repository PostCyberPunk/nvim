-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local utils = require("utils")

vim.keymap.set("i", "jj", "<ESC>")
-----------window operetions
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split Down" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split Right" })
vim.keymap.set("n", "<leader>wx", "<C-w>x", { desc = "Swap windows" })

vim.keymap.set("n", "<M-x>", function()
  Snacks.bufdelete()
end, { desc = "Close buffer" })
-- vim.keymap.set("n", "<c-j>", "<c-w>j")
-- vim.keymap.set("n", "<c-k>", "<c-w>k")
------ Selection and Motion--------
vim.keymap.set({ "n", "x" }, "gh", vim.lsp.buf.hover, { desc = "Hover" })
vim.keymap.set("x", "iL", "$h", { desc = "Till line end" })
vim.keymap.set("o", "iL", ":normal viL<CR>", { desc = "Till line end" })
vim.keymap.set("x", "il", "^o$h", { desc = "Whole line" })
vim.keymap.set("o", "il", ":normal vil<CR>", { desc = "Whole line" })

vim.keymap.set("n", "<leader><c-a>", function()
  local state = false
  if vim.g.snacks_animate then
    vim.g.snacks_animate = false
    state = true
  end
  local keys = vim.api.nvim_replace_termcodes("gg<s-v>G", true, false, true)
  vim.api.nvim_feedkeys(keys, "n", true)
  -- FIX: maybe i need a better way to do that use <leader>ua
  vim.defer_fn(function()
    vim.g.snacks_animate = state
  end, 500)
end, { desc = "Select All" })
-------------- Copy and Paste
vim.keymap.set({ "n", "x" }, "<c-v>", '"+p', { desc = "Paste(system)" })
vim.keymap.set({ "i" }, "<c-v>", "<c-r>+", { desc = "Paste(system)" })
vim.keymap.set({ "n", "x" }, "<leader>p", '"+p', { desc = "Paste(system)" })
vim.keymap.set({ "n", "x" }, "<leader>P", '"+P', { desc = "Paste(system) Before" })
vim.keymap.set("x", "Y", '"+y', { desc = "Copy(system)" })
vim.keymap.set("x", "<c-y>", '"+y', { desc = "Copy(system)" })
vim.keymap.set("x", "<leader>y", '"+y', { desc = "Copy(system)" })
vim.keymap.set("x", "<C-c>", '"+y', { desc = "Copy(system)" })
vim.keymap.set("n", "gV", "`[v`]", { desc = "Select last Paste" })
--toggle p
vim.keymap.set("n", "<leader>uP", function()
  if vim.g.pasteRing then
    vim.keymap.set("x", "p", "p", { desc = "Paste", noremap = true })
    vim.g.pasteRing = false
  else
    vim.keymap.set("x", "p", "P", { desc = "Paste!ring", noremap = true })
    vim.g.pasteRing = true
  end
end, { desc = "Toggle Paste RegisterRing" })
-----------SerachReplace(spectre)-------------
vim.keymap.set({ "x" }, "<leader>sr", function()
  require("grug-far").open({ visualSelectionUsage = "prefill-search", prefills = { paths = vim.fn.expand("%") } })
end, { desc = "Search and Replace with this word" })

vim.keymap.set({ "x" }, "<leader>sI", function()
  require("grug-far").open({ visualSelectionUsage = "operate-within-range" })
end, { desc = "Search within range" })

vim.keymap.set("n", "<leader>sR", function()
  require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
end, {
  desc = "Search on current file",
})
-----------GitSigns
vim.keymap.set({ "n", "v" }, "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
vim.keymap.set({ "n", "v" }, "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", { desc = " Reset Hunk" })
vim.keymap.set("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", { desc = "Undo Stage Hunk" })
-----------utils
vim.keymap.set("n", "<leader>up", function()
  utils.toggle_autopairs()
end, { desc = "Toggle AutoParits" })
vim.keymap.set("n", "<leader>u0", function()
  utils.toggle_signcolumn()
end, { desc = "Toggle Signcolumn" })
-----------toggle term
vim.keymap.set("n", "<leader>tg", function()
  utils.toggle_term_cmd("lazygit")
end, { desc = "Toggleterm lazygit" })
vim.keymap.set("n", "<leader>tl", function()
  utils.toggle_term_cmd("lf")
end, { desc = "Toggleterm lf " })
vim.keymap.set("n", "<leader>tL", function()
  utils.toggle_term_cmd({ cmd = "lf " .. vim.fn.getreg("%"), tid = "lffile" })
end, { desc = "Toggleterm lf " })
vim.keymap.set("n", "<leader>tb", function()
  utils.toggle_term_cmd("btm")
end, { desc = "Toggleterm btm" })
-----------Term Navi-----------
vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], { nowait = true })
vim.keymap.set("t", "<c-q>", "<cmd>tabclose<cr>")
vim.keymap.set("t", "<c-q>", function()
  if vim.api.nvim_list_tabpages()[2] == nil then
    vim.api.nvim_win_close(0, false)
  else
    vim.cmd("tabclose")
  end
end)
vim.keymap.set("t", "<c-j>", "<c-j>", { nowait = true })
vim.keymap.set("t", "<c-k>", "<c-k>", { nowait = true })
vim.keymap.set("t", "<c-l>", "<c-l>", { nowait = true })
----------Misc
-- vim.keymap.set("n", "<leader>snn", "<leader>snt<cr>", { desc = "Show All Notifications" })
-- vim.keymap.set("t", "<c-tab>", "<cmd>echo 'hello'<cr>")
-- vim.keymap.set("t", "<esc>", [[<cmd>tabprevious<cr>]], { buffer = 0 })
--
----------------------------------------------ufo folding
vim.keymap.set("n", "z;", function()
  local count = vim.v.count1
  vim.api.nvim_feedkeys("zM", "n", false)
  local i = 1
  while i <= count do
    vim.api.nvim_feedkeys("zr", "n", false)
    i = i + 1
  end
end, { desc = "Fold At level [count]" })
vim.keymap.set("n", "zp", function()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    -- vim.fn.CocActionAsync("definitionHover") -- coc.nvim
    vim.lsp.buf.hover()
  end
end, { desc = "Peek inside fold" })
------------open with rider -----
vim.keymap.set("n", "<leader>tr", function()
  local line = vim.fn.line(".")
  local col = vim.fn.virtcol(".")
  vim.cmd("!rider --line " .. line .. " --column " .. col .. " %")
end, { silent = true, desc = "Open With Rider" })
