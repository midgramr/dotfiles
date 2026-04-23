vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      vim.cmd 'TSUpdate'
    end
  end,
})

vim.pack.add({
  { src = Gh 'brenoprata10/nvim-highlight-colors' },
}, { confirm = false })

require('nvim-highlight-colors').setup {
  render = 'virtual',
  enable_tailwind = true,
  exclude_filetypes = { 'c', 'cpp' },
}
