if require("pcp.extra").imports.unity then
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
                  Snacks.picker.lsp_definitions()
                end,
                desc = "Goto Definition",
              },
            },
            enable_roslyn_analyzers = true,
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
  }
else
  return {}
end
