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
------------------require
vim.cmd("highlight LeapBackdrop guifg=#777777")
require("vscode.vsckey")
require("vscode.vscautocmd")
-- require("vscode.searchindex")
---opt
local opt = vim.opt
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.scroll = 10
