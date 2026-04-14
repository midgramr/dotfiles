vim.pack.add({
  { src = vim.g.gh 'folke/todo-comments.nvim', name = 'todo-comments' },
}, { confirm = false })

require('todo-comments').setup {
  signs = false,
}
