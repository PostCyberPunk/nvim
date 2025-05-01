local mocha = require("catppuccin.palettes").get_palette("mocha")
return {
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<leader>b,", "<cmd>BufferLineMovePrev<cr>", desc = "Move BufferLeft" },
      { "<leader>b.", "<cmd>BufferLineMoveNext<cr>", desc = "Move BufferRight" },
      { "<leader>bs", "<cmd>BufferLinePick<cr>", desc = "Select Buffer Visually" },
      { "<leader>bn", "<cmd>enew<cr>", desc = "new Buffer" },
    },
    opts = {
      highlights = {
        fill = { bg = mocha.mantle },
        separator = { fg = mocha.overlay0, bold = true },

        separator_selected = { fg = mocha.mauve, bg = mocha.red, sp = mocha.mauve, underline = true },
        indicator_selected = { bg = mocha.surface0, sp = mocha.mauve, underline = true },
        buffer_selected = { bg = mocha.surface0, sp = mocha.mauve, underline = true, italic = false },
        close_button_selected = { bg = mocha.surface0, sp = mocha.mauve, underline = true },

        hint_selected = { bg = mocha.surface0, sp = mocha.mauve, underline = true },
        hint_diagnostic_selected = { bg = mocha.surface0, sp = mocha.mauve, underline = true },
        info_selected = { bg = mocha.surface0, sp = mocha.mauve, underline = true },
        info_diagnostic_selected = { bg = mocha.surface0, sp = mocha.mauve, underline = true },
        warning_selected = { bg = mocha.surface0, sp = mocha.mauve, underline = true },
        warning_diagnostic_selected = { bg = mocha.surface0, sp = mocha.mauve, underline = true },
        error_selected = { bg = mocha.surface0, sp = mocha.mauve, underline = true },
        modified_selected = { bg = mocha.surface0, sp = mocha.mauve, underline = true },
        error_diagnostic_selected = { bg = mocha.surface0, sp = mocha.mauve, underline = true },
        diagnostic_selected = { bg = mocha.surface0, sp = mocha.mauve, underline = true },
        duplicate_selected = { bg = mocha.surface0, sp = mocha.mauve, underline = true },
        -- background = { bg = mocha.base },
        -- close_button = { bg = mocha.base },
        tab_selected = { fg = mocha.peach, sp = mocha.peach, underline = true },
      },
      options = {
        -- separator_style = "padded_slant",
        separator_style = { "|", "|" },
        -- indicator = { icon = "", style = "icon" },
        tab_size = 16,
        indicator = { style = "none" },
        buffer_close_icon = "",
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
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local function format_toggle()
        if vim.g.autoformat then
          return [[♥]]
        else
          return [[]]
        end
      end
      opts.options.component_separators = { left = "|", right = "|" }
      opts.options.section_separators = { left = "", right = "" }
      -- opts.options.section_separators = { left = "", right = "" }
      --    local custom_theme = require("lualine.themes.catppuccin")
      --    custom_theme.normal.a.bg = mocha.lavender
      -- opts.options.theme = custom_theme

      opts.sections.lualine_c[3].color = { fg = mocha.mauve }
      opts.sections.lualine_x[3].color = { bg = mocha.red }
      -- opts.sections.lualine_c[4] = {
      --   function()
      --     return require("noice").api.status.message.get()
      --   end,
      --   cond = require("noice").api.status.message.has,
      -- }
      table.insert(opts.sections.lualine_b, 2, {
        "diff",
        symbols = { added = " ", modified = " ", removed = " " },
        diff_color = {
          added = { fg = mocha.green },
          modified = { fg = mocha.peach },
          removed = { fg = mocha.red },
          -- TODO
          separator = "",
        },
      })
      opts.sections.lualine_x[4] = {
        -- Lsp server name .
        function()
          local msg = "No LSP"
          local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
          local clients = vim.lsp.get_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            --TODO : filetype undefined
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = ":",
        color = { fg = mocha.green },
        separator = "",
      }

      opts.sections.lualine_x[5] = { "filetype", icon_only = true, separator = "", color = { fg = mocha.peach } }
      opts.sections.lualine_x[6] = { "filesize", separator = "", color = { fg = mocha.green } }
      opts.sections.lualine_x[7] = { format_toggle, separator = "", color = { fg = mocha.mauve } }
    end,
  },
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "msg_show",
          any = {
            { find = "Pick window:" },
            { find = "AutoSave" },
          },
        },
        opts = { skip = true },
      })
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "hlchunk",
        },
        opts = { skip = true },
      })
      opts.cmdline = {
        opts = { popupmenu = { backend = "cmp" } }, -- global options for the cmdline. See section on views
      }
      opts.presets = {
        bottom_search = true,
        command_palette = false,
        long_message_to_split = true,
        inc_rename = true,
      }
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = function(_, opts)
      opts.timeout = 1000
      opts.stages = "static"
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {},
      spec = {
        { "<leader><tab>", group = "󰌕Tabs" },
        { "<leader>U", group = " Unity" },
        { "<leader>b", group = "󰓩 Buffers" },
        { "<leader>c", group = " Coding" },
        { "<leader>d", group = " Debugger" },
        { "<leader>f", group = "󰜏 file/find" },
        { "<leader>g", group = "󰊢 Git" },
        { "<leader>m", group = "烙More" },
        { "<leader>n", group = "󰽱Notes" },
        { "<leader>q", group = "󱂬 Session" },
        { "<leader>s", group = "󰍉 Search" },
        { "<leader>t", group = " Terminal" },
        { "<leader>u", group = " UI" },
        { "<leader>uu", group = "烙More" },
        { "<leader>w", group = "󰨡 Windows" },
        { "<leader>x", group = " Diagnosing" },
      },
    },
  },
}
