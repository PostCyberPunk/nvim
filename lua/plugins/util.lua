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
    end,
    keys = {
      {
        "<leader>qp",
        "<cmd>SessionSelect<cr>",
        desc = "Search Sessions",
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
        "<leader>qD",
        function()
          require("persisted").stop()
        end,
        desc = "Don't Save Current Session",
      },
      {
        "<leader>qd",
        function()
          vim.cmd("SessionSave")
          vim.cmd("SessionStop")
          vim.cmd("%bd")
          Snacks.dashboard.open()
          vim.cmd("bd#")
        end,
        desc = "Quit all and open dashboard",
      },
    },
  },
}
