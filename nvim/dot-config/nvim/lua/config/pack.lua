vim.g.gh = function(x)
  return 'https://github.com/' .. x
end

vim.api.nvim_create_user_command('PackList', function()
  vim.pack.update(nil, { offline = true })
end, { desc = 'List installed packages' })

vim.api.nvim_create_user_command('PackUpdate', function()
  vim.pack.update()
end, { desc = 'List installed packages' })

vim.api.nvim_create_user_command('PackPrune', function()
  local nonactive = vim
    .iter(vim.pack.get())
    :filter(function(x)
      return not x.active
    end)
    :map(function(x)
      return x.spec.name
    end)
    :totable()
  vim.pack.del(nonactive)
end, { desc = 'Prune unused packages' })

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
      vim.system({ 'make' }, { cwd = ev.data.path })
    end
  end,
})

-- Builtin plugins
vim.cmd.packadd 'nvim.difftool'
vim.cmd.packadd 'nvim.undotree'

-- TODO: better to iterate through files in plugin dir and require them, rather than
-- specifying them individually here

-- NOTE: load colorscheme first
require 'plugins.colorscheme'

require 'plugins.autopairs'
require 'plugins.blink'
require 'plugins.conform'
require 'plugins.gitsigns'
require 'plugins.mason-tool-installer'
require 'plugins.nvim-highlight-colors'
require 'plugins.nvim-treesitter'
require 'plugins.oil'
require 'plugins.telescope'
require 'plugins.todo-comments'
require 'plugins.vimtex'
