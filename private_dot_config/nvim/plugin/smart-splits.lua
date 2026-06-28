vim.pack.add({
  { src = utils.gh 'mrjones2014/smart-splits.nvim', name = 'smart-splits' }
}, { confirm = false })

local splits = require 'smart-splits'

-- resizing splits
vim.keymap.set('n', '<M-S-h>', splits.resize_left)
vim.keymap.set('n', '<M-S-j>', splits.resize_down)
vim.keymap.set('n', '<M-S-k>', splits.resize_up)
vim.keymap.set('n', '<M-S-l>', splits.resize_right)

-- moving between splits
vim.keymap.set('n', '<M-h>', splits.move_cursor_left)
vim.keymap.set('n', '<M-j>', splits.move_cursor_down)
vim.keymap.set('n', '<M-k>', splits.move_cursor_up)
vim.keymap.set('n', '<M-l>', splits.move_cursor_right)

-- swapping buffers between windows
vim.keymap.set('n', '<Leader><Leader>h', splits.swap_buf_left)
vim.keymap.set('n', '<Leader><Leader>j', splits.swap_buf_down)
vim.keymap.set('n', '<Leader><Leader>k', splits.swap_buf_up)
vim.keymap.set('n', '<Leader><Leader>l', splits.swap_buf_right)
