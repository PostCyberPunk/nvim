local cmp_off = {
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
  },
}
local cmp_on = {
  -- add all opened buffers
  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    -- keys = { { "<Tab>", "<C-n>" }, { "<S-Tab>", "<C-p>" } },
		-- stylua: ignore
    dependencies = { "hrsh7th/cmp-emoji", "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp-signature-help" ,"hrsh7th/cmp-cmdline"},
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources[4] = {
        name = "buffer",
        option = {
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end,
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
      opts.sources =
        cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" }, { name = "nvim_lsp_signature_help" } }))

      ---tabout and lua snip
      local luasnip = require("luasnip")
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- they way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
            -- elseif has_words_before() then
            --   cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ------- custom completion ------
        ["<space>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm()
            vim.api.nvim_feedkeys(" ", "n", true)
          else
            fallback()
          end
        end, { "i", "c" }),
        ["."] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm()
            vim.api.nvim_feedkeys(".", "n", true)
          else
            fallback()
          end
        end, { "i" }),
      })

      ------autopairs
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  -------------------TabOut
  {
    "abecodes/tabout.nvim",
    -- dependencies = { "nvim-treesitter", "nvim-cmp" },
    wants = { "nvim-treesitter" },
    after = { "nvim-cmp" },
    config = function()
      require("tabout").setup({
        tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = "<C-d>", -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = true, -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
          { open = "<", close = ">" },
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {}, -- tabout will ignore these filetypes
      })
    end,
  },

  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          if require("pcp.extra").imports.unity then
            require("luasnip").filetype_extend("cs", { "unity" })
          end
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    keys = function()
      return {}
    end,
  },
}

if require("pcp.extra").imports.cmp then
  return cmp_on
else
  return cmp_off
end
