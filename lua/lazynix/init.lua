require("lazy").setup({
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
    -- { import = "lazyvim.plugins.extras.ui.smear-cursor" },
    { import = "lazyvim.plugins.extras.ui.treesitter-context" },
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.lang.toml" },
    { import = "lazyvim.plugins.extras.lang.rust" },
    -- The following configs are needed for fixing lazyvim on nix
    -- disable mason.nvim, use config.extraPackages
    { import = "plugins" },
    { import = "plugins/unity" },
    { "williamboman/mason-lspconfig.nvim", enabled = false },
    { "williamboman/mason.nvim", enabled = false },
    { "jaybaby/mason-nvim-dap.nvim", enabled = false },
    -- uncomment to import/override with your plugins
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
  defaults = { lazy = true },
  opts = {
    colorscheme = "catppuccin-mocha",
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
  checker = { enabled = true, notify = false }, -- automatically check for plugin updates
})
vim.cmd([[colorscheme catppuccin-mocha]])
require("autosave").enabled = false
