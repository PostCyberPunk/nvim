-- bootstrap lazy.nvim, LazyVim and your plugins
-- vim.api.nvim_set_keymap("n", "<ESC>100;5u", "<c-i>", { silent = true, noremap = true })
if vim.g.vscode then
  require("vscode")
elseif vim.g.roller then
  require("scroller")
else
  require("config.lazy")
end
