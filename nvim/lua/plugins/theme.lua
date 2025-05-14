return {
  -- add gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      terminal_colors = true,
      transparent_mode = true,
      contrast = "hard",
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
