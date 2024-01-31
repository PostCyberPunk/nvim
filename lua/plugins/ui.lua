return {
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<leader>b,", "<cmd>BufferLineMovePrev<cr>", desc = "Move BufferLeft" },
      { "<leader>b.", "<cmd>BufferLineMoveNext<cr>", desc = "Move BufferRight" },
      { "<leader>bg", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer Visually" },
    },
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
      local mocha = require("catppuccin.palettes").get_palette("mocha")
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
        },
      })
      table.insert(opts.sections.lualine_c, 1, {
        -- Lsp server name .
        function()
          local msg = "No LSP"
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
        color = { fg = mocha.green },
      })

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
      defaults = {
        ["<leader>s"] = { name = "󰍉 Search" },
        ["<leader>f"] = { name = "󰜏 file/find" },
        ["<leader>x"] = { name = " Diagnosing" },
        ["<leader>c"] = { name = " Coding" },
        ["<leader>u"] = { name = " UI" },
        ["<leader>b"] = { name = "󰓩 Buffers" },
        ["<leader>w"] = { name = "󰨡 Windows" },
        ["<leader><tab>"] = { name = "󰌕Tabs" },
        ["<leader>d"] = { name = " Debugger" },
        ["<leader>g"] = { name = "󰊢 Git" },
        ["<leader>q"] = { name = "󱂬 Session" },
        ["<leader>t"] = { name = " Terminal" },
        ["<leader>uu"] = { name = "烙More" },
        ["<leader>m"] = { name = "烙More" },
        ["<leader>n"] = { name = "󰽱Notes" },
      },
    },
  },
}
