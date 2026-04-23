vim.pack.add({
  { src = Gh 'folke/todo-comments.nvim', name = 'todo-comments' },
}, { confirm = false })

require('todo-comments').setup {
  signs = false,
}
