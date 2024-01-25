vim.api.nvim_create_user_command("UnityStart", function()
  vim.cmd("echo serverstart('/tmp/univimIDE')")
  vim.g.autoformat = true
end, { desc = "Start UnityIDE" })

vim.api.nvim_create_user_command("HyprFocusMe", function()
  vim.cmd("!hyprctl dispatch focuswindow pid:$KITTY_PID")
  vim.cmd("!~/.config/hypr/scripts/RunCMD.sh close_special")
end, { desc = "use hyprctl to focus this nvim" })
