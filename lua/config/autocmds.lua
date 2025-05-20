-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local utils = require("utils")
--function
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

---open all folds fafter open a file---
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
  group = augroup("open_folds"),
  callback = function()
    require("ufo").openAllFolds()
    -- vim.cmd("normal zR")
  end,
})

vim.api.nvim_create_augroup("dashboard_on_empty", { clear = true })
vim.api.nvim_create_autocmd("User", {
  pattern = "BDeletePre *",
  group = "dashboard_on_empty",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local name = vim.api.nvim_buf_get_name(bufnr)

    if name == "" then
      Snacks.dashboard.open()
    end
  end,
})
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function() end,
})
vim.api.nvim_create_user_command("NeoTodo", function()
  vim.cmd([[
    augroup close_other_buffers
      autocmd!
      autocmd BufNew *.norg :BufferLineCloseOthers
      autocmd BufWinEnter *.norg :BufferLineCloseOthers
      autocmd BufAdd *.norg :BufferLineCloseOthers
    augroup END
    ]])
  require("autosave").enabled = true
  -- vim.cmd("ASToggle")
end, { desc = "Auto save when in neorg mode" })

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("user_close_with_q"),
  pattern = {
    "dap-float",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})
vim.api.nvim_create_user_command("Translate", function()
  local selected = utils.get_selected_text()
  local _cmd = "trans -b '" .. selected .. "'|bat --paging=always"
  local opts = { cmd = _cmd, tid = "trans", hidden = true, size = 40, direction = "float" }
  local term = require("toggleterm.terminal").Terminal:new(opts)
  term:toggle()
end, { range = true })
---------custom cmd  revert file--
vim.api.nvim_create_user_command("Revert", function()
  vim.cmd("earlier 1f")
  local buf = vim.api.nvim_buf_get_name(0)
  Snacks.bufdelete.delete({ force = true })
  -- vim.api.nvim_buf_delete(0, { force = true })
  -- require("mini.bufremove").delete(0, true)
  vim.cmd("e " .. buf)
  utils.notify("Revert file:" .. buf)
end, {})
------------UnityIDE--------------
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("unity_ide"),
  pattern = {
    "cs",
  },
  callback = function()
    vim.api.nvim_create_user_command("UnityStart", function()
      vim.cmd("echo serverstart('/tmp/univimIDE')")
      vim.g.autoformat = true
    end, { desc = "Start UnityIDE" })

    vim.api.nvim_create_user_command("HyprFocusMe", function()
      vim.cmd("!hyprctl dispatch focuswindow pid:$KITTY_PID")
      vim.cmd("!~/.config/hypr/scripts/RunCMD.sh close_special")
      vim.cmd([[autocmd BufWritePost *.cs UnivimCompile]])
    end, { desc = "use hyprctl to focus this nvim" })

    vim.keymap.set("n", "<leader>US", "<cmd>UnityStart<cr>", { desc = "Start Unity IDE server" })

    local Keys = require("lazyvim.plugins.lsp.keymaps").get()
    local omni = require("omnisharp_extended")
      -- stylua: ignore
		utils.replace_keys(Keys, {
        { "gd", function() omni.lsp_definitions() end, desc = "Goto Definition", has = "definition" },
        -- { "gr", function() omni.lsp_references() end, nowait = true, desc = "References" },
        -- { "gI", function() omni.lsp_implementations() end, desc = "Goto Implementation" },
        -- { "gy", function() omni.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
        -- { "<leader>ss", function() Snacks.picker.lsp_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Symbols", has = "documentSymbol" },
        -- { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Workspace Symbols", has = "workspace/symbols" },
      })
  end,
})
