return {
  --- hl chunk
  {
    -- "shellRaining/hlchunk.nvim",
    "postcyberpunk/hlchunk.nvim",
    branch = "pcp-fix",
    -- dir = "~/Repos/hlchunk.nvim",
    -- enabled = true,
    lazy = vim.g.isnix ~= 1,
    keys = {
      -- { "<leader>uuH", "<cmd>EnableHL<CR>", desc = "EnableHL" },
      -- { "<leader>uuh", "<cmd>DisableHL<CR>", desc = "DisableHL" },
      {
        "<leader>uuh",
        function()
          if vim.g.hlchunk then
            vim.cmd("DisableHL")
            vim.g.hlchunk = false
          else
            vim.cmd("EnableHL")
            vim.g.hlchunk = true
          end
        end,
        desc = "ToggleHLchunk",
      },
    },
    event = { "UIEnter" },
    config = function(_, opts)
      local line_count = 1000
      opts.blank = { choke_at_linecount = line_count }
      opts.chunk = { choke_at_linecount = line_count }
      opts.indent = { choke_at_linecount = line_count }
      opts.blank = { choke_at_linecount = line_count }
      opts.line_num = { choke_at_linecount = line_count }
      require("hlchunk").setup(opts)
    end,
  },
  {
    "hiphish/rainbow-delimiters.nvim", -- Powered by Tree-sitter
    submodules = false,
    lazy = vim.g.isnix ~= 1,
    opts = {
      strategy = {
        [""] = "rainbow-delimiters.strategy.global",
        vim = "rainbow-delimiters.strategy.local",
      },
      query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
      },
      priority = {
        [""] = 110,
        lua = 210,
      },
      highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      },
    },
    main = "rainbow-delimiters.setup", -- Required. Defaults to the repository name if not set.
  },
  {
    "utilyre/barbecue.nvim",
    lazy = vim.g.isnix ~= 1,
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      theme = "catppuccin",
    },
    config = true,
    -- config = function()
    --   require("barbecue").setup({
    --     theme = "catppuccin",
    --   })
    -- end,
  },
}
