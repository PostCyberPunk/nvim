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
        "<leader>qp",
        function()
          require("persisted").save({ session = vim.g.persisted_loaded_session })
          vim.cmd("%bd")
          require("persisted").stop()
          require("persisted").select()
        end,
        desc = "Switch Session([P]roject)",
      },
    },
  },
}
