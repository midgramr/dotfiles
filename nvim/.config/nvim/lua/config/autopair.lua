-- TODO: handle quotes and backticks
local combos = {
  ['('] = ')',
  ['['] = ']',
  ['{'] = '}',
}

local ns = vim.api.nvim_create_namespace 'autopairs'

local function insideautopair()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]
  local extmarks = vim.api.nvim_buf_get_extmarks(0, ns, { row, col }, { row, col }, { limit = 1 })
  local line = vim.api.nvim_get_current_line()
  local prev = line:sub(col, col)
  local next = line:sub(col + 1, col + 1)
  return #extmarks > 0 and combos[prev] and combos[prev] == next
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
    local row, col = cursor[1] - 1, cursor[2]
    local extmarks = vim.api.nvim_buf_get_extmarks(0, ns, { row, col }, { row, col }, { limit = 1 })
    local line = vim.api.nvim_get_current_line()
    local next = line:sub(col + 1, col + 1)
    if #extmarks > 0 and next == right then
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
