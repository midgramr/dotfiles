vim.pack.add({
  { src = utils.gh 'MeanderingProgrammer/render-markdown.nvim' },
}, { confirm = false })

require('render-markdown').setup()

vim.keymap.set('n', '<Leader>m', '<Cmd>RenderMarkdown toggle<CR>', { desc = 'Toggle Markdown rendering' })
