return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      keys[1] = { "<leader>cL", "<cmd>LspInfo<cr>", desc = "Lsp Info" }
      keys[#keys + 1] = { "gr", false }
      keys[#keys + 1] = { "gi", false }
      keys[#keys + 1] = { "gd", false }
      keys[#keys + 1] = { "gY", false }
      -- keys[12][1] = "<leader>cR"
    end,
  },
  {
    "VidocqH/lsp-lens.nvim",
    keys = { { "<leader>cl", "<cmd>LspLensToggle<cr>", desc = "Toggle LspLens" } },
    opts = {
      sections = {
        enable = false,
        definition = false,
        references = function(count)
          return "Ref: " .. count
        end,
        -- implements = false,
        implements = function(count)
          return "Imp: " .. count
        end,
        git_authors = false,
        -- git_authors = function(latest_author, count)
        --   return " " .. latest_author .. (count - 1 == 0 and "" or (" + " .. count - 1))
        -- end,
      },
    },
    config = function(_, opts)
      local SymbolKind = vim.lsp.protocol.SymbolKind
      opts.target_symbol_kinds =
        { SymbolKind.Function, SymbolKind.Method, SymbolKind.Interface, SymbolKind.Field, SymbolKind.Property }
      opts.wrapper_symbol_kinds = { SymbolKind.Class, SymbolKind.Struct, SymbolKind.Interface }
      require("lsp-lens").setup(opts)
    end,
  },
  {
    "dnlhc/glance.nvim",
    keys = {
      { "gr", "<cmd>Glance references<cr>", desc = "Glance Refercence" },
      { "gi", "<cmd>Glance implementations<cr>", desc = "Glance Refercence" },
      { "gd", "<cmd>Glance definitions<cr>", desc = "Glance Definition" },
      { "gY", "<cmd>Glance type_definitions<cr>", desc = "Glance Definition" },
    },
    config = true,
  },
  {
    "stevearc/aerial.nvim",
    keys = {
      {
        "<leader>co",
        function()
          require("aerial").toggle()
        end,
        desc = "Code Outline(Aerial)",
      },
    },
    opts = {
      buftype_exclude = {
        "nofile",
        "terminal",
      },
      attach_mode = "global",
      use_treesitter = true,
      backends = { "lsp", "treesitter", "markdown", "man" },
      layout = { min_width = 28 },
      show_guides = true,
      filter_kind = false,
      guides = {
        mid_item = "├ ",
        last_item = "└ ",
        nested_top = "│ ",
        whitespace = "  ",
      },
      -- manage_folds = true,
      -- link_folds_to_tree = true,
      -- link_tree_to_folds = false,
    },
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
