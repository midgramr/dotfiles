---Helper to convert "owner/repo" string to GitHub URL
---@param repo string
---@return string url
function Gh(repo)
  return 'https://github.com/' .. repo
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
