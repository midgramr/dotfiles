-- Windows
vim.keymap.set({ 'n', 't', 'i' }, '<M-q>', '<Cmd>q!<CR>', { desc = 'Quit window' })
vim.keymap.set({ 'n', 't', 'i' }, '<M-\\>', function()
  local width = vim.api.nvim_win_get_width(0)
  if width > 150 then
    return '<Cmd>vert Oil<CR>'
  else
    return '<Cmd>hor Oil<CR>'
  end
end, { desc = 'Open Oil in split', expr = true })

-- QOL
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-y>', '<Cmd>%y<CR>', { desc = 'Yank entire file' })
vim.keymap.set('ca', 'W', 'w')
vim.keymap.set('n', '<leader>R', function()
  local session = vim.fn.stdpath 'state' .. '/restart_session.vim'
  vim.cmd('wa!')
  vim.cmd('mksession! ' .. vim.fn.fnameescape(session))
  vim.cmd('restart source ' .. vim.fn.fnameescape(session))
end, { desc = 'Restart Neovim' })

-- LSP/diagnostics
vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float, {
  desc = 'vim.diagnostic.open_float',
})
vim.keymap.set('n', '<Leader>D', function()
  local enabled = vim.diagnostic.is_enabled { bufnr = 0 }
  vim.diagnostic.enable(not enabled, { bufnr = 0 })
end, {
  desc = 'Toggle buffer diagnostics',
})
