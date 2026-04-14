vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'Open help windows to the right',
  pattern = '*/doc/*.{txt,md}',
  callback = function()
    local width = vim.api.nvim_win_get_width(0)
    if width > 150 then
      pcall(vim.api.nvim_win_set_config, 0, { split = 'right', win = 0 })
    end
  end,
})

vim.api.nvim_create_autocmd('TermClose', {
  desc = 'Open previous buffer on term close',
  callback = function(ev)
    local wins = vim.fn.win_findbuf(ev.buf)
    for _, win in ipairs(wins) do
      local bufs = vim.fn.getbufinfo { buflisted = 1 }
      -- find a buffer that isn't the one being deleted
      -- TODO: only open a buffer that was previously open in the same tab
      for _, buf in ipairs(bufs) do
        if buf.bufnr ~= ev.buf then
          pcall(vim.api.nvim_win_set_buf, win, buf.bufnr)
          break
        end
      end
    end
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Override terminal buffer options',
  callback = function()
    vim.bo.bufhidden = 'unload'
    vim.bo.modified = false
  end,
})
