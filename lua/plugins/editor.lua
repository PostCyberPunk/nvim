local utils = require("utils")
return {
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
