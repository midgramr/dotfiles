vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Open help/man pages to the right by default',
  pattern = { 'help', 'man' },
  callback = function()
    local width = vim.api.nvim_win_get_width(0)
    if width > 150 then
      pcall(vim.api.nvim_win_set_config, 0, { split = 'right', win = 0 })
    end
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Override terminal buffer options',
  callback = function()
    vim.bo.bufhidden = 'unload'
    vim.bo.modified = false
    vim.bo.filetype = 'term'
    vim.cmd 'startinsert'
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    if vim.bo.filetype == 'term' then
      vim.cmd 'startinsert'
    end
  end,
})
