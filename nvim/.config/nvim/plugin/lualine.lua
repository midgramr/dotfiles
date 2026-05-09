vim.pack.add({
  utils.gh 'nvim-tree/nvim-web-devicons',
  { src = utils.gh 'nvim-lualine/lualine.nvim', name = 'lualine' },
}, { confirm = false })

require('lualine').setup {
  options = {
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_b = { 'branch', 'diagnostics' },
    lualine_x = { 'lsp_status', 'filetype' },
  },
  extensions = { 'fzf', 'man', 'oil', 'quickfix' }
}
