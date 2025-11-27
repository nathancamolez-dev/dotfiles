return {
  'folke/snacks.nvim',
  dependencies = {
    ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
    { 'folke/snacks.nvim', opts = { input = {}, picker = {}, terminal = {} } },
  },

  ---@type snacks.Config
  opts = {
    picker = {},
  },

  vim.keymap.set('n', '<leader>sf', function()
    Snacks.picker.files {
      layout = 'select',
    }
  end, { desc = 'Find Files' }),

  vim.keymap.set('n', '<leader><leader>', function()
    Snacks.picker.buffers {
      layout = 'dropdown',
    }
  end, { desc = 'Find Buffers' }),

  vim.keymap.set('n', '<leader>sg', function()
    Snacks.picker.grep {
      layout = 'left',
    }
  end, { desc = 'GREP' }),

  vim.keymap.set('n', '<leader>sn', function()
    Snacks.picker.files {
      layout = 'select',
      cwd = vim.fn.stdpath 'config',
    }
  end, { desc = 'Neovim Config' }),

  vim.keymap.set('n', '<leader>s.', function()
    Snacks.picker.files {
      layout = 'select',
      hidden = true,
      ignored = true,
    }
  end, { desc = 'dotfiles' }),
}
