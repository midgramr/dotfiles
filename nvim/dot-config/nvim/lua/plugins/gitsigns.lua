return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      map('n', '<leader>hp', gitsigns.preview_hunk_inline, { desc = 'Git [p]review hunk inline' })
      map('n', '<leader>hP', gitsigns.preview_hunk, { desc = 'Git [P]review hunk in float' })
      map('n', '<leader>hB', gitsigns.blame_line, { desc = 'Git [B]lame line' })
      map('n', '<leader>hb', gitsigns.blame, { desc = 'Git [b]lame' })
      map('n', '<leader>hd', function()
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
    end,

    preview_config = {
      row = 1,
    },
  },
}
