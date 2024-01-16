return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim", opts = {
    invert_selection = true,
  } },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
