local utils = require("utils")
return {
  -----------Telescope
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   keys = {
  --     { "<leader>sR", false },
  --     { "<leader>gc", false },
  --     { "<leader>gs", false },
  --     { "<leader>gfc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
  --     { "<leader>gfs", "<cmd>Telescope git_status<CR>", desc = "status" },
  --     {
  --       "<leader>fP",
  --       function()
  --         require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
  --       end,
  --       desc = "Find Plugin File",
  --     },
  --     {
  --       "<leader>fN",
  --       function()
  --         require("telescope.builtin").live_grep({ cwd = "~/Tool/Nerd/lib" })
  --       end,
  --       desc = "Find Nerd Fonts",
  --     },
  --   },
  --   opts = function(_, opts)
  --     -- opts.defaults.vimgrep_arguments = {
  --     --   "rg",
  --     --   "--hidden",
  --     --   "--no-heading",
  --     --   "--with-filename",
  --     --   "--line-number",
  --     --   "--column",
  --     --   "--smart-case",
  --     --   "--ignore-file gitignore",
  --     --   ".gitignore",
  --     -- }
  --     opts.defaults.find_command = { "rg", "--files", "--ignore-file", ".gitignore" }
  --   end,
  -- },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal name=ht<cr>", desc = "Toggleterm Horizontal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical name=vt<cr>", desc = "Toggleterm Horizontal" },
      { "<leader>tt", "<cmd>ToggleTerm direction=float name=ft<cr>", desc = "Toggleterm Floating" },
      { "<leader>tcc", "<cmd>ToggleTermSendCurrentLine<cr>", desc = "Term exec Current Line" },
      {
        "<leader>tcy",
        function()
          require("toggleterm").exec(vim.fn.getreg("+"))
        end,
        desc = "Term exec clipboard",
      },
      {
        "<leader>tcr",
        function()
          require("toggleterm").exec("cargo run")
        end,
        desc = "Term - cargo run",
      },
      {
        "<leader>tcc",
        function()
          if vim.g.term_run then
            require("toggleterm").exec(vim.g.term_run)
          else
            utils.ask_term_run()
          end
        end,
        desc = "Term - Run input",
      },
      {
        "<leader>tcC",
        function()
          utils.ask_term_run()
        end,
        desc = "Term - Set input",
      },
      {
        "<leader>tc<cr>",
        "<cmd>ToggleTermSendVisualSelection<cr>",
        mode = { "x" },
        desc = "Term exec Current Selection",
      },
      { "<leader>tr", ":Translate<cr>", mode = "x", desc = "Translate" },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 10
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        else
          return 20
        end
      end,
      on_create = function()
        vim.opt.foldcolumn = "0"
        vim.opt.signcolumn = "no"
      end,
      -- shell="fish",
      open_mapping = [[<F7>]],
      shading_factor = 2,
      direction = "horizontal",
      float_opts = {
        border = "curved",
        highlights = { border = "Normal", background = "Normal" },
      },
    },
  },
}
