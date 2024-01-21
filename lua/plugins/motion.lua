return {
  ------------Flash
  {
    "folke/flash.nvim",
    opts = function(_, opts)
      opts.modes = {
        search = { enabled = false },
        -- char = { jump_labels = true }
      }
      -- opts.char.jump_labels= true
    end,
  },
  --------------------spider
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "x" }, desc = "Spider-w" },
      { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "x" }, desc = "Spider-e" },
      { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "x" }, desc = "Spider-b" },
      { "zw", "<cmd>lua require('spider').motion('w')<CR>", mode = "o", desc = "Spider-w" },
      { "ze", "<cmd>lua require('spider').motion('e')<CR>", mode = "o", desc = "Spider-e" },
      { "zb", "<cmd>lua require('spider').motion('b')<CR>", mode = "o", desc = "Spider-b" },
    },
    -- config = true,
  },
  -----------Telescope
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>sR", false },
      { "<leader>gc", false },
      { "<leader>gs", false },
      { "<leader>gfc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>gfs", "<cmd>Telescope git_status<CR>", desc = "status" },
      {
        "<leader>fP",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
      {
        "<leader>fN",
        function()
          require("telescope.builtin").live_grep({ cwd = "/home/buzz/Tools/nerd/lib" })
        end,
        desc = "Find Nerd Fonts",
      },
    },
    opts = function(_, opts)
      -- opts.defaults.vimgrep_arguments = {
      --   "rg",
      --   "--hidden",
      --   "--no-heading",
      --   "--with-filename",
      --   "--line-number",
      --   "--column",
      --   "--smart-case",
      --   "--ignore-file gitignore",
      --   ".gitignore",
      -- }
      opts.defaults.find_command = { "rg", "--files", "--ignore-file", ".gitignore" }
    end,
  },
}
