return {
  'vimpostor/vim-tpipeline',
  enabled = false,
  init = function()
    vim.g.tpipeline_clearstl = 1
    vim.g.tpipeline_restore = 1
  end,
}
