--set nvim_home----------------
if vim.fn.has("unix") == 1 then
  vim.g["nvim_home"] = "~/.config/nvim"
elseif vim.fn.has("win32") == 1 then
  vim.g["nvim_home"] = "~/AppData/Local/nvim"
end
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-------------lazy.vim
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
  spec = "vscplug",
  defaults = { lazy = true, version = "*" },
  install = {},
  -- checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
---------costom cmd  revert file--
vim.api.nvim_create_user_command("Revert", function()
  vim.cmd("call VSCodeNotify('workbench.action.files.revert')")
end, {})
------------------require
vim.cmd("highlight LeapBackdrop guifg=#777777")
vim.cmd("command! Vb execute 'normal! <C-v>'")
require("vscode.vsckey")
require("vscode.vscautocmd")
-- require("vscode.searchindex")
-------------vscode status bar change
vim.cmd([[
  autocmd InsertEnter * :call VSCodeNotify('neovimmodestatus.changeColor', 'insert')
  autocmd ModeChanged *:[n]* :call VSCodeNotify('neovimmodestatus.changeColor', 'normal')
  autocmd ModeChanged *:[vV\x16]* :call VSCodeNotify('neovimmodestatus.changeColor', 'visual')
  autocmd ModeChanged *:[R]* :call VSCodeNotify('neovimmodestatus.changeColor', 'replace')
]])
---opt
local opt = vim.opt
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.scroll = 10
