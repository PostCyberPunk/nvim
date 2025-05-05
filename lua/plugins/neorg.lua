if require("pcp.extra").imports.neorg then
  return {
    {
      "nvim-neorg/neorg",
      -- lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
      version = "*", -- Pin Neorg to the latest stable release
      cmd = { "Neorg" },
      ft = { "norg" },
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
                order = { { "undone", " " }, { "done", "x" } },
              },
            },
          },
        })
        --Keymaps for norg file only
        vim.api.nvim_create_autocmd("Filetype", {
          pattern = "norg",
      -- stylua: ignore
        callback = function()
					-- vim.keymap.del("n", "<leader>n",{})
          --Navi
          vim.keymap.set("n", "J", "<Plug>(neorg.treesitter.next.heading)", { desc = "(Neorg) Next heading" })
          vim.keymap.set("n", "K", "<Plug>(neorg.treesitter.previous.heading)", { desc = "(Neorg) Previous heading" })
          -- Inset mode
          vim.keymap.set("i", "<C-t>", "<Plug>(neorg.promo.promote)", { desc = "(Neorg)Promete" })
          vim.keymap.set("i", "<C-d>", "<Plug>(neorg.promo.demote)", { desc = "(Neorg)Demote" })
          vim.keymap.set("i", "<M-d>", "<Plug>(neorg.tempus.insert-date.insert-mode)", { desc = "(Neorg)Add Date" })
          -- TaskTodo
          -- vim.keymap.set("n", "<leader>ntt", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", { desc = "Task Cycle" })
          vim.keymap.set( "n", "TD", "<Plug>(neorg.qol.todo-items.todo.task-done)", { desc = "Task Done" })
          vim.keymap.set( "n", "TU", "<Plug>(neorg.qol.todo-items.todo.task-undone)", { desc = "Task Undone" })
          vim.keymap.set( "n", "TP", "<Plug>(neorg.qol.todo-items.todo.task-pending)", { desc = "Task Pending" })
          vim.keymap.set( "n", "TO", "<Plug>(neorg.qol.todo-items.todo.task-on_hold)", { desc = "Task OnHolding" })
					vim.keymap.set( "n", "TC", "<Plug>(neorg.qol.todo-items.todo.task-cancelled)", { desc = "Task Cancelled" })
          vim.keymap.set( "n", "TR", "<Plug>(neorg.qol.todo-items.todo.task-recurring)", { desc = "Task Recurring" })
          vim.keymap.set( "n", "TI", "<Plug>(neorg.qol.todo-items.todo.task-important)", { desc = "Task Important" })
					-- QOL funcitons
					vim.keymap.set( "n", "<leader>ns", function() vim.api.nvim_feedkeys("Egsa", "m", false) end, { desc = "Neorg add surround" })
					vim.keymap.set( "n", "<leader>nS", function() vim.cmd("!rclone copy ~/notes/ tera:/notes") end, { desc = "Neorg Sync" })
          -- vim.keymap.set( "n", "o", "<Plug>(neorg.itero.next-iteration)", { desc = "Next itero" })
					-- vim.keymap.set( "n", "o", function() vim.cmd("<Plug>(neorg.itero.next-iteration)") vim.api.nvim_feedkeys("A", "n", false) end)
        end,
        })
      end,
			-- stylua: ignore
      keys = {
        { "<leader>n", false },
        { "<leader>nh", "<cmd>Neorg index<cr>", desc = "Neorg Home", { noremap = true, silent = true } },
        { "<leader>nb", "<cmd>Neorg toc right<cr>", desc = "Neorg Toc", { noremap = true, silent = true } },
        { "<leader>nq", "<cmd>Neorg return<cr>", desc = "Neorg Return", { noremap = true, silent = true } },
        { "<leader>nc", "<cmd>Neorg toggle-concealer<cr>", desc = "Neorg Toggle Concealer", { noremap = true, silent = true }, },
      },
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
else
  return {}
end
