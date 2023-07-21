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
  {
    "ggandor/leap.nvim",
    opts = {
      safe_labels = { "s", "z", "f", "n", "u", "t", "x", "q" },
    },
    -- keys = {
    --   {
    --     "n",
    --     "<leader><leader>s",
    --     function()
    --       local current_window = vim.fn.win_getid()
    --       require("leap").leap({ target_windows = { current_window } })
    --     end,
    --     { desc = "Search Bidirectional" },
    --   },
    -- },
  },
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
      table.remove(opts.ensure_installed, 3)
      table.remove(opts.ensure_installed, 16)
      vim.list_extend(opts.ensure_installed, {
        "c_sharp",
        "tsx",
        "typescript",
      })
      opts.incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "E",
          node_incremental = "E",
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
  --------------------spider
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "x" }, desc = "Spider-w" },
      { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "x" }, desc = "Spider-e" },
      { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "x" }, desc = "Spider-b" },
      { "zw", "<cmd>lua require('spider').motion('w')<CR>", mode = "o", desc = "Spider-w" },
      { "ze", "<cmd>lua require('spider').motion('e')<CR>", mode = "o", desc = "Spider-e" },
      { "zb", "<cmd>lua require('spider').motion('b')<CR>", mode = "o", desc = "Spider-b" },
    },
    -- config = true,
  },
  {
    "nvim-orgmode/orgmode",
    config = function()
      require("orgmode").setup_ts_grammar()
      require("orgmode").setup()
    end,
  },
}
