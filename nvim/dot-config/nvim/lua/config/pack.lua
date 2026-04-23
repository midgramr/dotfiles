---Helper to convert "owner/repo" string to GitHub URL
---@param repo string
---@return string url
function Gh(repo)
  return 'https://github.com/' .. repo
end

vim.api.nvim_create_user_command('Packlist', function()
  vim.pack.update(nil, { offline = true })
end, { desc = 'List installed packages' })

vim.api.nvim_create_user_command('Packupdate', function()
  vim.pack.update()
end, { desc = 'List installed packages' })

vim.api.nvim_create_user_command('Packprune', function()
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

require 'plugins.colorscheme'

vim
  .iter(vim.fs.dir(vim.fn.stdpath 'config' .. '/lua/plugins'))
  :filter(function(_, type)
    return type == 'file'
  end)
  :map(function(file)
    return string.match(file, '(.+)%.lua$')
  end)
  :each(function(plugin)
    require('plugins.' .. plugin)
  end)
