if require("pcp.extra").imports.unity then
  return {
    {
      dir = "~/Repos/UniVim.nvim",
      ft = "cs",
      keys = {
        { "<leader>UU", "<cmd>UnivimEnterPlayMode<cr>", desc = "Unity Enter Play Mode" },
        { "<leader>UQ", "<cmd>UnivimQutiPlayMode<cr>", desc = "Unity Quit Play Mode" },
        { "<leader>UP", "<cmd>UnivimPausePlayMode<cr>", desc = "Unity Pause Play Mode" },
      },
      config = true,
    },
  }
else
  return {}
end
