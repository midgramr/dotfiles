-- Windows
vim.keymap.set({ 'n', 't' }, '<M-q>', '<Cmd>bd!<CR>', { desc = 'Quit window' })
vim.keymap.set({ 'n', 't' }, '<M-s>', '<Cmd>vert Oil<CR>', { desc = 'Open Oil vertically' })
vim.keymap.set({ 'n', 't' }, '<M-x>', '<Cmd>hor Oil<CR>', { desc = 'Open Oil horizontally' })
vim.keymap.set({ 'n', 't' }, '<M-h>', '<Cmd>winc h<CR>', { desc = 'Move to left window' })
vim.keymap.set({ 'n', 't' }, '<M-j>', '<Cmd>winc j<CR>', { desc = 'Move to window below' })
vim.keymap.set({ 'n', 't' }, '<M-k>', '<Cmd>winc k<CR>', { desc = 'Move to right window' })
vim.keymap.set({ 'n', 't' }, '<M-l>', '<Cmd>winc l<CR>', { desc = 'Move to window above' })
vim.keymap.set({ 'n', 't' }, '<M-=>', '<Cmd>winc =<CR>', { desc = 'Increase window height' })
vim.keymap.set({ 'n', 't' }, '<M-]>', '<Cmd>res +1<CR>', { desc = 'Increase window height' })
vim.keymap.set({ 'n', 't' }, '<M-[>', '<Cmd>res -1<CR>', { desc = 'Decrease window height' })
vim.keymap.set({ 'n', 't' }, '<M-,>', '<Cmd>winc <<CR>', { desc = 'Decrease window width' })
vim.keymap.set({ 'n', 't' }, '<M-.>', '<Cmd>winc ><CR>', { desc = 'Increase window width' })

-- Tabs
for i = 1, 9 do
  vim.keymap.set('n', '<M-' .. i .. '>', i .. 'gt', { desc = 'Go to tab page ' .. i })
  vim.keymap.set(
    't',
    '<M-' .. i .. '>',
    '<C-\\><C-n>' .. i .. 'gt',
    { desc = 'Go to tab page ' .. i }
  )
end
vim.keymap.set({ 'n', 't' }, '<M-t>', '<Cmd>tab Oil<CR>', { desc = 'Open Oil in new tab' })

-- Terminal
vim.keymap.set('t', '<M-Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set({ 'n', 't' }, '<C-t>', function()
  local width = vim.api.nvim_win_get_width(0)
  if width > 150 then
    vim.cmd 'vert term'
  else
    vim.cmd 'split +term'
  end
end, { desc = 'Open terminal in split' })
vim.keymap.set('n', '<C-M-t>', function()
  vim.cmd 'tab term'
end, { desc = 'Open terminal in new tab' })

-- Navigation
vim.keymap.set('n', '[[', '?{<CR>w99[{', { remap = true })
vim.keymap.set('n', '][', '/}<CR>b99]}', { remap = true })
vim.keymap.set('n', ']]', 'j0[[%/{<CR>', { remap = true })
vim.keymap.set('n', '[]', 'k$][%?}<CR>', { remap = true })

-- QOL
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-y>', '<Cmd>%y<CR>', { desc = 'Yank entire file' })
vim.keymap.set('ca', 'W', 'w')
vim.keymap.set('n', '<leader>R', function()
  local session = vim.fn.stdpath 'state' .. '/restart_session.vim'
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

-- Completions
--[[
vim.keymap.set('i', '<C-j>', function()
  return utils.pumvisible() and '<C-n>' or '<C-j>'
end, { expr = true })

vim.keymap.set('i', '<C-k>', function()
  return utils.pumvisible() and '<C-p>' or '<C-k>'
end, { expr = true })

vim.keymap.set('i', '/', function()
  return vim.fn.pumvisible() ~= 0 and '<C-e>' or '/'
end, { expr = true })

vim.keymap.set({ 'i', 's' }, '<C-l>', function()
  if vim.snippet.active { direction = 1 } then
    return '<Cmd>lua vim.snippet.jump(1)<CR>'
  else
    return '<C-l>'
  end
end, { expr = true })

vim.keymap.set({ 'i', 's' }, '<C-h>', function()
  if vim.snippet.active { direction = 1 } then
    return '<Cmd>lua vim.snippet.jump(-1)<CR>'
  else
    return '<C-h>'
  end
end, { expr = true })
--]]

-- TODO: Autopairs
