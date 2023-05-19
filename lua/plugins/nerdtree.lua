if true then
  return {}
end
return {
  {
    "preservim/nerdtree",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>ze", ":NERDTreeFocus<CR>", desc = "Focus NerdTree" },
      { "<leader>e", ":NERDTreeToggle<CR>", desc = "Toggle NerdTree" },
    },
  },
}
