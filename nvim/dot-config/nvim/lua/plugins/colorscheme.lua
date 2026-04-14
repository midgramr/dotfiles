vim.pack.add({
  { src = vim.g.gh 'sainnhe/gruvbox-material' },
}, { confirm = false })

vim.g.gruvbox_material_enable_italic = true
vim.g.gruvbox_material_enable_bold = true
vim.g.gruvbox_material_float_style = 'blend'
vim.g.gruvbox_material_disable_terminal_colors = true
vim.g.gruvbox_material_current_word = 'bold'
vim.cmd.colorscheme 'gruvbox-material'
