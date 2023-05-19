if true then
  return {}
end
return {
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>ze", ":NvimTreeFocus<CR>", desc = "Focus NerdTree" },
      { "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle NerdTree" },
    },
    config = function()
      require("nvim-tree").setup({})
    end,
  },
}
