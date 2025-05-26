return {
  -------------neogit
  {
    "NeogitOrg/neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit", { noremap = true, silent = true } },
      {
        "<leader>g<cr>",
        function()
          vim.cmd("Gitsigns stage_hunk")
          vim.cmd("Neogit commit")
        end,
        mode = { "n", "x" },
        desc = "Stage and Commit Hunk",
        { noremap = true, silent = false },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional
    },
    opts = {
      ignored_settings = {
        "NeogitPushPopup--force-with-lease",
        "NeogitPushPopup--force",
        "NeogitPullPopup--rebase",
        "NeogitCommitPopup--allow-empty",
        "NeogitCommitPopup--all",
        "NeogitRevertPopup--no-edit",
      },
      disable_line_numbers = false,
      status = {
        recent_commit_count = 20,
      },
      rebase_editor = {
        kind = "vsplit",
      },
      merge_editor = {
        kind = "vsplit",
      },
      sections = {
        recent = {
          folded = false,
        },
      },
      mappings = {
        commit_editor = {
          ["<CR><CR>"] = "Submit",
          ["<CR><ESC>"] = "Abort",
        },
        rebase_editor = {
          ["<CR><CR>"] = "Submit",
          ["<CR><ESC>"] = "Abort",
        },
        merge_editor = {
          ["<CR><CR>"] = "Submit",
          ["<CR><ESC>"] = "Abort",
        },
        status = {
          ["K"] = "GoToPreviousHunkHeader",
          ["J"] = "GoToNextHunkHeader",
          ["R"] = "RefreshBuffer",
        },
      },
    },
    config = true,
  },
  ------diffview
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewFileHistory",
      "DiffviewOpen",
    },
    keys = {
      { "<leader>gdh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History", { noremap = true, silent = false } },
      { "<leader>gdM", "<cmd>DiffviewOpen main<cr>", desc = "Diff main", { noremap = true, silent = false } },
      { "<leader>gdD", "<cmd>DiffviewOpen dev<cr>", desc = "Diff dev", { noremap = true, silent = false } },
      { "<leader>gdd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open", { noremap = true, silent = false } },
      { "<leader>gdi", ":DiffviewOpen ", desc = "Diffview Open", { noremap = true, silent = false } },
      { "<leader>gdq", "<cmd>DiffviewClose<cr>", desc = "Diffview Close", { noremap = true, silent = false } }, --FIX:nvim_exec2 error
      { "<leader>gdr", "<cmd>DiffviewRefresh<cr>", desc = "Diffview Rfresh", { noremap = true, silent = false } },
    },
    config = function()
      require("diffview").setup({
        view = {
          default = {
            layout = "diff2_vertical",
          },
          merge_tool = {
            layout = "diff3_vertical",
            winbar_info = false,
          },
          file_hsitory = {
            layout = "diff2_vertical",
          },
        },
        keymaps = {
          file_panel = {
            { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
          },
          file_history_panel = {
            { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
          },
        },
      })
    end,
  },
}
