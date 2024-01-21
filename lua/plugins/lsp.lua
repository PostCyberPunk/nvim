return {
  ---------------manson--------------
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "clang-format",
        "clangd",
        "json-lsp",
        "prettier",
      },
    },
  },
  --------treesitter -----
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      table.remove(opts.ensure_installed, 3)
      table.remove(opts.ensure_installed, 16)
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
}
