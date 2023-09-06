local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local function vscall(cmds)
  vim.cmd(":call VSCodeNotify('" .. cmds .. "')")
end
local function vskcmd(key, cmds, _opts)
  keymap("n", key, ":call VSCodeNotify('" .. cmds .. "')<cr>", _opts)
end
local function vskcmdMode(mode, key, cmds, _opts)
  vim.keymap.set(mode, key, ":call VSCodeNotify('" .. cmds .. "')<cr>", _opts)
end
opts.noremap = false

-- keymap("n", "<Tab>", ":Tabnext<CR>", opts)
-- keymap("n", "<S-Tab>", ":Tabprev<CR>", opts)
-- keymap("n", "<leader><leader>", ':call VSCodeNotify("whichkey.show")<CR>', opts)
-- keymap("", "<Space>", "<Nop>", opts)
---clipboard

keymap("n", "<leader><C-q>", "<C-q>", opts)
vim.keymap.set({ "n", "x" }, "<C-v>", '"+p', opts)
vim.keymap.set({ "n", "x" }, "<leader>pp", '"+p', opts)
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
vskcmd("zm", "editor.foldRecursively", opts)
vskcmd("zo", "editor.unfold", opts)
vskcmd("zr", "editor.unfoldRecursively", opts)
vskcmd("za", "editor.toggleFold", opts)
vskcmdMode({ "n", "x", "o" }, "]z", "editor.gotoNextFold", opts)
vskcmdMode({ "n", "x", "o" }, "[z", "editor.gotoPreviousFold", opts)

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
vskcmd("<leader>wq", "workbench.action.closeActiveEditor", opts)
vskcmd("<leader>bq", "workbench.action.closeActiveEditor", opts)
vskcmd("<leader>bd", "workbench.action.closeActiveEditor", opts)
vskcmd("<leader>wd", "workbench.action.closeActiveEditorGroup", opts)
vskcmd("<leader>wD", "workbench.action.closeOtherEditors", opts)
-- vskcmd("<leader>wx", "workbench.action.moveActiveEditorGroupRight", opts)
vim.keymap.set("n", "<leader>uf", function()
  vscall("workbench.action.closeSidebar")
  vscall("workbench.action.closeAuxiliaryBar")
  vscall("workbench.action.closePanel")
end, opts)
--TODO : swapwindow need refined
-- keymap("n", "H", "gT", opts)
-- keymap("n", "L", "gt", opts)
vskcmd("L", "workbench.action.nextEditorInGroup", opts)
vskcmd("H", "workbench.action.previousEditorInGroup", opts)

vskcmd("<leader>un", "workbench.action.closeMessages", opts)
-------------coding -----------
vskcmd("<leader>cf", "editor.action.formatDocument", opts)
vskcmd("gr", "editor.action.referenceSearch.trigger", opts)
vskcmd("gp", "editor.action.peekDefinition", opts)
vskcmd("gt", "editor.action.peekTypeDefinition", opts)
vskcmd("gT", "editor.action.goToTypeDefinition", opts)
vskcmd("<leader>gs", "git.stageChange", opts)
vskcmd("<leader>co", "breadcrumbs.focusAndSelect", opts)
vskcmdMode({ "n", "x" }, "<leader>ca", "editor.action.quickFix", opts)
vskcmdMode({ "n", "x" }, "<leader>cr", "editor.action.refactor", opts)
vskcmdMode({ "n", "x" }, "<leader>ud", "unity-tools.SearchDocs", opts)
vskcmd("<leader>xx", "workbench.panel.markers.view.focus", opts)
vskcmd("]e", "go-to-next-error.nextInFiles.error", opts)
vskcmd("[e", "go-to-next-error.prevInFiles.error", opts)
vskcmd("]h", "workbench.action.editor.previousChange", opts)
vskcmd("[h", "workbench.action.editor.nextChange", opts)
vskcmd("]b", "editor.debug.action.goToNextBreakpoint", opts)
vskcmd("[b", "editor.debug.action.goToPreviousBreakpoint", opts)
--------------debuging------------------
vskcmd("<leader>db", "editor.debug.action.toggleBreakpoint", opts)
vskcmd("<leader>dw", "editor.debug.action.selectionToWatch", opts)
vskcmd("<leader>dW", "workbench.debug.action.focusWatchView", opts)
vskcmd("<leader>dv", "workbench.debug.action.focusVariablesView", opts)
vskcmd("<leader>ds", "debug.setVariable", opts)
vskcmd("<leader>dB", "editor.debug.action.toggleInlineBreakpoint", opts)
vskcmd("<leader>dC", "editor.debug.action.conditionalBreakpoint", opts)
vskcmd("<leader>dS", "workbench.action.debug.stepIntoTarget", opts)
--Externsion----------------------------------
-- vskcmd("<leader>tr", "command-runner.run',{'command':'rider'})", opts)
vskcmd("<leader>tr", "open-with-rider.open", opts)
vskcmd("<leader>cp", "workbench.action.openChat.copilot", opts)
vskcmd("<leader>RR", "workbench.action.files.revert", opts)
-- vskcmd(
--   "n",
--   "<leader>e",
--   "workbench.action.toggleSidebarVisibility',{'when':'explorerViewletVisible'})",
--   opts
-- )

------------------exchange---------------
vim.keymap.set("n", "gX", require("substitute.exchange").operator, { noremap = true })
vim.keymap.set("n", "gXX", require("substitute.exchange").line, { noremap = true })
vim.keymap.set("x", "gX", require("substitute.exchange").visual, { noremap = true })
-- Use VSCode Comments
keymap("x", "gc", "<Plug>VSCodeCommentary", opts)
keymap("n", "gc", "<Plug>VSCodeCommentary", opts)
keymap("o", "gc", "<Plug>VSCodeCommentary", opts)
keymap("n", "gcc", "<Plug>VSCodeCommentaryLine", opts)
