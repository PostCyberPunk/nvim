return {
  {
    "folke/persistence.nvim",
    enabled = false,
  },
  {
    "olimorris/persisted.nvim",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
    config = function()
      require("persisted").setup({
        autosave = true,
      })
      require("telescope").load_extension("persisted")
    end,
    keys = {
      {
        "<leader>qp",
        "<cmd>Telescope persisted<cr>",
        desc = "Telescope Sessions",
      },
      {
        "<leader>qs",
        function()
          require("persisted").load()
        end,
        desc = "Restore Session",
      },
      {
        "<leader>ql",
        function()
          require("persisted").load({ last = true })
        end,
        desc = "Restore Last Session",
      },
      {
        "<leader>qd",
        function()
          require("persisted").stop()
        end,
        desc = "Don't Save Current Session",
      },
    },
  },
  {
    "ahmedkhalf/project.nvim",
    opts = {},
    event = "VeryLazy",
    config = function(_, opts)
      require("project_nvim").setup(opts)
      require("telescope").load_extension("projects")
    end,
    keys = {
      { "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
    },
  },
  {
    "beauwilliams/focus.nvim",
    keys = { { "<leader>wl", "<cmd>FocusSplitNicely<cr>", desc = "Focus Split Nicely" } },
    cmd = { "FocusSplitNicely", "FocusSplitCycle" },
    module = "focus",
    config = function()
      require("focus").setup({ hybridnumber = true, width = 120 })
    end,
  },
}
