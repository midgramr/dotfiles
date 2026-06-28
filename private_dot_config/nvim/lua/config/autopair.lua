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

local function in_macro()
  return vim.fn.reg_recording() ~= '' or vim.fn.reg_executing() ~= ''
end

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
  if prev ~= next and combos[prev] and combos[prev] == next then
    return true
  end
  -- triple backtick fence, with optional language: ```<cursor>``` or ```lang<cursor>```
  return col >= 3 and line:sub(1, col):match('```%w*$') ~= nil and line:sub(col + 1, col + 3) == '```'
end

for left, right in pairs(combos) do
  if left == right then
    vim.keymap.set('i', left, function()
      if in_macro() then return left end
      local col = vim.api.nvim_win_get_cursor(0)[2]
      local line = vim.api.nvim_get_current_line()
      local next = line:sub(col + 1, col + 1)
      if next == right then
        return '<Right>'
      elseif col == #line then
        local prev = line:sub(col, col)
        if prev:match('%w') then
          return left
        end
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
      if in_macro() then return left end
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
      if in_macro() then return right end
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
  return not in_macro() and is_inside_pair() and '<BS><Del>' or '<BS>'
end, { expr = true })

vim.keymap.set('i', '<CR>', function()
  return not in_macro() and is_inside_bracket() and '<CR><Esc>O' or '<CR>'
end, { expr = true })
