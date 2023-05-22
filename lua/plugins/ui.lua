return {
  {
    "caenrique/nvim-maximize-window-toggle",
    keys = { { "<leader>wm", "<cmd>ToggleOnly<cr>", desc = "Max/Min Window" } },
  },
  {
    "goolord/alpha-nvim",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local button_rs = dashboard.button("s", " " .. " Restore Session", [[:lua require("persisted").load() <cr>]])
      button_rs.opts.hl = "AlphaButtons"
      button_rs.opts.hl_shortcut = "AlphaShortcut"
      dashboard.section.buttons.val[6] = button_rs
      local button = dashboard.button("p", " " .. " Projects", ":Telescope projects <CR>")
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
      table.insert(dashboard.section.buttons.val, 4, button)
    end,
  },
  -- {
  --   "akinsho/bufferline.nvim",
  --   opts = {
  --     options = {
  --       separator_style = { "thin", "thick" },
  --     },
  --   },
  -- },
  -- ---------------tokyonight-----
  {
    "folke/tokyonight.nvim",
    require("tokyonight").setup({
      -- other configs
      -- colors
      dim_inactive = true,
      on_colors = function(colors)
        colors.border = "#565f89"
        colors.bg_visual = "#2d8fb6"
      end,
      -- colors
    }),
    opts = { styles = "moon" },
  },
  -- windwo picker
  {
    "s1n7ax/nvim-window-picker",
    config = function()
      require("window-picker").setup({
        use_winbar = "smart",
        other_win_hl_color = "#f7667b",
        -- include_current_win = true,
        -- selection_display = function(char)
        --   return ":::" .. char
        -- end,
      })
    end,
    -- opts = {
    --   use_winbar = "smart",
    --   include_current_win = true,
    --   selection_display = function(char)
    --     return ":::" .. char
    --   end,
    -- },
  },
  --win sep
  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinNew" },
  },
  --focus---
  {
    "beauwilliams/focus.nvim",
    keys = { { "<leader>wl", "<cmd>FocusToggle<cr>", desc = "Focus Split Nicely" } },
    cmd = { "FocusToggle", "FocusSplitCycle" },
    module = "focus",
    config = function()
      require("focus").setup({
        hybridnumber = true,
        width = 120,
      })
    end,
  },
  ---------------------remove indentscope animation-----------

  {
    "echasnovski/mini.indentscope",
    enabled = false,
    config = function(_, opts)
      -- require("mini.indentscope").gen_animation.none()
      -- require("mini.indentscope").setup(opts)
    end,
  },

  -- add symbols-outline
  {
    "stevearc/aerial.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    config = function(_, opts)
      require("hlchunk").setup(opts)
    end,
  },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
}
