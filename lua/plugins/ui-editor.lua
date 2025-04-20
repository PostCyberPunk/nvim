return {
  ---------------------remove indentscope animation-----------
  { "echasnovski/mini.indentscope", enabled = false },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  --- hl chunk
  {
    -- "shellRaining/hlchunk.nvim",
    "postcyberpunk/hlchunk.nvim",
    -- dir = "~/Repos/hlchunk.nvim",
    -- enabled = true,
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
  -- {
  --   "HiPhish/nvim-ts-rainbow2",
  --   config = function()
  --     require("nvim-treesitter.configs").setup({
  --       rainbow = {
  --         enable = true,
  --         -- list of languages you want to disable the plugin for
  --         disable = { "jsx", "cpp" },
  --         -- Which query to use for finding delimiters
  --         query = "rainbow-parens",
  --         -- Highlight the entire buffer all at once
  --         strategy = require("ts-rainbow").strategy.global,
  --       },
  --     })
  --   end,
  -- },
  {
    "utilyre/barbecue.nvim",
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
  -- Colorizer ----------
  {
    "NvChad/nvim-colorizer.lua",
    config = true,
  },
}
