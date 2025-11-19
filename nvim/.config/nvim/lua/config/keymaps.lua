local function Map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

local function set_mappings()
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
  vim.api.nvim_set_keymap('n', '<leader>lr', ':LspRestart<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>b', function()
    local current_buf = vim.api.nvim_buf_get_name(0)
    require('mini.files').open(current_buf, true)
  end, { desc = 'Open mini.files in the current buffer path' })

  -- Bind to move with zz align
  Map('n', 'J', 'mzJ`z')
  Map('n', '<C-d>', '<C-d>zz')
  Map('n', '<C-u>', '<C-u>zz')
  Map('n', 'n', 'nzzzv')
  Map('n', 'N', 'Nzzzv')
  Map('n', 'o', 'o<esc>zzi')

  vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
  vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

  -- Auto indent on empty line.
  vim.keymap.set('n', 'i', function()
    return string.match(vim.api.nvim_get_current_line(), '%g') == nil and 'cc' or 'i'
  end, { expr = true, noremap = true })

  -- Auto indent on Enter insert
  vim.keymap.set('n', 'o', function()
    return vim.fn.getline '.' == '' and 'cc' or 'o'
  end, { expr = true, noremap = true })

  -- Switch between buffers
  vim.api.nvim_set_keymap('n', '<C-O>', ':b#<CR>', { noremap = true, silent = true })

  -- Terminal keymaps
  function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
  end

  vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'

  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode

  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
  --  See `:help wincmd` for a list of all window commands
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  -- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
  -- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
  -- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
  -- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
  -- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

  -- Telescope goimpl
  vim.api.nvim_set_keymap('n', '<leader>im', [[<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>]], { noremap = true, silent = true })
end

return {
  setup = set_mappings,
}
