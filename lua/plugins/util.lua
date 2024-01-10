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
          vim.cmd("Alpha")
          vim.cmd("bd#")
        end,
        desc = "Quit all and open alpha",
      },
    },
  },
  -- project_nvim --------------
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
  -----------welcome alpha-nvim
  {
    "goolord/alpha-nvim",
    dependencies = { "olimorris/persisted.nvim" },
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
███▄▄█▓▓█████████████████████▓▓▓██▓▄▄███
███▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█▓█
███ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄ █▓█
█▓█ ██▀▄ ▄▀██ ███▄▀▀▀▄▓▓██ ██▀▄ ▄▀▓▓ █▓█
███ █▌■   ■▐█ ██▓▓▌ ▐█████ █▌■   ■▐█ █▓█
█▓█ ▓▓▄▀ ▀▄██ █▓▓▀▄▄▄▀█▓▓█ ██▄▀ ▀▄██ █▓█
█▓█ ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀ ███
█▓█             NEOVIM               █▓█
█▓█       Powered by Lazy.Nvim       ███
█████▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█████
█▓▓█▌ ▐█▀▀████████████████████▀▀█▌ ▐█▓▓█
████  ██▄▄████████████████▓▓██▄▄██  ████

   Spleen Artpack #03 ■ November 2011

 ▄█ ▄█  ▓▄   ▐█ ▓▌  █████  ▄█▓▓▄  █▄ █▄
▀▓▓▀██  ██▀  ▐█ █▌  █▓▓██  █████  ██▀▓▓▀
  ▀  ▀  ▀     ▀ ▀   ▀▀▀▀▀   ▀▀▀   ▀  ▀
]]
      dashboard.section.header.val = vim.split(logo, "\n")
      ----------button
      local button = dashboard.button("p", " " .. " Projects", ":Telescope persisted<CR>")
      local button_rs = dashboard.button("s", " " .. " Restore Session", [[:lua require("persisted").load() <cr>]])
      local button_ls = dashboard.button("L", " " .. " Restore Last Session", ":SessionLoadLast<cr>")
      button_ls.opts.hl = "AlphaButtons"
      button_ls.opts.hl_shortcut = "AlphaShortcut"
      button_rs.opts.hl = "AlphaButtons"
      button_rs.opts.hl_shortcut = "AlphaShortcut"
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
      dashboard.section.buttons.val[6] = button_rs
      table.insert(dashboard.section.buttons.val, 6, button)
      table.insert(dashboard.section.buttons.val, 8, button_ls)
    end,
  },
}
