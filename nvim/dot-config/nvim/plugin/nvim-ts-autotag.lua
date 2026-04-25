vim.pack.add({
  { src = Gh 'windwp/nvim-ts-autotag' },
}, { confirm = false })

require('nvim-ts-autotag').setup()
