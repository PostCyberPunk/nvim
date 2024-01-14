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
    ft = {
      "norg",
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
          ["core.keybinds"] = {
            config = {
              hook = function(keybinds)
                -- Unmaping
                keybinds.unmap("norg", "n", "<leader>nnn")

                -- Mode
                keybinds.map("norg", "n", "<leader>nn", "<cmd>Neorg mode todo<cr>")
                keybinds.map("norg", "n", "<leader>nL", "<cmd>Neorg mode traverse-link<cr>")
                -- Navi
                keybinds.remap_event("norg", "n", "J", "core.integrations.treesitter.next.heading")
                keybinds.remap_event("norg", "n", "K", "core.integrations.treesitter.previous.heading")
                keybinds.remap_event("traverse-link", "n", "<CR>", "core.esupports.hop.hop-link")
                -- Todos
                keybinds.map("todo", "n", "<leader>nn", "<cmd>Neorg mode norg<cr>")
                keybinds.remap_event("todo", "i", "<CR>", "core.itero.next-iteration")
                keybinds.remap_event("todo", "n", "J", "core.integrations.treesitter.next.heading")
                keybinds.remap_event("todo", "n", "K", "core.integrations.treesitter.previous.heading")
                keybinds.remap_event("todo", "n", "go", "core.esupports.hop.hop-link")
                keybinds.remap_event("todo", "n", "t", "core.qol.todo_items.todo.task_cycle")
                keybinds.remap_event("todo", "i", "<C-t>", "core.promo.promote")
                keybinds.remap_event("todo", "i", "<C-d>", "core.promo.demote")
                keybinds.remap_event("todo", "i", "<M-d>", "core.tempus.insert-date-insert-mode")
                keybinds.remap_event("todo", "n", ">.", "core.promo.promote")
                keybinds.remap_event("todo", "n", "<,", "core.promo.demote")
                -- keybinds.remap_event("todo", "n", ">>", "core.promo.promote","nested")
                -- keybinds.remap_event("todo", "n", "<<", "core.promo.demote","nested")
                keybinds.map("todo", "n", "o", function()
                  vim.cmd("Neorg keybind all core.itero.next-iteration")
                  vim.cmd("startinsert")
                end)
              end,
              neorg_leader = "<leader>n",
            },
          },
          ["core.qol.todo_items"] = {
            config = {
              order = { { "undone", " " }, { "done", "x" } },
            },
          },
        },
      })
      require("neorg.modules.core.mode.module").public.add_mode("todo")
    end,
  },
}
