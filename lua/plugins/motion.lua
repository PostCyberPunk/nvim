return {
  ------------Flash
  {
    "folke/flash.nvim",
    opts = function(_, opts)
      opts.modes = {
        search = { enabled = true },
        char = {

          -- abcdeffffghijkllllllllllllll
          keys = {}, --Disable  "f", "F", "t", "T", ";", ","
          ------------------------------
          -- autojump = true,
          -- jump_labels = true,
          -- multi_line = false,
        },
      }
      opts.label = {
        current = false,
        after = false,
        before = { 0, 0, 1 },
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
  ---------------------tabout
  {
    "abecodes/tabout.nvim",
    lazy = false,
    config = function()
      require("tabout").setup({
        tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = "<C-d>", -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = false, -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {}, -- tabout will ignore these filetypes
      })
    end,
    dependencies = { -- These are optional
      "nvim-treesitter/nvim-treesitter",
    },
    opt = true, -- Set this to true if the plugin is optional
    event = "InsertCharPre", -- Set the event to 'InsertCharPre' for better compatibility
    priority = 1000,
  },
}
