return {
  -- add gruvbox
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, opts = { flavour = "latte" } },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
