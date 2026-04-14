vim.pack.add({
  { src = vim.g.gh 'brenoprata10/nvim-highlight-colors' },
}, { confirm = false })

require('nvim-highlight-colors').setup {
  render = 'virtual',
  enable_tailwind = true,
  exclude_filetypes = { 'c', 'cpp' },
}
