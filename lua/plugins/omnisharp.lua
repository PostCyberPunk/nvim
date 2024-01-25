return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = {
          handlers = {
            ["textDocument/definition"] = function(...)
              return require("omnisharp_extended").handler(...)
            end,
          },
          keys = {
            {
              "gd",
              function()
                require("omnisharp_extended").telescope_lsp_definitions()
              end,
              desc = "Goto Definition",
            },
          },
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
        },
      },
    },
  },
  -------------Misc-------------
  -- {
  --   "williamboman/mason.nvim",
  --   opts = function(_, opts)
  --     opts.ensure_installed = opts.ensure_installed or {}
  --     vim.list_extend(opts.ensure_installed, { "csharpier", "omnisharp" })
  --   end,
  -- },
  { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "c_sharp" })
      end
    end,
  },
  -- {
  --   "stevearc/conform.nvim",
  --   opts = {
  --     formatters_by_ft = {
  --       cs = { "csharpier" },
  --     },
  --     formatters = {
  --       csharpier = {
  --         command = "dotnet-csharpier",
  --         args = { "--write-stdout" },
  --       },
  --     },
  --   },
  -- },
  {
    "VidocqH/lsp-lens.nvim",
    keys = { { "<leader>uul", "<cmd>LspLensToggle<cr>", desc = "Toggle LspLens" } },
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
      opts.wrapper_symbol_kinds = { SymbolKind.Class, SymbolKind.Struct ,SymbolKind.Interface}
      require("lsp-lens").setup(opts)
    end,
  },
}
