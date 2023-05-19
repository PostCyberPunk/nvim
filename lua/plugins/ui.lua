return {
  {
    "caenrique/nvim-maximize-window-toggle",
    keys = { { "<leader>wm", "<cmd>ToggleOnly<cr>", desc = "Max/Min Window" } },
  },
  {
    "goolord/alpha-nvim",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local button = dashboard.button("p", " " .. " Projects", ":Telescope projects <CR>")
      button.opts.hl = "AlphaButtons"
      table.insert(dashboard.section.buttons.val, 4, button)
    end,
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
}
