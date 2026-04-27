vim.pack.add({
  { src = utils.gh 'sainnhe/everforest' },
  { src = utils.gh 'sainnhe/gruvbox-material' },
}, { confirm = false })

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    vim.api.nvim_set_hl(0, 'PreInsert', { link = 'NonText' })
    vim.api.nvim_set_hl(0, 'Pmenu', { link = 'Normal' })
    vim.api.nvim_set_hl(0, 'PmenuSel', { link = 'TelescopeSelection' })
    vim.api.nvim_set_hl(0, 'PmenuBorder', { link = 'FloatBorder' })
    vim.api.nvim_set_hl(0, 'PmenuKind', { link = 'Green' })
    vim.api.nvim_set_hl(0, 'BlinkCmpSignatureHelpBorder', { link = 'FloatBorder' })
  end,
})

vim.g.gruvbox_material_enable_italic = true
vim.g.gruvbox_material_enable_bold = true
vim.g.gruvbox_material_float_style = 'blend'
vim.g.gruvbox_material_disable_terminal_colors = true
vim.g.gruvbox_material_current_word = 'bold'
vim.cmd.colorscheme 'gruvbox-material'
