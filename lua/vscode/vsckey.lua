local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local function vskcmd(mode, key, cmds, _opts)
  keymap(mode, key, ":call " .. cmds .. "<cr>", _opts)
end
opts.noremap = false

keymap("n", "<Tab>", ":Tabnext<CR>", opts)
keymap("n", "<S-Tab>", ":Tabprev<CR>", opts)
-- keymap("n", "<leader><leader>", ':call VSCodeNotify("whichkey.show")<CR>', opts)
-- keymap("", "<Space>", "<Nop>", opts)
---clipboard

keymap("n", "<leader><C-v>", '"+p', opts)
keymap("v", "<leader>gc", '"+y', opts)
-------------Foldings--------------
--change the move cursor
local function moveCursor(direction)
  if vim.fn.reg_recording() == "" and vim.fn.reg_executing() == "" then
    return ("g" .. direction)
  else
    return direction
  end
end

vim.keymap.set("n", "k", function()
  return moveCursor("k")
end, { expr = true, remap = true })
vim.keymap.set("n", "j", function()
  return moveCursor("j")
end, { expr = true, remap = true })

vskcmd("n", "zM", "VSCodeNotify('editor.foldAll')", opts)
vskcmd("n", "zR", "SCodeNotify('editor.unfoldAll')", opts)
vskcmd("n", "zc", "VSCodeNotify('editor.fold')", opts)
vskcmd("n", "zC", "VSCodeNotify('editor.foldRecursively')", opts)
vskcmd("n", "zo", "VSCodeNotify('editor.unfold')", opts)
vskcmd("n", "zO", "VSCodeNotify('editor.unfoldRecursively')", opts)
vskcmd("n", "za", "VSCodeNotify('editor.toggleFold')", opts)

--
vskcmd("n", "<leader>p", "VSCodeNotify('workbench.action.showCommands')", opts)
vskcmd("n", "<leader>/", "VSCodeNotify('workbench.action.findInFiles')", opts)
vskcmd("n", "<leader>ff", "VSCodeNotify('workbench.action.quickOpen')", opts)
-- vskcmd("n", "<leader>fb", "VSCodeNotify('workbench.action.showAllEditors')", opts)
-- vskcmd("n", "<leader>ss", "VSCodeNotify('workbench.action.gotoSymbol')", opts)
vskcmd("n", "<leader>sS", "VSCodeNotify('workbench.action.showAllSymbols')", opts)
----------------window operetions -------------
-- vskcmd("n", "<leader>e", "VSCodeNotify('workbench.view.explorer',{'when':'!explorerViewletVisible'})", opts)
vskcmd("n", "<leader>e", "VSCodeNotify('workbench.explorer.fileView.focus',{'when':'!explorerViewletVisible'})", opts)
vskcmd("n", "<leader>wl", "VSCodeNotify('workbench.action.toggleEditorWidths')", opts)
vskcmd("n", "<leader>ww", "VSCodeNotify('workbench.action.focusNextGroup')", opts)
vskcmd("n", "<leader>w;", "VSCodeNotify('workbench.action.toggleAuxiliaryBar')", opts)
keymap("n", "H", "gT", opts)
keymap("n", "L", "gt", opts)
-- vskcmd(
--   "n",
--   "<leader>e",
--   "VSCodeNotify('workbench.action.toggleSidebarVisibility',{'when':'explorerViewletVisible'})",
--   opts
-- )

-- Use VSCode Comments
keymap("x", "gc", "<Plug>VSCodeCommentary", opts)
keymap("n", "gc", "<Plug>VSCodeCommentary", opts)
keymap("o", "gc", "<Plug>VSCodeCommentary", opts)
keymap("n", "gcc", "<Plug>VSCodeCommentaryLine", opts)
