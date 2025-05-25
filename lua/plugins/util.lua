return {
  {
    "folke/persistence.nvim",
    keys = {
      {
        "<leader>qp",
        function()
          Snacks.picker.projects()
        end,
      },
      {
        "<leader>qd",
        function()
          require("persistence").save()
          require("persistence").stop()
          vim.cmd("%bd")
          Snacks.dashboard.open()
        end,
        desc = "Quit all and open dashboard",
      },
    },
  },
}
