require("lazy").setup({
  defaults = { lazy = true },
  dev = {
    -- reuse files from pkgs.vimPlugins.*
    path = vim.g.plugin_path,
    patterns = { "." },
    -- fallback to download
    fallback = false,
  },
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- extras
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
    { import = "lazyvim.plugins.extras.editor.dial" },
    { import = "lazyvim.plugins.extras.editor.snacks_picker" },
    { import = "lazyvim.plugins.extras.ui.smear-cursor" },
    { import = "lazyvim.plugins.extras.ui.treesitter-context" },
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
    { import = "lazyvim.plugins.extras.lang.nix" },
    -- The following configs are needed for fixing lazyvim on nix
    -- disable mason.nvim, use config.extraPackages
    { "williamboman/mason-lspconfig.nvim", enabled = false },
    { "williamboman/mason.nvim", enabled = false },
    { "jaybaby/mason-nvim-dap.nvim", enabled = false },
    -- uncomment to import/override with your plugins
    { import = "plugins" },
    -- put this line at the end of spec to clear ensure_installed
    {
      "nvim-treesitter/nvim-treesitter",
      init = function()
        -- Put treesitter path as first entry in rtp
        vim.opt.rtp:prepend(vim.g.treesitter_path)
        vim.g.breakkk = true
      end,
      opts = function(_, opts)
        opts.auto_install = false
        opts.ensure_installed = {}
      end,
    },
  },
  opts = {
    colorscheme = "catppuccin",
  },
  performance = {
    rtp = {
      -- Setup correct config path
      paths = { vim.g.config_path },
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
