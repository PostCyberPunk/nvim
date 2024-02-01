if require("pcp.extra").imports.ai then
  return {
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      build = ":Copilot auth",
      opts = {
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          help = true,
        },
      },
    },
    {
      "nvim-cmp",
      dependencies = {
        {
          "zbirenbaum/copilot-cmp",
          dependencies = "copilot.lua",
          opts = {},
          config = function(_, opts)
            local copilot_cmp = require("copilot_cmp")
            copilot_cmp.setup(opts)
            -- attach cmp source whenever copilot attaches
            -- fixes lazy-loading issues with the copilot cmp source
            require("lazyvim.util").lsp.on_attach(function(client)
              if client.name == "copilot" then
                copilot_cmp._on_insert_enter({})
              end
            end)
          end,
        },
      },
      ---@param opts cmp.ConfigSchema
      opts = function(_, opts)
        table.insert(opts.sources, 4, {
          name = "copilot",
          group_index = 1,
          priority = 100,
        })
      end,
    },
    {
      -- dir = "~/Repos/CopilotChat.nvim",
      "jellydn/CopilotChat.nvim",
      branch = "canary", -- Will be merged to main branch when it's stable
      opts = {
        mode = "split", -- newbuffer or split, default: newbuffer
        show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
        prompts = {
          Neovim = "In Neovim.",
          Help = "Help me with this.",
          Shell = "Write a shell scipt for me.",
          Optimize = "Optimize the code to improve perfomance.",
          Review = "Review the following code and provide concise suggestions.",
          Continue = ",",
        },
      },
      build = function()
        vim.defer_fn(function()
          vim.cmd("UpdateRemotePlugins")
          vim.notify("CopilotChat - Updated remote plugins. Please restart Neovim.")
        end, 3000)
      end,
      event = "VeryLazy",
      keys = {
        { "<leader>cce", "<cmd>CCExplain<cr>", mode = { "x", "n" }, desc = "CopilotChat - Explain code" },
        { "<leader>cct", "<cmd>CCTests<cr>", mode = { "x", "n" }, desc = "CopilotChat - Generate tests" },
        { "<leader>ccn", "<cmd>CCNeovim<cr>", mode = { "x", "n" }, desc = "CopilotChat - Ask about neovim" },
        { "<leader>cch", "<cmd>CCHelp<cr>", mode = { "x", "n" }, desc = "CopilotChat - Help" },
        { "<leader>ccs", "<cmd>CCShell<cr>", mode = { "x", "n" }, desc = "CopilotChat - Write shell script" },
        { "<leader>cco", "<cmd>CCOptimize<cr>", mode = { "x", "n" }, desc = "CopilotChat - Optimize" },
        { "<leader>ccr", "<cmd>CCReview<cr>", mode = { "x", "n" }, desc = "CopilotChat - Review" },
        { "<leader>ccc", "<cmd>CCContinue<cr>", mode = { "x", "n" }, desc = "CopilotChat - Continue" },
        { "<leader>cc<cr>", "V<cmd>CCContinue<cr>", mode = { "x", "n" }, desc = "CopilotChat - Continue This line" },
        -- Those are available only on canary branch
        {
          "<leader>ccV",
          ":CopilotChatVsplitVisual",
          mode = "x",
          desc = "CopilotChat - Open in vertical split",
        },
        {
          "<leader>ccx",
          ":CopilotChatInPlace<cr>",
          mode = "x",
          desc = "CopilotChat - Run in-place code",
        },
      },
    },
    {
      "nvim-lualine/lualine.nvim",
      optional = true,
      event = "VeryLazy",
      opts = function(_, opts)
        local mocha = require("catppuccin.palettes").get_palette("mocha")
        local colors = {
          [""] = { fg = mocha.green },
          ["Normal"] = { fg = mocha.green },
          ["Warning"] = { fg = mocha.yellow },
          ["InProgress"] = { fg = mocha.blue },
        }
        table.insert(opts.sections.lualine_x, 7, {
          function()
            local icon = require("lazyvim.config").icons.kinds.Copilot
            local status = require("copilot.api").status.data
            return icon .. (status.message or "")
          end,
          cond = function()
            if not package.loaded["copilot"] then
              return
            end
            local ok, clients = pcall(require("lazyvim.util").lsp.get_clients, { name = "copilot", bufnr = 0 })
            if not ok then
              return false
            end
            return ok and #clients > 0
          end,
          color = function()
            if not package.loaded["copilot"] then
              return
            end
            local status = require("copilot.api").status.data
            return colors[status.status] or colors[""]
          end,
        })
      end,
    },
  }
else
  return {}
end
