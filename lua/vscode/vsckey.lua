local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local function vskcmd(key, cmds, _opts)
  keymap("n", key, ":call VSCodeNotify('" .. cmds .. "')<cr>", _opts)
end
opts.noremap = false

-- keymap("n", "<Tab>", ":Tabnext<CR>", opts)
-- keymap("n", "<S-Tab>", ":Tabprev<CR>", opts)
-- keymap("n", "<leader><leader>", ':call VSCodeNotify("whichkey.show")<CR>', opts)
-- keymap("", "<Space>", "<Nop>", opts)
---clipboard

keymap("n", "<leader><C-v>", '"+p', opts)
keymap("x", "<C-c>", '"+y', opts)
keymap("x", "<leader>yy", '"+y', opts)
keymap("n", "<leader><c-a>", "gg<s-v>G", opts)
-- keymap("i", "<tab>", ":call VSCodeNotify('tabout')<cr>", { noremap = true, silent = true })
-------------Foldings--------------
-----change the move cursor
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
--folding--

vskcmd("zM", "editor.foldAll", opts)
vskcmd("zR", "editor.unfoldAll", opts)
vskcmd("zc", "editor.fold", opts)
vskcmd("zC", "editor.foldRecursively", opts)
vskcmd("zo", "editor.unfold", opts)
vskcmd("zO", "editor.unfoldRecursively", opts)
vskcmd("za", "editor.toggleFold", opts)
vskcmd("]z", "editor.gotoNextFold", opts)
vskcmd("[z", "editor.gotoPreviousFold", opts)

-------------find and serach -----------
vskcmd("<leader>:", "workbench.action.showCommands", opts)
vskcmd("<leader>/", "workbench.action.findInFiles", opts)
vskcmd("<leader>ff", "workbench.action.quickOpen", opts)
vskcmd("<leader>fb", "workbench.action.showAllEditors", opts)
vskcmd("<leader>ss", "workbench.action.gotoSymbol", opts)
vskcmd("<leader>sS", "workbench.action.showAllSymbols", opts)
----------------window operetions -------------
-- vskcmd("n", "<leader>e", "workbench.view.explorer',{'when':'!explorerViewletVisible'})", opts)
vskcmd("<leader>e", "workbench.explorer.fileView.focus',{'when':'!explorerViewletVisible'})", opts)
vskcmd("<leader>wa", "workbench.action.toggleEditorWidths", opts)
vskcmd("<leader>ww", "workbench.action.focusNextGroup", opts)
vskcmd("<leader>bq", "workbench.action.closeActiveEditor", opts)
vskcmd("<leader>bd", "workbench.action.closeActiveEditor", opts)
vskcmd("<leader>wd", "workbench.action.closeActiveEditorGroup", opts)
vskcmd("<leader>wx", "workbench.action.moveActiveEditorGroupRight", opts)
--TODO : swapwindow need refined
-- keymap("n", "H", "gT", opts)
-- keymap("n", "L", "gt", opts)
vskcmd("L", "workbench.action.nextEditorInGroup", opts)
vskcmd("H", "workbench.action.previousEditorInGroup", opts)
-------------coding -----------
vskcmd("<leader>cf", "editor.action.formatDocument", opts)
vskcmd("gr", "editor.action.referenceSearch.trigger", opts)
vskcmd("gp", "editor.action.peekDeclaration", opts)
vskcmd("gt", "editor.action.peekTypeDefinition", opts)
vskcmd("gT", "editor.action.goToTypeDefinition", opts)
vskcmd("<leader>co", "breadcrumbs.focusAndSelect", opts)
vskcmd("<leader>ca", "editor.action.quickFix", opts)
vskcmd("<leader>xx", "workbench.panel.markers.view.focus", opts)
vskcmd("]e", "go-to-next-error.nextInFiles.error", opts)
-- vskcmd("<leader>tr", "command-runner.run',{'command':'rider'})", opts)
vskcmd("<leader>tr", "openwithrider.open", opts)
-- vskcmd(
--   "n",
--   "<leader>e",
--   "workbench.action.toggleSidebarVisibility',{'when':'explorerViewletVisible'})",
--   opts
-- )

-- Use VSCode Comments
keymap("x", "gc", "<Plug>VSCodeCommentary", opts)
keymap("n", "gc", "<Plug>VSCodeCommentary", opts)
keymap("o", "gc", "<Plug>VSCodeCommentary", opts)
keymap("n", "gcc", "<Plug>VSCodeCommentaryLine", opts)
