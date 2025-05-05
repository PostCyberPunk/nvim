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
        "<leader>tcY",
        function()
          local cp = vim.fn.getreg("+")
          vim.g.term_run = cp
          require("toggleterm").exec(cp)
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
        "<leader>tcc",
        function()
          local tt = require("toggleterm")
          local selected = require("utils").get_selected_text()
          if selected then
            vim.g.term_run = selected
            tt.exec(selected)
          end
        end,
        mode = { "v" },
        desc = "Term exec Current Selection(set)",
      },
      {
        "<leader>tcl",
        function()
          local cmd = vim.fn.system("history | head -n 1")
          require("toggleterm").exec(cmd)
        end,
        desc = "Term exec last fish command",
      },
      {
        "<leader>tcL",
        function()
          local cmd = vim.fn.system("history | head -n 1")
          require("toggleterm").exec(cmd)
          vim.g.term_run = cmd
        end,
        desc = "Term exec last fish command",
      },
      {
        "<leader>tcj",
        function()
          local current_directory = vim.fn.getcwd()
          local termrun_file = current_directory .. "/.termrun"

          -- Check if the file exists
          local file = io.open(termrun_file, "r")
          if file then
            -- If the file exists, read the first line
            local first_line = file:read("*l")
            file:close()
            require("toggleterm").exec(first_line)
          else
            print(".termrun file not found")
          end
        end,
        desc = "Term exec last fish command",
      },
      {
        "<leader>tc<cr>",
        function()
          local mode = vim.api.nvim_get_mode().mode
          if mode == "n" then
            vim.cmd("'<','>ToggleTermSendVisualSelection")
          else
            if mode == "V" then
              vim.cmd("'<,'>ToggleTermSendVisualLines")
            end
          end
        end,
        mode = { "v" },
        desc = "Term exec Current Selection",
      },
      {
        "<leader>tc<cr>",
        "<cmd>ToggleTermSendCurrentLine<cr>",
        desc = "Term exec Current Line",
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
