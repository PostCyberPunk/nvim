return {
  -- { "rafi/awesome-vim-colorschemes", priority = 1000 },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = true,
        mini = true,
      },
      highlight_overrides = {
        all = function(colors)
          return {
            Visual = { bg = "#585b70" },
            VertSplit = { fg = "#6670b0" },
          }
        end,
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  -- ---------------tokyonight-----
  {
    "folke/tokyonight.nvim",
    opts = {
      dim_inactive = true,
      on_colors = function(colors)
        colors.border = "#565f89"
        colors.bg_visual = "#2d8fb6"
      end,
      styles = "moon",
    },
    config = true,
  },
}
--#region
--#region_end
--:so $VIMRUNTIME/syntax/hitest.vim
