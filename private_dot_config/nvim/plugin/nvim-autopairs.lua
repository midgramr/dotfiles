vim.pack.add({
  { src = utils.gh 'windwp/nvim-autopairs' },
}, { confirm = false })

require('nvim-autopairs').setup()
