return {
  -- dashboard
  {
    "snacks.nvim",
    dependencies = { "olimorris/persisted.nvim" },
    -- stylua: ignore
    keys = {
      -----picker
      { "<leader>snn", function() Snacks.picker.notifications() end,  desc = "Notifications History" },
      { "<leader>sL", function() Snacks.picker.loclist() end,  desc = "Search loclist" },
      { "<leader>sl", function() Snacks.picker.resume() end,  desc = "Resume Last Search" },
      { "<leader>fP", function() Snacks.picker.files({ cwd = require("lazy.core.config").options.root }) end, desc = "Find Plugin File", },
      -----gig_picker
      { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit Commit", { noremap = true, silent = false } },
      { "<leader>g?", function() Snacks.picker.git_status() end, desc = "status", },
      -----dashboard
      { "<leader>qh", function() Snacks.dashboard.open() end, desc = "Open Dashboard", },
    },
    opts = function(_, opts)
      opts.dashboard = {
        formats = {
          key = function(item)
            return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
          end,
        },
        preset = {
          pick = function(cmd, opts2)
            return LazyVim.pick(cmd, opts2)()
          end,
          header = [[
███▄▄█▓▓█████████████████████▓▓▓██▓▄▄███
███▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█▓█
███ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄ █▓█
█▓█ ██▀▄ ▄▀██ ███▄▀▀▀▄▓▓██ ██▀▄ ▄▀▓▓ █▓█
███ █▌■   ■▐█ ██▓▓▌ ▐█████ █▌■   ■▐█ █▓█
█▓█ ▓▓▄▀ ▀▄██ █▓▓▀▄▄▄▀█▓▓█ ██▄▀ ▀▄██ █▓█
█▓█ ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀ ███
█▓█             NEOVIM               █▓█
█▓█       Powered by Lazy.Nvim       ███
█████▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█████
█▓▓█▌ ▐█▀▀████████████████████▀▀█▌ ▐█▓▓█
████  ██▄▄████████████████▓▓██▄▄██  ████

   Spleen Artpack #03 ■ November 2011

 ▄█ ▄█  ▓▄   ▐█ ▓▌  █████  ▄█▓▓▄  █▄ █▄
▀▓▓▀██  ██▀  ▐█ █▌  █▓▓██  █████  ██▀▓▓▀
 ▀  ▀  ▀     ▀ ▀   ▀▀▀▀▀   ▀▀▀   ▀  ▀
]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "p", desc = "Projects", action = ":SessionSelect" },
          { icon = " ", key = "L", desc = "Restore Session", action = ":SessionLoadLast" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        },
        sections = {
          { section = "header", padding = 0 },
          { section = "startup", padding = 1 },
          { pane = 2, icon = " ", section = "keys", padding = 1 },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git status --short --branch --renames",
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
        },
      }
      opts.indent = { enabled = false }
      opts.scope = { enabled = false }
      opts.notifier = { timeout = 1000 }
    end,
  },
}
