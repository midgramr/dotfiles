vim.pack.add ({
  { src = vim.g.gh 'lervag/vimtex' },
}, { confirm = false })

vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_view_zathura_use_synctex = 0
