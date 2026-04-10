local gitsigns = require 'gitsigns'

gitsigns.setup {
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map('n', '<Leader>gp', gitsigns.preview_hunk_inline, { desc = 'Git [p]review hunk inline' })
    map('n', '<Leader>gP', gitsigns.preview_hunk, { desc = 'Git [P]review hunk in float' })
    map('n', '<Leader>gB', gitsigns.blame_line, { desc = 'Git [B]lame line' })
    map('n', '<Leader>gb', gitsigns.blame, { desc = 'Git [b]lame' })
    map('n', '<Leader>gd', function()
      gitsigns.diffthis '@'
    end, { desc = 'Git [D]iff against last commit' })

    local nav_opts = {
      preview = true,
      target = 'all',
    }
    map('n', '[c', function()
      gitsigns.nav_hunk('prev', nav_opts)
    end, { desc = 'Previous hunk' })
    map('n', ']c', function()
      gitsigns.nav_hunk('next', nav_opts)
    end, { desc = 'Previous hunk' })

    vim.api.nvim_set_hl(0, 'GitSignsAddInline', { link = 'OctoBubbleGreen' })
    vim.api.nvim_set_hl(0, 'GitSignsChangeInline', { link = 'OctoBubbleBlue' })
    vim.api.nvim_set_hl(0, 'GitSignsDeleteInline', { link = 'OctoBubbleRed' })
  end,

  preview_config = {
    row = 1,
  },
}
