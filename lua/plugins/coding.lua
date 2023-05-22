return {
  ----manson--------------
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "omnisharp-mono",
        "clang-format",
        "clangd",
        "yaml-language-server",
        "json-lsp",
        "pyright",
        "pylint",
        "prettier",
        -- "eslint-lsp",
        -- "flake8", --python formater
      },
    },
  },
  ------------leap.nvim-
  -- {
  --   "ggandor/leap.nvim",
  --   keys = {
  --     {
  --       "n",
  --       "<leader><leader>s",
  --       function()
  --         local current_window = vim.fn.win_getid()
  --         require("leap").leap({ target_windows = { current_window } })
  --       end,
  --       { desc = "Search Bidirectional" },
  --     },
  --   },
  -- },
  ---- flit.nvim --------------
  {
    "ggandor/flit.nvim",
    opts = { multiline = false },
  },
  --------treesitter -----
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "c_sharp",
        "tsx",
        "typescript",
      })
      opts.incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<leader>v",
          node_incremental = "<leader>v",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      }
    end,
  },
  ----Telescope---
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      -- opts.defaults.vimgrep_arguments = {
      --   "rg",
      --   "--hidden",
      --   "--no-heading",
      --   "--with-filename",
      --   "--line-number",
      --   "--column",
      --   "--smart-case",
      --   "--ignore-file gitignore",
      --   ".gitignore",
      -- }
      opts.defaults.find_command = { "rg", "--files", "--ignore-file", ".gitignore" }
    end,
  },
}
