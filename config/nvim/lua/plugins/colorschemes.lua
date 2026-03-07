-- All colorschemes matching Omarchy themes
return {
  -- Tokyo Night (default)
  {
    "folke/tokyonight.nvim",
    priority = 1000,
  },
  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
  -- Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
  },
  -- Nord
  {
    "shaunsingh/nord.nvim",
    priority = 1000,
  },
  -- Rose Pine
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
  },
  -- Kanagawa
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
  },
  -- Everforest
  {
    "neanias/everforest-nvim",
    priority = 1000,
  },
  -- Miasma
  {
    "xero/miasma.nvim",
    priority = 1000,
  },
  -- Set default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
}
