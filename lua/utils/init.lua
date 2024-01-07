local M = {}

local function bool2str(bool)
  return bool and "on" or "off"
end
function M.extend_tbl(default, opts)
  opts = opts or {}
  return default and vim.tbl_deep_extend("force", default, opts) or opts
end
----------------------------toggle terms
local terms = {}
function M.toggle_term_cmd(opts)
  -- if a command string is provided, create a basic table for Terminal:new() options
  if type(opts) == "string" then
    opts = { cmd = opts, hidden = true }
  end
  local num = vim.v.count > 0 and vim.v.count or 1
  -- if terminal doesn't exist yet, create it
  if not terms[opts.cmd] then
    terms[opts.cmd] = {}
  end
  if not terms[opts.cmd][num] then
    if not opts.count then
      opts.count = vim.tbl_count(terms) * 100 + num
    end
    if not opts.on_exit then
      opts.on_exit = function()
        terms[opts.cmd][num] = nil
      end
    end
    terms[opts.cmd][num] = require("toggleterm.terminal").Terminal:new(opts)
  end
  -- toggle the terminal
  terms[opts.cmd][num]:toggle()
end

-----------------------notify-
function M.notify(msg, type, opts)
  vim.schedule(function()
    vim.notify(msg, type, M.extend_tbl({ title = "NeoVim" }, opts))
  end)
end
------------------------- Toggle autopairs
function M.toggle_autopairs()
  if vim.g.minipairs_disable then
    vim.g.minipairs_disable = false
  else
    vim.g.minipairs_disable = true
  end
  M.notify(string.format("autopairs %s", bool2str(not vim.g.minipairs_disable)))
end
-- Toggle syntax highlighting and treesitter
function M.toggle_syntax()
  local ts_avail, parsers = pcall(require, "nvim-treesitter.parsers")
  if vim.g.syntax_on then -- global var for on//off
    if ts_avail and parsers.has_parser() then
      vim.cmd.TSBufDisable("highlight")
    end
    vim.cmd.syntax("off") -- set vim.g.syntax_on = false
  else
    if ts_avail and parsers.has_parser() then
      vim.cmd.TSBufEnable("highlight")
    end
    vim.cmd.syntax("on") -- set vim.g.syntax_on = true
  end
  M.notify(string.format("syntax %s", bool2str(vim.g.syntax_on)))
end
--- Toggle laststatus=3|2|0
function M.toggle_statusline()
  local laststatus = vim.opt.laststatus:get()
  local status
  if laststatus == 0 then
    vim.opt.laststatus = 2
    status = "local"
  elseif laststatus == 2 then
    vim.opt.laststatus = 3
    status = "global"
  elseif laststatus == 3 then
    vim.opt.laststatus = 0
    status = "off"
  end
  M.notify(string.format("statusline %s", status))
end

--- Toggle signcolumn="auto"|"no"
function M.toggle_signcolumn()
  if vim.wo.signcolumn == "no" then
    vim.wo.signcolumn = "yes"
  elseif vim.wo.signcolumn == "yes" then
    vim.wo.signcolumn = "auto"
  else
    vim.wo.signcolumn = "no"
  end
  M.notify(string.format("signcolumn=%s", vim.wo.signcolumn))
end
---------------------------------------------------------------
return M
---------------------------------------------------------------
