return {
  'stevearc/oil.nvim',
  keys = {
    {
      '-',
      '<Cmd>Oil<CR>',
      mode = 'n',
      desc = 'Open parent directory',
    },
  },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    watch_for_changes = true,
    show_hidden = true,
    skip_confirm_for_simple_edits = true,
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false,
}
