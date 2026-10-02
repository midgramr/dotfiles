vim.pack.add({
  { src = utils.gh 'mikesmithgh/kitty-scrollback.nvim' },
}, { confirm = false })

require('kitty-scrollback').setup()
