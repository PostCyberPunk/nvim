-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
--------------------change LeapBackdrop
vim.cmd("highlight LeapBackdrop guifg=#777777")
---------costom cmd  revert file--
vim.api.nvim_create_user_command("Revert", function()
  vim.cmd("earlier 1f")
end, {})

opt.clipboard = ""
-------------folds---------------
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false
