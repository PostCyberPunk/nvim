---@class utils
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
    opts = { cmd = opts, tid = opts, hidden = true, direction = "float" }
  elseif type(opts) == "table" then
    opts = { cmd = opts.cmd, tid = opts.tid, hidden = true, direction = "float" }
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
function M.ask_term_run()
  local input = vim.fn.input("Term arg: ")
  if input ~= "" then
    vim.g.term_run = input
    require("toggleterm").exec(input)
  end
end
-----------------------notify-
function M.notify(msg, type, opts)
  vim.schedule(function()
    vim.notify(msg, type, M.extend_tbl({ title = "NeoVim" }, opts))
  end)
end
------------------------- Toggle autopairs
function M.toggle_autopairs()
  if vim.g.autopairs_disable then
    require("nvim-autopairs").enable()
    vim.g.autopairs_disable = false
  else
    vim.g.autopairs_disable = true
    require("nvim-autopairs").disable()
  end
  M.notify(string.format("autopairs %s", bool2str(not vim.g.autopairs_disable)))
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
function M.get_selected_text()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  if next(lines) == nil then
    return nil
  end
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return table.concat(lines, "\n")
end
---------------------------------------------------------------
function M.replace_keys(Keys, new_mappings)
  local key_index = {}
  -- Build an index for fast lookup
  for i, item in ipairs(Keys) do
    key_index[item[1]] = i
  end
  -- Replace or insert
  for _, mapping in ipairs(new_mappings) do
    local key = mapping[1]
    if key_index[key] then
      Keys[key_index[key]] = mapping
    else
      table.insert(Keys, mapping)
    end
  end
  return Keys
end
---------------------------------------------------------------
function M.getImports()
  local _arg = vim.g.pcp_extra
  if _arg == nil then
    _arg = vim.fn.getenv("PCP_NVIM_EXTRA")
  end
  if _arg == nil or _arg == "" then
    return {}
  end
  return vim.tbl_map(function(x)
    return { import = "pcp_extra." .. x }
  end, vim.split(_arg, ","))
end
---------------------------------------------------------------
function M.print_table(tbl, indent)
  indent = indent or 0
  local prefix = string.rep("  ", indent)
  for k, v in pairs(tbl) do
    if type(v) == "table" then
      print(prefix .. tostring(k) .. " = {")
      M.print_table(v, indent + 1)
      print(prefix .. "}")
    else
      print(prefix .. tostring(k) .. " = " .. tostring(v))
    end
  end
end
---------------------------------------------------------------
---@class utils.shell_cmd.opts
---@field show_stdout boolean? Show output after command (default: false)
---@field pre_msg string? Message before execution
---@field post_msg string? Message after execution
---@field on_success fun(output:string)? Callback when command succeeds
---@param opts utils.shell_cmd.opts Options table
function M.shell_cmd(cmd, opts)
  -- opts:
  --   cmd: (string) Shell command to execute
  --   show_stdout: (boolean, default true) Whether to notify with stdout after execution
  --   pre_msg: (string|nil) Notify message before command execution (optional)
  --   post_msg: (string|nil) Notify message after command execution (optional, shown only on success)

  opts = opts or {}
  local show_stdout = opts.show_stdout
  if show_stdout == nil then
    show_stdout = false
  end
  local pre_msg = opts.pre_msg
  local post_msg = opts.post_msg
  local on_success = opts.on_success

  if not cmd or type(cmd) ~= "string" then
    vim.notify("notify_shell_command: cmd is required and must be a string", vim.log.levels.ERROR)
    return
  end

  if pre_msg then
    vim.notify(pre_msg, vim.log.levels.INFO)
  else
    vim.notify("About to execute: " .. cmd, vim.log.levels.INFO)
  end

  local handle
  local stdout = {}

  ---@diagnostic disable: undefined-field
  handle = vim.loop.spawn("sh", {
    args = { "-c", cmd },
    stdio = { nil, vim.loop.new_pipe(false), vim.loop.new_pipe(false) },
  }, function(code, _)
    handle:close()
    local output = table.concat(stdout)
    vim.schedule(function()
      if show_stdout then
        vim.notify("Command finished. Output:\n" .. output, vim.log.levels.INFO)
      end
      if code == 0 then
        if post_msg then
          vim.notify(post_msg, vim.log.levels.INFO)
        else
          vim.notify("Command succeeded", vim.log.levels.INFO)
        end
        if on_success then
          on_success(output)
        end
      else
        vim.notify("Command failed with exit code: " .. code, vim.log.levels.ERROR)
      end
    end)
  end)
end

---------------------------------------------------------------
return M
---------------------------------------------------------------
