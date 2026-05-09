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
vim.keymap.set({ 'n', 't', 'i' }, '<M-h>', '<Cmd>winc h<CR>', { desc = 'Move to left window' })
vim.keymap.set({ 'n', 't', 'i' }, '<M-j>', '<Cmd>winc j<CR>', { desc = 'Move to window below' })
vim.keymap.set({ 'n', 't', 'i' }, '<M-k>', '<Cmd>winc k<CR>', { desc = 'Move to right window' })
vim.keymap.set({ 'n', 't', 'i' }, '<M-l>', '<Cmd>winc l<CR>', { desc = 'Move to window above' })
vim.keymap.set({ 'n', 't', 'i' }, '<M-=>', '<Cmd>winc =<CR>', { desc = 'Increase window height' })
vim.keymap.set({ 'n', 't', 'i' }, '<M-]>', '<Cmd>res +1<CR>', { desc = 'Increase window height' })
vim.keymap.set({ 'n', 't', 'i' }, '<M-[>', '<Cmd>res -1<CR>', { desc = 'Decrease window height' })
vim.keymap.set({ 'n', 't', 'i' }, '<M-,>', '<Cmd>winc <<CR>', { desc = 'Decrease window width' })
vim.keymap.set({ 'n', 't', 'i' }, '<M-.>', '<Cmd>winc ><CR>', { desc = 'Increase window width' })

-- Terminal
-- Overrides the builtin `term` command to set $TERM dynamically
local function term()
  vim.fn.jobstart(vim.o.shell, {
    env = { TERM = vim.env.TERM },
    term = true,
  })
end

vim.keymap.set('t', '<M-Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set({ 'n', 't' }, '<C-t>', function()
  local width = vim.api.nvim_win_get_width(0)
  if width > 150 then
    vim.cmd 'vert new'
    term()
  else
    vim.cmd 'new'
    term()
  end
end, { desc = 'Open terminal in split' })

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
