return {
  {
    "caenrique/nvim-maximize-window-toggle",
    keys = { { "<leader>wm", "<cmd>ToggleOnly<cr>", desc = "Max/Min Window" } },
  },
  {
    "goolord/alpha-nvim",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local button_rs = dashboard.button("s", " " .. " Restore Session", [[:lua require("persisted").load() <cr>]])
      button_rs.opts.hl = "AlphaButtons"
      button_rs.opts.hl_shortcut = "AlphaShortcut"
      dashboard.section.buttons.val[6] = button_rs
      local button = dashboard.button("p", " " .. " Projects", ":Telescope projects <CR>")
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
      table.insert(dashboard.section.buttons.val, 4, button)
    end,
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        separator_style = "slant",
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            if e == "error" then
              local sym = e == "error" and " " or (e == "warning" and " " or "i")
              s = s .. n .. sym
            end
          end
          return s
        end,
      },
    },
    config = true,
  },
  -- windwo picker
  {
    "s1n7ax/nvim-window-picker",
    keys = {
      {
        "n",
        "<leader>wp",
        function()
          local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
          vim.api.nvim_set_current_win(picked_window_id)
        end,
        { desc = "Pick a window" },
      },
    },
    config = function()
      require("window-picker").setup({
        use_winbar = "smart",
        other_win_hl_color = "#f7667b",
        -- include_current_win = true,
        -- selection_display = function(char)
        --   return ":::" .. char
        -- end,
      })
    end,
  },
  --win sep
  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinNew" },
  },
  --focus---
  {
    "beauwilliams/focus.nvim",
    keys = { { "<leader>wa", "<cmd>FocusToggle<cr>", desc = "Focus Split Nicely" } },
    cmd = { "FocusToggle", "FocusSplitCycle" },
    module = "focus",
    config = function()
      require("focus").setup({
        hybridnumber = true,
        width = 120,
      })
    end,
  },
  ---------------------remove indentscope animation-----------

  {
    "echasnovski/mini.indentscope",
    enabled = false,
    config = function(_, opts)
      -- require("mini.indentscope").gen_animation.none()
      -- require("mini.indentscope").setup(opts)
    end,
  },

  -- add symbols-outline
  {
    "stevearc/aerial.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  --- hl chunk
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    config = function(_, opts)
      require("hlchunk").setup(opts)
    end,
  },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local colors = {
        bg = "#202328",
        fg = "#bbc2cf",
        yellow = "#ECBE7B",
        cyan = "#008080",
        darkblue = "#081633",
        green = "#98be65",
        orange = "#FF8800",
        violet = "#a9a1e1",
        magenta = "#c678dd",
        blue = "#51afef",
        red = "#ec5f67",
      }
      table.insert(opts.sections.lualine_b, 2, {
        "diff",
        symbols = { added = " ", modified = " ", removed = " " },
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.orange },
          removed = { fg = colors.red },
        },
      })
      table.insert(opts.sections.lualine_c, 1, {
        -- Lsp server name .
        function()
          local msg = "No Active Lsp"
          local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = ":",
      })

      opts.sections.lualine_x[5] = { "encoding" }
      opts.sections.lualine_x[6] = { "filesize" }
    end,
  },
}
