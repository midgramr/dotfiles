vim.pack.add({
  { src = utils.gh 'nvim-tree/nvim-web-devicons' },
  { src = utils.gh 'stevearc/oil.nvim', name = 'oil' },
}, { confirm = false })

require('nvim-web-devicons').setup()
require('oil').setup {
  watch_for_changes = true,
  show_hidden = true,
  skip_confirm_for_simple_edits = true,
  keymaps = {
    ['`'] = { 'actions.cd', opts = { scope = 'win' }, mode = 'n' },
    ['<C-t>'] = {},
  },
}

vim.keymap.set('n', '-', '<Cmd>Oil<CR>', { desc = 'Open directory' })
