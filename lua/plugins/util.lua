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
  -- #34afff
  -- Colorizer ----------
  {
    "NvChad/nvim-colorizer.lua",
    config = true,
  },
  ---- flit.nvim --------------
  {
    "ggandor/flit.nvim",
    opts = { multiline = false },
  },
  --------treesitter -----
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "c_sharp",
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },
  ----Telescope---
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--hidden",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--ignore-file",
          ".gitignore",
        },
      },
    },
  },
}
