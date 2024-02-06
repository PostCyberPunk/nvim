-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

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

vim.api.nvim_create_augroup("alpha_on_empty", { clear = true })
vim.api.nvim_create_autocmd("User", {
  pattern = "BDeletePre *",
  group = "alpha_on_empty",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local name = vim.api.nvim_buf_get_name(bufnr)

    if name == "" then
      vim.cmd([[:Alpha | bd#]])
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
  vim.cmd("ASToggle")
end, { desc = "auto close other buffer" })

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
