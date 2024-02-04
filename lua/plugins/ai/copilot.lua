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
        vim.keymap.set("n", "<leader>uuC", function()
          if vim.g.copilot_pcp_disabled then
            vim.cmd("Copilot enable")
            vim.g.copilot_pcp_disabled = false
          else
            vim.cmd("Copilot disable")
            vim.g.copilot_pcp_disabled = true
          end
        end, { desc = "Toggle Copilot completion" })
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
			-- stylua: ignore
      keys =
				function()
					local keybinds={
        { "<leader>cc<cr>", "V<cmd>CopilotChatVisualContinue<cr>", mode = { "x", "n" }, desc = "CopilotChat - Continue This line" },
        -- Those are available only on canary branch
        {
          "<leader>ccv",
          ":CopilotChatVisual",
          mode = "x",
          desc = "CopilotChat - Open in vertical split",
        },
        {
          "<leader>ccx",
          ":CopilotChatInPlace<cr>",
          mode = "x",
          desc = "CopilotChat - Run in-place code",
        },}
					local my_prompts = {
						{prompt = "In Neovim.",desc = "Neovim",key = "n"},
						{prompt = "Help with this",desc = "Help",key = "h"},
						{prompt = "Simplify and imporve readablilty",desc = "Simplify",key = "s"},
						{prompt = "Optimize the code to improve perfomance and readablilty.",desc = "Optimize",key = "o"},
						{prompt = "Find possible errors and fix them for me",desc = "Fix",key = "f"},
						{prompt = "Explain in detail",desc = "Explain",key = "e"},
						{prompt = "Write a shell scirpt",desc = "Shell",key = "S"},
					}
					for _,v in pairs(my_prompts) do
						table.insert(keybinds,{ "<leader>cc"..v.key, ":CopilotChatVisual "..v.prompt.."<cr>", mode = "x", desc = "CopilotChat - "..v.desc })
						table.insert(keybinds,{ "<leader>cc"..v.key, "<cmd>CopilotChat "..v.prompt.."<cr>", desc = "CopilotChat - "..v.desc })
					end
					return keybinds
				end,
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
          separator = "",
        })
      end,
    },
  }
else
  return {}
end
