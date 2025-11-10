return {
  require 'custom.plugins.omarchy-themes',

  {
    'vague2k/vague.nvim',
    priority = 1000,
    config = function()
      require('vague').setup {
        transparent = true,
        italic = false,

        on_highlights = function(highlights)
          -- Ajuste para o menu de seleção
          highlights.PmenuSel = {
            bg = '#405065',
            bold = true,
          }
        end,
      }
    end,
  },

  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_transparent_background = 1
    end,
  },

  {
    'rose-pine/neovim',
    priority = 1000,
    config = function()
      require('rose-pine').setup {
        styles = {
          italic = false,
          transparency = true,
        },
        palette = {
          moon = {
            line = '#111111',
          },
        },
        highlight_groups = {
          CursorLine = { bg = 'line' },
        },
      }
    end,
  },

  { 'tjdevries/colorbuddy.nvim', priority = 1000 },

  { 'jwbaldwin/oscura.nvim' },
}
