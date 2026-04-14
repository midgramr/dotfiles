vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>')

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
  vim.keymap.set('t', '<M-' .. i .. '>', '<C-\\><C-n>' .. i .. 'gt', { desc = 'Go to tab page ' .. i })
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
  vim.cmd 'startinsert'
end, { desc = 'Open terminal in split' })
vim.keymap.set('n', '<C-M-t>', function()
  vim.print 'here?'
  vim.cmd 'tab term'
  vim.cmd 'startinsert'
end, { desc = 'Open terminal in new tab' })

vim.keymap.set('n', '<C-y>', '<Cmd>%y<CR>', { desc = 'Yank entire file' })

vim.keymap.set('n', '[[', '?{<CR>w99[{', { remap = true })
vim.keymap.set('n', '][', '/}<CR>b99]}', { remap = true })
vim.keymap.set('n', ']]', 'j0[[%/{<CR>', { remap = true })
vim.keymap.set('n', '[]', 'k$][%?}<CR>', { remap = true })

-- I often accidentally type ':W' instead of ':w'
vim.keymap.set('ca', 'W', 'w')
