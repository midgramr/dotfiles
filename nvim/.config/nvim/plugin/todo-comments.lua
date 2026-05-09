vim.pack.add({
  { src = utils.gh 'folke/todo-comments.nvim', name = 'todo-comments' },
}, { confirm = false })

require('todo-comments').setup { signs = false }
