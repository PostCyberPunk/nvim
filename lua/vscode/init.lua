vim.g["nvim_home"] = "~/AppData/Local/nvim"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

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
vim.cmd("highlight LeapBackdrop guifg=#777777")
require("vscode.vsckey")
require("vscode.vscautocmd")

---opt
local opt = vim.opt
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.scroll = 10
