if require("pcp.extra").imports.unity then
  return {
    {
      dir = "~/Repos/UniVim.nvim",
      ft = "cs",
      keys = {
        { "<leader>UU", "<cmd>UnivimQutiPlayMode<cr>", desc = "Unity enter play Mode" },
        { "<leader>UQ", "<cmd>UnivimQutiPlayMode<cr>", desc = "Unity quit play Mode" },
        { "<leader>UP", "<cmd>UnivimPausePlayMode<cr>", desc = "Unity quit play Mode" },
      },
      config = true,
    },
    {
      "folke/which-key.nvim",
      optional = true,
      opts = {
        defaults = {
          ["<leader>U"] = { name = " Unity" },
        },
      },
    },
  }
else
  return {}
end
