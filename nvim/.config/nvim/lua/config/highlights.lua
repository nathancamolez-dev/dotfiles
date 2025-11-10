local M = {}

function M.apply()
  vim.api.nvim_set_hl(0, 'PmenuSel', {
    bg = '#405065',
    bold = true,
  })

  vim.api.nvim_set_hl(0, 'TelescopeMatching', {
    fg = '#ff995e',
    italic = true,
    bold = true,
  })

  vim.api.nvim_set_hl(0, 'BlinkCmpLabelMatch', {
    fg = '#ff995e',
    italic = true,
    bold = true,
  })
end

return M
