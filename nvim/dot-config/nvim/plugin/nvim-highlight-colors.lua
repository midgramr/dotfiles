vim.pack.add({
  { src = utils.gh 'brenoprata10/nvim-highlight-colors' },
}, { confirm = false })

require('nvim-highlight-colors').setup {
  render = 'virtual',
  exclude_filetypes = { 'c', 'cpp' },
}
