return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    -- tag = "*",
    keys = {
      { "<leader>nh", "<cmd>Neorg index<cr>", desc = "Neorg Home", { noremap = true, silent = true } },
      { "<leader>nb", "<cmd>Neorg toc left<cr>", desc = "Neorg Toc", { noremap = true, silent = true } },
      { "<leader>nq", "<cmd>Neorg return<cr>", desc = "Neorg Return", { noremap = true, silent = true } },
    },
    cmd = {
      "Neorg",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {
            config = {
              icon_preset = "varied",
            },
          }, -- Adds pretty icons to your documents
          ["core.itero"] = {},
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
              },
              default_workspace = "notes",
            },
          },
          ["core.qol.todo_items"] = {
            config = {
              order = { { "undone"," " }, {"done","x" }},
            },
          },
        },
      })
    end,
  },
}
