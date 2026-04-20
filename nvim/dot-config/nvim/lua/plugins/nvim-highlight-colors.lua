vim.pack.add({
  { src = Gh 'brenoprata10/nvim-highlight-colors' },
}, { confirm = false })

require('nvim-highlight-colors').setup {
  render = 'virtual',
  enable_tailwind = true,
  exclude_filetypes = { 'c', 'cpp' },
}
