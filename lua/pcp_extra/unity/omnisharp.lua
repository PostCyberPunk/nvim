return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, _)
      --https://nix-community.github.io/nixvim/plugins/lsp/servers/omnisharp/index.html
      require("lspconfig").omnisharp.setup({
        --FIX: OS specifaction
        cmd = { "dotnet", vim.g.runtime_path .. "/lib/omnisharp-roslyn/OmniSharp.dll" },
        -- cmd = { "OmniSharp" },
        settings = {
          FormattingOptions = {
            EnableEditorConfigSupport = true,
            OrganizeImports = nil,
          },
          RoslynExtensionsOptions = {
            EnableAnalyzersSupport = true,
            EnableImportCompletion = nil,
            AnalyzeOpenDocumentsOnly = true,
          },
          Sdk = {
            IncludePrereleases = true,
          },
        },
      })
    end,
  },
  { "Hoffs/omnisharp-extended-lsp.nvim", lazy = (vim.g.isnix ~= 1) },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "c_sharp" })
      end
    end,
  },
  -------------Misc-------------
  -- {
  --   "williamboman/mason.nvim",
  --   opts = function(_, opts)
  --     opts.ensure_installed = opts.ensure_installed or {}
  --     vim.list_extend(opts.ensure_installed, { "csharpier", "omnisharp" })
  --   end,
  -- },
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
