return {
  {
    "Exafunction/windsurf.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = function(_, opts)
          local codeium_status = function()
            if require("codeium") == nil then
              return ""
            end
            local status = require("codeium.virtual_text").status()

            if status.state == "idle" then
              return "󰭻"
            end

            if status.state == "waiting" then
              -- Waiting for response
              return ""
            end

            if status.state == "completions" and status.total > 0 then
              return string.format("%d/%d", status.current, status.total)
            end
            return "0"
          end
          table.insert(opts.sections.lualine_y, 1, { codeium_status, separator = "" })
        end,
      },
    },
    --toggle codeium
    keys = { { "<leader>ci", "<cmd>Codeium Toggle<cr>", desc = "Codeium" } },
    config = function()
      require("codeium").setup({
        -- Optionally disable cmp source if using virtual text only
        enable_cmp_source = false,
        virtual_text = {
          enabled = true,
          key_bindings = {
            accept = "<M-f>",
            accept_word = false,
            accept_line = false,
            clear = false,
            next = "<M-]>",
            prev = "<M-[>",
          },
        },
      })
      require("codeium").s.enabled = false
    end,
  },
}
