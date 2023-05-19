return {
  {
    "caenrique/nvim-maximize-window-toggle",
    keys = { { "<leader>wm", "<cmd>ToggleOnly<cr>", desc = "Max/Min Window" } },
  },
  {
    "goolord/alpha-nvim",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local findB =
        dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"), table.insert(
          dashboard.section.buttons.val,
          4,
          --   dashboard.button("k", " " .. "Change keymap", function()
          --     require("persistence").load({ last = true })
          --   end)
          -- )
          dashboard.button("k", " " .. "Change keymap", ":Telescope live_grep <CR>")
        )
    end,
  },
}
