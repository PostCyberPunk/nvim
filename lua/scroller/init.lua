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

require("lazy").setup(require("scroller.rollug"), {
  defaults = { lazy = true, version = "*" },
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
vim.cmd([[colorscheme catppuccin]])
vim.keymap.set("n", "d", "<c-d>", { noremap = true, silent = true })
vim.keymap.set("n", "u", "<c-u>", { noremap = true, silent = true })
vim.keymap.set("n", "q", ":qa!<CR>", { noremap = true, silent = true })
vim.o.number = true
vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
