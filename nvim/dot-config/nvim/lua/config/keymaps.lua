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

-- Autopairs
-- NOTE: not handling single/double quotes, since that requires extra logic
local combos = {
  ['('] = ')',
  ['['] = ']',
  ['{'] = '}',
}

local ns = vim.api.nvim_create_namespace 'autopairs'

local function insideautopair()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line, col = cursor[1] - 1, cursor[2]
  local extmarks = vim.api.nvim_buf_get_extmarks(0, ns, { line, col }, { line, col }, { limit = 1 })
  -- NOTE: cleaner approach might be to get the current line with nvim_get_current_line()
  -- and index into that string
  local prev = vim.api.nvim_buf_get_text(0, line, math.max(0, col - 1), line, col, {})
  local next = vim.api.nvim_buf_get_text(0, line, col, line, col + 1, {})
  return #extmarks > 0
    and #prev > 0
    and combos[prev[1]]
    and #next > 0
    and combos[prev[1]] == next[1]
end

for left, right in pairs(combos) do
  vim.keymap.set('i', left, function()
    vim.api.nvim_put({ left .. right }, 'c', false, false)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row, col = cursor[1], cursor[2]
    vim.api.nvim_buf_set_extmark(0, ns, row - 1, col, { invalidate = true })
  end)

  vim.keymap.set('i', right, function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local line, col = cursor[1] - 1, cursor[2]
    local extmarks = vim.api.nvim_buf_get_extmarks(
      0,
      ns,
      { line, col },
      { line, col },
      { limit = 1 }
    )
    local next = vim.api.nvim_buf_get_text(0, line, col, line, col + 1, {})
    if #extmarks > 0 and #next > 0 and next[1] == right then
      -- TODO: handle case when blink.cmp autoinserts a pair during completion
      return '<Right>'
    else
      return right
    end
  end, { expr = true })
end

vim.keymap.set('i', '<BS>', function()
  return insideautopair() and '<BS><Del>' or '<BS>'
end, { expr = true })

vim.keymap.set('i', '<CR>', function()
  return insideautopair() and '<CR><Esc>O' or '<CR>'
end, { expr = true })
