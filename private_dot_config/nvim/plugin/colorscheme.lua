vim.pack.add({
  { src = utils.gh 'sainnhe/everforest' },
  { src = utils.gh 'sainnhe/gruvbox-material' },
  { src = utils.gh 'Aejkatappaja/cendre' },
}, { confirm = false })

require('cendre').setup {
  background = 'hard',
}
vim.cmd.colorscheme 'cendre'
