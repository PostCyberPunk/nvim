return {
  { "rafi/awesome-vim-colorschemes", priority = 1000 },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
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
