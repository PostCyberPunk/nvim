return {
  -- {
  --   "ggandor/leap.nvim",
  --   opts = {
  --     safe_labels = { "s", "z", "f", "n", "u", "t", "x", "q" },
  --   },
  --   keys = {
  --     { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
  --     { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
  --     { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
  --   },
  --   config = function(_, opts)
  --     local leap = require("leap")
  --     for k, v in pairs(opts) do
  --       leap.opts[k] = v
  --     end
  --     leap.add_default_mappings(true)
  --     vim.keymap.del({ "x", "o" }, "x")
  --     vim.keymap.del({ "x", "o" }, "X")
  --   end,
  -- },
  -- {
  --   "ggandor/flit.nvim",
  --   keys = function()
  --     ---@type LazyKeys[]
  --     local ret = {}
  --     for _, key in ipairs({ "f", "F", "t", "T" }) do
  --       ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
  --     end
  --     return ret
  --   end,
  --   opts = { labeled_modes = "nx", multiline = false },
  -- },
  --------------------spider
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "x" }, desc = "Spider-w" },
      { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "x" }, desc = "Spider-e" },
      { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "x" }, desc = "Spider-b" },
      { "zw", "<cmd>lua require('spider').motion('w')<CR>", mode = "o", desc = "Spider-w" },
      { "ze", "<cmd>lua require('spider').motion('e')<CR>", mode = "o", desc = "Spider-e" },
      { "zb", "<cmd>lua require('spider').motion('b')<CR>", mode = "o", desc = "Spider-b" },
    },
    -- config = true,
  },
}
