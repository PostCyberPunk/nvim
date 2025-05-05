return {
  -- windwo picker
  {
    "s1n7ax/nvim-window-picker",
    version = "v1.*",
    keys = {
      {
        "<leader>wP",
        function()
          local current_buf = vim.api.nvim_get_current_buf()
          local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
          vim.api.nvim_win_close(vim.api.nvim_get_current_win(), true)
          vim.api.nvim_set_current_win(picked_window_id)
          vim.api.nvim_win_set_buf(picked_window_id, current_buf)
        end,
        "n",
        desc = "Replace a window",
      },
      {
        "<leader>wp",
        function()
          local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
          vim.api.nvim_set_current_win(picked_window_id)
        end,
        "n",
        desc = "Pick a window",
      },
    },

    config = function()
      require("window-picker").setup({
        use_winbar = "smart",
        other_win_hl_color = "#B4BEFE",
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
        -- include_current_win = true,
        -- selection_display = function(char)
        --   return ":::" .. char
        -- end,
      })
    end,
  },
  --win sep
  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinNew" },
  },
  --focus---
  {
    "beauwilliams/focus.nvim",
    keys = { { "<leader>wa", "<cmd>FocusToggle<cr>", desc = "Focus Split Nicely" } },
    cmd = { "FocusToggle", "FocusSplitCycle", "FocusSplitNicely" },
    config = function(_, opts)
      local focus = require("focus")
      focus.setup(opts)
      focus.focus_disable()
      ---- disable focus on certain file and buf types
      local ignore_filetypes = { "neo-tree" }
      local ignore_buftypes = { "nofile", "prompt", "popup" }

      local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })

      vim.api.nvim_create_autocmd("WinEnter", {
        group = augroup,
        callback = function(_)
          if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
            vim.w.focus_disable = true
          else
            vim.w.focus_disable = false
          end
        end,
        desc = "Disable focus autoresize for BufType",
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = augroup,
        callback = function(_)
          if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
            vim.b.focus_disable = true
          else
            vim.b.focus_disable = false
          end
        end,
        desc = "Disable focus autoresize for FileType",
      })
    end,
  },
  {
    "anuvyklack/hydra.nvim",
    dependencies = {
      "mrjones2014/smart-splits.nvim",
      "sindrets/winshift.nvim",
    },
    config = function()
      local Hydra = require("hydra")
      local splits = require("smart-splits")

      local cmd = require("hydra.keymap-util").cmd
      local pcmd = require("hydra.keymap-util").pcmd
      --stylua:ignore
      local window_hint = [[
                  Size            Move               Split
             -------------    -----------       ---------------
      k            K             <C-k>         s : horizontally
  h       l    H       L     <C-h>   <C-l>     v : vertically
      j            J             <C-j>         q : close
 focus        window          = : equalize

]]
      Hydra({
        name = "Windows",
        hint = "window mdoe",
        -- hint = window_hint,
        config = {
          invoke_on_body = true,
          -- hint = false,
          hint = {
            border = "rounded",
            offset = -1,
            show_name = false,
          },
        },
        mode = "n",
        body = "<leader>w;",
  			-- stylua: ignore
        heads = {
          { "h", "<C-w>h" },
          { "j", "<C-w>j" },
          { "k", pcmd("wincmd k", "E11", "close") },
          { "l", "<C-w>l" },

          { "<c-h>", cmd("WinShift left") },
          { "<c-j>", cmd("WinShift down") },
          { "<c-k>", cmd("WinShift up") },
          { "<c-l>", cmd("WinShift right") },

          { "H", function() splits.resize_left(2) end, },
          { "J", function() splits.resize_down(2) end, },
          { "K", function() splits.resize_up(2) end, },
          { "L", function() splits.resize_right(2) end, },
          { "=", "<C-w>=", { desc = "equalize" } },

          { "s", pcmd("split", "E36") },
          { "v", pcmd("vsplit", "E36") },

          { "q", pcmd("close", "E444"), { desc = "close window" } },
          { "<C-c>", pcmd("close", "E444"), { desc = false } },
          { "<C-q>", pcmd("close", "E444"), { desc = false } },

          { "<Esc>", nil, { exit = true, desc = false } },
        },
      })
    end,
  },
  -- {
  --   "xiyaowong/transparent.nvim",
  --   opts = {
  --     extra_groups = {
  --       "NotifyBackground",
  --     },
  --   },
  --   config = function()
  --     vim.api.nvim_set_hl(0, "NotifyBackground", vim.api.nvim_get_hl_by_name("Normal", true))
  --     vim.g.transparent_groups = vim.list_extend(
  --       vim.g.transparent_groups or {},
  --       vim.tbl_map(function(v)
  --         return v.hl_group
  --       end, vim.tbl_values(require("bufferline.config").highlights))
  --     )
  --   end,
  -- },
}
