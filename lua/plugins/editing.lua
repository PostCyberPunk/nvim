return {
  -- #34afff
  -- Colorizer ----------
  {
    "NvChad/nvim-colorizer.lua",
    config = true,
  },
  -----------Color Picker------------
  {
    "ziontee113/color-picker.nvim",
    keys = { { "<leader>cp", "<cmd>PickColor<cr>", desc = "Color picker", { noremap = true, silent = true } } },
    opts = {
      -- for changing icons & mappings
      -- ["icons"] = { "ﱢ", "" },
      -- ["icons"] = { "ﮊ", "" },
      -- ["icons"] = { "", "ﰕ" },
      -- ["icons"] = { "", "" },
      -- ["icons"] = { "", "" },
      ["icons"] = { "ﱢ", "" },
      ["border"] = "rounded", -- none | single | double | rounded | solid | shadow
      ["keymap"] = { -- mapping example:
        ["U"] = "<Plug>ColorPickerSlider5Decrease",
        ["O"] = "<Plug>ColorPickerSlider5Increase",
      },
      ["background_highlight_group"] = "Normal", -- default
      ["border_highlight_group"] = "FloatBorder", -- default
      ["text_highlight_group"] = "Normal", --default
    },
    config = true,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function(_, opts)
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:>]]
      vim.o.foldcolumn = "1"
      --
      opts.provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end

      ---preivew
      opts.preview = {
        win_config = {
          border = { "", "─", "", "", "", "─", "", "" },
          winhighlight = "Normal:Folded",
          winblend = 0,
        },
        mappings = {
          scrollU = "<C-u>",
          scrollD = "<C-d>",
          jumpTop = "[",
          jumpBot = "]",
        },
      }
      opts.open_fold_hl_timeout = 150
      -----virtText handler
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ("  %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end
      opts.fold_virt_text_handler = handler

      require("ufo").setup(opts)
    end,
  },
  --------------exchange ------------------
  {
    "gbprod/substitute.nvim",
    config = true,
  },
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewFileHistory",
      "DiffviewOpen",
    },
    keys = {
      { "<leader>gdh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History", { noremap = true, silent = false } },
      { "<leader>gdm", "<cmd>DiffviewOpen main<cr>", desc = "Diff main", { noremap = true, silent = false } },
      { "<leader>gdd", "<cmd>DiffviewOpen dev<cr>", desc = "Diff dev", { noremap = true, silent = false } },
    },
    config = true,
  },
  {
    "NeogitOrg/neogit",
    keys = {
      { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit Commit", { noremap = true, silent = false } },
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit", { noremap = true, silent = true } },
    },
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
    },
    opts = {
      disable_line_numbers = false,
      mappings = {
        commit_editor = {
          ["<leader><CR>"] = "Submit",
          ["<leader><ESC>"] = "Abort",
        },
        status = {
          ["K"] = "GoToPreviousHunkHeader",
          ["J"] = "GoToNextHunkHeader",
        },
      },
    },
    config = true,
  },
  {
    "folke/flash.nvim",
    opts = function(_, opts)
      opts.modes = {
        search = { enabled = false },
        -- char = { jump_labels = true }
      }
      -- opts.char.jump_labels= true
    end,
  },
  {
    "AckslD/muren.nvim",
    keys = {
      { "<leader>sz", "<cmd>MurenToggle<cr>", desc = "Muren Search Replace", { noremap = true, silent = true } },
    },
    opts = function(_, opts)
      opts.files = "%"
    end,
    config = true,
  },
  {
    "nat-418/boole.nvim",
    config = {
      mappings = {
        increment = "<C-a>",
        decrement = "<C-x>",
      },
    },
    -- config = true,
  },
}
