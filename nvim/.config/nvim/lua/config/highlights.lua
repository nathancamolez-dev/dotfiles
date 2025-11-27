local M = {}

function M.apply()
  vim.api.nvim_set_hl(0, 'PmenuSel', {
    bg = '#405065',
    fg = '#ff995e',
    bold = true,
    italic = true,
  })

  vim.api.nvim_set_hl(0, 'TelescopeMatching', {
    fg = '#ff995e',
    italic = true,
    bold = true,
  })

  vim.api.nvim_set_hl(0, 'SnacksPickerMatch', {
    fg = '#ff995e',
    italic = true,
    bold = true,
  })

  vim.api.nvim_set_hl(0, 'TelescopeSelection', {
    bold = false,
    italic = false,
  })

  vim.api.nvim_set_hl(0, 'BlinkCmpLabelMatch', {
    fg = '#ff995e',
    italic = true,
    bold = true,
  })
end

return M
