if true then
  return {}
end
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline" })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "markdownlint", "marksman" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {},
      },
    },
  },
  {
    "lukas-reineke/headlines.nvim",
    opts = function()
      local opts = {}
      for _, ft in ipairs({ "markdown", "rmd", "org" }) do
        opts[ft] = {
          headline_highlights = {},
          fat_headlines = false,
        }
        for i = 1, 6 do
          local hl = "Headline" .. i
          vim.api.nvim_set_hl(0, hl, { link = "Headline", default = true })
          table.insert(opts[ft].headline_highlights, hl)
        end
      end
      return opts
    end,
    ft = { "markdown", "rmd", "org" },
    config = function(_, opts)
      -- PERF: schedule to prevent headlines slowing down opening a file
      vim.schedule(function()
        require("headlines").setup(opts)
        require("headlines").refresh()
      end)
    end,
  },
  {
    "ellisonleao/glow.nvim",
    config = function(_, opts)
      require("glow").setup(opts)
      vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
        pattern = "*.md",
        callback = function(event)
          vim.keymap.set("n", "<leader>np", "<cmd>Glow<cr>", { desc = "Glow", buffer = event.buf, silent = true })
        end,
      })
    end,
    ft = "markdown",
  },
}
