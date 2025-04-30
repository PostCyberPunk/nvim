return {
  ------------Flash
  {
    "folke/flash.nvim",
    opts = function(_, opts)
      opts.modes = {
        search = { enabled = true },
        char = { jump_labels = true, multi_line = false },
      }
      opts.label = {
				current = false,
        after = false,
				before = {0,0,1},
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
}
