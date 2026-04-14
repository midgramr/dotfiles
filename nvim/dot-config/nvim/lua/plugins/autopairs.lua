vim.pack.add({
  { src = vim.g.gh 'windwp/nvim-autopairs' },
}, { confirm = false })

require('nvim-autopairs').setup()
