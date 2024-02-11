return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      integrations = {
        cmp = true,
        flash = true,
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {
      modes = {
        -- search = { enabled = false },
        char = { jump_labels = true, multi_line = false },
      },
      label = {
        current = false,
        after = false,
        before = { 0, 0, 1 },
      },
    },
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" }, },
  },
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
		-- stylua: ignore
    dependencies = {"hrsh7th/cmp-buffer" ,"hrsh7th/cmp-cmdline"},
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      opts.sources = {
        { name = "path" },
        { name = "buffer" },
      }
      opts.experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      }
      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      }) -- `/` cmdline setup.
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      opts.mapping = cmp.mapping.preset.insert({
        ["<space>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm()
            vim.api.nvim_feedkeys(" ", "n", true)
          else
            fallback()
          end
        end, { "c" }),
        ["<cr>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if cmp.get_selected_entry() == nil then
              cmp.select_next_item()
            end
            cmp.confirm()
          else
            fallback()
          end
        end, { "c" }),
        ["<down>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "c" }),
        ["<up>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "c" }),
      })
    end,
    config = true,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = {
      options = {
        component_separators = "|",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          { "mode", separator = { left = "" }, right_padding = 2 },
        },
        lualine_b = {
          {
            function()
              return vim.fn.getcwd()
            end,
          },
          "fileformat",
        },
        lualine_c = { "encoding", "filesize" },
        lualine_x = {},
        lualine_y = { "filetype", "progress" },
        lualine_z = {
          {
            function()
              return vim.fn.hostname()
            end,
            separator = { right = "" },
          },
        },
      },
      tabline = {},
      extensions = {},
    },
  },
}
