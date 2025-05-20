if vim.g.vscode then
  require("vscode")
elseif vim.g.roller then
  require("scroller")
elseif vim.g.isnix == 1 then
  require("lazynix")
else
  require("config.lazy")
end
