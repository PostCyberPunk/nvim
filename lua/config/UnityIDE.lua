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
  end,
})
