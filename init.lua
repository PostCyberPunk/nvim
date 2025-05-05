if vim.g.vscode then
  require("vscode")
elseif vim.g.roller then
  require("scroller")
else
  require("config.lazy")
end
