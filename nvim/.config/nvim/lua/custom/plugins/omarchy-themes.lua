return {
  -- Tokyo Night
  { 'folke/tokyonight.nvim' },

  -- Catppuccin
  { 'catppuccin/nvim', name = 'catppuccin', opts = {
    transparent_background = true,
  } },

  -- Everforest
  { 'sainnhe/everforest' },

  -- Kanagawa
  { 'rebelot/kanagawa.nvim' },

  -- Nord
  {
    'EdenEast/nightfox.nvim',
    config = function()
      require('nightfox').setup {
        options = { transparent = true },
      }
    end,
  },

  -- Rose Pine
  { 'rose-pine/neovim', name = 'rose-pine' },

  -- Gruvbox
  { 'ellisonleao/gruvbox.nvim' },

  -- Dracula
  { 'Mofiqul/dracula.nvim' },

  -- Mars
  { 'steve-lohmeyer/mars.nvim', name = 'mars' },

  { 'AlexvZyl/nordic.nvim' },

  -- One dark Pro
  { 'olimorris/onedarkpro.nvim' },
}
