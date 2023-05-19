return {
  {
    "s1n7ax/nvim-window-picker",
    version = "v1.*",
    config = function()
      require("window-picker").setup({
        autoselect_one = true,
        include_current = false,
        filter_rules = {
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "neo-tree", "neo-tree-popup", "notify" },

            -- if the buffer type is one of following, the window will be ignored
            buftype = { "terminal", "quickfix" },
          },
        },
        other_win_hl_color = "#e35e4f",
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "s1n7ax/nvim-window-picker",
    },
    ---lazykeys
    keys = { { "<leader>fd", "<cmd>Neotree focus<CR>", desc = "Explorer NeoTree Focus" } },
    --config
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        source_selector = {
          winbar = true,
          statusline = true,
        },
        window = {
          mappings = {
            --Navigation with HJKL
            ["h"] = function(state)
              local node = state.tree:get_node()
              if node.type == "directory" and node:is_expanded() then
                require("neo-tree.sources.filesystem").toggle_directory(state, node)
              else
                require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
              end
            end,
            ["l"] = function(state)
              local node = state.tree:get_node()
              if node.type == "directory" then
                if not node:is_expanded() then
                  require("neo-tree.sources.filesystem").toggle_directory(state, node)
                elseif node:has_children() then
                  require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
                end
              else
                state.commands["open"](state)
                vim.cmd("Neotree close")
              end
            end,
            ["<tab>"] = function(state)
              state.commands["open"](state)
              vim.cmd("Neotree reveal")
            end,
            ["<cr>"] = function(state)
              local node = state.tree:get_node()
              if node.type == "directory" then
                if not node:is_expanded() then
                  require("neo-tree.sources.filesystem").toggle_directory(state, node)
                end
              else
                state.commands["open"](state)
                vim.cmd("Neotree close")
              end
            end,
            ["i"] = "open",
          },
        },
      })
    end,
  },
}
