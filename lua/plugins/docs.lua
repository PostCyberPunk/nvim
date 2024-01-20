return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    -- tag = "*",
    keys = {
      { "<leader>nh", "<cmd>Neorg index<cr>", desc = "Neorg Home", { noremap = true, silent = true } },
      { "<leader>nb", "<cmd>Neorg toc right<cr>", desc = "Neorg Toc", { noremap = true, silent = true } },
      { "<leader>nq", "<cmd>Neorg return<cr>", desc = "Neorg Return", { noremap = true, silent = true } },
      {
        "<leader>nc",
        "<cmd>Neorg toggle-concealer<cr>",
        desc = "Neorg Toggle Concealer",
        { noremap = true, silent = true },
      },
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
                keybinds.unmap("todo", "n", "Z")

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
                keybinds.remap_event("todo", "n", "<C-t>", "core.promo.promote")
                keybinds.remap_event("todo", "n", "<C-d>", "core.promo.demote")
                keybinds.remap_event("todo", "i", "<C-t>", "core.promo.promote")
                keybinds.remap_event("todo", "i", "<C-d>", "core.promo.demote")
                keybinds.remap_event("todo", "i", "<M-d>", "core.tempus.insert-date-insert-mode")
                -- keybinds.remap_event("todo", "n", ">>", "core.promo.promote","nested")
                -- keybinds.remap_event("todo", "n", "<<", "core.promo.demote","nested")

                keybinds.map("todo", "n", "t", function()
                  vim.cmd("Neorg keybind all core.qol.todo_items.todo.task_cycle")
                  vim.api.nvim_feedkeys("j", "n", false)
                end)
                keybinds.map("todo", "n", "<leader>nS", function()
                  vim.cmd("!rclone copy ~/notes/ tera:/notes")
                end, { desc = "Sync My Notes" })
                keybinds.map("todo", "n", "o", function()
                  vim.cmd("Neorg keybind all core.itero.next-iteration")
                  vim.api.nvim_feedkeys("A", "n", false)
                end)
                keybinds.map("todo", "n", "<leader>ns", function()
                  vim.api.nvim_feedkeys("Egsa", "m", false)
                end, { desc = "Neorg add surround" })
                -- keybinds.map("todo", "x", "<leader>r", function()
                --   vim.cmd("'<,'>s/.$/")
                -- end, { desc = "Neorg replace" })

                --#region
                keybinds.remap_event(
                  "todo",
                  "n",
                  "ZU",
                  "core.qol.todo_items.todo.task_undone",
                  { desc = "[Neorg] Undone" }
                )
                keybinds.remap_event(
                  "todo",
                  "n",
                  "ZP",
                  "core.qol.todo_items.todo.task_pending",
                  { desc = "[Neorg] Pending" }
                )
                keybinds.remap_event("todo", "n", "ZD", "core.qol.todo_items.todo.task_done", { desc = "[Neorg] Done" })
                keybinds.remap_event(
                  "todo",
                  "n",
                  "ZH",
                  "core.qol.todo_items.todo.task_on_hold",
                  { desc = "[Neorg] Hold" }
                )
                keybinds.remap_event(
                  "todo",
                  "n",
                  "ZC",
                  "core.qol.todo_items.todo.task_cancelled",
                  { desc = "[Neorg] Cancelled" }
                )
                keybinds.remap_event(
                  "todo",
                  "n",
                  "ZR",
                  "core.qol.todo_items.todo.task_recurring",
                  { desc = "[Neorg] Recurring" }
                )
                keybinds.remap_event(
                  "todo",
                  "n",
                  "ZI",
                  "core.qol.todo_items.todo.task_important",
                  { desc = "[Neorg] Important" }
                )
                keybinds.remap_event(
                  "todo",
                  "n",
                  "ZA",
                  "core.qol.todo_items.todo.task_ambiguous",
                  { desc = "[Neorg] Ambiguonus" }
                )
                --#endregion
              end,
              neorg_leader = "<leader>n",
            },
          },
          ["core.qol.todo_items"] = {
            config = {
              order = { { "undone", " " }, { "done", "x" } },
            },
          },
          ["core.mode"] = {
            config = {
              current_mode = "todo",
            },
          },
        },
      })
      require("neorg.modules.core.mode.module").public.add_mode("todo")
    end,
  },
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {
      enabled = false,
      -- or just leave it empty :)
    },
  },
}
