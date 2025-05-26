-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
--
-- disable lazyvim automatically update;
-- vim.g.lazy_nvim_auto_update = 0

local opt = vim.opt
--------------------
opt.jumpoptions = "stack"
opt.signcolumn = "auto"
opt.clipboard = ""
opt.expandtab = false
-------------folds---------------
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false
vim.g.autoformat = true
vim.g.python3_host_prog = "~/.mlib/pynvim/bin/python3"
-----------setup default term = powershell
if vim.fn.has("win32") == 1 then
  local powershell_options = {
    shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
    shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    shellquote = "",
    shellxquote = "",
  }

  for option, value in pairs(powershell_options) do
    vim.opt[option] = value
  end
end
