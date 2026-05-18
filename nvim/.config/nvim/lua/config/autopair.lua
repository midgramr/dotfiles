local combos = {
  ['('] = ')',
  ['['] = ']',
  ['{'] = '}',
  ["'"] = "'",
  ['"'] = '"',
  ['`'] = '`',
}

-- If inserting in the middle of a line, only auto-insert bracket
-- if the next character is a trigger character
local trigger = {
  [','] = true,
  [' '] = true,
  ['.'] = true,
  [')'] = true,
}

local function is_inside_pair()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local prev = line:sub(col, col)
  local next = line:sub(col + 1, col + 1)
  return combos[prev] and combos[prev] == next
end

local function is_inside_bracket()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local prev = line:sub(col, col)
  local next = line:sub(col + 1, col + 1)
  return prev ~= next and combos[prev] and combos[prev] == next
end

for left, right in pairs(combos) do
  if left == right then
    vim.keymap.set('i', left, function()
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local line = vim.api.nvim_get_current_line()
      local next = line:sub(col + 1, col + 1)
      if next == right then
        return '<Right>'
      elseif col == #line then
        if left == '`' and #line > 1 then
          local prev1 = line:sub(col, col)
          local prev2 = line:sub(col - 1, col - 1)
          if prev1 == '`' and prev2 == '`' then
            return string.rep('`', 4) .. string.rep('<Left>', 3)
          end
        end
        return left .. right .. '<Left>'
      else
        return left
      end
    end, { expr = true })
  else
    vim.keymap.set('i', left, function()
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local line = vim.api.nvim_get_current_line()
      local next = line:sub(col + 1, col + 1)
      if col == #line or trigger[next] then
        return left .. right .. '<Left>'
      else
        return left
      end
    end, { expr = true })

    vim.keymap.set('i', right, function()
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local line = vim.api.nvim_get_current_line()
      local next = line:sub(col + 1, col + 1)
      if next == right then
        return '<Right>'
      else
        return right
      end
    end, { expr = true })
  end
end

vim.keymap.set('i', '<BS>', function()
  return is_inside_pair() and '<BS><Del>' or '<BS>'
end, { expr = true })

vim.keymap.set('i', '<CR>', function()
  return is_inside_bracket() and '<CR><Esc>O' or '<CR>'
end, { expr = true })
