local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

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
      vim.list_extend(Keys, {
        { "gd", function() omni.lsp_definitions() end, desc = "Goto Definition", has = "definition" },
        { "gr", function() omni.lsp_references() end, nowait = true, desc = "References" },
        { "gI", function() omni.lsp_implementations() end, desc = "Goto Implementation" },
        { "gy", function() omni.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
        -- { "<leader>ss", function() Snacks.picker.lsp_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Symbols", has = "documentSymbol" },
        -- { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "LSP Workspace Symbols", has = "workspace/symbols" },
      })
  end,
})
